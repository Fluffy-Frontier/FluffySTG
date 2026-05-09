/obj/machinery/door/airlock/multi_tile/otw
	overlays_file = null
	icon = 'tff_modular/modules/asdasvasdqwe/structures/1x2blast_hor.dmi'
	opacity = TRUE

/obj/machinery/door/airlock/multi_tile/otw/vert
	dir = 4
	icon = 'tff_modular/modules/asdasvasdqwe/structures/1x2blast_vert.dmi'

/obj/machinery/door/airlock/multi_tile/oth
	overlays_file = null
	icon = 'tff_modular/modules/asdasvasdqwe/structures/1x3blast_hor.dmi'

/obj/machinery/door/airlock/multi_tile/oth/vert
	dir = 4
	icon = 'tff_modular/modules/asdasvasdqwe/structures/1x3blast_vert.dmi'

/obj/machinery/door/airlock/multi_tile/of
	overlays_file = null
	icon = 'tff_modular/modules/asdasvasdqwe/structures/1x4blast_hor.dmi'

/obj/machinery/door/airlock/multi_tile/of/vert
	dir = 4
	icon = 'tff_modular/modules/asdasvasdqwe/structures/1x4blast_vert.dmi'

/obj/machinery/door/airlock/blasty
	overlays_file = null
	icon = 'tff_modular/modules/asdasvasdqwe/structures/blastdoor.dmi'

/obj/machinery/door/airlock/firewindow
	opacity = FALSE
	overlays_file = null
	icon = 'tff_modular/modules/asdasvasdqwe/structures/doorfirewindow.dmi'

/obj/machinery/door/airlock/gates
	opacity = FALSE
	overlays_file = null
	icon = 'tff_modular/modules/asdasvasdqwe/structures/gates.dmi'

/obj/machinery/door/airlock/shutterr
	opacity = FALSE
	overlays_file = null
	icon = 'tff_modular/modules/asdasvasdqwe/structures/shutters.dmi'

/obj/machinery/door/airlock/crusher
	opacity = FALSE
	overlays_file = null
	icon = 'tff_modular/modules/asdasvasdqwe/structures/crusher.dmi'

/obj/machinery/door/airlock/old_grey
	overlays_file = null
	icon = 'tff_modular/modules/asdasvasdqwe/ship/airlock_grey.dmi'

/obj/machinery/door/airlock/old_red
	overlays_file = null
	icon = 'tff_modular/modules/asdasvasdqwe/ship/ancient.dmi'




/obj/structure/mirrorr
	icon = 'tff_modular/modules/asdasvasdqwe/structures/toolabnormalities.dmi'
	icon_state = "mirror"
	anchored = TRUE
	density = TRUE

/obj/structure/vivavoce
	icon = 'tff_modular/modules/asdasvasdqwe/structures/toolabnormalities.dmi'
	icon_state = "vivavoce"
	anchored = TRUE
	density = TRUE

/obj/structure/wishwell
	icon = 'tff_modular/modules/asdasvasdqwe/structures/toolabnormalities.dmi'
	icon_state = "wishwell"
	anchored = TRUE
	density = TRUE

/obj/structure/slab
	icon = 'tff_modular/modules/asdasvasdqwe/structures/toolabnormalities.dmi'
	icon_state = "slab"
	anchored = TRUE
	density = TRUE

/obj/structure/cavein
	icon = 'tff_modular/modules/asdasvasdqwe/structures/lc13_structures.dmi'
	icon_state = "cavein_floor"
	anchored = TRUE
	density = TRUE

/obj/structure/wall_vent
	icon = 'tff_modular/modules/asdasvasdqwe/structures/lc13_structures.dmi'
	icon_state = "wall_vent"
	anchored = TRUE

/obj/structure/fishman
	icon = 'tff_modular/modules/asdasvasdqwe/structures/lc13_structures.dmi'
	icon_state = "fish_machine"
	anchored = TRUE
	density = TRUE

/obj/structure/fishcan
	icon = 'tff_modular/modules/asdasvasdqwe/structures/lc13_structures.dmi'
	icon_state = "fish_cannery"
	anchored = TRUE
	density = TRUE

/obj/structure/tripwire
	icon = 'tff_modular/modules/asdasvasdqwe/structures/lc13_structures.dmi'
	icon_state = "tripwire"



/obj/structure/compostbin
	icon = 'tff_modular/modules/asdasvasdqwe/structures/farming_structures.dmi'
	icon_state = "compostbin"
	anchored = TRUE
	density = TRUE

/obj/structure/sextractor
	icon = 'tff_modular/modules/asdasvasdqwe/structures/farming_structures.dmi'
	icon_state = "sextractor_manual"
	anchored = TRUE
	density = TRUE

/obj/structure/gardentool
	icon = 'tff_modular/modules/asdasvasdqwe/structures/farming_structures.dmi'
	icon_state = "gardentool"
	anchored = TRUE
	density = TRUE
	//-5 -broken

/obj/structure/rackbroken
	icon = 'tff_modular/modules/asdasvasdqwe/structures/farming_structures.dmi'
	icon_state = "rack-broken"
	anchored = TRUE
	density = TRUE

/obj/structure/seedbin
	icon = 'tff_modular/modules/asdasvasdqwe/structures/farming_structures.dmi'
	icon_state = "seedbin"
	anchored = TRUE
	density = TRUE
	//-5 -broken

/obj/structure/growbin
	icon = 'tff_modular/modules/asdasvasdqwe/structures/farming_structures.dmi'
	icon_state = "grownbin"
	anchored = TRUE
	density = TRUE
	//-1 -5 -broken

/obj/structure/soil
	icon = 'tff_modular/modules/asdasvasdqwe/structures/farming_structures.dmi'
	icon_state = "soil"
	anchored = TRUE
	density = TRUE

/obj/structure/rackk
	icon = 'tff_modular/modules/asdasvasdqwe/structures/farming_structures.dmi'
	icon_state = "rack"
	anchored = TRUE
	density = TRUE
	//-5 -broken





/obj/structure/generat
	name = "Генератор"
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "regen"
	density = TRUE
	//_alert _dull _broken
	anchored = TRUE

/obj/structure/radio
	name = "Радио"
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "radio"
	density = TRUE
	//-on
	anchored = TRUE

/obj/structure/radio/wrench_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_FAILURE

/obj/structure/book
	name = "Книга на столе"
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "book_0"
	density = TRUE
	//book_3

/obj/structure/altarr
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "altar"
	anchored = TRUE
	density = TRUE

/obj/structure/oceanicvendor
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "oceanicwaves"
	anchored = TRUE
	density = TRUE

/obj/structure/meatvine
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "meatvine"
	anchored = TRUE
	density = TRUE

/obj/structure/meatboi
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "meatboi"
	anchored = TRUE
	density = TRUE

/obj/structure/silent_girl_corpse
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "silent_girl_corrosion_dead"
	anchored = TRUE

/obj/structure/envysin_body
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "envysin_dead"
	anchored = TRUE
	density = TRUE

/obj/structure/pedestal
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x48.dmi'
	icon_state = "bough_pedestal"
	anchored = TRUE
	density = TRUE

/obj/structure/lastshot
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x48.dmi'
	icon_state = "last_shot"
	anchored = TRUE
	density = TRUE

/obj/structure/tentacle
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/48x64.dmi'
	icon_state = "violet_dusk_tentacle"
	anchored = TRUE
	density = TRUE
	//_ability

/obj/structure/green_dusk
	name = "Генератор"
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x48.dmi'
	icon_state = "green_dusk"
	density = TRUE
	//_create _dead _1 _2 _3
	anchored = TRUE

/obj/structure/green_dusk/wrench_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_FAILURE

/obj/structure/broken_monolith
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "violet_midnightr_dead"
	anchored = TRUE
	density = TRUE
	//violet_midnight r w b p _dead

/obj/structure/thunderbird
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "thunderbird"
	anchored = TRUE
	density = TRUE
	//_altar

/obj/structure/doomsday
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "doomsday_inert"
	anchored = TRUE
	density = TRUE
	//doomsday _active _angry

/obj/structure/kqe_heart
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "kqe_heart"
	anchored = TRUE
	density = TRUE

/obj/structure/lovetown_slumberer
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "lovetown_slumberer"
	anchored = TRUE
	density = TRUE

/obj/structure/ymbh
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x64.dmi'
	icon_state = "YMBH"
	anchored = TRUE
	density = TRUE
	//_YES _NO

/obj/structure/idol
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x96.dmi'
	icon_state = "flesh_idol"
	anchored = TRUE
	density = TRUE

/obj/structure/burrowing
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/96x96.dmi'
	icon_state = "burrowingheaven_contained"
	anchored = TRUE
	density = TRUE
	//_breached

/obj/structure/house
	name = "Дом"
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/96x96.dmi'
	icon_state = "House"
	density = TRUE
	//_damaged _broken
	anchored = TRUE

/obj/structure/house/wrench_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_FAILURE

/obj/structure/intercomy
	icon = 'tff_modular/modules/asdasvasdqwe/ship/radio.dmi'
	icon_state = "intercom"
	//wideband -table

/obj/structure/wreck_stuff
	name = "Поломанная машинерия"
	icon = 'tff_modular/modules/asdasvasdqwe/ship/salvage_structure.dmi'
	icon_state = "wreck_protolathe"
	density = TRUE
	anchored = TRUE

/obj/structure/wreck_stuff/wrench_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_FAILURE

/obj/structure/wreck_stuff/b
	icon_state = "wreck_circuit_imprinter"

/obj/structure/wreck_stuff/c
	icon_state = "wreck_d_analyzer"

/obj/structure/wreck_stuff/d
	icon_state = "wreck_autolathe"

/obj/structure/wreck_stuff/e
	icon_state = "wreck_remains"

/obj/structure/wreck_stuff/f
	icon_state = "wreck_server"

/obj/structure/wreck_stuff/g
	icon_state = "makeshift_frame3_Wooden"

/obj/structure/wreck_stuff/h
	icon_state = "makeshift_frame3_Metal"

/obj/structure/wreck_stuff/aa
	icon_state = "wreck_pda"

/obj/structure/wreck_stuff/ab
	icon_state = "computer_broken"









/obj/machinery/quantumpad/special
	icon = 'icons/obj/machines/destructive_scanner.dmi'
	icon_state = "tube_open"

/obj/machinery/quantumpad/special/doteleport(mob/user = null, obj/machinery/quantumpad/target_pad)
	var/target_turf = pick(SSjob.firsto_randoms)

	var/atom/pickup_zone = drop_location()
	for(var/atom/movable/to_pickup in pickup_zone)
		if(to_pickup == src)
			continue
		if(istype(to_pickup, /mob/living/carbon/human))
			var/mob/living/carbon/human/player = to_pickup
			player.addmrak()
			player.add_fov_trait(src, FOV_270_DEGREES)
		to_pickup.forceMove(src)
	teleporting = TRUE
	flick("tube_down", src)
	playsound(get_turf(src), 'sound/items/weapons/flash.ogg', 25, TRUE)
	playsound(src, 'sound/machines/destructive_scanner/TubeDown.ogg', 100)
	addtimer(CALLBACK(src, PROC_REF(teleport_contents), user, target_turf), teleport_speed)

/obj/machinery/quantumpad/special/teleport_contents(mob/user, turf/target_turf)
	teleporting = FALSE
	if(machine_stat & NOPOWER)
		if(user)
			to_chat(user, span_warning("[src] is unpowered!"))
		return

	last_teleport = world.time

	// use a lot of power
	use_energy(active_power_usage / power_efficiency)
	sparks()

	playsound(get_turf(src), 'sound/items/weapons/emitter2.ogg', 25, TRUE)
	playsound(target_turf, 'sound/items/weapons/emitter2.ogg', 25, TRUE)

	for(var/atom/movable/ROI in get_turf(src))
		if(QDELETED(ROI))
			continue //sleeps in CHECK_TICK

		// if is anchored, don't let through
		if(ROI.anchored)
			continue

		if(isliving(ROI))
			var/mob/living/living_subject = ROI
			//only TP living mobs buckled to non anchored items
			if(living_subject.buckled && living_subject.buckled.anchored)
				continue

			living_subject.addvhs()
			living_subject.removemrak()
		do_teleport(ROI, target_turf, no_effects = TRUE, channel = TELEPORT_CHANNEL_QUANTUM)

		CHECK_TICK















GLOBAL_LIST_EMPTY(global_teleporters_entrance)

GLOBAL_LIST_EMPTY(global_teleporters_exit)

//LOCATION = LIST()
GLOBAL_LIST_EMPTY(mainlocation_random_teleporters)

//LOCATION = LIST()
GLOBAL_LIST_EMPTY(global_id_teleporters)

GLOBAL_LIST_EMPTY(after_death_teleporters)


/obj/effect/teleporter
	name = "teleport"
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = ""

	var/my_id = "" as text

	var/target_id = "" as text

	var/teleport_chance = 0

/obj/effect/teleporter/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(teleport),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/teleporter/proc/teleport(datum/source, atom/movable/movable_atom)
	SIGNAL_HANDLER

	if(!prob(teleport_chance))
		return

	if(ishuman(movable_atom))
		. = movable_atom

	return .

/obj/effect/teleporter/dual
	name = "AtoB"

/obj/effect/teleporter/dual/Initialize(mapload)
	. = ..()
	if(my_id)
		GLOB.global_id_teleporters[my_id] = src

/obj/effect/teleporter/dual/teleport()
	. = ..()
	if(!.)
		return

	var/mob/living/victim = .

	var/turf/target_turf = get_turf(GLOB.global_id_teleporters[target_id])

	victim.forceMove(target_turf)
	return


/obj/effect/teleporter/fromto
	name = "AtoBBB"

	var/from = FALSE

/obj/effect/teleporter/fromto/Initialize(mapload)
	. = ..()
	if(target_id)
		if(islist(GLOB.global_teleporters_entrance[target_id]))
			GLOB.global_teleporters_entrance[target_id] += src
		else
			GLOB.global_teleporters_entrance[target_id] = list(src)

/obj/effect/teleporter/fromto/teleport()
	. = ..()
	if(!. || !target_id)
		return

	var/mob/living/victim = .
	var/turf/target_turf = get_turf(pick(GLOB.global_teleporters_entrance[target_id]))

	victim.forceMove(target_turf)

/obj/effect/teleporter/death
	name = "deathToB"

	var/level = 1

/obj/effect/teleporter/death/Initialize(mapload)
	. = ..()
	if(!islist(GLOB.after_death_teleporters[level]))
		GLOB.after_death_teleporters[level] = list()
	GLOB.after_death_teleporters[level] += src

/*
/obj/machinery/quantumpad/special/doteleport(mob/user = null, obj/machinery/quantumpad/target_pad = linked_pad)
	if(!target_pad)
		return
	var/atom/pickup_zone = drop_location()
	for(var/atom/movable/to_pickup in pickup_zone)
		if(to_pickup == src)
			continue
		if(istype(to_pickup, /mob/living/carbon/human))
			var/mob/living/carbon/human/player = to_pickup
			player.addmrak()
		to_pickup.forceMove(src)
	teleporting = TRUE
	flick("tube_down", src)
	playsound(get_turf(src), 'sound/items/weapons/flash.ogg', 25, TRUE)
	playsound(src, 'sound/machines/destructive_scanner/TubeDown.ogg', 100)
	addtimer(CALLBACK(src, PROC_REF(teleport_contents), user, target_pad), teleport_speed)

/obj/machinery/quantumpad/special/teleport_contents(mob/user, obj/machinery/quantumpad/target_pad)
	teleporting = FALSE
	if(machine_stat & NOPOWER)
		if(user)
			to_chat(user, span_warning("[src] is unpowered!"))
		return
	if(QDELETED(target_pad) || target_pad.machine_stat & NOPOWER)
		if(user)
			to_chat(user, span_warning("Linked pad is not responding to ping. Teleport aborted."))
		return

	last_teleport = world.time

	// use a lot of power
	use_energy(active_power_usage / power_efficiency)
	sparks()
	target_pad.sparks()

	var/target_turf = get_turf(target_pad)
	playsound(get_turf(src), 'sound/items/weapons/emitter2.ogg', 25, TRUE)
	playsound(target_turf, 'sound/items/weapons/emitter2.ogg', 25, TRUE)

	for(var/atom/movable/ROI in get_turf(src))
		if(QDELETED(ROI))
			continue //sleeps in CHECK_TICK

		// if is anchored, don't let through
		if(ROI.anchored)
			continue

		if(isliving(ROI))
			var/mob/living/living_subject = ROI
			//only TP living mobs buckled to non anchored items
			if(living_subject.buckled && living_subject.buckled.anchored)
				continue

		do_teleport(ROI, target_turf, no_effects = TRUE, channel = TELEPORT_CHANNEL_QUANTUM)
		CHECK_TICK
*/



/obj/structure/radio/starter

/obj/structure/radio/starter/proc/announce()
	for(var/mob/M in view(7, src))
		to_chat(M, "С резким шумом радио в комнате включается и начинает проигрывать запись.", confidential = TRUE)
	priority_announce("Приветствую, экипаж!\n\
		Вы были отобраны для проведения предварительного осмотра аномалии, обнаруженной на станции «Омега-329», в созвездии Скорпиона. По имеющимся данным, аномалия представляет собой нелинейное пространство, визуально напоминающее подсобные помещения торговых комплексов. \n\
		Перед входом вам будет выдано стандартное снаряжение: защитные костюмы четвёртого уровня, средства связи, фото- и видеорегистрации, а также базовые наборы для выживания. \n\
		Ваша задача — провести первичный анализ внутреннего пространства, задокументировать наблюдения и оценить потенциальные риски. \n\
		На распределение ролей и подготовку отводится 5 минут. \n\
		После этого вы обязаны приступить к экспедиции. \n\
		Время начала операции — 08:00 по местному времени. \n\
		Удачи!", "Исследовательский центр", 'tff_modular/modules/asdasvasdqwe/sounds/soundy/announce1.wav')









/obj/structure/generat/office
	name = "Сломанный Генератор"
	desc = "Внутри не хватает нескольких деталей. Может они где-то рядом..."
	icon_state = "regen_broken"
	anchored = TRUE
	var/iron_needed = 5
	var/silver_needed = 9
	var/titanium_needed = 15

	var/materials_collected = FALSE

/obj/structure/generat/office/examine(mob/user)
	. = ..()

	if(!materials_collected)
		. += "Для полного ремонта необходимо собрать:"
		. += "Железо: [span_red(iron_needed)] шт."
		. += "Серебро: [span_red(silver_needed)] шт."
		. += "Титаниум: [span_red(titanium_needed)] шт."
	else
		. += "Осталось закрутить детали [span_red("гаечным ключом")] и готово!"

/obj/structure/generat/office/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/wreck_stuff/metal) && iron_needed > 0)
		iron_needed--
		qdel(tool)
	if(istype(tool, /obj/item/wreck_stuff/e) && silver_needed > 0)
		silver_needed--
		qdel(tool)
	if(istype(tool, /obj/item/wreck_stuff/f) && titanium_needed > 0)
		titanium_needed--
		qdel(tool)

	if(iron_needed < 1 && silver_needed < 1 && titanium_needed < 1)
		materials_collected = TRUE
		icon_state = "regen_alert"
	playsound(src, 'sound/items/weapons/gun/general/mag_bullet_insert.ogg', 50, vary = FALSE)

/obj/structure/generat/office/wrench_act(mob/living/user, obj/item/tool)
	if(!materials_collected)
		return ITEM_INTERACT_FAILURE
	else
		playsound(src, 'tff_modular/modules/asdasvasdqwe/sounds/death.ogg', 50, vary = FALSE)
		var/area/event/office/generators/zone = get_area(src)
		zone.generator_on = TRUE
		icon_state = "regen"
		return ITEM_INTERACT_SUCCESS





/obj/structure/monitor
	name = "Монитор"

	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "monitor1"
	var/answer = ""
	anchored = TRUE


/obj/structure/monitor/wrench_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_FAILURE



/obj/structure/monitor/archive
	desc = "Для открытия шлюза нужно ввести правильный пароль. Подсказки находятся где-то в этой локации."

/obj/structure/monitor/archive/attack_hand(mob/living/user, list/modifiers)
	var/input = tgui_input_text(user, "Введи пароль:", "Ввод пароля")

/obj/structure/monitor/archive/inside

/obj/structure/monitor/archive/inside/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		priority_announce("Внимание!\n\
			Где-то внутри офисных помещений обнаружен зашифрованный сигнал. Найдите источник и зафиксируйте аномалию.", "Исследовательский центр")



/obj/structure/monitor/office

	desc = "Похоже, что нужно ввести голосовую команду. На правом нижнем углу экрана приклеен листок бумаги с текстом - 'Не забудь о шифре Цезаря.'"


/obj/structure/monitor/office/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_PRE_HEAR, PROC_REF(on_hear))

/obj/structure/monitor/office/proc/on_hear(datum/source, list/hearing_args)
	SIGNAL_HANDLER

	var/message = hearing_args[HEARING_RAW_MESSAGE]

	if(lowertext(message) == answer)
		INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, say), "Добро пожаловать в зону отдыха.")
		var/area/zone = get_area(src)
		var/obj/machinery/door/airlock/multi_tile/metal/door = locate(/obj/machinery/door/airlock/multi_tile/metal) in zone
		if(door)
			door.set_bolt(FALSE)
			INVOKE_ASYNC(door, TYPE_PROC_REF(/obj/machinery/door/airlock/multi_tile/metal, open))
		else
			to_chat(world, "failed to open mainlocation HOTEL")
	else
		INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, say), "Неверный пароль.")




/obj/machinery/computer/office_spec
	name = "Консоль"
	desc = "Терминал со включенным экраном. На нем видна консоль с текстом: 'Введите пароль'."
	icon_screen = "oldcomp_broken"
	icon_state = "oldcomp"


	var/static/list/codes = list(
		"code",
		"debug",
		""
	)

	var/static/list/guessed_codes = list(
		//123
	)


/obj/machinery/computer/office_spec/attack_hand(mob/living/user, list/modifiers)
	if(LAZYLEN(guessed_codes) - LAZYLEN(codes) < 1)
		to_chat(user, "Терминал отказывается работать.")
		return

	var/code = tgui_input_text(user, "Введите пароль:", "Ввод пароля", max_length = 10)

	if(code in codes && !(code in guessed_codes))
		guessed_codes += code
		to_chat(user, "Верный пароль. Осталось еще [span_red(LAZYLEN(guessed_codes) - LAZYLEN(codes))]")




/obj/machinery/computer/color_pass
	name = "Консоль"
	desc = "Терминал со включенным экраном. На нем видна консоль с текстом: ''."
	icon_screen = "oldcomp_broken"
	icon_state = "oldcomp"

	var/password = ""
	var/password_guessed = FALSE

/obj/machinery/computer/color_pass/attack_hand(mob/living/user, list/modifiers)

	if(password_guessed)
		return

	var/input = tgui_input_text(user, "Правильный ответ:", "Ввод пароля")

	if(!input || input != password)
		playsound(src, 'sound/machines/terminal/terminal_error.ogg', 50, FALSE)
		return

	icon_screen = "library"
	update_appearance()
	playsound(src, 'sound/machines/terminal/terminal_success.ogg', 50, FALSE)









/obj/machinery/door/airlock/old_red/office
	desc = "Не похоже на то, что шлюз можно открыть без питания."

/obj/machinery/door/airlock/old_red/office/open(forced)
	var/area/event/office/generators/zone = get_area(src)
	if(!zone.generator_on)
		return FALSE
	return ..()

/turf/open/floor/shock_water
	name = "Опасная лужа"
	desc = "Вода под высоким напряжением"

	icon = 'icons/turf/mining.dmi'
	icon_state = "wateryrock"
	base_icon_state = "wateryrock"

/turf/open/floor/shock_water/Entered(atom/movable/arrived)
	. = ..()

	if(istype(arrived, /mob/living/carbon/human))
		var/mob/living/carbon/human/player = arrived
		player.electrocute_act(25, src)
		player.visible_message(span_danger("[player] бьёт током!!"))
		player.emote("agony")














/* FUN */



/obj/structure/unffunyback
	name = "СКУЧНЫЙ МУСОРНЫЙ БАК =("
	desc = "НЕ ВЫБРАСЫВАЙ СЮДА ШАРИКИ =(!!!"
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "trashcartopen"
	density = TRUE
	anchored = TRUE
	var/toys_left = 10

/obj/structure/unffunyback/wrench_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_FAILURE

/obj/structure/unffunyback/examine(mob/user)
	. = ..()
	if(toys_left > 0)
		. += "НЕ СОБИРАЙ ЕЩЕ [span_red(toys_left)] ШАРИКОВ!!!!!!!!!!!!!!!!!"

/obj/structure/unffunyback/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/toy/balloon_animal) && toys_left > 0)
		toys_left--
		qdel(tool)
		flick("trashcart", src)
		playsound(src, 'sound/items/weapons/gun/general/mag_bullet_insert.ogg', 50, vary = FALSE)

	if(toys_left == 0)
		icon_state = "trashcart"
		var/area/zone = get_area(src)

		var/obj/machinery/door/airlock/multi_tile/oth/door = locate(/obj/machinery/door/airlock/multi_tile/oth) in zone
		if(door)
			door.set_bolt(FALSE)
			door.open()
			door.set_bolt(TRUE)
		else
			to_chat(world, "failed to open sublocation FUN")



/obj/structure/generat/generatorroom
	var/static/list/randoms = list("regen", "regen_alert", "regen_dull", "regen_broken")

/obj/structure/generat/generatorroom/Initialize(mapload)
	. = ..()
	icon_state = rand(randoms)

/obj/structure/wreck_stuff/random

/obj/structure/wreck_stuff/random/Initialize(mapload)
	. = ..()
	icon_state = rand(list("wreck_protolathe", "wreck_circuit_imprinter", "wreck_d_analyzer", "wreck_autolathe", "wreck_remains", "wreck_server", "makeshift_frame3_Wooden", "makeshift_frame3_Metal", "wreck_pda", "computer_broken"))

/obj/structure/green_dusk/random_generators
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/64x48.dmi'
	icon_state = "green_dusk"
	var/static/list/randoms = list("green_dusk", "green_dusk_dead",  "green_dusk_1", "green_dusk_2", "green_dusk_3")
