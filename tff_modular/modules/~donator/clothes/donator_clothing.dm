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

/obj/item/clothing/suit/teshari
	name = "teshari base"
	desc = "HOW YOU GET THIS?"
	icon = 'tff_modular/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_teshari = 'tff_modular/master_files/icons/donator/mob/clothing/suit.dmi'

/obj/item/clothing/suit/teshari/mob_can_equip(mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(!is_species(equipper, /datum/species/teshari))
		to_chat(equipper, span_warning("[src] is far too small for you!"))
		return FALSE
	return ..()

/obj/item/clothing/under/teshari
	name = "teshari base"
	desc = "HOW YOU GET THIS?"
	icon = 'tff_modular/master_files/icons/donator/mob/clothing/under.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/under.dmi'
	worn_icon_teshari = 'tff_modular/master_files/icons/donator/mob/clothing/under.dmi'

/obj/item/clothing/under/teshari/mob_can_equip(mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(!is_species(equipper, /datum/species/teshari))
		to_chat(equipper, span_warning("[src] is far too small for you!"))
		return FALSE
	return ..()

/obj/item/clothing/suit/teshari/furcoat
	name = "tenka fabric coat"
	desc = "This is a small tenka fabric coat, with slits for wings. It’s visible that it was sewn for a small creature."
	icon_state = "zanozkin_furcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/labcoat
	name = "lab coat"
	desc = "This is a very long laboratory coat and it has slits for wings."
	icon_state = "zanozkin_labcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/labcoat/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/teshari/graycoat
	name = "grey coat"
	desc = "This is a grey coat, it has hidden slits for wings, the material seems expensive and from a certain angle the bottom part seems transparent."
	icon_state = "zanozkin_strangeshirt"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/jacket
	name = "black jacket FZ"
	desc = "This is a black jacket from an unknown company with hidden slits for wings."
	icon_state = "zanozkin_coldcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/jacket/noblue
	icon_state = "zanozkin_coldcoat_noblue"


/obj/item/clothing/suit/teshari/russian_jacket
	name = "russian raptor coat"
	desc = "This is a fucking Russian jacket for raptors."
	icon_state = "zanozkin_coat_korea"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/aqua_cloak // тут действительно в виде suit.
	name = "short shirt FZ"
	desc = "This is a short shirt from an unknown company for small winged creatures"
	icon_state = "zanozkin_aquacloak"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/teshari/aqua_cloak/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/under/teshari/consultant
	name = "crocs suit"
	desc = "Crocs clothes for little winged creatures!"
	icon_state = "zanozkin_consultant"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/teshari/consultant/female
	name = "crocs skirt"
	icon_state = "zanozkin_consultant_skirt"

/obj/item/clothing/under/teshari/nt_combineso
	name = "combeniso NT"
	desc = "This jumpsuit was custom-made for workers of the Avali race near their homeland."
	icon_state = "zanozkin_nt"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/teshari/meme
	name = "shirt and shorts"
	desc = "It's just a shirt and shorts, but it reminds me of something."
	icon_state = "zanozkin_meme"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/teshari/elite_suit
	name = "elite feathered"
	desc = "White shirt, black bow tie and beige pants. This suit doesn't look bad."
	icon_state = "zanozkin_elite"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/teshari/elite_suit/plus
	name = "elite feathered deluxe"
	desc = "White shirt, black bow tie, beige jacket and beige pants. This suit doesn't look bad"
	icon_state = "zanozkin_eliteplus"

/obj/item/clothing/under/teshari/waistcoat
	name = "delicate suit"
	desc = "Costume for winged pick-up artist."
	icon_state = "zanozkin_waistcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/teshari/mechsuit
	name = "rivka"
	desc = "Personalized suit, it seems it was made to order and given as a gift"
	icon_state = "zanozkin_mechsuit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/neck/cloak/teshari/tenkacoat
	name = "small cloak"
	desc = "Just a small cloak... for avali?"
	icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "zanozkin_tenkacoat"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	worn_icon_teshari = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/neck/cloak/tendercloak
	name = "bayou old mantle"
	desc = "This is a very shabby (and time-worn) cape, it smells funny of silt."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "ten_neck"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'

/obj/item/clothing/neck/cloak/eldercoat
	name = "hunter's cloak"
	desc = "Just part of hunter's coat."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "eldercoat"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	resistance_flags = FIRE_PROOF

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

/obj/item/clothing/neck/cloak/haori
	name = "Flaming Haori"
	desc = "A white haori with a flaming pattern on the end. It seems to radiate heat and energy. It seems."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "romontesque_haori"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/clothing/glasses/hud/security/sunglasses/ballistic
	name = "ballistic security glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_redsec"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Default" = list(
			RESKIN_ICON_STATE = "delingar_glasses_redsec",
			RESKIN_WORN_ICON_STATE = "delingar_glasses_redsec"
		),
		"Blue" = list(
			RESKIN_ICON_STATE = "delingar_glasses_bluesec",
			RESKIN_WORN_ICON_STATE = "delingar_glasses_bluesec"
		),
		"Black" = list(
			RESKIN_ICON_STATE = "delingar_glasses_blacksec",
			RESKIN_WORN_ICON_STATE = "delingar_glasses_blacksec"
		),
	)

/obj/item/clothing/glasses/meson/ballistic
	name = "ballistic meson glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_meson"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Default" = list(
			RESKIN_ICON_STATE = "delingar_glasses_meson",
			RESKIN_WORN_ICON_STATE = "delingar_glasses_meson"
		),
		"Orange" = list(
			RESKIN_ICON_STATE = "delingar_glasses_yellow",
			RESKIN_WORN_ICON_STATE = "delingar_glasses_yellow"
		),
	)

// Sprites of ballistic glasses by ebin_halcyon

/obj/item/clothing/glasses/hud/health/ballistic
	name = "ballistic health-check glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_medical"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'

/obj/item/clothing/glasses/hud/diagnostic/ballistic
	name = "ballistic diagnostic glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_diagnostic"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'

/obj/item/clothing/glasses/ballistic
	name = "ballistic glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_yellow"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'

/obj/item/clothing/glasses/science/ballistic
	name = "ballistic science glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "delingar_glasses_science"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/glasses.dmi'

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

/obj/item/clothing/neck/voidarr_cape
	name = "Voidarr personel cape"
	desc = "Garment fit for Voidarr workforce, darker than the void of stars, as though woven from the very shadow that falleth betwixt dusk and dawn. The cape doth glisten faintly, upon its length, there lieth a subtle sprinkling of moondust."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "smol42_voidarr_cape"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	resistance_flags = FIRE_PROOF
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Snow" = list(
			RESKIN_ICON_STATE = "smol42_voidarr_cape_snow",
			RESKIN_WORN_ICON_STATE = "smol42_voidarr_cape_snow"
		)
	)

/obj/item/clothing/neck/smoltrenchcoat
	name = "Secure Trenchcoat"
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "smol42_trenchcoat"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Snow" = list(
			RESKIN_ICON_STATE = "smol42_trenchcoat_white",
			RESKIN_WORN_ICON_STATE = "smol42_trenchcoat_white"
		),
		"Tin" = list(
			RESKIN_ICON_STATE = "smol42_trenchcoat_tin",
			RESKIN_WORN_ICON_STATE = "smol42_trenchcoat_tin"
		),
		"Blue" = list(
			RESKIN_ICON_STATE = "smol42_trenchcoat_blue",
			RESKIN_WORN_ICON_STATE = "smol42_trenchcoat_blue"
		)
	)

/obj/item/clothing/neck/mousecloak
	name = "Winter assault cloak"
	desc = "Life is all about doing whatever you want. Waterproof with handmade details, it includes special sleeves, detachable parts and zipper pockets."
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/cloaks.dmi'
	icon_state = "siamant_sectac_w"
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/neck.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/mousecloak/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "over shoulder")

// Uniform sprite copied from SS1984 Paradise Station

/obj/item/clothing/under/rank/nanotrasen_consultant/trurl
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/under.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/under.dmi'
	worn_icon_digi = 'tff_modular/master_files/icons/donator/mob/clothing/under_digi.dmi'
	desc = "Gold trim on space-black cloth, this uniform bears an inscription that reads \"N.A.V. Trurl \" on the left shoulder. Worn exclusively by officers of the Nanotrasen Navy."
	name = "NAV Trurl officer uniform"
	icon_state = "ued_trurl_uniform"
