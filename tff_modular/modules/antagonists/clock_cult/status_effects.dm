/datum/status_effect/interdiction
	id = "interdicted"
	duration = 2.6 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	tick_interval = 0.2 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/interdiction
	/// If we kicked the owner out of running mode
	var/running_toggled = FALSE

/datum/status_effect/interdiction/tick()
	if(owner.move_intent != MOVE_INTENT_WALK)
		owner.toggle_move_intent()
		owner.adjust_confusion_up_to(1 SECONDS, 1 SECONDS)
		running_toggled = TRUE
		to_chat(owner, span_warning("You know you shouldn't be running here."))

	owner.add_movespeed_modifier(/datum/movespeed_modifier/clock_interdiction)

/datum/status_effect/interdiction/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/clock_interdiction)

	if(running_toggled && owner.move_intent == MOVE_INTENT_WALK)
		owner.toggle_move_intent()

/atom/movable/screen/alert/status_effect/interdiction
	name = "Interdicted"
	desc = "I don't think I am meant to go this way."
	icon = 'tff_modular/modules/antagonists/clock_cult/icons/hud/screen_alert.dmi'
	icon_state = "belligerent"

/datum/movespeed_modifier/clock_interdiction
	multiplicative_slowdown = 1.5

/datum/status_effect/clock_warp_sickness
	id = "clock_warp_sickness"
	alert_type = /atom/movable/screen/alert/status_effect/clock_warp_sickness

/datum/status_effect/clock_warp_sickness/on_creation(mob/living/new_owner, _duration = 1 SECONDS)
	duration = _duration
	return ..()

/datum/status_effect/clock_warp_sickness/on_apply()
	. = ..()
	owner.add_actionspeed_modifier(/datum/actionspeed_modifier/clock_warp_sickness)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/clock_warp_sickness)
	owner.adjust_confusion(duration)
	owner.adjust_dizzy(duration)
	owner.add_client_colour(/datum/client_colour/clock_warp)

/datum/status_effect/clock_warp_sickness/on_remove()
	. = ..()
	owner.remove_actionspeed_modifier(/datum/actionspeed_modifier/clock_warp_sickness)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/clock_warp_sickness)
	owner.remove_client_colour(/datum/client_colour/clock_warp)

/atom/movable/screen/alert/status_effect/clock_warp_sickness
	name = "Warp Sickness"
	desc = "You are disoriented from recently teleporting."
	icon = 'tff_modular/modules/antagonists/clock_cult/icons/mob/actions_clock.dmi'
	icon_state = "warp_down"
	alerttooltipstyle = "clockwork"

/datum/movespeed_modifier/clock_warp_sickness
	multiplicative_slowdown = 1

/datum/actionspeed_modifier/clock_warp_sickness
	multiplicative_slowdown = 0.6

/datum/client_colour/clock_warp
	color = LIGHT_COLOR_CLOCKWORK
	priority = 2
	fade_out = 5

/datum/status_effect/speech/slurring/clock
	id = "clock_slurring"
	common_prob = 50
	uncommon_prob = 25
	replacement_prob = 33
	doubletext_prob = 0
	text_modification_file = "slurring_clock_text.json"
