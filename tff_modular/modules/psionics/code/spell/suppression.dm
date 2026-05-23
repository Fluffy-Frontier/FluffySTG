/datum/action/cooldown/spell/psionic/suppression
	name = "Psionic Suppression"
	desc = "Suppress your psionic energy, making your signal invisible to other psionics, but you can't use psionic abilities."
	button_icon_state = "tech_shield"
	category = "Tier 2"
	cooldown_time = 30 SECONDS
	psionic_level = 2
	mana_cost = 0
	point_cost = 0
	ignore_suppression = TRUE
	locked = FALSE
	var/suppressing = FALSE

/datum/action/cooldown/spell/psionic/suppression/cast(atom/cast_on)
	. = ..()
	if(suppressing || HAS_TRAIT_FROM(cast_on, TRAIT_PSIONIC_SUPPRESSED, ACTION_TRAIT))
		REMOVE_TRAIT(cast_on, TRAIT_PSIONIC_SUPPRESSED, ACTION_TRAIT)
	else
		ADD_TRAIT(cast_on, TRAIT_PSIONIC_SUPPRESSED, ACTION_TRAIT)
