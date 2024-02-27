/obj/item/clothing/neck/cloak/officer
	name = "officer's coat"
	desc = "Officer's coat in RedSec colors with a big N on the back. The inside of the collar has a label with 'Cyrus' written on it."
	var/alternate_desc = "Officer's coat in Syndicate colors with a big S on the back. The inside of the collar has a label with 'Nova' written on it."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "mercreaper_cloak_nt"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	unique_reskin = list(
		"Nanotrasen" = "mercreaper_cloak_nt",
		"Syndicate" = "mercreaper_cloak_syndie"
	)

/obj/item/clothing/neck/cloak/officer/reskin_obj(mob/M)
	. = ..()
	if(icon_state == "mercreaper_cloak_syndie")
		desc = alternate_desc

/obj/item/clothing/suit/hooded/wintercoat/specialops
	name = "security long jacket"
	desc = "Long jacket developed by \"Armadayne\" for security officers. The Armadine logo is blue on the back. Made from materials to retain heat and can be used down to -20 Celsius."

	var/altname = "security winter long jacket"
	var/altdesc = "Long jacket developed by Armadain for security personnel working in harsh, low temperature conditions. Maintains body temperature at -40 Celsius. Armadine logo on the back in blue."

	icon = 'tff_modular/master_files/icons/donator/obj/clothing/suit.dmi'
	icon_state = "mercreapercoat_summer"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_state = "mercreapercoat_summer"

	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK

	unique_reskin = list(
		"Summer" = "mercreapercoat_summer",
		"Winter" = "mercreapercoat_winter"
	)

	hoodtype = /obj/item/clothing/head/hooded/winterhood/specialops

/obj/item/clothing/head/hooded/winterhood/specialops
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_state = "mercreaperhood_summer"
	unique_reskin = list(
		"Summer" = "mercreaperhood_summer",
		"Winter" = "mercreaperhood_winter"
	)

/obj/item/clothing/suit/hooded/wintercoat/specialops/reskin_obj(mob/M)
	. = ..()
	if(current_skin == "Winter")
		name = altname
		desc = altdesc

	var/obj/item/clothing/head/hooded/winterhood/specialops/resprited_hood = hood
	var/datum/component/toggle_attached_clothing/hood_comp = GetComponent(/datum/component/toggle_attached_clothing)

	resprited_hood.current_skin = current_skin
	resprited_hood.icon_state = resprited_hood.unique_reskin[current_skin][RESKIN_ICON_STATE]
	hood_comp.undeployed_overlay = mutable_appearance(worn_icon, "[worn_icon_state][hood_down_overlay_suffix]", -NECK_LAYER)

/obj/item/clothing/suit/hooded/wintercoat/specialops/AltClick(mob/user)
	. = ..()
	if(!current_skin)
		return
	icon_state = "[unique_reskin[current_skin][RESKIN_ICON_STATE]][zipped ? "_t" : ""]"
	worn_icon_state = "[unique_reskin[current_skin][RESKIN_WORN_ICON_STATE]][zipped ? "_t" : ""]"

	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		wearer.update_worn_oversuit()
