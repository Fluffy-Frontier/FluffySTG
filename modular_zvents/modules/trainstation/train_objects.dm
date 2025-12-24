/obj/machinery/door/train
	name = "Train door"

/obj/machinery/door/train/lock()
	. = ..()
	locked = TRUE

/obj/machinery/door/train/unlock()
	. = ..()
	locked = FALSE

/obj/machinery/door/train/open(forced)
	if(locked)
		if(usr)
			balloon_alert(usr, "Locked!")
			to_chat(usr, "Door is locked from other side!")
		return
	return ..()

/obj/machinery/door/train/close(forced)
	if(locked)
		if(usr)
			balloon_alert(usr, "Locked!")
			to_chat(usr, "Door is locked!")
		return
	return ..()

/obj/machinery/door/train/train_door
	name = "Train door"
	desc = "A solid metal door, often used in train carriages."
	icon = 'modular_zvents/icons/doors/train_door.dmi'
	has_access_panel = FALSE


/obj/machinery/door/train/train_door/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/redirect_attack_hand_from_turf, interact_check = CALLBACK(src, PROC_REF(drag_check)))

/obj/machinery/door/train/train_door/proc/drag_check(mob/user)
	if(user.pulling)
		return FALSE
	return TRUE

/obj/machinery/door/train/train_door/animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 1.5 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 1.5 SECONDS
		if(DOOR_DENY_ANIMATION)
			return 0.1 SECONDS

/obj/machinery/door/train/train_door/animation_segment_delay(animation)
	switch(animation)
		if(DOOR_OPENING_PASSABLE)
			return 1.4 SECONDS
		if(DOOR_OPENING_FINISHED)
			return 1.5 SECONDS
		if(DOOR_CLOSING_UNPASSABLE)
			return 0.2 SECONDS
		if(DOOR_CLOSING_FINISHED)
			return 1.5 SECONDS

/obj/machinery/door/train/coupe_door
	name = "Coupe door"
	desc = "A solid metal door, often used in train carriages."
	icon = 'modular_zvents/icons/doors/coupe_door.dmi'
	has_access_panel = FALSE

/obj/structure/table/train_table
	name = "Train table"
	desc = "A square piece of iron standing on metal leg. It can not move."
	icon = 'modular_zvents/icons/structures/trainstructures.dmi'
	icon_state = "table"
	base_icon_state = "table"
	density = TRUE
	anchored = TRUE
	pass_flags_self = PASSTABLE | LETPASSTHROW
	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT | IGNORE_DENSITY
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	max_integrity = 250
	integrity_failure = 0.33
	smoothing_flags = NONE
	smoothing_groups = NONE
	canSmoothWith = NONE
	can_flip = FALSE

/obj/structure/table/train_shelf
	name = "Train shelf"
	desc = "A metal simple shelf for storing things."
	icon = 'modular_zvents/icons/structures/trainstructures.dmi'
	icon_state = "shelf_metal"
	base_icon_state = "shelf_metal"
	density = FALSE
	anchored = TRUE
	pass_flags_self = LETPASSTHROW
	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT | IGNORE_DENSITY
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	max_integrity = 250
	integrity_failure = 0.33
	smoothing_flags = NONE
	smoothing_groups = NONE
	canSmoothWith = NONE
	can_flip = FALSE

/obj/structure/table/train_shelf/wood
	name = "Train wooden shelf"
	icon_state = "shelf_wood"
	base_icon_state = "shelf_wood"
	max_integrity = 150
	custom_materials = list(/datum/material/wood =SHEET_MATERIAL_AMOUNT)


/obj/structure/gangway
	name = "Train gangway"
	desc = "A durable insulated cover connecting two railcars together."
	icon = 'modular_zvents/icons/structures/trainstructures.dmi'
	icon_state = "gangway_still"
	base_icon_state = "gangway_still"
	max_integrity = 1000
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	flags_1 = NO_TURF_MOVEMENT

/obj/structure/gangway/Initialize(mapload)
	. = ..()
	RegisterSignal(SStrain_controller, COMSIG_TRAIN_BEGIN_MOVING, PROC_REF(on_train_begin_moving))
	RegisterSignal(SStrain_controller, COMSIG_TRAIN_STOP_MOVING, PROC_REF(on_train_stop_moving))

/obj/structure/gangway/Destroy(force)
	. = ..()
	UnregisterSignal(SStrain_controller, list(COMSIG_TRAIN_BEGIN_MOVING, COMSIG_TRAIN_STOP_MOVING))

/obj/structure/gangway/proc/on_train_begin_moving()
	SIGNAL_HANDLER

	icon_state = "gangway_moving"

/obj/structure/gangway/proc/on_train_stop_moving()
	SIGNAL_HANDLER

	icon_state = "gangway_still"



/obj/machinery/button/auto_detect
	// Устройство к которому мы подключены
	var/list/atom/connected_device = null
	// Предустановленный билд
	var/prebuild_type = null
	// Радиус поиска цели для коннекта
	var/find_range = 1
	// Список всех типов устройст к которым мы можем быть подключены
	var/static/connectable_devices = list(
		/obj/machinery/door,
		/obj/structure/curtain,
	)


/obj/machinery/button/auto_detect/Initialize(mapload)
	. = ..()
	detect_and_connect()

/obj/machinery/button/auto_detect/proc/is_avaible(atom/object)
	if(!istype(object))
		return FALSE
	if(prebuild_type && istype(object, prebuild_type))
		return TRUE
	for(var/type in connectable_devices)
		if(istype(object, type))
			return TRUE
	return FALSE

/obj/machinery/button/auto_detect/proc/detect_and_connect()
	var/turf/our_turf = get_turf(src)
	for(var/atom/A in range(our_turf, find_range))
		if(isturf(A))
			continue
		if(!is_avaible(A))
			continue
		LAZYADD(connected_device, A)

/obj/machinery/button/auto_detect/attempt_press(mob/user)
	. = ..()
	if(!.)
		return
	if(!length(connected_device))
		return
	for(var/atom/A in connected_device)
		if(istype(A, /obj/machinery/door))
			var/obj/machinery/door/D = A
			if(D.locked)
				D.unlock()
			else
				D.lock()
		if(istype(A, /obj/structure/curtain))
			var/obj/structure/curtain/C = A
			C.toggle()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/button/auto_detect, 24)
