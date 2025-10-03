/obj/item/gun/energy
	icon_state = "energy"
	name = "energy gun"
	desc = "A basic energy-based gun."
	icon = 'icons/obj/weapons/guns/energy.dmi'
	pickup_sound = 'sound/items/handling/gun/gun_pick_up.ogg'
	drop_sound = 'sound/items/handling/gun/gun_drop.ogg'
	sound_vary = TRUE

	wield_slowdown = LASER_SMG_SLOWDOWN
	aimed_wield_slowdown = LASER_RIFLE_SLOWDOWN

	ammo_x_offset = 2
	///If this gun has a "this is loaded with X" overlay alongside chargebars and such
	var/single_shot_type_overlay = TRUE
	///Should we give an overlay to empty guns?
	var/display_empty = TRUE
	///If we have an additional overlay based on our shot type while active
	var/shot_type_fluff_overlay = FALSE

	///whether the gun's cell drains the cyborg user's cell to recharge
	var/use_cyborg_cell = FALSE
	///set to true so the gun is given an empty cell
	var/dead_cell = FALSE

	// Self charging vars

	/// Whether or not our gun charges its own cell on a timer.
	var/selfcharge = 0
	/// The amount of time between instances of cell self recharge
	var/charge_timer = 0
	/// The amount of seconds_per_tick during process() before the gun charges itself
	var/charge_delay = 8
	/// The amount restored by the gun to the cell per self charge tick
	var/self_charge_amount = STANDARD_ENERGY_GUN_SELF_CHARGE_RATE

	var/latch_closed = TRUE
	var/latch_toggle_delay = 1.0 SECONDS
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/gun,
		/obj/item/attachment/sling,
		/obj/item/attachment/ammo_counter,
	)
	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_MUZZLE = 1,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 26,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 21,
			"y" = 24,
		)
	)

/obj/item/gun/energy/fire_sounds()
	// What frequency the energy gun's sound will make
	var/pitch_to_use = 1

	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	// What percentage of the full battery a shot will expend
	var/shot_cost_percent = round(clamp(shot.e_cost / cell.maxcharge, 0, 1) * 100)
	// Ignore this on oversized/infinite cells or ammo without cost
	if(shot_cost_percent > 0 && shot_cost_percent < 100)
		// The total amount of shots the fully charged energy gun can fire before running out
		var/max_shots = round(100/shot_cost_percent) - 1
		// How many shots left before the energy gun's current battery runs out of energy
		var/shots_left = round((round(clamp(cell.charge / cell.maxcharge, 0, 1) * 100))/shot_cost_percent) - 1
		pitch_to_use = LERP(1, 0.3, (1 - (shots_left/max_shots)) ** 2)

	var/sound/playing_sound = sound(suppressed ? suppressed_sound : fire_sound)
	playing_sound.pitch = pitch_to_use

	if(suppressed)
		playsound(src, playing_sound, suppressed_volume, vary_fire_sound, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(src, playing_sound, fire_sound_volume, vary_fire_sound)

/obj/item/gun/energy/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		cell.use(round(cell.charge / severity))
		chambered = null //we empty the chamber
		recharge_newshot() //and try to charge a new shot
		update_appearance()

/obj/item/gun/energy/get_cell(atom/movable/interface, mob/user)
	if(istype(interface, /obj/item/inducer))
		to_chat(user, span_alert("Error: unable to interface with [interface]."))
		return null
	return cell

/obj/item/gun/energy/Initialize(mapload)
	if(cell_type)
		cell = new cell_type(src)
	else
		cell = new(src)
	if(!dead_cell)
		cell.give(cell.maxcharge)
	update_ammo_types()
	. = ..()
	recharge_newshot(TRUE)
	if(selfcharge)
		START_PROCESSING(SSobj, src)
	update_appearance()
	update_overlays()
	RegisterSignal(src, COMSIG_ITEM_RECHARGED, PROC_REF(instant_recharge))
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/gun/energy/add_weapon_description()
	AddElement(/datum/element/weapon_description, attached_proc = PROC_REF(add_notes_energy))

/**
 *
 * Outputs type-specific weapon stats for energy-based firearms based on its firing modes
 * and the stats of those firing modes. Esoteric firing modes like ion are currently not supported
 * but can be added easily
 *
 */
/obj/item/gun/energy/proc/add_notes_energy()
	var/list/readout = list()
	// Make sure there is something to actually retrieve
	if(!ammo_type.len)
		return
	var/obj/projectile/exam_proj
	readout += "\nStandard models of this projectile weapon have [span_warning("[ammo_type.len] mode\s")]."
	readout += "Our heroic interns have shown that one can theoretically stay standing after..."
	if(projectile_damage_multiplier <= 0)
		readout += "a theoretically infinite number of shots on [span_warning("every")] mode due to esoteric or nonexistent offensive potential."
		return readout.Join("\n") // Sending over the singular string, rather than the whole list
	for(var/obj/item/ammo_casing/energy/for_ammo as anything in ammo_type)
		exam_proj = for_ammo.projectile_type
		if(!ispath(exam_proj))
			continue
		if(initial(exam_proj.damage) > 0) // Don't divide by 0!!!!!
			readout += "[span_warning("[HITS_TO_CRIT((initial(exam_proj.damage) * projectile_damage_multiplier) * for_ammo.pellets)] shot\s")] on [span_warning("[for_ammo.select_name]")] mode before collapsing from [initial(exam_proj.damage_type) == STAMINA ? "immense pain" : "their wounds"]."
			if(initial(exam_proj.stamina) > 0) // In case a projectile does damage AND stamina damage (Energy Crossbow)
				readout += "[span_warning("[HITS_TO_CRIT((initial(exam_proj.stamina) * projectile_damage_multiplier) * for_ammo.pellets)] shot\s")] on [span_warning("[for_ammo.select_name]")] mode before collapsing from immense pain."
		else
			readout += "a theoretically infinite number of shots on [span_warning("[for_ammo.select_name]")] mode."

	return readout.Join("\n") // Sending over the singular string, rather than the whole list

/obj/item/gun/energy/proc/update_ammo_types()
	var/obj/item/ammo_casing/energy/shot
	for (var/i in 1 to ammo_type.len)
		var/shottype = ammo_type[i]
		shot = new shottype(src)
		ammo_type[i] = shot
	shot = ammo_type[select]
	fire_sound = shot.fire_sound
	fire_delay = shot.delay

/obj/item/gun/energy/Destroy()
	if (cell)
		QDEL_NULL(cell)
	STOP_PROCESSING(SSobj, src)

	// Intentional cast.
	// Sometimes ammo_type has paths, sometimes it has atom.
	for (var/atom/item in ammo_type)
		qdel(item)
	ammo_type = null

	return ..()

/obj/item/gun/energy/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == cell)
		cell = null
		update_appearance()

/obj/item/gun/energy/process(seconds_per_tick)
	if(selfcharge && cell && cell.percent() < 100)
		charge_timer += seconds_per_tick
		if(charge_timer < charge_delay)
			return
		charge_timer = 0
		cell.give(self_charge_amount * seconds_per_tick)
		if(!chambered) //if empty chamber we try to charge a new shot
			recharge_newshot(TRUE)
		update_appearance()

/obj/item/gun/energy/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/melee/baton/security))
		return try_charging_with_batton(attacking_item, user)
	if(istype(attacking_item, /obj/item/stock_parts/power_store/cell))
		return try_insert_cell(attacking_item, user)
	. = ..()

/obj/item/gun/energy/proc/try_charging_with_batton(obj/item/melee/baton/security/stunbaton, mob/living/carbon/user)
	//Если батарея пуста или станбатон выключен - обычный удар по стволу
	if(has_empty_cell() || !stunbaton.active)
		stunbaton.attack_atom(src, user)
		return FALSE
	//Шанс может быть больше, если в это верить
	if(loc == user && prob(40))
		stunbaton.attack(user, user)
		return FALSE
	if(prob(25))
		do_sparks(3, source = src)
		qdel(cell)
		to_chat(user, span_warning("Из разъема для батареи разносится отвратительный горелый запах."))
		stunbaton.attack_atom(src, user)
		return FALSE
	//Ну это реально глупо. Кто будет в здравом уме бить электрической дубинкой по энергетическому оружие, чтобы зарядить его.
	if(cell.charge == cell.maxcharge)
		//НА ПУТИ К ФИАСКО
		if(prob(50))
			if(prob(50))
				explosion(src, 0, 0, 1, 2, 1, "[user] попытался зарядить [name] с помощью грубой силы.")
				qdel(cell)
				return FALSE
			else
				do_sparks(3, source = src)
				cell.use(cell.charge)
				to_chat(user, span_notice("Батарея издает подозрительный звук."))
				stunbaton.attack_atom(src, user)
				return FALSE
	if(prob(55))
		do_sparks(3, source = src)
		electrocute_mob(user, cell, src)
		cell.use(LASER_SHOTS(2, cell.maxcharge))
		stunbaton.attack_atom(src, user)
		return FALSE
	else
		//Если игрок прошел через все испытания он получает ААААААААААВТО. 5 патронов.
		cell.give(LASER_SHOTS(5, cell.maxcharge))
		to_chat(user, "Каким то образом батарея выдерживает твое гениальное действие.")
		stunbaton.attack_atom(src, user)
	return TRUE

/obj/item/gun/energy/proc/try_insert_cell(obj/item/stock_parts/power_store/cell/new_cell, mob/user)
	if(!new_cell)
		return FALSE
	if(latch_closed)
		to_chat(user, "Unlatch the power cell's retainment clip")
		return FALSE
	if(!has_empty_cell())
		if(tac_reloads)
			if(do_after(user, tactical_reload_delay, src, hidden = TRUE))
				if(insert_cell(user, new_cell))
					to_chat(user, span_notice("You perform a tactical reload on \the [src]."))
			else
				to_chat(user, span_warning("Your reload was interupted!"))
				return FALSE
		else
			to_chat(user, span_warning("Take out the battery first!"))
			return FALSE
	else
		if(insert_cell(user, new_cell))
			to_chat(user, span_notice("You insert battery in \the [src]."))

	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD) // Для СкайРатовского ХУДа.
	return TRUE

/obj/item/gun/energy/can_shoot()
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	return !QDELETED(cell) ? (cell.charge >= shot.e_cost) : FALSE

/obj/item/gun/energy/recharge_newshot(no_cyborg_drain)
	if (!ammo_type || !cell)
		return
	if(use_cyborg_cell && !no_cyborg_drain)
		if(iscyborg(loc))
			var/mob/living/silicon/robot/robot = loc
			if(robot.cell)
				var/obj/item/ammo_casing/energy/shot = ammo_type[select] //Necessary to find cost of shot
				shot.e_cost = initial(shot.e_cost) * cell.maxcharge / STANDARD_CELL_CHARGE
				battery_damage_multiplier = max(1 + (cell.maxcharge / (STANDARD_CELL_CHARGE * 200)), 1)
				if(robot.cell.use(shot.e_cost)) //Take power from the borg...
					cell.give(shot.e_cost) //... to recharge the shot
	if(!chambered)
		var/obj/item/ammo_casing/energy/AC = ammo_type[select]
		AC.e_cost = initial(AC.e_cost) * cell.maxcharge / STANDARD_CELL_CHARGE //LASER_SHOTS((initial(AC.e_cost) * (clamp(1 + (cell.maxcharge / STANDARD_CELL_CHARGE * 100), 1, 1.5))), cell.maxcharge)		//LASER_SHOTS(10, STANDARD_CELL_CHARGE)
		battery_damage_multiplier = max(1 + (cell.maxcharge / (STANDARD_CELL_CHARGE * 200)), 1)
		if(cell.charge >= AC.e_cost) //if there's enough power in the cell cell...
			chambered = AC //...prepare a new shot based on the current ammo type selected
			if(!chambered.loaded_projectile)
				chambered.newshot()

/obj/item/gun/energy/handle_chamber()
	if(chambered && !chambered.loaded_projectile) //if loaded_projectile is null, i.e the shot has been fired...
		var/obj/item/ammo_casing/energy/shot = chambered

		//if(cell.maxcharge > STANDARD_CELL_CHARGE)
		//	shot.e_cost = LASER_SHOTS(25, cell.maxcharge)//Лень пока что * (clamp(1 + cell.maxcharge/500, 0, 1))
		//else
		cell.use(shot.e_cost)//... drain the cell cell
	chambered = null //either way, released the prepared shot
	recharge_newshot() //try to charge a new shot

/obj/item/gun/energy/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(!chambered && can_shoot())
		process_chamber() // If the gun was drained and then recharged, load a new shot.
	..()
	if(!latch_closed && prob(65)) //make the cell slide out if it's fired while the retainment clip is unlatched, with a 65% probability
		to_chat(user, span_warning("The [src]'s cell falls out!"))
		eject_cell()
	return


/obj/item/gun/energy/process_burst(mob/living/user, atom/target, message = TRUE, params = null, zone_override="", randomized_gun_spread = 0, randomized_bonus_spread = 0, rand_spr = 0, iteration = 0)
	if(!chambered && can_shoot())
		process_chamber() // Ditto.
	return ..()

/obj/item/gun/energy/proc/select_fire(mob/living/user)
	select++
	if (select > ammo_type.len)
		select = 1
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	fire_sound = shot.fire_sound
	fire_delay = shot.delay
	if (shot.select_name && user)
		balloon_alert(user, "set to [shot.select_name]")
	chambered = null
	recharge_newshot(TRUE)
	update_appearance()

/obj/item/gun/energy/update_icon_state()
	var/skip_inhand = initial(inhand_icon_state) //only build if we aren't using a preset inhand icon
	var/skip_worn_icon = initial(worn_icon_state) //only build if we aren't using a preset worn icon

	if(skip_inhand && skip_worn_icon) //if we don't have either, don't do the math.
		return ..()

	var/ratio = get_charge_ratio()
	var/temp_icon_to_use = initial(icon_state)
	if(modifystate)
		var/obj/item/ammo_casing/energy/shot = ammo_type[select]
		temp_icon_to_use += "[shot.select_name]"

	temp_icon_to_use += "[ratio]"
	if(!skip_inhand)
		inhand_icon_state = temp_icon_to_use
	if(!skip_worn_icon)
		worn_icon_state = temp_icon_to_use
	return ..()


/obj/item/gun/energy/update_overlays()
	. = ..()
	if(!automatic_charge_overlays)
		return

	var/overlay_icon_state = "[icon_state]_charge"
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]

	if(modifystate)
		if(single_shot_type_overlay)
			. += "[icon_state]_[initial(shot.select_name)]"
		overlay_icon_state += "_[initial(shot.select_name)]"

	var/ratio = get_charge_ratio()
	if(ratio == 0 && display_empty)
		. += "[icon_state]_empty"
		return

	if(ismob(loc))
		var/mutable_appearance/latch_overlay
		latch_overlay = mutable_appearance('tff_modular/modules/evento_needo/icons/cell_latch.dmi')
		if(latch_closed)
			if(cell)
				latch_overlay.icon_state = "latch-on-full"
			else
				latch_overlay.icon_state = "latch-on-empty"
		else
			if(cell)
				latch_overlay.icon_state = "latch-off-full"
			else
				latch_overlay.icon_state = "latch-off-empty"
		. += latch_overlay

	if(shot_type_fluff_overlay)
		. += "[icon_state]_[initial(shot.select_name)]_extra"

	if(shaded_charge)
		. += "[icon_state]_charge[ratio]"
		return
	var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)
	for(var/i = ratio, i >= 1, i--)
		charge_overlay.pixel_w = ammo_x_offset * (i - 1)
		charge_overlay.pixel_z = ammo_y_offset * (i - 1)
		. += new /mutable_appearance(charge_overlay)


///Used by update_icon_state() and update_overlays()
/obj/item/gun/energy/proc/get_charge_ratio()
	return can_shoot() ? CEILING(clamp(cell.charge / cell.maxcharge, 0, 1) * charge_sections, 1) : 0
	// Sets the ratio to 0 if the gun doesn't have enough charge to fire, or if its power cell is removed.

/obj/item/gun/energy/suicide_act(mob/living/user)
	if(istype(user) && can_shoot() && can_trigger_gun(user) && user.get_bodypart(BODY_ZONE_HEAD))
		user.visible_message(span_suicide("[user] is putting the barrel of [src] in [user.p_their()] mouth. It looks like [user.p_theyre()] trying to commit suicide!"))
		sleep(2.5 SECONDS)
		if(user.is_holding(src))
			user.visible_message(span_suicide("[user] melts [user.p_their()] face off with [src]!"))
			playsound(loc, fire_sound, 50, TRUE, -1)
			var/obj/item/ammo_casing/energy/shot = ammo_type[select]
			cell.use(shot.e_cost)
			update_appearance()
			return FIRELOSS
		else
			user.visible_message(span_suicide("[user] panics and starts choking to death!"))
			return OXYLOSS
	else
		user.visible_message(span_suicide("[user] is pretending to melt [user.p_their()] face off with [src]! It looks like [user.p_theyre()] trying to commit suicide!</b>"))
		playsound(src, dry_fire_sound, 30, TRUE)
		return OXYLOSS

/obj/item/gun/energy/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, selfcharge))
			if(var_value)
				START_PROCESSING(SSobj, src)
			else
				STOP_PROCESSING(SSobj, src)
	. = ..()


/obj/item/gun/energy/ignition_effect(atom/A, mob/living/user)
	if(!can_shoot() || !ammo_type[select])
		shoot_with_empty_chamber()
		. = ""
	else
		var/obj/item/ammo_casing/energy/E = ammo_type[select]
		var/obj/projectile/energy/loaded_projectile = E.loaded_projectile
		if(!loaded_projectile)
			. = ""
		else if(loaded_projectile.damage <= 0 || loaded_projectile.damage_type == STAMINA)
			user.visible_message(span_danger("[user] tries to light [A.loc == user ? "[user.p_their()] [A.name]" : A] with [src], but it doesn't do anything. Dumbass."))
			playsound(user, E.fire_sound, 50, TRUE)
			playsound(user, loaded_projectile.hitsound, 50, TRUE)
			cell.use(E.e_cost)
			. = ""
		else if(loaded_projectile.damage_type != BURN)
			user.visible_message(span_danger("[user] tries to light [A.loc == user ? "[user.p_their()] [A.name]" : A] with [src], but only succeeds in utterly destroying it. Dumbass."))
			playsound(user, E.fire_sound, 50, TRUE)
			playsound(user, loaded_projectile.hitsound, 50, TRUE)
			cell.use(E.e_cost)
			qdel(A)
			. = ""
		else
			playsound(user, E.fire_sound, 50, TRUE)
			playsound(user, loaded_projectile.hitsound, 50, TRUE)
			cell.use(E.e_cost)
			. = span_rose("[user] casually lights [A.loc == user ? "[user.p_their()] [A.name]" : A] with [src]. Damn.")

/obj/item/gun/energy/proc/instant_recharge()
	SIGNAL_HANDLER
	if(!cell)
		return
	cell.charge = cell.maxcharge
	recharge_newshot(no_cyborg_drain = TRUE)
	update_appearance()

/obj/item/gun/energy/proc/insert_cell(mob/user, obj/item/stock_parts/power_store/C)
	if(!C)
		return FALSE
	if(cell)
		eject_cell()
	user.temporarilyRemoveItemFromInventory(C)
	if(!user.transferItemToLoc(C, src))
		qdel(C) // Если что-то пошло не так...
		return FALSE
	cell = C
	var/obj/item/ammo_casing/energy/shot = ammo_type[select] //Necessary to find cost of shot
	shot.e_cost = initial(shot.e_cost) * cell.maxcharge / STANDARD_CELL_CHARGE
	battery_damage_multiplier = max(1 + (cell.maxcharge / (STANDARD_CELL_CHARGE * 200)), 1)

	playsound(src, load_sound, load_sound_volume, load_sound_vary)
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	balloon_alert(user, "cell inserted")

//special is_type_in_list method to counteract problem with current method
/obj/item/gun/energy/proc/is_attachment_in_contents_list()
	for(var/content_item in contents)
		if(istype(content_item, /obj/item/attachment/))
			return TRUE
	return FALSE

/obj/item/gun/energy/proc/has_empty_cell()
	if(!cell)
		return TRUE
	return FALSE

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/gun/energy/attack_hand(mob/user, list/modifiers)
	if(!internal_magazine && loc == user && user.is_holding(src) && !has_empty_cell() && !latch_closed)
		eject_cell(user)
		return
	return ..()

/obj/item/gun/energy/attack_self(mob/living/user)
	if(latch_closed)
		unique_action(user)
	else if(!latch_closed)
		if(has_empty_cell())
			balloon_alert(user, "there is no cell!")
			return FALSE
		eject_cell(user)
	return ..()

/obj/item/gun/energy/proc/eject_cell(mob/user)
	playsound(src, load_sound, load_sound_volume, load_sound_vary)
	update_appearance()
	cell.update_appearance()
	if(user)
		to_chat(user, span_notice("You pull the cell out of \the [src]."))
		user.put_in_hands(cell)
	else
		cell.forceMove(drop_location())

	//cell = null

	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD) // Для СкайРатовского ХУДа.

	balloon_alert(user, "cell ejected")


/obj/item/gun/energy/screwdriver_act(mob/living/user, obj/item/I)
	if(!user.is_holding(src))
		return ..()
	var/choice = isnull(pin) ? FALSE : tgui_input_list(user, "Choose action", "Choice", list("Take pin out", "Cell-slot action"))
	if(choice == "Cell-slot action" || !choice)
		if(latch_closed)
			to_chat(user, span_notice("You start to unlatch the [src]'s power cell retainment clip..."))
			if(do_after(user, latch_toggle_delay, src))
				to_chat(user, span_notice("You unlatch the [src]'s power cell retainment clip " + span_red("OPEN") + "."))
				playsound(src, 'sound/items/taperecorder/taperecorder_play.ogg', 50, FALSE)
				tac_reloads = TRUE
				latch_closed = FALSE
				update_appearance()
			return ITEM_INTERACT_SUCCESS
		else if(!latch_closed)
			// if(!cell && is_attachment_in_contents_list())
			// 	return ..() //should bring up the attachment menu if attachments are added. If none are added, it just does leaves the latch open
			to_chat(user, span_warning("You start to latch the [src]'s power cell retainment clip..."))
			if (do_after(user, latch_toggle_delay, src))
				to_chat(user, span_notice("You latch the [src]'s power cell retainment clip " + span_green("CLOSED") + "."))
				playsound(src, 'sound/items/taperecorder/taperecorder_close.ogg', 50, FALSE)
				tac_reloads = FALSE
				latch_closed = TRUE
				update_appearance()
				return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/gun/energy/unique_action(mob/living/user)
	if(ammo_type.len > 1)
		select_fire(user)
		update_appearance()
