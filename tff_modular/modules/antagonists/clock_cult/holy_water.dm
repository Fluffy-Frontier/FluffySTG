/datum/reagent/water/holywater/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(IS_CLOCK(exposed_mob))
		to_chat(exposed_mob, span_userdanger("Your mind burns in agony as you feel the light of the Justicar being ripped away from you by something else!"))

/datum/reagent/water/holywater/proc/handle_cultists(mob/living/carbon/affected_mob, seconds_per_tick)
	var/list/phrase_list
	if(IS_CULTIST(affected_mob)) //snowflakey but it works
		var/datum/antagonist/cult/cult_datum = affected_mob.mind.has_antag_datum(/datum/antagonist/cult)
		phrase_list = cult_datum?.cultist_deconversion_phrases
	else if(IS_CLOCK(affected_mob))
		var/datum/antagonist/clock_cultist/servant_datum = affected_mob.mind.has_antag_datum(/datum/antagonist/clock_cultist)
		phrase_list = servant_datum?.servant_deconversion_phrases

	if(data["deciseconds_metabolized"] >= (25 SECONDS)) // 10 units
		affected_mob.adjust_stutter_up_to(4 SECONDS * seconds_per_tick, 20 SECONDS)
		affected_mob.set_dizzy_if_lower(10 SECONDS)
		if(SPT_PROB(10, seconds_per_tick))
			if(phrase_list)
				affected_mob.say(pick(phrase_list["spoken"]), forced = "holy water")
			if(prob(10))
				affected_mob.visible_message(span_danger("[affected_mob] starts having a seizure!"), span_userdanger("You have a seizure!"))
				affected_mob.Unconscious(12 SECONDS)
				var/span_type
				if(IS_CULTIST(affected_mob))
					span_type = "cultlarge"
				else if(IS_CLOCK(affected_mob))
					span_type = "big_brass"
				if(phrase_list)
					to_chat(affected_mob, "<span class=[span_type]>[pick(phrase_list["seizure"])].</span>")

	if(data["deciseconds_metabolized"] >= (1 MINUTES)) // 24 units
		if(IS_CULTIST(affected_mob))
			affected_mob.mind.remove_antag_datum(/datum/antagonist/cult)
		if(IS_CLOCK(affected_mob))
			affected_mob.mind.remove_antag_datum(/datum/antagonist/clock_cultist)
		affected_mob.Unconscious(10 SECONDS)
		affected_mob.remove_status_effect(/datum/status_effect/jitter)
		affected_mob.remove_status_effect(/datum/status_effect/speech/stutter)
		holder.remove_reagent(type, volume) // maybe this is a little too perfect and a max() cap on the statuses would be better??
		return TRUE
