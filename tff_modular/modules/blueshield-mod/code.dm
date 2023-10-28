/datum/mod_theme/blueshield/New()
	allowed_suit_storage += list(
		/obj/item/storage/belt/holster/energy/blueshield
	)
	skins += list(
		"bodyguard" = list(
			MOD_ICON_OVERRIDE = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard.dmi',
			MOD_WORN_ICON_OVERRIDE = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard_worn.dmi',
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/obj/item/mod/control/pre_equipped/blueshield/set_mod_skin(new_skin)
	. = ..()
	if(new_skin == "bodyguard")
		helmet.worn_icon_muzzled = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard_anthro_worn.dmi'
		chestplate.worn_icon_digi = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard_anthro_worn.dmi'
		boots.worn_icon_digi = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard_anthro_worn.dmi'
