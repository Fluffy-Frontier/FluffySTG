/datum/mod_theme/blueshield/New()
	allowed_suit_storage += list(
		/obj/item/storage/belt/holster/energy/blueshield
	)
	variants += list(
		"bodyguard" = list(
			MOD_ICON_OVERRIDE = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard.dmi',
			MOD_WORN_ICON_OVERRIDE = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard_worn.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT|HEADINTERNALS,
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
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
		),
	)

/datum/mod_theme/blueshield/set_skin(obj/item/mod/control/mod, skin)
	. = ..()
	if(skin == "bodyguard")
		for(var/obj/item/clothing/mod_part in mod.get_parts())
			if(istype(mod_part, /obj/item/clothing/head))
				mod_part.worn_icon_muzzled = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard_anthro_worn.dmi'
			if(istype(mod_part, /obj/item/clothing/suit) || istype(mod_part, /obj/item/clothing/shoes) )
				mod_part.worn_icon_digi = 'tff_modular/modules/blueshield-mod/icons/mod_bodyguard_anthro_worn.dmi'
