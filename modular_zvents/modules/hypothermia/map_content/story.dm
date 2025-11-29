/obj/item/keycard/important
	name = "Important story key"
	color = COLOR_RED
	max_integrity = 250
	armor_type = /datum/armor/disk_nuclear
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/keycard/important/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/stationloving, TRUE)
	SSpoints_of_interest.make_point_of_interest(src)


/obj/item/keycard/important/hypothermia
	color = COLOR_BLUE_LIGHT


/obj/item/keycard/important/hypothermia/amory_key
	name = "Zvezda heavy armory key"

/obj/item/keycard/important/hypothermia/ship_control_key
	name = "Buran helm key"
	color = COLOR_GOLD
	desc = "Это ключ от консоли управления шатлом колониального класса 'Буран', без него шатл просто не получится запустить!"

/obj/item/story_item
	name = "Important story item"
	max_integrity = 250
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

	var/important_text = "Это важный сюжетный предмет! Не потеряйте его!"

/obj/item/story_item/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/stationloving, TRUE)
	SSpoints_of_interest.make_point_of_interest(src)

/obj/item/story_item/examine(mob/user)
	. = ..()
	. += span_boldwarning(important_text)


/obj/item/story_item/hypothermia_applied_ai_core
	name = "applied AI core"
	desc = "Старый позитронный мозг в треснутом корпусе. Кто-то гвоздём нацарапал «ТЫВОЖКА». Ещё едва работает."
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "spheribrain-searching"
	w_class = WEIGHT_CLASS_BULKY
	important_text = "Это единственный ИИ-модуль, способный управлять колониальным шаттлом. Без него корабль не взлетит!"


/obj/item/story_item/hypothermia_fusion_core
	name = "depleted fusion core"
	desc = "Тяжёлый микротермоядерный сердечник РБМК-класса. Последний в колонии. Холодный, но кольца удержания целы. Заправьте плазмой или урановыми листами — может и заработает."
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "syndicate-bomb-inactive-wires"
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 20
	important_text = "Без рабочего термоядерного сердечника двигатели шаттла не получат энергию. Вы не улетите с планеты!"

	var/refueled = FALSE

/obj/item/story_item/hypothermia_fusion_core/attackby(obj/item/W, mob/user, params)
	if(refueled)
		return ..()

	if(istype(W, /obj/item/stack/sheet/mineral/plasma))
		var/obj/item/stack/sheet/mineral/plasma/P = W
		if(P.amount >= 50)
			P.use(50)
			refueled = TRUE
			icon_state = "syndicate-bomb-active-wires"
			desc = "Тяжёлый микротермоядерный сердечник РБМК-класса. Теперь работает — кто-то засунул туда плазму и помолился."
			visible_message(span_notice("[user] запихивает плазменные листы в [src]. Сердечник начинает тихо гудеть."))
			return
		else
			balloon_alert(user, "Недостаточно материала!")
	if(istype(W, /obj/item/stack/sheet/mineral/uranium))
		var/obj/item/stack/sheet/mineral/uranium/U = W
		if(U.amount >= 50)
			U.use(50)
			refueled = TRUE
			icon_state = "syndicate-bomb-active-wires"
			desc = "Тяжёлый микротермоядерный сердечник РБМК-класса. Кто-то приварил урановые пластины. Он опасно раск... но даст мощность!"
			visible_message(span_danger("[user] вставляет урановые листы в [src]. Сердечник начинает тихо гудеть!"))
			return
		else
			balloon_alert(user, "Недостаточно материала!")
	return ..()


/obj/item/story_item/hypothermia_navigation_tape
	name = "navigation tape cassette"
	desc = "Пыльная магнитная лента с надписью «H1132 → EARTH». Единственная копия координат прыжка из этой системы. Без неё автопилот просто уведёт шаттл в солнце."
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "tape_yellow"
	w_class = WEIGHT_CLASS_SMALL
	important_text = "Это единственная лента с координатами Земли! Без неё шаттл улетит в никуда и вы сгорите в гиперпространстве!"


/obj/item/story_item/hypothermia_thermal_regulator
	name = "main thermal regulator valve"
	desc = "Огромный латунный клапан, вырванный из системы терморегуляции колонии. Без него двигатели шаттла перегреются и взорвутся через 30 секунд после старта."
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "valve_1"
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 15
	important_text = "Критически важный клапан терморегуляции! Без него двигатели шаттла взорвутся через полминуты полёта!"


// Шаблон шаттла
/datum/map_template/shuttle/zvezda
	port_id = "event"
	prefix = "_maps/modular_events/"
	suffix = "buran"
	name = "Buran-class Colonial Shuttle"
	description = "Колониальный шаттл класса «Буран». Единственный шанс выбраться с планеты."
	width = 23
	height = 30

/obj/docking_port/mobile/buran
	name = "Buran-class Colonial Shuttle"
	shuttle_id = "event"
	width = 23
	height = 30
	movement_force = list("KNOCKDOWN" = 0,"THROW" = 0)

/obj/docking_port/stationary/zvezda_buran
	name = "Buran docking port"
	hidden = FALSE
	dir = WEST


/obj/machinery/shuttle_launch_terminal
	name = "shuttle launch terminal"
	desc = "Терминал запуска шатла 'Буран'. Запускается только если все критические модули вставлены и авторизация подтверждена."
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"
	density = TRUE
	anchored = TRUE

	var/obj/item/story_item/hypothermia_applied_ai_core/ai_core
	var/obj/item/story_item/hypothermia_fusion_core/fusion_core
	var/obj/item/story_item/hypothermia_navigation_tape/nav_tape
	var/obj/item/story_item/hypothermia_thermal_regulator/thermal_reg

	var/ready_ai = FALSE
	var/ready_core = FALSE
	var/ready_nav = FALSE
	var/ready_therm = FALSE
	var/key_inserted = FALSE

	var/launch_time = 15 MINUTES
	var/time_left
	var/obj/docking_port/mobile/connected_port = null

	var/launching = FALSE


/obj/machinery/shuttle_launch_terminal/Initialize(mapload)
	. = ..()
	for(var/obj/docking_port/mobile/M in get_area(src))
		connected_port = M
		break

	if(!connected_port)
		stack_trace("Launch terminal placed without mobile docking port nearby!")
	add_filter("story_outline", 2, list("type" = "outline", "color" = "#fa3b3b", "size" = 1))


/obj/machinery/shuttle_launch_terminal/examine(mob/user)
	. = ..()
	check_modules()
	if(!ready_ai)
		. += span_warning("Отсутствует applied AI core!")
	if(!ready_core)
		. += span_warning("Отсутствует refueled fusion core!")
	if(!ready_nav)
		. += span_warning("Отсутствует navigation tape!")
	if(!ready_therm)
		. += span_warning("Отсутствует thermal regulator!")
	if(key_inserted)
		. += span_notice("Ключ вставлен.")
	else
		. += span_warning("Ключ не вставлен.")


/obj/machinery/shuttle_launch_terminal/proc/check_modules()
	ready_ai = !!ai_core
	ready_core = !!fusion_core
	ready_nav = !!nav_tape
	ready_therm = !!thermal_reg
	return ready_ai && ready_core && ready_nav && ready_therm


/obj/machinery/shuttle_launch_terminal/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/keycard/important/hypothermia/ship_control_key))
		if(key_inserted)
			to_chat(user, span_warning("Ключ уже вставлен."))
			return

		if(!check_modules())
			to_chat(user, span_warning("Сначала вставьте все критические модули!"))
			return

		balloon_alert(user, "Начинаю процедуру запуска!")
		visible_message(span_notice("[user] начинает процедуру запуска."))
		if(!do_after(user, 15 SECONDS, src))
			balloon_alert(user, "Процедура прервана!")
			return
		balloon_alert(user, "Запускаю шатл!")
		if(!user.transferItemToLoc(W, src))
			return

		key_inserted = TRUE
		to_chat(user, span_notice("Вы вставляете ключ в терминал."))
		visible_message(span_notice("[user] вставляет ключ управления в терминал запуска."))

		start_launch_countdown(user)
		return

	if(istype(W, /obj/item/story_item/hypothermia_applied_ai_core))
		if(ai_core)
			to_chat(user, span_warning("AI core уже вставлен!"))
			return

		if(!user.transferItemToLoc(W, src))
			return

		ai_core = W
		to_chat(user, span_notice("Вы вставляете [W] в терминал."))
		visible_message(span_notice("[user] вставляет [W] в терминал."))
		return

	if(istype(W, /obj/item/story_item/hypothermia_fusion_core))
		var/obj/item/story_item/hypothermia_fusion_core/core = W
		if(fusion_core)
			to_chat(user, span_warning("Fusion core уже вставлен!"))
			return

		if(!core.refueled)
			to_chat(user, span_warning("Fusion core - не заправлен!"))
			return

		if(!user.transferItemToLoc(W, src))
			return

		fusion_core = W
		to_chat(user, span_notice("Вы вставляете [W] в терминал."))
		visible_message(span_notice("[user] вставляет [W] в терминал."))
		return

	if(istype(W, /obj/item/story_item/hypothermia_navigation_tape))
		if(nav_tape)
			to_chat(user, span_warning("Navigation tape уже вставлена!"))
			return

		if(!user.transferItemToLoc(W, src))
			return

		nav_tape = W
		to_chat(user, span_notice("Вы вставляете [W] в терминал."))
		visible_message(span_notice("[user] вставляет [W] в терминал."))
		return

	if(istype(W, /obj/item/story_item/hypothermia_thermal_regulator))
		if(thermal_reg)
			to_chat(user, span_warning("Thermal regulator уже вставлен!"))
			return

		if(!user.transferItemToLoc(W, src))
			return

		thermal_reg = W
		to_chat(user, span_notice("Вы вставляете [W] в терминал."))
		visible_message(span_notice("[user] вставляет [W] в терминал."))
		return

	return ..()



/obj/machinery/shuttle_launch_terminal/proc/start_launch_countdown(mob/user)
	if(launching)
		return

	launching = TRUE
	time_left = launch_time

	priority_announce("Последовательность запуска шаттла инициирована. Запуск через 15 минут.", "Priority Alert", 'sound/effects/alert.ogg')

	addtimer(CALLBACK(src, PROC_REF(announce_remaining), 10), launch_time - 10 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(announce_remaining), 5), launch_time - 5 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(announce_remaining), 3), launch_time - 3 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(announce_remaining), 1), launch_time - 1 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(launch_shuttle)), launch_time)


/obj/machinery/shuttle_launch_terminal/proc/announce_remaining(minutes)
	priority_announce("Запуск шаттла через [minutes] минут[minutes > 1 ? "ы" : "у"].", "Priority Alert", 'sound/effects/alert.ogg')


/obj/machinery/shuttle_launch_terminal/proc/launch_shuttle()
	connected_port.destination = null
	connected_port.mode = SHUTTLE_IGNITING
	connected_port.setTimer(connected_port.ignitionTime)



/obj/item/climbing_hook/emergency/safeguard
	name = "safeguard climbing hook"
	desc = "An emergency climbing hook that automatically deploys when falling into a chasm, pulling the user to safety but causing injury."
	icon_state = "climbingrope_s"
	slot_flags = ITEM_SLOT_BELT

/obj/item/climbing_hook/emergency/safeguard/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_BELT && isliving(user))
		RegisterSignal(user, COMSIG_MOVABLE_CHASM_DROPPED, PROC_REF(on_chasm_drop))

/obj/item/climbing_hook/emergency/safeguard/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOVABLE_CHASM_DROPPED)

/obj/item/climbing_hook/emergency/safeguard/proc/on_chasm_drop(mob/living/user, turf/chasm_turf)
	SIGNAL_HANDLER
	if(user.stat == DEAD)
		return
	var/list/possible_turfs = list()
	for(var/turf/T in orange(2, chasm_turf))
		if(!T.density && !T.GetComponent(/datum/component/chasm) && isopenturf(T))
			possible_turfs += T
	if(!length(possible_turfs))
		return
	var/turf/safe_turf = get_closest_atom(/turf, possible_turfs, chasm_turf)
	if(!safe_turf)
		return
	chasm_turf.Beam(safe_turf, icon_state = "zipline_hook", time = 1 SECONDS)
	playsound(user, 'sound/items/weapons/zipline_fire.ogg', 50)
	chasm_turf.visible_message(span_warning("A climbing rope shoots out from [user] and latches onto [safe_turf]! [user] is pulled to safety!"))
	user.take_bodypart_damage(20)
	user.forceMove(safe_turf)
	user.Paralyze(5 SECONDS)
	return COMPONENT_NO_CHASM_DROP
