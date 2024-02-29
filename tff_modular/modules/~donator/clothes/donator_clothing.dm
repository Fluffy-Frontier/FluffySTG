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
	desc = "Long jacket developed by \"Armadyne\" for security officers. There is a blue Armadyne logo on the back. Made from materials to retain heat and can be used down to -20 Celsius."

	icon = 'tff_modular/master_files/icons/donator/obj/clothing/suit.dmi'
	icon_state = "mercreapercoat_summer"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_state = "mercreapercoat_summer"

	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK

	hoodtype = /obj/item/clothing/head/hooded/winterhood/specialops

/obj/item/clothing/suit/hooded/wintercoat/specialops/winter
	name = "security winter long jacket"
	desc = "Long jacket developed by \"Armadyne\" for security personnel working in harsh, low temperature conditions. There is a blue Armadyne logo on the back. Made from materials to retain heat and can be used down to -40 Celsius."

	icon_state = "mercreapercoat_winter"
	worn_icon_state = "mercreapercoat_winter"

	hoodtype = /obj/item/clothing/head/hooded/winterhood/specialops/winter

/obj/item/clothing/head/hooded/winterhood/specialops
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_state = "mercreaperhood_summer"

/obj/item/clothing/head/hooded/winterhood/specialops/winter
	worn_icon_state = "mercreaperhood_winter"
