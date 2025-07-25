
// Magnet Stuff
// Magnetizer - заряжаем плазмой, тыкаем по магниту (или его корпусу если в нём есть магнит), потом в левый угол территории которую хотим использовать для магнита
// Mineral Magnet Parts - тыкаем по корпусу магнита и получаем магнит
// Magnet Chassis - корпус магнита, единственное применение это поставить в него магнит
// Mineral Magnet - сам магнит в котором происходит вся логика действий и обработка чего куда и зачем
// Mineral Magnet Target - маркер где стоит магнит, высчитывает сверху где стоит центр притяжения, сколько сам стоит слева снизу
// Mineral Magnet Controls - позволяет выбирать магнит для взаимодействия и впринципе является интерфейсом для взаимодействия с магнитом
// Misc - всякая мелочёвка, платы, лэндмарки, силовые поля
// Для быстрого поиска нужного можно использовать адекватные методы поиска или по маркеру <->


////////////////
// MAGNETIZER // <->
////////////////

/obj/item/magnetizer
	name = "Magnetizer"
	desc = "A gun that manipulates the magnetic flux of an area. The designated area can then be activated or deactivated with a mineral magnet."
	icon = 'tff_modular/modules/mining_magnet/icons/mining_magnet.dmi'
	icon_state = "magnet"
	var/loaded = 0
	var/obj/machinery/mining_magnet/magnet = null

/obj/item/magnetizer/examine()
	. = ..()
	if(loaded)
		. += span_notice("The magnetizer is loaded with a solid plasma. Designate the mineral magnet to attach, then designate the lower left tile of the area to magnetize.")
		. += span_notice("The magnetized area must be a clean shot of space, surrounded by bordering tiles on all sides.")
		. += span_notice("A small mineral magnet requires an 7x7 area of space, a large one requires a 15x15 area of space.")
	else
		. += span_alert("The magnetizer must be loaded with a solid plasma to use.")

/obj/item/magnetizer/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/stack/sheet/mineral/plasma) && !loaded)
		loaded = TRUE
		to_chat(user, span_notice("You charge the magnetizer with the solid plasma."))
		W.use(1)

	else return ..()

/turf/open/floor/attackby(obj/item/object, mob/living/user, list/modifiers)
	. = ..()
	if(!istype(object, /obj/item/magnetizer))
		return .

	var/obj/item/magnetizer/magnetizer = object
	var/obj/machinery/mining_magnet/magnet = magnetizer.magnet

	if(!magnet)
		return
	if(magnet.target)
		to_chat(user, span_alert("Magnet target already designated. Unlocking."))
		magnet = null
		return
	if(!magnetizer.loaded)
		to_chat(user, span_alert("The magnetizer needs to be loaded with a plasmastone chunk first."))
		return

	var/obj/magnet_target_marker/M = new magnet.marker_type(src)

	// лёгкая проверка на 3 опорные точки по углам (левый нижний угол = турф по которому мы тыкнули)
	if(src.z != magnet.z)
		to_chat(user, span_alert("Designation failed: designated tile is outside magnet range."))
		qdel(M)
		return

	var/turf/DownRight = locate(x + M.width - 1, y, z)
	var/turf/UpperLeft = locate(x, y + M.height - 1, z)
	var/turf/UpperRight = locate(x + M.width - 1, y + M.height - 1, z)
	if(!DownRight || !UpperLeft || !UpperRight)
		to_chat(user, span_alert("Designation failed: designated tile is outside current valid z coordinate."))
		qdel(M)
		return

	var/dist_to_magnet = max(get_dist(magnet, src), get_dist(magnet, DownRight), get_dist(magnet, UpperLeft), get_dist(magnet, UpperRight))
	if(dist_to_magnet > magnet.max_range)
		to_chat(user, span_alert("Designation failed: designated tile is outside magnet range."))
		qdel(M)
		return

	if(!M.construct(user))
		qdel(M)
		return

	to_chat(user, span_notice("Designation successful. The magnet is now fully operational."))
	magnet.target = M
	magnetizer.loaded = FALSE
	magnet = null

////////////////////////
//MINERAL MAGNET PARTS// <->
////////////////////////

/obj/item/magnet_parts
	name = "mineral magnet parts"
	desc = "Used to construct a new magnet on a magnet chassis."
	icon = 'tff_modular/modules/mining_magnet/icons/mining_magnet.dmi'
	icon_state = "dbox"
	var/constructed_magnet = /obj/machinery/mining_magnet

/obj/item/magnet_parts/small
	name = "small mineral magnet parts"
	constructed_magnet = /obj/machinery/mining_magnet/small

////////////////////
// MAGNET CHASSIS // <->
////////////////////

/obj/machinery/magnet_chassis
	name = "magnet chassis"
	desc = "A strong metal rig designed to hold and link up magnet apparatus with other technology."
	icon = 'tff_modular/modules/mining_magnet/icons/64x64.dmi'
	icon_state = "chassis"
	anchored = TRUE
	density = TRUE
	max_integrity = 500
	var/obj/machinery/mining_magnet/linked_magnet = null

/obj/machinery/magnet_chassis/post_machine_initialize()
	. = ..()
	SSmagnet_mining.magnet_chassis += src
	update_dir_bounds()
	for(var/obj/machinery/mining_magnet/MM in range(1,src))
		linked_magnet = MM
		MM.linked_chassis = src
		break

/obj/machinery/magnet_chassis/Destroy()
	SSmagnet_mining.magnet_chassis -= src
	if(linked_magnet)
		qdel(linked_magnet)
	linked_magnet = null
	..()

/obj/machinery/magnet_chassis/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/magnet_parts))
		if(linked_magnet)
			to_chat(user, span_alert("There's already a magnet installed."))
			return
		if(I.use_tool(src, user, 24 SECONDS))
			var/obj/item/magnet_parts/mag_parts = I
			var/obj/machinery/mining_magnet/magnet = new mag_parts.constructed_magnet(get_turf(src))
			magnet.dir = dir
			qdel(mag_parts)
			user.visible_message(span_notice("[user] constructs [src]!"))
			return

	else if(istype(I, /obj/item/magnetizer))
		if(!linked_magnet)
			return
		if(linked_magnet.target)
			to_chat(user, span_alert("That magnet is already locked onto a location."))
			return

		var/obj/item/magnetizer/magnetizer = I
		magnetizer.magnet = linked_magnet
		to_chat(user, span_notice("Magnet locked. Designate lower left tile of target area (excluding the borders)."))
		return

	else if(istype(I, /obj/item/stack/sheet/plasteel) && get_integrity_percentage() != 1)
		if(I.use(1))
			to_chat(user, span_notice("You manage repair some damage on [src] with [I]"))
			repair_damage(40)
			return
	..()

/obj/machinery/magnet_chassis/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(tool.use_tool(src, user, 5 SECONDS))
		setDir(turn(dir, -90))
		update_dir_bounds()
		return

/obj/machinery/magnet_chassis/proc/update_dir_bounds()
	if(dir & (EAST|WEST))
		bound_height = 64
		bound_width = 32
	else
		bound_height = 32
		bound_width = 64

////////////////////
// MINERAL MAGNET // <->
////////////////////

/obj/machinery/mining_magnet
	name = "mineral magnet"
	desc = "A piece of machinery able to generate a strong magnetic field to attract mineral sources."
	icon = 'tff_modular/modules/mining_magnet/icons/64x64.dmi'
	icon_state = "magnet"
	anchored = TRUE
	req_access = list(ACCESS_MINING, ACCESS_MINING_STATION)
	var/obj/machinery/magnet_chassis/linked_chassis = null
	var/health = 100
	var/attract_time = 300
	var/cooldown_time = 1200
	var/active = 0
	var/last_used = 0
	var/last_use_attempt = 0
	var/automatic_mode = 0
	var/auto_delay = 100
	var/last_delay = 0
	var/cooldown_override = 0
	var/malfunctioning = 0
	var/rarity_mod = 0
	var/max_range = 30
	var/last_encounter
	var/autosetup = FALSE

	var/sound_activate = 'tff_modular/modules/mining_magnet/sound/ArtifactAnc1.ogg'
	var/sound_destroyed = 'tff_modular/modules/mining_magnet/sound/Machinery_Break_1.ogg'

	var/marker_type = /obj/magnet_target_marker
	var/obj/magnet_target_marker/target = null
	var/list/wall_bits = list()

/obj/machinery/mining_magnet/proc/get_magnetic_center()
	return target?.magnetic_center // the target marker has the center

/obj/machinery/mining_magnet/proc/get_scan_range() // reworked
	if(target)
		return target.scan_range
	return 6 // 6 if there's no center marker

/obj/machinery/mining_magnet/proc/check_for_unacceptable_content()
	if(target)
		return target.check_for_unacceptable_content()
	return TRUE // fail if there's no center marker

/obj/machinery/mining_magnet/proc/get_encounter(var/rarity_mod)
	return SSmagnet_mining.select_encounter(rarity_mod)

/obj/machinery/mining_magnet/small
	marker_type = /obj/magnet_target_marker/small

/obj/machinery/mining_magnet/small/get_encounter(rarity_mod)
	return SSmagnet_mining.select_small_encounter(rarity_mod)

/obj/machinery/mining_magnet/Initialize(mapload)
	. = ..()
	if(mapload)
		autosetup = TRUE
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/mining_magnet/post_machine_initialize()
	. = ..()
	for(var/obj/machinery/magnet_chassis/MC in range(1, src))
		linked_chassis = MC
		MC.linked_magnet = src
		break

	// mining magnets can automatically set up immediately at roundstart as a treat
	if(!target && autosetup)
		for(var/obj/magnet_target_marker/marker in SSmagnet_mining.magnet_markers)
			if(IN_GIVEN_RANGE(marker, src, max_range))
				target = marker
				target.construct()
				break

/obj/machinery/mining_magnet/process()
	if(!target)
		return
	if(automatic_mode && last_used < REALTIMEOFDAY && last_delay < REALTIMEOFDAY)
		if (target.check_for_unacceptable_content())
			last_delay = REALTIMEOFDAY + auto_delay
			return
		else
			pull_new_source()

/obj/machinery/mining_magnet/Destroy(force)
	. = ..()
	health = 0 // DIE!!!!!! GOD!!!! (this makes sure the computers know the magnet is Dead and Buried)
	visible_message("<b>[src] breaks apart!</b>")
	new /obj/effect/gibspawner/robot(loc)
	playsound(loc, sound_destroyed, 50, 2)
	linked_chassis?.linked_magnet = null
	linked_chassis = null
	qdel(target)
	for(var/obj/O in wall_bits)
		qdel(O)

/obj/machinery/mining_magnet/examine()
	. = ..()
	if(health < 50)
		. += span_alert("It's rather badly damaged. It probably needs some wiring replaced inside.")
	else if(health < 100)
		. += span_alert("It's a bit damaged. It looks like it needs some welding done.")

/obj/machinery/mining_magnet/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	if(linked_chassis)
		linked_chassis.take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	else
		qdel(src) //если у нет корпуса - значит не должно быть и магнита

/obj/machinery/mining_magnet/ex_act(severity)
	switch(severity)
		if(1)
			damage(rand(75,120))
		if(2)
			damage(rand(25,75))
		if(3)
			damage(rand(10,25))

/obj/machinery/mining_magnet/welder_act(mob/living/user, obj/item/tool)
	. = ..()
	if(health < 50)
		to_chat(user, span_alert("You need to use wire to fix the cabling first."))
		return
	if(tool.use(1))
		damage(-10)
		malfunctioning = FALSE
		user.visible_message("<b>[user]</b> uses [tool] to repair some of [src]'s damage.")
		if(health >= 100)
			to_chat(user, span_notice("<b>[src] looks fully repaired!</b>"))

/obj/machinery/mining_magnet/attackby(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	if(active)
		to_chat(user, span_alert("It's way too dangerous to do that while it's active!"))
		return

	. = ..()
	if(istype(weapon, /obj/item/stack/cable_coil))
		if(health > 50)
			to_chat(user, span_alert("The cabling looks fine. Use a welder to repair the rest of the damage."))
			return
		if(weapon.use(1))
			damage(-10)
			user.visible_message("<b>[user]</b> uses [weapon] to repair some of [src]'s cabling.")
			playsound(loc, 'sound/items/Deconstruct.ogg', 50, 1)
			if(health >= 50)
				to_chat(user, span_notice("The wiring is fully repaired. Now you need to weld the external plating."))
				malfunctioning = FALSE
		return

	else if(istype(weapon, /obj/item/magnetizer))
		var/obj/item/magnetizer/magnetizer = weapon
		if(target)
			to_chat(user, span_alert("That magnet is already locked onto a location."))
			return

		magnetizer.magnet = src
		to_chat(user, span_notice("Magnet locked. Designate lower left tile of target area (excluding the borders)."))
		return

	if(weapon.force)
		var/damage = weapon.force
		damage /= 3
		if(HAS_TRAIT(user, TRAIT_HULK))
			damage *= 4
		if(damage >= 10)
			damage(damage)

/obj/machinery/mining_magnet/update_overlays()
	. = ..()
	switch(health)
		if(70 to 94)
			. += "damage-1"
		if(40 to 69)
			. += "damage-2"
		if(10 to 39)
			. += "damage-3"
		if(-INFINITY to 10)
			. += "damage-4"

	if(active)
		. += "active"

	// Sanity check to make sure we gib on no health
/obj/machinery/mining_magnet/proc/check_should_die()
	if(isnull(health) || health <= 0)
		qdel(src)
		return TRUE
	return FALSE

/obj/machinery/mining_magnet/proc/damage(var/amount)
	if (!isnum(amount))
		return

	health -= amount
	health = clamp(health, 0, 100)

	if(health < 1 && !active)
		qdel(src)
		return

	update_appearance(UPDATE_OVERLAYS)
	if (!prob(health) && amount > 0)
		malfunctioning = TRUE
	return

/obj/machinery/mining_magnet/proc/do_malfunction()
	visible_message("<b>[src] makes a loud bang! That didn't sound too good...</b>")
	playsound(loc, 'tff_modular/modules/mining_magnet/sound/Generic_Hit_Heavy_1.ogg', 50, 1)
	damage(rand(5,10))

/obj/machinery/mining_magnet/proc/pull_new_source(var/selectable_encounter_id = null)
	if(!target)
		return

	if(!length(wall_bits))
		wall_bits = target.generate_walls()

	for(var/obj/effect/forcefield/mining/M in wall_bits)
		M.set_opacity(TRUE)
		M.set_density(TRUE)
		M.invisibility = INVISIBILITY_NONE

	active = TRUE

	damage(rand(2, 6))

	last_used = REALTIMEOFDAY + cooldown_time
	playsound(loc, sound_activate, 100, 0, 3, 0.25)
	update_appearance(UPDATE_OVERLAYS)

	target.erase_area()

	var/sleep_time = attract_time
	if(sleep_time < 1)
		sleep_time = 20
	sleep_time /= 3

	if (malfunctioning && prob(20))
		do_malfunction()
	sleep(sleep_time)

	var/datum/mining_encounter/MC

	if(selectable_encounter_id != null)
		if(selectable_encounter_id in SSmagnet_mining.mining_encounters_selectable)
			MC = SSmagnet_mining.mining_encounters_selectable[selectable_encounter_id]
			SSmagnet_mining.remove_selectable_encounter(selectable_encounter_id)
		else
			to_chat(usr, "Uh oh, something's gotten really fucked up with the magnet system. Please report this to a coder! (ERROR: INVALID ENCOUNTER)")
			MC = get_encounter(rarity_mod)
	else
		MC = get_encounter(rarity_mod)
	last_encounter = MC.type

	if(MC)
		MC.generate(target)
	else
		for (var/obj/effect/forcefield/mining/M in wall_bits)
			M.set_opacity(FALSE)
			M.set_density(FALSE)
			M.invisibility = INVISIBILITY_OBSERVER
		active = FALSE
		to_chat(usr, "Uh oh, something's gotten really fucked up with the magnet system. Please report this to a coder! (ERROR: NO ENCOUNTER)")
		return

	sleep(sleep_time)
	if(malfunctioning && prob(20))
		do_malfunction()

	active = FALSE
	update_appearance(UPDATE_OVERLAYS)

	for(var/obj/effect/forcefield/mining/M in wall_bits)
		M.set_opacity(FALSE)
		M.set_density(FALSE)
		M.invisibility = INVISIBILITY_OBSERVER

	check_should_die()
	return

/obj/machinery/mining_magnet/ui_data(mob/user)
	. = ..()
	.["magnetHealth"] = health
	.["magnetActive"] = active
	.["magnetLastUsed"] = last_used
	.["magnetCooldownOverride"] = cooldown_override
	.["magnetAutomaticMode"] = automatic_mode

	var/list/miningEncounters = list()
	for(var/encounter_id in SSmagnet_mining.mining_encounters_selectable)
		var/datum/mining_encounter/encounter = SSmagnet_mining.mining_encounters_selectable[encounter_id]
		if(istype(encounter))
			miningEncounters += list(list(
				name = encounter.name,
				id = encounter_id
			))
	.["miningEncounters"] = miningEncounters

	.["time"] = REALTIMEOFDAY

/obj/machinery/mining_magnet/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/magnetNotReady = active || (last_used > REALTIMEOFDAY && !cooldown_override) || last_use_attempt > REALTIMEOFDAY
	switch(action)
		/*
		if ("geoscan")
			var/MC = src.get_magnetic_center()
			if (!MC)
				to_chat(usr, "Error. Magnet is not magnetized.")
				return
			mining_scan(MC, usr, src.get_scan_range())*/
		if ("activateselectable")
			if (magnetNotReady)
				return
			if (!target || !get_magnetic_center())
				visible_message("<b>[src.name]</b> states, \"Magnetic field strength error. Please ensure mining area is properly magnetized\"")
				return

			if (target.check_for_unacceptable_content())
				visible_message("<b>[src.name]</b> states, \"Safety lock engaged. Please remove all personnel and vehicles from the magnet area.\"")
			else
				last_use_attempt = REALTIMEOFDAY + 10
				pull_new_source(params["encounter_id"])
				. = TRUE
		if ("activatemagnet")
			if (magnetNotReady)
				return
			if (!target || !get_magnetic_center())
				visible_message("<b>[name]</b> states, \"Magnetic field strength error. Please ensure mining area is properly magnetized\"")
				return

			if (target.check_for_unacceptable_content())
				visible_message("<b>[name]</b> states, \"Safety lock engaged. Please remove all personnel and vehicles from the magnet area.\"")
			else
				last_use_attempt = REALTIMEOFDAY + 10 // This is to prevent href exploits or autoclickers from pulling multiple times simultaneously
				pull_new_source()
				. = TRUE
		if("overridecooldown")
			if (!ishuman(usr))
				to_chat(usr, span_alert("AI and robotic personnel may not access the override."))
			else
				var/mob/living/carbon/human/H = usr
				if(!allowed(H))
					to_chat(usr, span_alert("Access denied."))
				else
					cooldown_override = !cooldown_override
				. = TRUE
		if("automode")
			automatic_mode = !automatic_mode
			. = TRUE

///////////////////////////
// MINERAL MAGNET TARGET // <->
///////////////////////////

/obj/magnet_target_marker
	name = "mineral magnet target"
	desc = "Marks the location of an area of asteroid magnetting."
	invisibility = INVISIBILITY_MAXIMUM
	var/width = 15
	var/height = 15
	var/scan_range = 7
	var/turf/magnetic_center
	alpha = 128
	anchored = TRUE

/obj/magnet_target_marker/small
	width = 7
	height = 7
	scan_range = 3

/obj/magnet_target_marker/ex_act()
	return

/obj/magnet_target_marker/bullet_act()
	SHOULD_CALL_PARENT(FALSE)
	return

/obj/magnet_target_marker/proc/get_encounter_size(size, P)
	. = size
	if(!P || prob(P))
		var/max_r = round(min(width,height)/2)-1
		. = rand(size, max_r)

/obj/magnet_target_marker/proc/erase_area()
	var/turf/origin = get_turf(src)
	for(var/turf/T in block(locate(origin.x + 1, origin.y + 1, origin.z), locate(origin.x + width - 2, origin.y + height - 2, origin.z)))
		for(var/mob/living/L in T)
			if(isliving(L) && L.stat == DEAD) // we don't care about dead critters
				qdel(L)
		for(var/obj/O in T)
			if(O.type in SSmagnet_mining.erase_protected)
				continue
			qdel(O)
		T.cut_overlays()
		T.ChangeTurf(/turf/open/space)

#define straight_line_of_turf(A, width, height, offset_width, offset_height) \
	block(locate(A.x + offset_width, A.y + offset_height, A.z), locate(A.x + width, A.y + height, A.z))

/obj/magnet_target_marker/proc/get_corners(var/turf/origin)
	if(!origin)
		origin = get_turf(src)

	. = list()
// сперва берём горизонтальные края
	for(var/turf/T in straight_line_of_turf(origin, width - 1, 0, 0, 0))
		if(T) . += T
	for(var/turf/T in straight_line_of_turf(origin, width - 1, height - 1, 0, height - 1))
		if(T) . += T

// потом берём вертикальные края с офссетом +1 и укорачиванием -2 (тоесть берём только неучтённые турфы)
	for(var/turf/T in straight_line_of_turf(origin, 0, height - 2, 0, 1))
		if(T) . += T
	for(var/turf/T in straight_line_of_turf(origin, width - 1, height - 2, width - 1, 1))
		if(T) . += T

#undef straight_line_of_turf

/obj/magnet_target_marker/proc/generate_walls()
	var/list/walls = list()
	var/list/corners = get_corners()

	for(var/turf/T in corners)
		var/obj/effect/forcefield/mining/WALL = new (T)
		walls += WALL
	return walls

/obj/magnet_target_marker/proc/check_for_unacceptable_content()
	// this used to use an area, which meant it only checked
	var/turf/origin = get_turf(src)
	var/unacceptable = FALSE
	for(var/turf/T in block(locate(origin.x-1, origin.y-1, origin.z), locate(origin.x + width, origin.y + height, origin.z)))

		for(var/mob/living/L in T)
			if(isanimal_or_basicmob(L)) // we don't care about critters
				continue
			if(!iseyemob(L)) //neither blob overmind or AI eye should block this
				unacceptable = TRUE
				break
		for(var/obj/vehicle/V in T)
			unacceptable = TRUE
			break

	return unacceptable

/obj/magnet_target_marker/Initialize(mapload)
	SSmagnet_mining.magnet_markers += src
	..()

/obj/magnet_target_marker/Destroy(force)
	SSmagnet_mining.magnet_markers -= src
	..()

/obj/magnet_target_marker/proc/construct(var/mob/user)
	// Сперва смотрим на внешние края и проверяем, что они в рамках z уровня
	var/turf/origin = get_turf(src)
	var/list/borders = get_corners(origin)
	if(borders.len != (width * 2) + ((height - 2) * 2)) // если количество стен не равно его размерам, то значит часть стен потерялось из-за границ z уровня
		to_chat(user, span_alert("Error: magnet area spans over construction area bounds."))
		return FALSE
	for(var/turf/T in borders)
		if(isspaceturf(T))
			to_chat(user, span_alert("Error: bordering tile has a gap, cannot magnetize area."))
			return FALSE
		else if(!isopenturf(T))
			to_chat(user, span_alert("Error: bordering tile covered by a wall, cannot magnetize area."))
			return FALSE

	// После уже смотрим чего есть внутри, смещаем ради этого начальную позицию на 1 (сколько край мы уже осмотрели)
	for(var/turf/T in block(locate(origin.x + 1, origin.y + 1, origin.z), locate(origin.x + width - 2, origin.y + height - 2, origin.z)))
		if(!T)
			to_chat(user, span_alert("Error: magnet area spans over construction area bounds."))
			return FALSE
		if((!isspaceturf(T) && !ispassmeteorturf(T)))
			to_chat(user, span_alert("Error: [T] detected in [width]x[height] magnet area. Cannot magnetize."))
			return FALSE

	magnetic_center = locate(origin.x + round(width/2), origin.y + round(height/2), origin.z)
	return TRUE

/////////////////////////////
// MINERAL MAGNET CONTROLS // <->
/////////////////////////////

/obj/machinery/computer/magnet
	name = "mineral magnet controls"
	icon = 'tff_modular/modules/mining_magnet/icons/mining_magnet.dmi'
	icon_keyboard = "mmagnet_key"
	icon_screen = "mmagnet"
	circuit = /obj/item/circuitboard/computer/mining_magnet
	var/temp = null
	var/list/linked_magnets = list()
	var/obj/machinery/mining_magnet/linked_magnet = null
	req_access = list(ACCESS_MINING)

/obj/machinery/computer/magnet/post_machine_initialize()
	. = ..()
	connection_scan()

/obj/machinery/computer/magnet/ui_interact(mob/user, datum/tgui/ui)
	..()
	if(!allowed(user))
		to_chat(user, span_alert("Access Denied."))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MineralMagnet", name)
		ui.open()

/obj/machinery/computer/magnet/ui_data(mob/user)
	. = ..()
	.["linkedMagnets"] = null

	if(istype(linked_magnet))
		. = linked_magnet.ui_data(user)
		.["isLinked"] = TRUE
	else
		var/list/linkedMagnets = list()
		for (var/obj/M in linked_magnets)
			var/magnetData = list(
				name = M.name,
				x = M.x,
				y = M.y,
				z = M.z,
				ref = "\ref[M]",
				angle = -arctan(M.x - user.x, M.y - user.y)
			)
			linkedMagnets += list(magnetData)
		.["linkedMagnets"] = linkedMagnets
		.["isLinked"] = FALSE

/obj/machinery/computer/magnet/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if (.)
		return
	switch(action)
		if("linkmagnet")
			connection_scan() // Magnets can explode inbetween scanning and linking
			linked_magnet = locate(params["ref"]) in linked_magnets
			if (!istype(linked_magnet))
				linked_magnet = null
				visible_message("<b>[src.name]</b> states, \"Designated magnet is no longer operational.\"")
			. = TRUE
		if ("magnetscan")
			switch(connection_scan())
				if(1)
					visible_message("<b>[src.name]</b> states, \"Unoccupied Magnet Chassis located. Please connect magnet system to chassis.\"")
				if(2)
					visible_message("<b>[src.name]</b> states, \"Magnet equipment not found within range.\"")
				else
					visible_message("<b>[src.name]</b> states, \"Magnet equipment located. Link established.\"")
			. = TRUE
		if ("unlinkmagnet")
			linked_magnet = null
			. = TRUE
		else
			if(istype(linked_magnet))
				if (linked_magnet.health <= 0)
					linked_magnet = null // ITS DEAD!!!! STOP!!!
					visible_message("<b>[src.name]</b> states, \"Designated magnet is no longer operational.\"")
					return
				. = linked_magnet.ui_act(action, params, ui, state)

/obj/machinery/computer/magnet/proc/connection_scan()
	linked_magnets = list()
	var/badmagnets = 0

	for(var/obj/machinery/magnet_chassis/MC in SSmagnet_mining.magnet_chassis)
		if(!IN_GIVEN_RANGE(MC, src, 20))
			continue
		if(MC.linked_magnet)
			linked_magnets += MC.linked_magnet
		else
			badmagnets++
	if(linked_magnets.len)
		return 0
	if(badmagnets)
		return 1
	return 2

//////////
// MISC //
//////////

/obj/effect/forcefield/mining
	name = "magnetic forcefield"
	desc = "A powerful field used by the mining magnet to attract minerals."
	icon = 'tff_modular/modules/mining_magnet/icons/mining_magnet.dmi'
	icon_state = "noise6"
	color = "#BF12DE"
	alpha = 175
	opacity = 0
	density = 0
	invisibility = INVISIBILITY_MAXIMUM
	anchored = TRUE
	initial_duration = 0


/obj/item/circuitboard/computer/mining_magnet
	name = "circuit board (mining magnet computer)"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/magnet

/obj/effect/landmark/magnet_center
	name = "magnet_center"
	icon = 'tff_modular/modules/mining_magnet/icons/landmarks.dmi'
	icon_state = "magnet-center"
	var/width = 15
	var/height = 15
	var/obj/machinery/mining_magnet/magnet

/obj/effect/landmark/magnet_center/Initialize(mapload)
	. = ..()
	var/turf/T = locate(x - round(width/2), y - round(height/2), z)
	var/obj/magnet_target_marker/M = new /obj/magnet_target_marker(T)
	M.width = width
	M.height = height

/obj/effect/landmark/magnet_shield
	name = "magnet_shield"
	icon = 'tff_modular/modules/mining_magnet/icons/landmarks.dmi'
	icon_state = "magnet-shield"

/obj/effect/landmark/magnet_shield/Initialize(mapload)
	..()
	return INITIALIZE_HINT_QDEL
