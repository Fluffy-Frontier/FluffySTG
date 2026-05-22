/datum/antagonist/loner
	name = "\improper Loner"
	antagpanel_category = ANTAG_GROUP_SYNDICATE
	show_in_roundend = TRUE
	roundend_category = "traitors"
	show_in_antagpanel = TRUE
	stinger_sound = 'tff_modular/modules/psionics/sounds/power_unlock.ogg'
	var/datum/psionic/psi
	var/previosly_psionic = FALSE

/datum/antagonist/loner/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/current_owner = mob_override || owner.current
	if(current_owner.get_psionic())
		current_owner.remove_psionic()
		previosly_psionic = TRUE
	current_owner.add_psionic(/datum/psionic/harmonious)

/datum/antagonist/loner/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/current_owner = mob_override || owner.current
	current_owner.remove_psionic()
	if(previosly_psionic)
		current_owner.add_psionic(/datum/psionic/sensitive)

/datum/antagonist/loner/forge_objectives()
	. = ..()
	var/datum/objective/assassination = new /datum/objective/assassinate()
	assassination.owner = owner
	objectives += assassination

	var/datum/objective/thief = new /datum/objective/steal()
	thief.owner = owner
	objectives += thief

	var/datum/objective/protect = new /datum/objective/protect()
	protect.owner = owner
	objectives += protect

	var/datum/objective/escape = new /datum/objective/escape()
	escape.owner = owner
	objectives += escape
