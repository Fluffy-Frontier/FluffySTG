/mob/living/carbon/human/necromorph/infector/enhanced
	health = 185
	maxHealth = 185
	class = /datum/necro_class/infector/enhanced
	necro_species = /datum/species/necromorph/infector/enhanced
	necro_armor = /datum/armor/dsnecro_e_infector

/mob/living/carbon/human/necromorph/infector/enhanced/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()
	add_movespeed_modifier(/datum/movespeed_modifier/dsnecro_faster)

/mob/living/carbon/human/necromorph/infector/enhanced/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.infector_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/infector/enhanced
	display_name = "Infector Enhanced"
	desc = "A high value, fragile support, the Infector works as a builder and healer"
	necromorph_type_path = /mob/living/carbon/human/necromorph/infector/enhanced
	biomass_cost = 450
	biomass_spent_required = 1000
	melee_damage_lower = 10
	melee_damage_upper = 16
	necro_armor = /datum/armor/dsnecro_e_infector
	actions = list(
		/datum/action/cooldown/mob_cooldown/charge/necro/execution/infector,
		/datum/action/cooldown/necro/infector_proboscis/enhanced,
		/datum/action/cooldown/necro/shout,
		/datum/action/cooldown/necro/corruption/infector,
	)
	implemented = TRUE

/datum/armor/dsnecro_e_infector
	melee = 55
	bullet = 65
	laser = 15
	energy = 15
	bomb = 15
	bio = 75
	fire = 15
	acid = 95

/datum/species/necromorph/infector/enhanced
	name = "Infector Enhanced"
	id = SPECIES_NECROMORPH_INFECTOR_ENHANCED
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/infector/enhanced,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/infector/enhanced,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/infector/enhanced,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/infector/enhanced,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/infector/enhanced,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/infector/enhanced,
	)
	mutanteyes = /obj/item/organ/eyes/necro/enhanced

/datum/species/necromorph/infector/enhanced/get_scream_sound(mob/living/carbon/human/necromorph/infector)
	return pick(
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/infector/infector_shout_long_1.ogg',
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/infector/infector_shout_long_2.ogg',
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/infector/infector_shout_long_3.ogg',
	)
