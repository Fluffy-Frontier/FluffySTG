/datum/action/cooldown/spell/pointed/psionic/barrier
	name = "Barrier"
	desc = "Give yourself or a target psionic armour."
	button_icon_state = "tech_frostaura"
	category = "Tier 2"
	cooldown_time = 60 SECONDS
	psionic_level = 2
	point_cost = 1
	mana_cost = 30
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/barrier/is_valid_target(atom/cast_on)
	. = ..()
	if(!ishuman(cast_on))
		return FALSE

/datum/action/cooldown/spell/pointed/psionic/barrier/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/artificer = cast_on
	var/duration = 20 SECONDS * cast_power
	artificer.apply_status_effect(/datum/status_effect/psionic_armour, duration)
	playsound(artificer, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	return TRUE

/datum/status_effect/psionic_armour
	id = "psionic_armour"
	duration = 20 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/psionic_armour
	show_duration = TRUE

/datum/status_effect/psionic_armour/on_creation(mob/living/new_owner, new_duration)
	. = ..()
	duration = new_duration

/datum/status_effect/psionic_armour/on_apply()
	. = ..()
	var/mob/living/carbon/human/affected = owner
	ADD_TRAIT(affected, TRAIT_HARDLY_WOUNDED, PSIONIC_TRAIT)
	affected.physiology.brute_mod *= 0.75
	affected.physiology.burn_mod *= 0.75
	affected.physiology.stamina_mod *= 0.25
	return TRUE

/datum/status_effect/psionic_armour/on_remove()
	. = ..()
	var/mob/living/carbon/human/affected = owner
	REMOVE_TRAIT(affected, TRAIT_HARDLY_WOUNDED, PSIONIC_TRAIT)
	affected.physiology.brute_mod /= 0.75
	affected.physiology.burn_mod /= 0.75
	affected.physiology.stamina_mod /= 0.25
	return TRUE

/atom/movable/screen/alert/status_effect/psionic_armour
	name = "Psionic Armour"
	desc = "You covered with Psi Armour, and any damage you receive is reduced!"
	overlay_icon = 'tff_modular/modules/psionics/icons/spells.dmi'
	overlay_state = "tech_frostaura"
