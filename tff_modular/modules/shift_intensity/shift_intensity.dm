#define LAST_ATTEMPT_DEADLINE 120 SECONDS

SUBSYSTEM_DEF(shift_intensity)
	name = "Shift Intensity Vote"
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP
	dependencies = list(
		/datum/controller/subsystem/vote,
	)

	/// Время до начала раунда, после которого подсистема будет пытаться запустить голосование
	var/start_time
	/// Количество игроков, необходимое для старта голосования
	var/minimum_players

/datum/controller/subsystem/shift_intensity/Initialize()
	start_time = CONFIG_GET(number/shift_intensity_vote_starttime)
	minimum_players = CONFIG_GET(number/shift_intensity_vote_minimum_players)

	if(!CONFIG_GET(flag/shift_intensity))
		can_fire = FALSE
		return SS_INIT_NO_NEED

	log_game("SSshift_intensity was enabled in config. Vote will start [start_time/10] seconds before the start of the round.")
	message_admins("SSshift_intensity was enabled in config. Vote will start [start_time/10] seconds before the start of the round.")
	return SS_INIT_SUCCESS

/datum/controller/subsystem/shift_intensity/Recover()
	start_time = SSshift_intensity.start_time
	minimum_players = SSshift_intensity.minimum_players

/datum/controller/subsystem/shift_intensity/fire()
	if(SSticker.current_state > GAME_STATE_PREGAME)
		can_fire = FALSE
		return

	if(istype(SSvote.current_vote, /datum/vote/shift_intensity))
		can_fire = FALSE
		return

	if(SSticker.GetTimeLeft() <= start_time)
		if(SSticker.totalPlayers < minimum_players)
			if(SSticker.GetTimeLeft() > LAST_ATTEMPT_DEADLINE) // Будет пытаться начать воут вплоть до 120 секунд доя старта раунда и потом отключится, если все еще не набрались люди
				return

			can_fire = FALSE
			log_game("The vote for shift intensity was cancelled due to insufficient number of players.")
			message_admins("The vote for shift intensity was cancelled due to insufficient number of players.")
			return

		can_fire = FALSE
		SSvote.initiate_vote(/datum/vote/shift_intensity, "server", forced = TRUE)

#undef LAST_ATTEMPT_DEADLINE
