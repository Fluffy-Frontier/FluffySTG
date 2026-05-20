/datum/antagonist/loner
	name = "\improper Loner"
	antagpanel_category = ANTAG_GROUP_SYNDICATE
	show_in_antagpanel = TRUE
	var/datum/psionic/psi

/datum/antagonist/loner/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/current_owner = mob_override || owner.current
	current_owner.add_psionic(/datum/psionic/harmonious)
	ADD_TRAIT(current_owner, TRAIT_IMMUNE_TO_PSI_SUPPRESSION, PSIONIC_TRAIT)
