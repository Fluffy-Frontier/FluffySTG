/datum/vote/shift_intensity
	name = "Intensity"
	default_choices = list(
		ROUND_LIGHT_SHIFT_STRING,
		ROUND_MID_SHIFT_STRING,
		ROUND_HEAVY_SHIFT_STRING,
	)

/datum/vote/shift_intensity/toggle_votable()
	CONFIG_SET(flag/allow_shift_intensity_vote, !CONFIG_GET(flag/allow_shift_intensity_vote))

/datum/vote/shift_intensity/is_config_enabled()
	return CONFIG_GET(flag/shift_intensity) && CONFIG_GET(flag/allow_shift_intensity_vote)

/datum/vote/shift_intensity/can_be_initiated(forced)
	. = ..()
	if(. != VOTE_AVAILABLE)
		return

	if(!forced && SSticker.current_state != GAME_STATE_PREGAME)
		return "It's too late for that, the round is already starting."

	return VOTE_AVAILABLE

/datum/vote/shift_intensity/initiate_vote(initiator, duration)
	. = ..()
	// Необходимо продлить время до старта раунда, если до него меньше 90 секунд (60 секунд сам воут + 30 на то, чтобы игроки успели понять тип раунда)
	if(SSticker.GetTimeLeft() < 90 SECONDS)
		SSticker.SetTimeLeft(90 SECONDS)

/datum/vote/shift_intensity/create_vote(mob/vote_creator)
	if(SSshift_intensity.enable_hell_shift)
		default_choices += ROUND_TOTALLY_HELL_SHIFT_STRING
	return ..()

/datum/vote/shift_intensity/tiebreaker(list/winners)
	// Если никто не проголосовал - смена будет *обычная*
	if(choices_by_ckey.len == 0)
		return ROUND_LIGHT_SHIFT_STRING
	// Если ничья между грином и редом - будет блю
	if((ROUND_LIGHT_SHIFT_STRING in winners) && (ROUND_HEAVY_SHIFT_STRING in winners))
		return ROUND_MID_SHIFT_STRING
	return ..()

/datum/vote/shift_intensity/finalize_vote(winning_option)
	if(SSticker.current_state != GAME_STATE_PREGAME)
		message_admins("Shift type vote ended after the round started. No changes to the round type.")
		log_admin("Shift type vote ended after the round started. No changes to the round type.")
		return

	message_admins("Shift type vote ended.")
	log_admin("Shift type vote ended.")

	switch(winning_option)
		if(ROUND_LIGHT_SHIFT_STRING, ROUND_MID_SHIFT_STRING, ROUND_HEAVY_SHIFT_STRING, ROUND_TOTALLY_HELL_SHIFT_STRING)
			SSshift_intensity.set_intensity(winning_option)
		else
			CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")
