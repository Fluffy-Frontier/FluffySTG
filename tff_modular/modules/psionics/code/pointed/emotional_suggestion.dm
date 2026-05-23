/datum/action/cooldown/spell/pointed/psionic/emotional_suggestion
	name = "Psionic Emotional Suggestion"
	desc = "Allows you to psionically commune with the target using emotions."
	button_icon_state = "tech_gambit"
	cooldown_time = 2 SECONDS
	mana_cost = 5
	point_cost = 0
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/is_valid_target(atom/cast_on)
	if(!iscarbon(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/emotional_suggestion/cast(atom/cast_on)
	. = ..()
	emotional_suggestion(cast_on, owner)
	drain_mana()
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/emotional_suggestion/proc/emotional_suggestion(atom/hit_atom, mob/living/user)
	var/mob/living/target = hit_atom
	if(target.stat == DEAD)
		to_chat(user, span_warning("Not even a psion of your level can suggest to the dead."))
		return

	var/text = tgui_input_list(user, "Which emotion would you like to suggest?", "Emotional Suggestion", list("Calm", "Happiness", "Sadness", "Fear", "Anger", "Stress", "Confusion"))
	if(!text)
		return

	text = lowertext(text)

	log_say("[key_name(user)] suggested an emotion to [key_name(target)]: [text]")

	to_chat(user, span_horizonblue("You psionically suggest an emotion to [target]: [text]"))

	var/mob/living/carbon/human/H = target
	var/datum/psionic/target_sensitivity = H.get_psionic()
	if(target_sensitivity)
		to_chat(H, span_horizonblue("<i>[user] blinks, their eyes briefly developing an unnatural shine.</i>"))
		to_chat(H, span_horizonblue("You sense [user]'s psyche link with your own, and an emotion of <b>[text]</b> washes through your mind."))
	else
		to_chat(H, span_horizonblue("An emotion from outside your consciousness slips into your mind: <b>[text]</b>."))

	playsound(H, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	return TRUE
