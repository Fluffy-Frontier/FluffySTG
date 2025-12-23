/datum/map_config
	// Является ли эта карта - поездом
	var/trainstation = FALSE

GLOBAL_LIST_EMPTY(moving_tufs)


SUBSYSTEM_DEF(train_controller)
	name = "Train Controller"
	wait = 0.2 SECONDS

	dependencies = list(
		/datum/controller/subsystem/mapping,
		/datum/controller/subsystem/statpanels,
	)

	VAR_PRIVATE/moving = FALSE

	VAR_PRIVATE/list/all_simulated_turfs = list()

	VAR_PRIVATE/list/to_process

	// Загружается или выгружается в данный момент станция
	var/loading = FALSE
	// Станция запланированная для загрузки
	var/datum/train_station/planned_to_load = null
	// Текущая загруженная станция
	var/datum/train_station/loaded_station = null

	var/static/list/known_stations = list()

/datum/controller/subsystem/train_controller/Initialize()
	RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, PROC_REF(on_enter_pregame))
	load_stations()

/datum/controller/subsystem/train_controller/Destroy()
	all_simulated_turfs.Cut()
	to_process.Cut()
	return ..()

/datum/controller/subsystem/train_controller/proc/check_trainstation()
	if(!SSmapping.current_map)
		return FALSE
	if(!SSmapping.current_map.trainstation)
		return FALSE
	return FALSE

/datum/controller/subsystem/train_controller/proc/load_stations()
	for(var/path in subtypesof(/datum/train_station))
		known_stations += new path

/datum/controller/subsystem/train_controller/proc/announce_game()
	to_chat(world, span_boldnotice( \
		"Trainstation режим - активен \n \
		Станция будет заменена на подвижный состав, что будет перемещаться между разными станциями. \
		Вам и вамшим коллегам предстоит добраться от стартовой станции к конечному пункту назначения, \
		в процессе вам предстоит следить за тем, чтобы предоставленный вам состав оставался в порядке и мог \
		продолжать ваше путешествие. \n \
		Event by: Fenysha \
	"))


/datum/controller/subsystem/train_controller/proc/on_enter_pregame()
	SIGNAL_HANDLER

	// Сперва на перво сообщим об правилах игры
	announce_game()
	ASYNC
		load_startpoint()


/datum/controller/subsystem/train_controller/proc/load_startpoint()
	load_station(/datum/train_station/start_point, stop_moving = FALSE, hide_for_players = FALSE)


/datum/controller/subsystem/train_controller/proc/on_station_unloaded()
	loading = FALSE

/datum/controller/subsystem/train_controller/proc/unload_station(datum/train_station/to_unload, hide_for_players = TRUE)
	if(!to_unload)
		return
	loading = TRUE
	to_unload.unload_station(CALLBACK(src, PROC_REF(on_station_unloaded)))


/datum/controller/subsystem/train_controller/proc/on_station_loaded()
	loading = FALSE

/datum/controller/subsystem/train_controller/proc/load_station(path_or_instance, stop_moving = FALSE, hide_for_players = TRUE)
	var/datum/train_station/to_load = null
	if(ispath(path_or_instance, /datum/train_station))
		to_load = locate(path_or_instance) in known_stations
	else if(istype(path_or_instance, /datum/train_station))
		to_load = path_or_instance

	if(!to_load)
		CRASH("Failed to load station [path_or_instance], invalid path!")
	if(hide_for_players)
		for(var/mob/living/L in GLOB.alive_player_list)
			L.overlay_fullscreen("station_loading", /atom/movable/screen/fullscreen/flash/black)

	if(loaded_station)
		unload_station(loaded_station, hide_for_players ? FALSE : TRUE)
		UNTIL(!loading)
	loading = TRUE
	to_load.load_station(CALLBACK(src, PROC_REF(on_station_loaded)))
	message_admins("TRAINSTATION: start to load station: [to_load.name]!")
	UNTIL(!loading)

	loaded_station = to_load
	if(stop_moving)
		stop_moving()
	for(var/mob/living/L in GLOB.alive_player_list)
		L.clear_fullscreen("station_loading", animated = 5 SECONDS)
	show_station_logo(to_load)

/datum/controller/subsystem/train_controller/proc/show_station_logo(datum/train_station/station)


/datum/controller/subsystem/train_controller/proc/register(turf/open/moving/T)
	if(T in all_simulated_turfs)
		return
	all_simulated_turfs += T

/datum/controller/subsystem/train_controller/proc/unregister(turf/open/moving/T)
	all_simulated_turfs -= T


/datum/controller/subsystem/train_controller/proc/start_moving()
	if(moving)
		return
	moving = TRUE
	for(var/turf/open/moving/T as anything in all_simulated_turfs)
		T.moving = TRUE
		T.update_appearance()

/datum/controller/subsystem/train_controller/proc/stop_moving()
	if(!moving)
		return
	moving = FALSE
	for(var/turf/open/moving/T as anything in all_simulated_turfs)
		T.moving = FALSE
		T.update_appearance()

/datum/controller/subsystem/train_controller/fire(resumed)
	if(!moving)
		return
	INVOKE_ASYNC(src, PROC_REF(process_turfs), world.tick_usage)

/datum/controller/subsystem/train_controller/proc/process_turfs(seconds_per_tick)
	for(var/turf/open/moving/T as anything in all_simulated_turfs)
		T.process_contents(seconds_per_tick)

/obj/structure/fluff/bus

/datum/controller/subsystem/train_controller/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TrainMovementController")
		ui.open()

/datum/controller/subsystem/train_controller/ui_state(mob/user)
	return GLOB.admin_state

/datum/controller/subsystem/train_controller/ui_data(mob/user)
	var/list/data = list()
	data["moving"] = moving
	data["num_turfs"] = length(all_simulated_turfs)
	data["stations"] = list()
	for(var/datum/train_station/station in known_stations)
		data["stations"] += list(
			list(
				"name" = station.name,
				"type" = station.type,
				)
			)
	data["current_station"] = loaded_station?.name || "None"
	return data

/datum/controller/subsystem/train_controller/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("open_vv")
			if(!check_rights(R_ADMIN))
				return
			usr.client.debug_variables(src)
		if("start_moving")
			start_moving()
			return TRUE
		if("stop_moving")
			stop_moving()
			return TRUE
		if("set_speed")
			var/new_speed = params["speed"]
			if(isnum(new_speed) && new_speed > 0)
				return TRUE
		if("set_cooldown")
			var/new_cd = params["cooldown"]
			if(isnum(new_cd) && new_cd > 0)
				return TRUE

		if("load_station")
			var/station_type = text2path(params["station_type"])
			if(ispath(station_type, /datum/map_template/train_station))
				INVOKE_ASYNC(src, PROC_REF(load_station), station_type)
				return TRUE
		if("unload_station")
			if(loaded_station)
				INVOKE_ASYNC(src, PROC_REF(unload_station), loaded_station)
				loaded_station = null
				return TRUE

ADMIN_VERB(open_train_controller, R_ADMIN, "Open train controller", "Open active train controller.", ADMIN_CATEGORY_EVENTS)
	SStrain_controller.ui_interact(usr)

/obj/effect/mapping_helpers/ztrait_injector/trainstation
	traits_to_add = list(ZTRAIT_NOPARALLAX = TRUE, ZTRAIT_NOXRAY = TRUE, ZTRAIT_NOPHASE = TRUE, ZTRAT_TRAINSTATION = TRUE, ZTRAIT_BASETURF = /turf/open/space)

