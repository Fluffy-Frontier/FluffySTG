/datum/antagonist/traitor/loner
	name = "\improper Psionic Agent"
	stinger_sound = 'tff_modular/modules/psionics/sounds/power_unlock.ogg'
	give_uplink = FALSE
	uplink_flag_given = NONE
	var/datum/psionic/psi
	var/previosly_psionic = FALSE

/datum/antagonist/traitor/loner/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/current_owner = mob_override || owner.current
	if(current_owner.get_psionic())
		current_owner.remove_psionic()
		previosly_psionic = TRUE
	current_owner.add_psionic(/datum/psionic/harmonious)

/datum/antagonist/traitor/loner/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/current_owner = mob_override || owner.current
	current_owner.remove_psionic()
	if(previosly_psionic)
		current_owner.add_psionic(/datum/psionic/sensitive)
