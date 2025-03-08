/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/ravager
	name = "alien ravager"
	desc = "An alien with angry red chitin, with equally intimidating looking blade-like claws in place of normal hands. That sharp tail looks like it'd probably hurt."
	caste = "ravager"
	maxHealth = 350
	health = 350
	icon_state = "alienravager"
	mob_size = MOB_SIZE_LARGE
	melee_damage_lower = 30
	melee_damage_upper = 35

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel
	)

/mob/living/carbon/alien/adult/tgmc/ravager/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/slicing,
		/datum/action/cooldown/alien/tgmc/literally_too_angry_to_die,
		/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager,
	)
	grant_actions_by_list(innate_actions)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
