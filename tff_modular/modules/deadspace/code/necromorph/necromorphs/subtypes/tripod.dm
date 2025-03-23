/mob/living/carbon/human/necromorph/tripod
	health = 475
	maxHealth = 475
	class = /datum/necro_class/tripod
	necro_species = /datum/species/necromorph/tripod
	necro_armor = /datum/armor/dsnecro_tripod
	pixel_x = -16
	pixel_y = -18
	base_pixel_x = -16
	base_pixel_y = -18
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/tripod,
		/obj/item/bodypart/head/necromorph/tripod,
		/obj/item/bodypart/arm/left/necromorph/tripod,
		/obj/item/bodypart/arm/right/necromorph/tripod,
		/obj/item/bodypart/leg/left/necromorph/tripod,
		/obj/item/bodypart/leg/right/necromorph/tripod,
	)

/mob/living/carbon/human/necromorph/tripod/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.leaper_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/tripod
	display_name = "Tripod"
	desc = "A long range ambusher, the leaper can leap on unsuspecting victims from afar, knock them down, and tear them apart with its bladed tail. Not good for prolonged combat though."
	necromorph_type_path = /mob/living/carbon/human/necromorph/tripod
	tier = 2
	nest_allowed = FALSE
	biomass_cost = 360
	biomass_spent_required = 1350
	melee_damage_lower = 22
	melee_damage_upper = 26
	armour_penetration = 25
	necro_armor = /datum/armor/dsnecro_tripod
	actions = list(
	)

/datum/species/necromorph/tripod
	name = "Tripod"
	id = SPECIES_NECROMORPH_TRIPOD
	bodypart_overrides = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/tripod,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/tripod,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/tripod,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/tripod,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/tripod,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/tripod,
	)

/datum/armor/dsnecro_tripod
	melee = 65
	bullet = 45
	laser = 15
	energy = 15
	bomb = 15
	bio = 65
	fire = 20
	acid = 95
