/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/praetorian
	name = "alien praetorian"
	desc = "An alien that looks like the awkward half-way point between a queen and a drone, in fact that's likely what it is."
	icon_state = "alienpraetorian"
	caste = "praetorian"
	maxHealth = 400
	health = 400
	mob_size = MOB_SIZE_LARGE
	melee_damage_lower = 25
	melee_damage_upper = 30
	next_evolution = /mob/living/carbon/alien/adult/tgmc/queen

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc/large,
		ORGAN_SLOT_XENO_RESINSPINNER = /obj/item/organ/alien/resinspinner,
		ORGAN_SLOT_XENO_ACIDGLAND = /obj/item/organ/alien/acid/tgmc/large,
		ORGAN_SLOT_XENO_NEUROTOXINGLAND = /obj/item/organ/alien/neurotoxin/tgmc/large,
	)

	mecha_armor_penetration = 30
	resist_heavy_hits = TRUE

/mob/living/carbon/alien/adult/tgmc/praetorian/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/alien/tgmc/heal_aura/juiced,
		/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/hard_throwing,
	)
	grant_actions_by_list(innate_actions)

	add_movespeed_modifier(/datum/movespeed_modifier/alien_big)
	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
