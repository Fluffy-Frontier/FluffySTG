/datum/mod_theme/interdyne/dec
	name = "interdyne elite"
	desc = "A corpse-snatching and rapid-retrieval modsuit, resulting from a lucrative tech exchange between Interdyne Pharmaceutics and Cybersun Industries."
	extended_desc = "While Waffle Corp. and Azik Interstellar provide the means, Donk Co., Tiger Cooperative, Animal Rights Consortium and \
		Gorlex Marauders willing or easily bribable brawn, S.E.L.F. and MI13 information, the clear syndicate tech providers would be Interdyne and Cybersun, \
		their combined knowledge in technologies rivaled by only the most enigmatic of aliens, and certainly not by any Nanotrasen scientist. \
		This model is one of the rare fruits created by their joint operations, mashing scrapped designs with super soldier enhancements. \
		Already light, when powered on, this MODsuit injects the wearer seemlessly with muscle-enhancing supplements, while adding piston strength \
		to their legs. The combination of these mechanisms is very energy draining - but results in next to no speed reduction for the wearer.\
		Over the years, many a rich person, including Nanotrasen officials with premium subscriptions, had their life or genes rescued thanks to the \
		unrivaled speed of this suit. Equally as many, however, mysteriously disappeared in the flash of these white suits after they forgot \
		to pay off said subscriptions in due time or publicly communicated unfavourable opinions on Interdyne's gene-modding tech and ethics. "
	default_skin = "dec"
	armor_type = /datum/armor/mod_theme_interdyne
	variants = list(
		"dec" = list(
			MOD_ICON_OVERRIDE = 'tff_modular/modules/interdyne_dec_mod/icons/obj/mod_cloting.dmi',
			MOD_WORN_ICON_OVERRIDE = 'tff_modular/modules/interdyne_dec_mod/icons/mob/mod_clothing.dmi',
			MOD_SNOUT_ICON_OVERRIDE = 'tff_modular/modules/interdyne_dec_mod/icons/mob/mod_clothing_mutant.dmi',
			MOD_DIGITIGRADE_ICON_OVERRIDE = 'tff_modular/modules/interdyne_dec_mod/icons/mob/mod_clothing_mutant.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
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

/obj/item/mod/control/pre_equipped/interdyne/dec
	theme = /datum/mod_theme/interdyne/dec
	starting_frequency = MODLINK_FREQ_SYNDICATE
	applied_cell = /obj/item/stock_parts/power_store/cell/super

/obj/machinery/suit_storage_unit/interdyne/dec
	mask_type = /obj/item/clothing/mask/neck_gaiter
	storage_type = /obj/item/tank/internals/oxygen
	mod_type = /obj/item/mod/control/pre_equipped/interdyne/dec