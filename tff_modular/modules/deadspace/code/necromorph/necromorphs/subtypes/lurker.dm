/mob/living/carbon/human/necromorph/lurker
	maxHealth = 65
	class = /datum/necro_class/lurker
	necro_species = /datum/species/necromorph/lurker
	necro_armor = /datum/armor/dsnecro_lurker
	pixel_x = -16
	base_pixel_x = -16
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/lurker,
		/obj/item/bodypart/head/necromorph/lurker,
		/obj/item/bodypart/arm/left/necromorph/lurker,
		/obj/item/bodypart/arm/right/necromorph/lurker,
		/obj/item/bodypart/leg/left/necromorph/lurker,
		/obj/item/bodypart/leg/right/necromorph/lurker,
	)

	tutorial_text = "<b>Spine Shot:</b> Brethrens Moons have gifted you with the ability to shot spines, deadly and fast projectiles!"

	var/icon/tentacle
	var/tentacle_path = 'tff_modular/modules/deadspace/icons/necromorphs/lurker/lurker.dmi'
	var/tentacle_state = "lurker_tentacle_combined"

/mob/living/carbon/human/necromorph/lurker/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.lurker_sounds[audio_type]), volume, vary, extra_range)

/mob/living/carbon/human/necromorph/lurker/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()
	add_movespeed_modifier(/datum/movespeed_modifier/dsnecro_faster)
	tentacle = icon(icon = tentacle_path, icon_state = tentacle_state)
	add_overlay(tentacle)

/mob/living/carbon/human/necromorph/lurker/death(gibbed)
	. = ..()
	cut_overlay(tentacle)

/datum/necro_class/lurker
	display_name = "Lurker"
	desc = "Long range fire-support that fires sharp spines in waves of three."
	necromorph_type_path = /mob/living/carbon/human/necromorph/lurker
	tier = 1
	biomass_cost = 70
	biomass_spent_required = 0
	melee_damage_lower = 10
	melee_damage_upper = 16
	necro_armor = /datum/armor/dsnecro_lurker
	actions = list(
		/datum/action/cooldown/necro/shoot/lurker,
		/datum/action/cooldown/necro/shout,
	)
	implemented = TRUE

/datum/armor/dsnecro_lurker
	melee = 30
	bullet = 15
	laser = 10
	energy = 10
	bomb = 0
	bio = 50
	fire = 0
	acid = 80

/datum/species/necromorph/lurker
	name = "Lurker"
	id = SPECIES_NECROMORPH_LURKER
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/lurker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/lurker,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/lurker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/lurker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/lurker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/lurker,
	)

/datum/species/necromorph/lurker/get_scream_sound(mob/living/carbon/human/necromorph/lurker)
	return pick(
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/lurker/lurker_shout_long_2.ogg',
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/lurker/lurker_shout_long_3.ogg',
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/lurker/lurker_shout_4.ogg',
	)
