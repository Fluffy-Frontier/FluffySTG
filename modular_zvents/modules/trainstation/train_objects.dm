/obj/machinery/door/train_door
	name = "Train door"
	desc = "A solid metal door, often used in train carriages."
	icon = 'modular_zvents/icons/doors/train_door.dmi'
	has_access_panel = FALSE


/obj/machinery/door/train_door/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/redirect_attack_hand_from_turf, interact_check = CALLBACK(src, PROC_REF(drag_check)))

/obj/machinery/door/train_door/proc/drag_check(mob/user)
	if(user.pulling)
		return FALSE
	return TRUE

/obj/machinery/door/train_door/animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 1.5 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 1.5 SECONDS
		if(DOOR_DENY_ANIMATION)
			return 0.1 SECONDS

/obj/machinery/door/train_door/animation_segment_delay(animation)
	switch(animation)
		if(DOOR_OPENING_PASSABLE)
			return 1.4 SECONDS
		if(DOOR_OPENING_FINISHED)
			return 1.5 SECONDS
		if(DOOR_CLOSING_UNPASSABLE)
			return 0.2 SECONDS
		if(DOOR_CLOSING_FINISHED)
			return 1.5 SECONDS

/obj/machinery/door/coupe_door
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
