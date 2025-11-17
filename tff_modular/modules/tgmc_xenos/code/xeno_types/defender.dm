/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/defender
	name = "alien defender"
	desc = "A heavy looking alien with a wrecking ball-like tail that'd probably hurt to get hit by."
	icon_state = "aliendefender"
	caste = "defender"
	maxHealth = 150
	health = 150
	mob_size = MOB_SIZE_LARGE
	melee_damage_lower = 25
	melee_damage_upper = 30
	alien_speed = 1.5
	next_evolution = /mob/living/carbon/alien/adult/tgmc/crusher

	armor_type = /datum/armor/tgmc_xeno/defender

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc/small,
	)

/mob/living/carbon/alien/adult/tgmc/defender/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep,
		/datum/action/cooldown/alien/fortify,
	)
	grant_actions_by_list(innate_actions)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/carbon/alien/adult/tgmc/defender/update_icons()
	. = ..()
	if(fortify)
		icon_state = "alien[caste]_fortify"

/mob/living/carbon/alien/adult/tgmc/defender/set_stat()
	. = ..()
	if(. == CONSCIOUS && fortify)
		var/datum/action/cooldown/alien/fortify/fortify_action = locate() in actions
		fortify_action.set_fortify(FALSE)

/datum/armor/tgmc_xeno/defender
	bomb = 30
	bullet = 45
	energy = 30
	laser = 30
	fire = 40
	melee = 45
