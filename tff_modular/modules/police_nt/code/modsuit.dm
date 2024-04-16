/datum/mod_theme/ntis_derevolutioner
	name = "derevolutioner"
	desc = "A prototype of the Magnate-class suit issued to NT Internal Security."
	default_skin = "ntis_derevolutioner"
	armor_type = /datum/armor/mod_theme_ntis_derevolutioner
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY + 5
	slowdown_inactive = 0.50
	slowdown_active = 0
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	skins = list(
		"ntis_derevolutioner" = list(
			MOD_ICON_OVERRIDE = 'tff_modular/modules/police_nt/icons/ntis_derevolutioner_icon.dmi',
			MOD_WORN_ICON_OVERRIDE = 'tff_modular/modules/police_nt/icons/ntis_derevolutioner_worn.dmi',
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
	)

/datum/armor/mod_theme_ntis_derevolutioner
	melee = 60
	bullet = 65
	laser = 60
	energy = 60
	bomb = 90
	bio = 100
	fire = 100
	acid = 100
	wound = 35

/obj/item/mod/control/pre_equipped/ntis_derevolutioner
	worn_icon = 'tff_modular/modules/police_nt/icons/ntis_derevolutioner_worn.dmi'
	icon = 'tff_modular/modules/police_nt/icons/ntis_derevolutioner_icon.dmi'
	icon_state = "ntis_derevolutioner-control"
	theme = /datum/mod_theme/ntis_derevolutioner
	applied_cell = /obj/item/stock_parts/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/quick_cuff,
		/obj/item/mod/module/emp_shield,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack/advanced,
	)

/obj/item/mod/control/pre_equipped/ntis_derevolutioner/set_mod_skin(new_skin)
	. = ..()
	if(new_skin == "ntis_derevolutioner")
		helmet.worn_icon_muzzled = 'tff_modular/modules/police_nt/icons/ntis_derevolutioner_worn_anthro.dmi'
		chestplate.worn_icon_digi = 'tff_modular/modules/police_nt/icons/ntis_derevolutioner_worn_anthro.dmi'
		boots.worn_icon_digi = 'tff_modular/modules/police_nt/icons/ntis_derevolutioner_worn_anthro.dmi'
