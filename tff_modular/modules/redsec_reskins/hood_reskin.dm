//из-за того что у шубы есть капюшон и возможность застегнуть пуговки, приходится перезаписывать кучу проков, поехали-и-и-и...
/obj/item/clothing/suit/hooded/wintercoat/security/reskin_obj(mob/M)
	. = ..()
	var/obj/item/clothing/head/hooded/winterhood/security/resprited_hood = hood
	if(!LAZYLEN(unique_reskin[current_skin]))
		return

	resprited_hood.current_skin = current_skin
	if(resprited_hood.unique_reskin[current_skin][RESKIN_ICON])
		resprited_hood.icon = resprited_hood.unique_reskin[current_skin][RESKIN_ICON]

	if(resprited_hood.unique_reskin[current_skin][RESKIN_ICON_STATE])
		resprited_hood.icon_state = resprited_hood.unique_reskin[current_skin][RESKIN_ICON_STATE]

	if(resprited_hood.unique_reskin[current_skin][RESKIN_WORN_ICON])
		resprited_hood.worn_icon = resprited_hood.unique_reskin[current_skin][RESKIN_WORN_ICON]

	if(resprited_hood.unique_reskin[current_skin][RESKIN_WORN_ICON_STATE])
		resprited_hood.worn_icon_state = resprited_hood.unique_reskin[current_skin][RESKIN_WORN_ICON_STATE]

	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		wearer.update_worn_oversuit()

//возможность "расстегнуть" шубу, поднимание капюшона и опускание ломает тестурку....
/obj/item/clothing/suit/hooded/wintercoat/security/AltClick(mob/user)
	. = ..()
	if(!current_skin)
		return
	worn_icon_state = "[unique_reskin[current_skin][RESKIN_WORN_ICON_STATE]][zipped ? "_t" : ""]"

	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		wearer.update_worn_oversuit()

/obj/item/clothing/suit/hooded/wintercoat/security/on_hood_down(obj/item/clothing/head/hooded/hood)
	. = ..()
	if(!current_skin)
		return
	icon_state = "[unique_reskin[current_skin][RESKIN_ICON_STATE]]"
	worn_icon_state = icon_state
	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		wearer.update_worn_oversuit()

/obj/item/clothing/suit/hooded/wintercoat/security/on_hood_up(obj/item/clothing/head/hooded/hood)
	. = ..()
	if(!current_skin)
		return
	if(hood_up)
		icon_state = "[unique_reskin[current_skin][RESKIN_ICON_STATE]][hood_up_affix]"
		worn_icon_state = icon_state
	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		wearer.update_worn_oversuit()

//капюшон зависит от самой шубы, убираем ему совсем возможность меняться
/obj/item/clothing/head/hooded/winterhood/security/reskin_obj(mob/M)
	return

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
