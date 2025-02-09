/datum/mod_theme/solfed
	hardlight_theme = "alert_amber" // ALERT_AMBER

/obj/item/mod/control/pre_equipped/solfed
	theme = /datum/mod_theme/solfed
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/headprotector,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/flashlight,
	)

/datum/mod_theme/solfed
	name = "solfed"
	desc = "A Solar Federation armored suit, offering quicker speed at the cost of modules capacity."
	extended_desc = "A Solar Federation classic, this series of MODsuits was designed for protecting its \
		user from workplace hazards while doing so in style."
	default_skin = "solfed"
	armor_type = /datum/armor/mod_theme_solfed
	complexity_max = DEFAULT_MAX_COMPLEXITY - 5
	slowdown_inactive = 1
	slowdown_active = 0.2
	variants = list(
		"solfed" = list(
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH,
				SEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
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

/datum/armor/mod_theme_solfed
	melee = 30
	bullet = 30
	laser = 30
	energy = 30
	bomb = 30
	bio = 100
	fire = 75
	acid = 75
	wound = 20

/obj/item/mod/construction/plating/solfed
	theme = /datum/mod_theme/solfed
