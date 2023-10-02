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
	var/list/names = list()
	var/list/opinions = list()
	for(var/datum/phystool_mode/mode in avaible_modes)
		names[mode.name] = REF(mode)
		var/image/target_image = image(icon = mode.mode_icon, icon_state = mode.mode_icon_state)
		opinions += list(mode.name = target_image)
	var/pick = show_radial_menu(user, src.loc, opinions, custom_check = FALSE, require_near = TRUE, tooltips = TRUE)
	if(!pick)
		return
	var/mode_reference = opinions[pick]
	selected_mode = locate(mode_reference) in avaible_modes
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
	if(!do_work_effect(target, user))
		return
	selected_mode.main_act(target, user)
	playsound(user, 'tff_modular/modules/dm_construct13/sound/toolgun_shot1.ogg', 100, TRUE)

/obj/item/phystool/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!do_work_effect(target, user))
		return
	selected_mode.secondnary_act(target, user)
	playsound(user, 'tff_modular/modules/dm_construct13/sound/toolgun_shot2.ogg', 100, TRUE)

/obj/item/phystool/proc/do_work_effect(atom/target, mob/user)
	if(!target)
		return FALSE
	work_beam = user.Beam(target, "light_beam", time = 5)
	return TRUE
