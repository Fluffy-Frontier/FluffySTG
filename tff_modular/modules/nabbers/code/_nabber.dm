#define BASE_CLOTH_X_1 1
#define BASE_CLOTH_Y_1 1

#define NABBER_COLD_THRESHOLD_1 180
#define NABBER_COLD_THRESHOLD_2 140
#define NABBER_COLD_THRESHOLD_3 100

#define NABBER_HEAT_THRESHOLD_1 300
#define NABBER_HEAT_THRESHOLD_2 440
#define NABBER_HEAT_THRESHOLD_3 600

/datum/species/nabber
	name = "Giant Armored Serpentid"
	id = SPECIES_NABBER
	bodytype = BODYTYPE_CUSTOM
	eyes_icon = 'tff_modular/modules/nabbers/icons/organs/nabber_eyes.dmi'
	can_augment = FALSE
	veteran_only = FALSE //Change in the future.
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		NO_UNDERWEAR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
		TRAIT_PUSHIMMUNE,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE
	)
	no_equip_flags = ITEM_SLOT_FEET | ITEM_SLOT_OCLOTHING | ITEM_SLOT_SUITSTORE
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	default_mutant_bodyparts = list(
		"legs" = "Normal Legs"
	)
	mutanttongue = /obj/item/organ/internal/tongue/insect
	liked_food = RAW
	disliked_food = CLOTH | GRAIN | FRIED | TOXIC | GORE | GROSS
	toxic_food = DAIRY
	always_customizable = FALSE
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 10)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 25)
	// Need balancing
	speedmod = 1
	mutantbrain = /obj/item/organ/internal/brain/nabber
	mutanteyes = /obj/item/organ/internal/eyes/nabber
	mutantlungs = /obj/item/organ/internal/lungs/nabber
	mutantheart = /obj/item/organ/internal/heart/nabber
	mutantliver = /obj/item/organ/internal/liver/nabber
	mutantears = /obj/item/organ/internal/ears/nabber
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/nabber,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/nabber,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/nabber,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/nabber,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/nabber,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/nabber,
	)
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = NABBER_HEAD_ICON,
		LOADOUT_ITEM_MASK = NABBER_MASK_ICON,
		LOADOUT_ITEM_UNIFORM = NABBER_UNIFORM_ICON,
		LOADOUT_ITEM_HANDS =  NABBER_HANDS_ICON,
		LOADOUT_ITEM_GLASSES = NABBER_EYES_ICON,
		LOADOUT_ITEM_BELT = NABBER_BELT_ICON,
		LOADOUT_ITEM_MISC = NABBER_BACK_ICON,
		LOADOUT_ITEM_EARS = NABBER_EARS_ICON
	)

/datum/species/nabber/randomize_features(mob/living/carbon/human/human_mob)
	var/main_color
	var/random = rand(1,6)
	switch(random)
		if(1)
			main_color = "#44FF77"
		if(2)
			main_color = "#227900"
		if(3)
			main_color = "#c40000"
		if(4)
			main_color = "#660000"
		if(5)
			main_color = "#c0ad00"
		if(6)
			main_color = "#e6ff03"
	human_mob.dna.features["mcolor"] = main_color
	human_mob.dna.features["mcolor2"] = main_color
	human_mob.dna.features["mcolor3"] = main_color

/datum/species/nabber/prepare_human_for_preview(mob/living/carbon/human/nabber)
	var/nabber_color = "#00ac1d"
	nabber.dna.features["mcolor"] = nabber_color
	nabber.dna.features["mcolor2"] = nabber_color
	nabber.dna.features["mcolor3"] = nabber_color
	regenerate_organs(nabber, src, visual_only = TRUE)
	nabber.update_body(TRUE)

/datum/species/nabber/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Durable leather",
		SPECIES_PERK_DESC = "The Giant Armored Serpentid chitin is very robust and protects them from pressure and low temperature hazards, while also providing decent brute resistance."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Heavy Skeleton",
		SPECIES_PERK_DESC = "Giant Armored Serpentid are large and heavy. They can't be properly grabbed by other creatures."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Custom body",
		SPECIES_PERK_DESC = "Giant Armored Serpentid has a nonhumanoid body and can't wear most clothes."
	))

	return perk_descriptions

/datum/species/nabber/random_name(gender, unique, lastname)
	if(unique)
		return random_unique_name(gender)

	var/random_name
	random_name += (pick("Alpha","Delta","Dzetta","Phi","Epsilon","Gamma","Tau","Omega") + " [rand(1, 199)]")
	return random_name

/datum/species/nabber/get_species_description()
	return placeholder_description

/datum/species/nabber/get_species_lore()
	return list(placeholder_lore)
