/mob/living/carbon/human/necromorph/infector
	health = 90
	maxHealth = 90
	class = /datum/necro_class/infector
	necro_species = /datum/species/necromorph/infector
	necro_armor = /datum/armor/dsnecro_infector
	var/mob/eye/signal/biomass_source
	var/current_biomass = 0
	tutorial_text = "<b>Sting:</b>  your sting attack has increased damage, and if you use it on a dead corpse, you can convert it to the necromorph side.\n\
					<b>Huggy:</b> your dash allows you to grab an enemy and start a long animation of converting the victim. If you get grabbed while doing so - your progress will be stopped!"

/mob/living/carbon/human/necromorph/infector/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()
	add_movespeed_modifier(/datum/movespeed_modifier/dsnecro_faster)
	AddComponent(/datum/component/execution/infector)

/mob/living/carbon/human/necromorph/infector/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.infector_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/infector
	display_name = "Infector"
	desc = "A high value, fragile support, the Infector works as a builder and healer"
	necromorph_type_path = /mob/living/carbon/human/necromorph/infector
	biomass_cost = 280
	biomass_spent_required = 680
	melee_damage_lower = 10
	melee_damage_upper = 16
	necro_armor = /datum/armor/dsnecro_infector
	actions = list(
		/datum/action/cooldown/mob_cooldown/charge/necro/execution/infector,
		/datum/action/cooldown/necro/infector_proboscis,
		/datum/action/cooldown/necro/shout,
		/datum/action/cooldown/necro/corruption/infector,
	)
	implemented = TRUE

/datum/armor/dsnecro_infector
	melee = 25
	bullet = 40
	laser = 10
	energy = 10
	bomb = 15
	bio = 75
	fire = 15
	acid = 95

/datum/species/necromorph/infector
	name = "Infector"
	id = SPECIES_NECROMORPH_INFECTOR
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/infector,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/infector,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/infector,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/infector,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/infector,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/infector,
	)
	mutanttongue = /obj/item/organ/tongue/necro/proboscis


/datum/species/necromorph/infector/get_scream_sound(mob/living/carbon/human/necromorph/infector)
	return pick(
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/infector/infector_shout_long_1.ogg',
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/infector/infector_shout_long_2.ogg',
		'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/infector/infector_shout_long_3.ogg',
	)


/*
*
*		ORGANS
*
*/

//This is a proc so it can be used in another place later
/mob/living/carbon/human/necromorph/infector/proc/inject_necrotoxin(var/mob/living/L, var/quantity = 5)
	if (istype(L) && !(isnecromorph(L)))
		if (!L.reagents.has_reagent(/datum/reagent/toxin/necro))
			to_chat(L, span_warning("You feel a tiny prick."))
		L.reagents.add_reagent(/datum/reagent/toxin/necro, quantity)
