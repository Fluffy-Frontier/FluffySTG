/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/defender
	name = "alien defender"
	desc = "A heavy looking alien with a wrecking ball-like tail that'd probably hurt to get hit by."
	caste = "defender"
	maxHealth = 300
	health = 300
	icon_state = "aliendefender"
	mob_size = MOB_SIZE_LARGE
	melee_damage_lower = 25
	melee_damage_upper = 30
	next_evolution = /mob/living/carbon/alien/adult/tgmc/warrior

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/small,
	)

	melee_vehicle_damage = 30
	armor_type = /datum/armor/mod_theme_administrative

/mob/living/carbon/alien/adult/tgmc/defender/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep,
	)
	grant_actions_by_list(innate_actions)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	add_movespeed_modifier(/datum/movespeed_modifier/alien_heavy)
