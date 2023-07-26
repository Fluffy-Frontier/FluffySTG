#define TESHARI_ALT_HEATMOD 1.5
#define TESHARI_ALT_COLDMOD 0.20
#define TEHSARI_ALT_TEMP_OFFSET -50

/**
 * ТЕШАРИ - ПЕРЕРАБОТАННЫЕ
 *
 * Главный файл обьявляющий новую специю. Заменяет собой прошлых тешари.
 * Все файлы связанные со специей обозначаются, как teshari/alt - для удобства.
 */


/datum/species/teshari/alt
	name = "Teshari"
	id = SPECIES_TESHARI_ALT
	eyes_icon = 'modular_skyrat/modules/organs/icons/teshari_eyes.dmi'
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
		TRAIT_NO_UNDERWEAR,
		TRAIT_HAS_MARKINGS,
		TRAIT_WEAK_BODY,
		TRAIT_CAN_BUCKLED_TO_HAND
	)
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"ears" = ACC_RANDOM,
		"legs" = "Normal Legs"
	)
	payday_modifier = 0.75
	digitigrade_customization = DIGITIGRADE_NEVER
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = TESHARI_HEAD_ICON,
		LOADOUT_ITEM_MASK = TESHARI_MASK_ICON,
		LOADOUT_ITEM_NECK = TESHARI_NECK_ICON,
		LOADOUT_ITEM_SUIT = TESHARI_SUIT_ICON,
		LOADOUT_ITEM_UNIFORM = TESHARI_UNIFORM_ICON,
		LOADOUT_ITEM_HANDS =  TESHARI_HANDS_ICON,
		LOADOUT_ITEM_SHOES = TESHARI_FEET_ICON,
		LOADOUT_ITEM_GLASSES = TESHARI_EYES_ICON,
		LOADOUT_ITEM_BELT = TESHARI_BELT_ICON,
		LOADOUT_ITEM_MISC = TESHARI_BACK_ICON,
		LOADOUT_ITEM_ACCESSORY = TESHARI_ACCESSORIES_ICON,
		LOADOUT_ITEM_EARS = TESHARI_EARS_ICON
	)
	exotic_blood = /datum/reagent/blood/teshari
	coldmod = TESHARI_ALT_COLDMOD
	heatmod = TESHARI_ALT_HEATMOD
	bodytemp_normal = BODYTEMP_NORMAL + TEHSARI_ALT_TEMP_OFFSET
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + (TEHSARI_ALT_TEMP_OFFSET/2))
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + TEHSARI_ALT_TEMP_OFFSET)
	mutanttongue = /obj/item/organ/internal/tongue/teshari/alt
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/teshari/alt,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/teshari/alt,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/teshari/alt,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/teshari/alt,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/teshari/alt,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/teshari/alt,
	)

	var/datum/action/cooldown/teshari/agility/teshari_agility
	var/datum/action/cooldown/teshari/echolocation/teshari_echolocation

/datum/species/teshari/alt/on_species_gain(mob/living/carbon/human/C, datum/species/old_species, pref_load)
	. = ..()
	teshari_agility = new(C)
	teshari_agility.Grant(C)
	teshari_echolocation = new(C)
	teshari_echolocation.Grant(C)

/datum/species/teshari/alt/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	teshari_agility.Destroy()
	teshari_echolocation.Destroy()

/mob/living/carbon/human/species/teshari/alt
	race = /datum/species/teshari/alt

