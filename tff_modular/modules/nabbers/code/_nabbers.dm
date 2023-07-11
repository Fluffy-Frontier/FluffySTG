#define NABBER_COLD_THRESHOLD_1 180
#define NABBER_COLD_THRESHOLD_2 140
#define NABBER_COLD_THRESHOLD_3 100

#define NABBER_HEAT_THRESHOLD_1 300
#define NABBER_HEAT_THRESHOLD_2 440
#define NABBER_HEAT_THRESHOLD_3 600

#define NABBER_DAMAGE_ONBURNING 5

/datum/species/nabber
	name = "Giant Armored Serpentid"
	id = SPECIES_NABBER
	bodytype = BODYTYPE_CUSTOM
	eyes_icon = 'tff_modular/modules/nabbers/icons/organs/nabber_eyes.dmi'
	can_augment = FALSE
	veteran_only = TRUE
	species_traits = list(
		MUTCOLORS,
		NO_UNDERWEAR,
		HAS_MARKINGS
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
		TRAIT_PUSHIMMUNE,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE
	)
	body_size_restricted = TRUE
	no_equip_flags = ITEM_SLOT_FEET | ITEM_SLOT_OCLOTHING | ITEM_SLOT_SUITSTORE | ITEM_SLOT_EYES
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
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
	mutanteyes = /obj/item/organ/internal/eyes/robotic/nabber
	mutantlungs = /obj/item/organ/internal/lungs/nabber
	mutantheart = /obj/item/organ/internal/heart/nabber
	mutantliver = /obj/item/organ/internal/liver/nabber
	mutantears = /obj/item/organ/internal/ears/nabber
	mutantappendix = null
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
		LOADOUT_ITEM_BELT = NABBER_BELT_ICON,
		LOADOUT_ITEM_MISC = NABBER_BACK_ICON,
		LOADOUT_ITEM_EARS = NABBER_EARS_ICON
	)
	var/datum/action/cooldown/nabber_combat/combat_mode
	var/datum/action/cooldown/optical_camouflage/camouflage

/datum/species/nabber/on_species_gain(mob/living/carbon/human/C, datum/species/old_species, pref_load)
	. = ..()
	combat_mode = new(C)
	combat_mode.Grant(C)
	camouflage = new(C)
	camouflage.Grant(C)

/datum/species/nabber/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	combat_mode.Destroy()
	camouflage.Destroy()

/datum/species/nabber/spec_life(mob/living/carbon/human/H, seconds_per_tick, times_fired)
	. = ..()
	if(isdead(H))
		return
	//Огонь вызывает у ГБС асфиксию. Им лучше не гореть.
	if(H.on_fire)
		H.apply_damage(NABBER_DAMAGE_ONBURNING, OXY)

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
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Serpent body",
		SPECIES_PERK_DESC = "GAS possess serpent-like bodies and cannot wear most human clothes."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Robust chitin",
		SPECIES_PERK_DESC = "GAS possess durable chitinous exoskeletons and can withstand a lot of brute damage."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Extreme heat weakness",
		SPECIES_PERK_DESC = "GAS is afraid of fire. High temperatures and open flames suffocate them and deal massive damage.."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Welder eyelids",
		SPECIES_PERK_DESC = "GAS can close their second pair of eyelids to protect their eyes from welder flash."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Mantis arms",
		SPECIES_PERK_DESC = "GAS possesses a second pair of arms with massive sharp mantis blades. They can have only one pair active at a time and need to pump blood between them."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Camoufage",
		SPECIES_PERK_DESC = "GAS can blend in with their surroundings and become transparent to hide from danger."
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

/mob/living/carbon/human/species/nabber
	race = /datum/species/nabber
