/datum/vote/shift_intensity
	name = "Intensity"
	default_choices = list(
		ROUND_LIGHT_SHIFT_STRING,
		ROUND_MID_SHIFT_STRING,
		ROUND_HARD_SHIFT_STRING,
	)
	var/static/list/roundstart_rulesets = list(
		/datum/dynamic_ruleset/roundstart/nuclear,
		/datum/dynamic_ruleset/roundstart/revs,
		/datum/dynamic_ruleset/roundstart/bloodcult,
	)

/datum/vote/shift_intensity/toggle_votable()
	CONFIG_SET(flag/allow_shift_intensity_vote, !CONFIG_GET(flag/allow_shift_intensity_vote))

/datum/vote/shift_intensity/is_config_enabled()
	return CONFIG_GET(flag/shift_intensity) && CONFIG_GET(flag/allow_shift_intensity_vote)

/datum/vote/shift_intensity/can_be_initiated(forced)
	. = ..()
	if(. != VOTE_AVAILABLE)
		return .

	if(SSticker.current_state != GAME_STATE_PREGAME)
		return "It's too late for that, the round is already starting."

	if(forced)
		return VOTE_AVAILABLE

	return VOTE_AVAILABLE

/datum/vote/shift_intensity/initiate_vote(initiator, duration)
	. = ..()
	// Необходимо продлить время до старта раунда, асли до него меньше 90 секунд (60 секунд сам воут + 30 на то, чтобы игроки успели понять тип раунда)
	if(SSticker.GetTimeLeft() < 90 SECONDS)
		SSticker.SetTimeLeft(90 SECONDS)

/datum/vote/shift_intensity/tiebreaker(list/winners)
	// Если никто не проголосовал - смена будет *обычная*
	if(choices_by_ckey.len == 0)
		return ROUND_MID_SHIFT_STRING
	return ..()


/datum/vote/shift_intensity/finalize_vote(winning_option)
	if(SSticker.current_state != GAME_STATE_PREGAME)
		message_admins("Shift type vote ended after the round started. No changes to the round type. Current type: [winning_option]")
		log_admin("Shift type vote ended after the round started. No changes to the round type. Current type: [winning_option]")
		return

	// Боже, прости меня за это, но меня заставляют. Нужно будет заменить на отдельные конфиги для каждого типа раунда
	switch(winning_option)
		if(ROUND_LIGHT_SHIFT_STRING)
			SSdynamic.max_threat_level = 30
			SSdynamic.low_pop_maximum_threat = 20
			SSdynamic.threat_curve_centre = -4
			SSdynamic.threat_curve_width = 2.2
			GLOB.shift_intensity_level = ROUND_LIGHT_SHIFT
			message_admins("Selected Green Shift")
		if(ROUND_MID_SHIFT_STRING)
			// Ничего не меняем, все как обычно
			GLOB.shift_intensity_level = ROUND_MID_SHIFT
			message_admins("Selected Blue Shift")
		if(ROUND_HARD_SHIFT_STRING)
			GLOB.dynamic_no_stacking = FALSE
			SSdynamic.threat_curve_centre = 4
			SSdynamic.threat_curve_width = 2.2
			// Ужас. Но нужен, чтобы выбирать случайно культ, нюку или реву для спавна раундстартом
			var/chosen_roundstart_ruleset = pick(roundstart_rulesets)
			GLOB.dynamic_forced_roundstart_ruleset += new chosen_roundstart_ruleset()
			GLOB.shift_intensity_level = ROUND_HARD_SHIFT
			message_admins("Selected Red Shift. Randomly selected ruleset: [chosen_roundstart_ruleset]")
		else
			CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")

	message_admins("Shift type vote ended ")
	log_admin("Shift type vote ended ")
