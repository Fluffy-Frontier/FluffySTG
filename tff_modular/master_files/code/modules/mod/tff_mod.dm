/**
 * РнД МОД
 */

/obj/item/mod/construction/plating/rnd
	icon = 'tff_modular/master_files/icons/obj/mod.dmi'
	theme = /datum/mod_theme/rnd

/datum/mod_theme/rnd
	name = "scientist"
	desc = "An scientist-fit suit with heat, shock, fire and explosive resistance. Laplas anomalistic desing."
	default_skin = "rnd"
	armor_type = /datum/armor/mod_theme_rnd
	inbuilt_modules = list(/obj/item/mod/module/rig_module, /obj/item/mod/module/core_rnd)
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	siemens_coefficient = 0
	slowdown_inactive = 1
	slowdown_active = 0.7
	complexity_max = 15
	ui_theme = "ntos"
	allowed_suit_storage = list(
		/obj/item/construction/rcd,
		/obj/item/pipe_dispenser,
		/obj/item/analyzer,
	)
	skins = list(
		"rnd" = list(
			MOD_ICON_OVERRIDE = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'tff_modular/master_files/icons/mob/clothing/modsuits/tff_mod.dmi',
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
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
		"robotic" = list(
			MOD_ICON_OVERRIDE = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'tff_modular/master_files/icons/mob/clothing/modsuits/tff_mod.dmi',
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
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

/datum/armor/mod_theme_rnd
	melee = 5
	bullet = 5
	laser = 5
	energy = 5
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 10

/obj/item/mod/control/rnd
	worn_icon = 'tff_modular/master_files/icons/mob/clothing/modsuits/tff_mod.dmi'
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_clothing.dmi'
	icon_state = "rnd-control"
	theme = /datum/mod_theme/rnd

/obj/item/mod/control/pre_equipped/rnd
	worn_icon = 'tff_modular/master_files/icons/mob/clothing/modsuits/tff_mod.dmi'
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_clothing.dmi'
	icon_state = "rnd-control"
	theme = /datum/mod_theme/rnd
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	applied_cell = /obj/item/stock_parts/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/tether,
	)
