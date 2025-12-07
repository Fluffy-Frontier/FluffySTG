// TFF Донаторские костюмы и куртки

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

/obj/item/clothing/suit/jacket/leather/futuristic //Fluffs for PhenyaMomota, contributor and maintainer
	name = "futuristic jacket"
	desc = "This jacket is equipped with electronic components, lighting, heating and other additional mechanisms from the hi-tech world. Inside you can find a tag that says it is Charles Ray property."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/suit.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "/obj/item/clothing/suit/jacket/leather/futuristic"
	post_init_icon_state = "fjacket"
	worn_icon_state = "fjacket"
	greyscale_config = /datum/greyscale_config/fjacket
	greyscale_config_worn = /datum/greyscale_config/fjacket/worn
	greyscale_colors = "#ffd900#00b7ff"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/jacket/leather/futuristic/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance('tff_modular/master_files/icons/donator/mob/clothing/suit.dmi', "fjacket-emissive", src, alpha = src.alpha)

// Elder coat set - Full hunter outfit
/obj/item/clothing/under/eldercoat
	name = "hunter's uniform"
	desc = "Old-fashioned robes with a patterned pattern all over the clothes and a cape hanging from the left shoulder."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/under.dmi'
	icon_state = "eldercoat"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/under.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/clothing/shoes/eldercoat
	name = "leather boots"
	desc = "Old-fashioned leather boots in a dark shade"
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/shoes.dmi'
	icon_state = "eldercoat"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/shoes.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/clothing/gloves/eldercoat
	name = "leather gloves"
	desc = "Elongated leather gloves of an old-fashioned kind."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "eldercoat"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/gloves.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/eldercoat
	name = "three-cornered hat"
	desc = "A pointed leather hat in a dark shade with a protruding feather."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/head.dmi'
	icon_state = "eldercoat"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/head.dmi'
	resistance_flags = FIRE_PROOF

