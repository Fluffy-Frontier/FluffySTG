/atom/movable/screen/alert/status_effect/crucible_soul_cooldown
	name = "Curse of Crucible Soul"
	desc = "Your body and soul need some time to regain stability. During that time you will not be able to consume the brew of the crucible soul."
	icon_state = "crucible"

/datum/status_effect/crucible_soul_cooldown
	id = "Curse of Crucible Soul"
	status_type = STATUS_EFFECT_REFRESH
	duration = 300 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/crucible_soul_cooldown
	show_duration = TRUE

/obj/item/eldritch_potion/crucible_soul/attack_self(mob/user)
	if(user.has_status_effect(/datum/status_effect/crucible_soul))
		to_chat(user, span_alert("You are unable to consume the potion because you still are under it's effect!"))
		return

	if(user.has_status_effect(/datum/status_effect/crucible_soul_cooldown))
		to_chat(user, span_alert("You are unable to consume the potion because your soul and body aren't ready yet!"))
		return
	. = ..()

/datum/status_effect/crucible_soul/on_remove()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/crucible_soul_cooldown)
