/obj/item/phystool
	name = "Physical tool"
	desc = "A tool for manipulate object and create it."
	icon = 'tff_modular/master_files/icons/obj/architector_items.dmi'
	icon_state = "physgun_grayscale"
	inhand_icon_state = "physgun_grayscale"
	worn_icon_state = "physgun_grayscale"
	belt_icon_state = "physgun_grayscale"
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

	//Режим взаимодействия выбранный в данный момент.
	var/datum/phystool_mode/selected_mode
	//Режими, доступные для использования.
	var/list/datum/phystool_mode/avaible_modes = list(
		/datum/phystool_mode/build_mode,
		/datum/phystool_mode/spawn_mode,
	)
	//Разблокирован ли полный функционал инструмента.
	var/advanced = FALSE
	//Датум луча, во время использования.
	var/datum/beam/work_beam

/obj/item/phystool/Initialize(mapload)
	. = ..()
	for(var/datum/phystool_mode/mode_to_add in avaible_modes)
		mode_to_add = new()

/obj/item/phystool/AltClick(mob/user)
	. = ..()

	var/datum/phystool_mode/pick = tgui_input_list(user, "Select work mode:", "Phystool mode", avaible_modes)
	selected_mode = pick
	selected_mode.on_selected()
	playsound(user, 'tff_modular/modules/dm_construct13/sound/toolgun_select.ogg', 100, TRUE)

/obj/item/phystool/examine(mob/user)
	. = ..()
	if(!selected_mode)
		. += span_notice("No selected mode!")
		return
	. += span_notice(selected_mode.desc)

/obj/item/phystool/Destroy(force)
	. = ..()
	qdel(avaible_modes)

/obj/item/phystool/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!selected_mode)
		return
	if(!do_work_effect(target, user))
		return
	selected_mode.main_act(target, user)
	playsound(user, 'tff_modular/modules/dm_construct13/sound/toolgun_shot1.ogg', 100, TRUE)

/obj/item/phystool/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!selected_mode)
		return
	if(!do_work_effect(target, user))
		return
	selected_mode.secondnary_act(target, user)
	playsound(user, 'tff_modular/modules/dm_construct13/sound/toolgun_shot2.ogg', 100, TRUE)

/obj/item/phystool/use(used)
	. = ..()
	if(!selected_mode)
		return
	selected_mode.use_act()

/obj/item/phystool/proc/do_work_effect(atom/target, mob/user)
	if(!target)
		return FALSE
	work_beam = user.Beam(target, "light_beam", time = 3)
	return TRUE
