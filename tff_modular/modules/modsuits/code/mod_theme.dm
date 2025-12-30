/datum/mod_theme
	// Должен ли этот вид МОД костюмов поступать вместе с модулем RIG
	var/install_rig = TRUE

/datum/mod_theme/rnd
	name = "scientist"
	desc = "A research mod suit with increased mobility, thermal protection, and enhanced armor for protection against explosions."
	extended_desc = "A classic reinforced suit designed by Laplas Anomalistic, this particular version features a custom color scheme \
					commissioned by Nanotransen. This model has a built-in computing module that simplifies working with anomalous materials. \
					Reinforced armor plates guarantee the user protection from external impacts, while a smart support system \
					inside the suit prevents injury to the user during sudden movements or falls from great heights. "
	default_skin = "rnd"
	armor_type = /datum/armor/mod_theme_rnd
	inbuilt_modules = list(/obj/item/mod/module/core_rnd)
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	activation_step_time = MOD_ACTIVATION_STEP_TIME * 0.5
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	slowdown_deployed = 0.5
	complexity_max = 15
	allowed_suit_storage = list(
		/obj/item/gun/energy/event_horizon,
		/obj/item/construction/rcd,
		/obj/item/pipe_dispenser,
		/obj/item/analyzer,
	)
	variants = list(
		"rnd" = list(
			MOD_ICON_OVERRIDE = 'tff_modular/modules/modsuits/icons/mod_icons/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'tff_modular/modules/modsuits/icons/worn_icons/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"robotic" = list(
			MOD_ICON_OVERRIDE = 'tff_modular/modules/modsuits/icons/mod_icons/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'tff_modular/modules/modsuits/icons/worn_icons/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_rnd
	melee = 10
	bullet = 15
	laser = 15
	energy = 10
	bomb = 100
	bio = 100
	fire = 70
	acid = 100
	wound = 10
