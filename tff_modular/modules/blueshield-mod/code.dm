/datum/mod_theme/blueshield
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/storage/belt/holster/energy/blueshield,
	)
	skins = list(
		"praetorian" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/blueshield/icons/praetorian.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/blueshield/icons/worn_praetorian.dmi',
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
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

/obj/item/mod/control/pre_equipped/bodyguard/Initialize(mapload, new_theme, new_skin, new_core)
	. = ..()
	helmet.worn_icon_muzzled = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard_anthro_worn.dmi'
	chestplate.worn_icon_digi = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard_anthro_worn.dmi'
	boots.worn_icon_digi = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard_anthro_worn.dmi'


/obj/machinery/suit_storage_unit/bodyguard
	storage_type = /obj/item/tank/internals/oxygen
	mod_type = /obj/item/mod/control/pre_equipped/bodyguard
