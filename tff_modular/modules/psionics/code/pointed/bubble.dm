/datum/action/cooldown/spell/pointed/psionic/bubble
	name = "Psionic Bubble"
	desc = "Create a protective bubble around you or target that removes your need to breathe or wear space protection!"
	button_icon_state = "tech_condensation"
	point_cost = 1
	cooldown_time = 30 SECONDS
	mana_cost = 10
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/bubble/is_valid_target(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/bubble/cast(atom/cast_on)
	. = ..()
	var/mob/living/living_living = cast_on
	var/duration = cast_power * 15 SECONDS
	living_living.apply_status_effect(/datum/status_effect/psi_bubble, duration)
	playsound(cast_on, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	return TRUE

/datum/status_effect/psi_bubble
	id = "psi_bubble"
	alert_type = /atom/movable/screen/alert/status_effect/psi_bubble
	tick_interval = STATUS_EFFECT_AUTO_TICK
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	duration = 15 SECONDS
	show_duration = TRUE
	var/icon/bubbleicon

/datum/status_effect/psi_bubble/on_creation(mob/living/new_owner, set_duration)
	if(isnum(set_duration))
		duration = set_duration
	return ..()

/datum/status_effect/psi_bubble/on_apply()
	. = ..()
	bubbleicon = icon(icon = 'icons/effects/effects.dmi', icon_state = "bubbles")
	owner.add_overlay(bubbleicon)
	owner.add_traits(list(TRAIT_OXYIMMUNE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD), PSIONIC_TRAIT)
	RegisterSignal(owner, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	return TRUE

/datum/status_effect/psi_bubble/on_remove()
	. = ..()
	owner.cut_overlay(bubbleicon)
	owner.remove_traits(list(TRAIT_OXYIMMUNE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD), PSIONIC_TRAIT)
	UnregisterSignal(owner, COMSIG_ATOM_EXAMINE)
	return TRUE

/datum/status_effect/psi_bubble/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_horizonblue("[source.p_Theyre()] covered with strange bubbles!")

/atom/movable/screen/alert/status_effect/psi_bubble
	name = "Air Bubble"
	desc = "There is a protective bubble around you that removes your need to breathe or wear space protection!"
	overlay_icon = 'icons/effects/effects.dmi'
	overlay_state = "shield2"
