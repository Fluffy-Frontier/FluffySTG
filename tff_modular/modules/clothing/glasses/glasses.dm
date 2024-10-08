// Sprites of ballistic glasses by ebin_halcyon

/obj/item/clothing/glasses/hud/health/ballistic
	name = "ballistic health-check glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/modules/clothing/glasses/glasses.dmi'
	icon_state = "delingar_glasses_medical"
	worn_icon = 'tff_modular/modules/clothing/glasses/glasses_worn.dmi'

/obj/item/clothing/glasses/hud/diagnostic/ballistic
	name = "ballistic diagnostic glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/modules/clothing/glasses/glasses.dmi'
	icon_state = "delingar_glasses_diagnostic"
	worn_icon = 'tff_modular/modules/clothing/glasses/glasses_worn.dmi'

/obj/item/clothing/glasses/ballistic
	name = "ballistic glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/modules/clothing/glasses/glasses.dmi'
	icon_state = "delingar_glasses_yellow"
	worn_icon = 'tff_modular/modules/clothing/glasses/glasses_worn.dmi'

/obj/item/clothing/glasses/science/ballistic
	name = "ballistic science glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/modules/clothing/glasses/glasses.dmi'
	icon_state = "delingar_glasses_science"
	worn_icon = 'tff_modular/modules/clothing/glasses/glasses_worn.dmi'

/obj/item/clothing/glasses/hud/security/sunglasses/ballistic
	name = "ballistic security glasses"
	desc = "Made from the same cheap plastic as regular glasses. Don't expect them to help you. They have some strange orange shield logo on side."
	icon = 'tff_modular/modules/clothing/glasses/glasses.dmi'
	icon_state = "delingar_glasses_redsec"
	worn_icon = 'tff_modular/modules/clothing/glasses/glasses_worn.dmi'
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
	icon = 'tff_modular/modules/clothing/glasses/glasses.dmi'
	icon_state = "delingar_glasses_meson"
	worn_icon = 'tff_modular/modules/clothing/glasses/glasses_worn.dmi'
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
