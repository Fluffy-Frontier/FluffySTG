/*
/mob/living/carbon/human/necromorph/fodder
	health = 65
	maxHealth = 65
	class = /datum/necro_class/fodder
	necro_species = /datum/species/necromorph/fodder
	necro_armor = /datum/armor/dsnecro_fodder
	pass_flags = PASSTABLE | PASSFLAPS
	pixel_x = 0
	pixel_y = 0
	base_pixel_x = 0
	base_pixel_y = 0
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/fodder,
		/obj/item/bodypart/head/necromorph/fodder,
		/obj/item/bodypart/leg/left/necromorph/fodder,
		/obj/item/bodypart/leg/right/necromorph/fodder,
		/obj/item/bodypart/arm/right/necromorph/fodder,
		/obj/item/bodypart/arm/left/necromorph/fodder
	)

/mob/living/carbon/human/necromorph/fodder/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	add_movespeed_modifier(/datum/movespeed_modifier/dsnecro_faster) //Almost as fast as a person, absolutely terrifying

/mob/living/carbon/human/necromorph/fodder/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.slasher_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/fodder
	display_name = "fodder"
	desc = "A small ambush and flanking necromorph. Used as scouts and spies, these little monsters can easily hide under objects and scurry into vents. Fares very poorly against armored targets. Will be AI controlled when not being used by a signal."
	necromorph_type_path = /mob/living/carbon/human/necromorph/fodder
	tier = 0
	nest_allowed = FALSE
	biomass_cost = 38
	biomass_spent_required = 0
	melee_damage_lower = 10
	melee_damage_upper = 14
	necro_armor = /datum/armor/dsnecro_fodder
	actions = list(
	)

/datum/species/necromorph/fodder
	name = "Fodder"
	id = SPECIES_NECROMORPH_FODDER
	bodypart_overrides = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/fodder,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/fodder,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/fodder,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/fodder,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/fodder,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/fodder
	)
*/
/datum/armor/dsnecro_fodder
	melee = 25
	bullet = 30
	laser = 10
	energy = 10
	bomb = 15
	bio = 50
	fire = 0
	acid = 80
