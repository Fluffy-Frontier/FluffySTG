/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/warrior
	name = "alien warrior"
	desc = "If there are aliens to call walking tanks, this would be one of them, with both the heavy armor and strong arms to back that claim up."
	caste = "warrior"
	maxHealth = 400
	health = 400
	icon_state = "alienwarrior"
	mob_size = MOB_SIZE_LARGE
	melee_damage_lower = 30
	melee_damage_upper = 35

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel
	)

	hud_offset_y = -16

/mob/living/carbon/alien/adult/tgmc/warrior/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep,
		/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender,
		/datum/action/cooldown/alien/tgmc/warrior_agility,
	)
	grant_actions_by_list(innate_actions)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	add_movespeed_modifier(/datum/movespeed_modifier/alien_big)
