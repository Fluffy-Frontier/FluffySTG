/mob/living/carbon/human/necromorph/tripod
	health = 475
	maxHealth = 475
	class = /datum/necro_class/tripod
	necro_species = /datum/species/necromorph/tripod
	necro_armor = /datum/armor/dsnecro_tripod
	mob_size = MOB_SIZE_HUGE
	pixel_x = -48
	base_pixel_x = -48
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/tripod,
		/obj/item/bodypart/head/necromorph/tripod,
		/obj/item/bodypart/arm/left/necromorph/tripod,
		/obj/item/bodypart/arm/right/necromorph/tripod,
		/obj/item/bodypart/leg/left/necromorph/tripod,
		/obj/item/bodypart/leg/right/necromorph/tripod,
	)

/mob/living/carbon/human/necromorph/tripod/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()
	AddComponent(/datum/component/execution/tripod)

/mob/living/carbon/human/necromorph/tripod/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.tripod_sounds[audio_type]), volume, vary, extra_range)

/mob/living/carbon/human/necromorph/tripod/resolve_right_click_attack(atom/target, list/modifiers)
	if(isliving(target))
		var/datum/component/execution/tripod/execute = GetComponent(/datum/component/execution/tripod)
		perform_execution(execute, target, src)
	return ..()

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
		/datum/action/cooldown/necro/swing/tripod,
		/datum/action/cooldown/mob_cooldown/lava_swoop/high_leap,
	)
	implemented = TRUE

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
	mutanteyes = /obj/item/organ/eyes/necro/enhanced
	mutanttongue = /obj/item/organ/tongue/necro/tripod

/datum/armor/dsnecro_tripod
	melee = 65
	bullet = 45
	laser = 15
	energy = 15
	bomb = 15
	bio = 65
	fire = 20
	acid = 95
