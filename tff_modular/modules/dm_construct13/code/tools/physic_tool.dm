/obj/item/phystool
	name = "Phystool"
	desc = "Some kind of an revolver.. bluespace power cell and anomaly core connected together..."
	icon = 'tff_modular/master_files/icons/obj/architector_items.dmi'
	icon_state = "toolgun"
	inhand_icon_state = "toolgun"
	worn_icon_state = "toolgun"
	worn_icon = 'tff_modular/master_files/icons/mob/inhands/items/architector items_belt.dmi'
	lefthand_file = 'tff_modular/master_files/icons/mob/inhands/items/architector_items_lefthand.dmi'
	righthand_file = 'tff_modular/master_files/icons/mob/inhands/items/architector_items_righthand.dmi'
	demolition_mod = 0.5
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 1
	throw_range = 1
	drop_sound = 'sound/items/handling/screwdriver_drop.ogg'
	pickup_sound = 'tff_modular/modules/dm_construct13/sound/toolgun_select.ogg'
	resistance_flags = INDESTRUCTIBLE


	//Режим взаимодействия выбранный в данный момент.
	var/datum/phystool_mode/selected_mode
	//Режими, доступные для использования.
	var/list/datum/phystool_mode/avaible_modes = list(
		/datum/phystool_mode/build_mode,
		/datum/phystool_mode/spawn_mode,
		/datum/phystool_mode/color_mode,
		/datum/phystool_mode/size_mode,
	)
	//Датум луча, во время использования.
	var/datum/beam/work_beam

/obj/item/phystool/examine(mob/user)
	. = ..()
	. += span_notice("ALT + LMB on device, to choise work mode.")
	if(!selected_mode)
		. += span_notice("No selected mode!")
		return
	. += span_notice(selected_mode.desc)

/obj/item/phystool/AltClick(mob/user)
	. = ..()
	if(selected_mode)
		qdel(selected_mode)
	var/datum/phystool_mode/mode_to_select = tgui_input_list(user, "Select work mode:", "Phystool mode", avaible_modes)
	if(!mode_to_select)
		return
	selected_mode = new mode_to_select
	selected_mode.on_selected(user)
	playsound(user, 'tff_modular/modules/dm_construct13/sound/toolgun_select.ogg', 100, TRUE)

/obj/item/phystool/attack_self(mob/user)
	. = ..()
	if(!selected_mode)
		return
	selected_mode.use_act(user)

/obj/item/phystool/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!selected_mode)
		return
	if(!selected_mode.main_act(target, user))
		playsound(user, 'tff_modular/modules/dm_construct13/sound/toolgun_error.ogg', 100, TRUE)
		return
	do_work_effect(target, user)
	playsound(user, 'tff_modular/modules/dm_construct13/sound/toolgun_shot1.ogg', 100, TRUE)

/obj/item/phystool/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!selected_mode)
		return
	if(!selected_mode.secondnary_act(target, user))
		playsound(user, 'tff_modular/modules/dm_construct13/sound/toolgun_error.ogg', 100, TRUE)
		return
	do_work_effect(target, user)
	playsound(user, 'tff_modular/modules/dm_construct13/sound/toolgun_shot1.ogg', 100, TRUE)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/obj/item/phystool/proc/do_work_effect(atom/target, mob/user)
	if(!target)
		return
	work_beam = user.Beam(target, "light_beam", time = 3)
