SUBSYSTEM_DEF(shift_intensity)
	name = "Shift Intensity Vote"
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP
	dependencies = list(
		/datum/controller/subsystem/vote,
	)

	// Время до начала раунда, после которого подсистема будет пытаться запустить голосование
	var/start_time
	// Количество игроков, необходимое для старта голосования
	var/minimum_players

/datum/controller/subsystem/shift_intensity/Initialize()
	if(!CONFIG_GET(flag/shift_intensity))
		can_fire = FALSE
		return SS_INIT_NO_NEED

	start_time = CONFIG_GET(number/shift_intensity_vote_starttime)
	minimum_players = CONFIG_GET(number/shift_intensity_vote_minimum_players)
	return SS_INIT_SUCCESS

/datum/controller/subsystem/shift_intensity/Recover()
	start_time = SSshift_intensity.start_time

/datum/controller/subsystem/shift_intensity/fire()
	if(SSticker.current_state > GAME_STATE_PREGAME)
		can_fire = FALSE
		return

	if(SSticker.GetTimeLeft() <= start_time)
		can_fire = FALSE
		if(GLOB.clients.len < minimum_players)
			return
		SSvote.initiate_vote(/datum/vote/shift_intensity, "server", forced = TRUE)

