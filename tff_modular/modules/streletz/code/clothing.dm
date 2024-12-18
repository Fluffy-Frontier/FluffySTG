/obj/item/clothing/suit/armor/vest/alt/caftan
	name = "security caftan"
	desc = "This is a long and quite comfortable outfit, sitting tightly on the shoulders. Looks like it's from times of troubles."
	icon = 'tff_modular/modules/streletz/icons/obj/suit.dmi'
	worn_icon = 'tff_modular/modules/streletz/icons/mob/suit.dmi'
	icon_state = "caftan_red"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "caftan_red",
			RESKIN_WORN_ICON_STATE = "caftan_red"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "caftan_blue",
			RESKIN_WORN_ICON_STATE = "caftan_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "caftan_white",
			RESKIN_WORN_ICON_STATE = "caftan_white"
		),
	)

/obj/item/clothing/head/berendeyka
	name = "security beanie with band"
	desc = "Soft and armored beanie that toggles its order."
	icon = 'tff_modular/modules/streletz/icons/obj/hat.dmi'
	worn_icon = 'tff_modular/modules/streletz/icons/mob/hat.dmi'
	icon_state = "berendeyka_red"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	//supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "berendeyka_red",
			RESKIN_WORN_ICON_STATE = "berendeyka_red"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "berendeyka_blue",
			RESKIN_WORN_ICON_STATE = "berendeyka_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "berendeyka_white",
			RESKIN_WORN_ICON_STATE = "berendeyka_white"
		),
	)
