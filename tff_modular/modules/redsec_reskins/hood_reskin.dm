//Привязываем скин капюшона к самой шубе
/obj/item/clothing/suit/hooded/wintercoat/security/reskin_obj(mob/M)
	. = ..()
	if(!LAZYLEN(unique_reskin[current_skin]))
		return
	var/obj/item/clothing/head/hooded/winterhood/security/resprited_hood = hood
	var/datum/component/toggle_attached_clothing/hood_comp = GetComponent(/datum/component/toggle_attached_clothing) //оверлей опущенного капюшона записан в компоненте
	var/overlay_state

	resprited_hood.current_skin = current_skin
	if(resprited_hood.unique_reskin[current_skin][RESKIN_ICON])
		resprited_hood.icon = resprited_hood.unique_reskin[current_skin][RESKIN_ICON]

	if(resprited_hood.unique_reskin[current_skin][RESKIN_ICON_STATE])
		resprited_hood.icon_state = resprited_hood.unique_reskin[current_skin][RESKIN_ICON_STATE]

	if(resprited_hood.unique_reskin[current_skin][RESKIN_WORN_ICON_STATE])
		resprited_hood.worn_icon_state = resprited_hood.unique_reskin[current_skin][RESKIN_WORN_ICON_STATE]
		overlay_state = "[worn_icon_state][hood_down_overlay_suffix]"

	if(resprited_hood.unique_reskin[current_skin][RESKIN_WORN_ICON])
		resprited_hood.worn_icon = resprited_hood.unique_reskin[current_skin][RESKIN_WORN_ICON]
		if(overlay_state)
			hood_comp.undeployed_overlay = mutable_appearance(worn_icon, overlay_state, -SUIT_LAYER)

	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		wearer.update_worn_oversuit()

/obj/item/clothing/head/hooded/winterhood/security/reskin_obj(mob/M)
	return

//Переназначаем прок поднятия/опускания капюшона, так как в первоначальном виде смена стейтов текстурки привязана к initial(icon_state)
/datum/component/toggle_attached_clothing/toggle_deployable()
	. = ..()
	var/obj/item/parent_gear = parent
	var/mob/living/carbon/human/wearer = parent_gear.loc
	if (parent_gear.current_skin && parent_icon_state_suffix)
		parent_gear.icon_state = "[parent_gear.unique_reskin[parent_gear.current_skin][RESKIN_ICON_STATE]][currently_deployed ? parent_icon_state_suffix : ""]"
		parent_gear.worn_icon_state = parent_gear.icon_state
	parent_gear.update_slot_icon()
	wearer.update_mob_action_buttons()

//Тоже переназначаем растёгивание/застёгивание шубы из-за привязки смены текстуры к initial(icon_state)
/obj/item/clothing/suit/hooded/wintercoat/security/AltClick(mob/user)
	. = ..()
	if(!current_skin)
		return
	icon_state = "[unique_reskin[current_skin][RESKIN_ICON_STATE]][zipped ? "_t" : ""]"
	worn_icon_state = "[unique_reskin[current_skin][RESKIN_WORN_ICON_STATE]][zipped ? "_t" : ""]"

	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		wearer.update_worn_oversuit()

/obj/item/clothing/suit/hooded/wintercoat/security
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits/wintercoat.dmi',
			RESKIN_ICON_STATE = "coatsecurity_winter",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suits/wintercoat.dmi',
			RESKIN_WORN_ICON_STATE = "coatsecurity_winter"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/wintercoat.dmi',
			RESKIN_ICON_STATE = "coatsecurity",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/wintercoat.dmi',
			RESKIN_WORN_ICON_STATE = "coatsecurity"
		),
	)

/obj/item/clothing/head/hooded/winterhood/security
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/head/winterhood.dmi',
			RESKIN_ICON_STATE = "winterhood_security",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/head/winterhood.dmi',
			RESKIN_WORN_ICON_STATE = "winterhood_security"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'icons/obj/clothing/head/winterhood.dmi',
			RESKIN_ICON_STATE = "hood_security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/head/winterhood.dmi',
			RESKIN_WORN_ICON_STATE = "hood_security"
		),
	)
