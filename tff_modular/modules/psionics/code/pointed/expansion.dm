/datum/action/cooldown/spell/pointed/psionic/expansion
	name = "Psionic Expansion"
	desc = "Allows the selected target to see living creatures through walls."
	button_icon_state = "gen_rmind"
	category = "Tier 2"
	cooldown_time = 40 SECONDS
	psionic_level = 2
	point_cost = 1
	mana_cost = 10
	locked = FALSE
	cast_range = 5

/datum/action/cooldown/spell/pointed/psionic/expansion/is_valid_target(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	if(HAS_TRAIT(cast_on, TRAIT_THERMAL_VISION))
		to_chat(cast_on, span_warning("The target doesn't need it!"))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/expansion/cast(atom/cast_on)
	. = ..()
	var/mob/living/getting_vision = cast_on
	var/new_duration = 15 SECONDS * cast_power
	getting_vision.apply_status_effect(/datum/status_effect/thermal_vision, new_duration)
	drain_mana()

/datum/status_effect/thermal_vision
	id = "thermal_vision"
	duration = 15 SECONDS
	show_duration = TRUE
	alert_type = null

/datum/status_effect/thermal_vision/on_creation(mob/living/new_owner, new_duration)
	. = ..()
	duration = new_duration

/datum/status_effect/thermal_vision/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, PSIONIC_TRAIT)
	owner.update_sight()
	return TRUE

/datum/status_effect/thermal_vision/on_remove()
	. = ..()
	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, PSIONIC_TRAIT)
	owner.update_sight()
	return TRUE
