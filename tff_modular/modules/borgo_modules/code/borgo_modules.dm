// Handcuffs for borg
/obj/item/borg/apparatus/handcuff
	name = "handcuff storage apparatus"
	desc = "A special apparatus for carrying handcuffs and zipties"
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "borg_beaker_apparatus"
	storable = list(
		/obj/item/restraints/handcuffs,
	)
	var/image/stored_underlay

/obj/item/borg/apparatus/handcuff/Initialize(mapload)
	add_glass()
	RegisterSignal(stored, COMSIG_ATOM_UPDATED_ICON, PROC_REF(on_stored_updated_icon))
	update_appearance()
	return ..()

/obj/item/borg/apparatus/handcuff/Destroy()
	QDEL_NULL(stored)
	return ..()

/obj/item/borg/apparatus/handcuff/update_overlays()
	. = ..()
	if(stored_underlay)
		underlays -= stored_underlay
	if(!stored)
		return
	stored_underlay = image(stored)
	stored_underlay.layer = FLOAT_LAYER
	stored_underlay.plane = FLOAT_PLANE
	stored_underlay.pixel_w = 0
	stored_underlay.pixel_x = 0
	stored_underlay.pixel_y = 0
	stored_underlay.pixel_z = 0
	underlays += stored_underlay

/obj/item/borg/apparatus/handcuff/examine()
	. = ..()
	. += "The handcuff storage contains:"
	if(stored)
		var/obj/item/restraints/handcuffs = stored
		. += handcuffs.name
	else
		. += "Nothing."
	. += span_notice(" <i>Alt-click</i> will drop the stored handcuffs. ")

/obj/item/borg/apparatus/handcuff/click_alt(mob/living/silicon/robot/user)
	if(!stored)
		to_chat(user, span_notice("[src] is empty."))
		return CLICK_ACTION_BLOCKING

	var/obj/item/restraints/handcuffs = stored
	user.visible_message(span_notice("[user] dumps [handcuffs] from [src]."), span_notice("You dump [handcuffs] from [src]."))
	handcuffs.forceMove(drop_location())
	return CLICK_ACTION_SUCCESS
