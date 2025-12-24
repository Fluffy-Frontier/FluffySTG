/obj/effect/landmark/trainstation
	icon_state = "tdome_admin"

/obj/effect/landmark/trainstation/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STATION_UNLOAD, INNATE_TRAIT)

// Используетя для создания окрестности станции над рельсами путей
/obj/effect/landmark/trainstation/nearstation_spawnpoint
	name = "Near station placer"

// Используется для создания станций, под рельсами путей
/obj/effect/landmark/trainstation/station_spawnpoint
	name = "Station Placer"


/obj/effect/landmark/trainstation/object_spawner
	name = "Object spawner"

	var/accuracy = 1
	var/list/possible_objects = list()
	var/min_delay = 1 SECONDS
	var/max_delay = 3 SECONDS

	COOLDOWN_DECLARE(spawn_cd)


/obj/effect/landmark/trainstation/object_spawner/Initialize(mapload)
	. = ..()
	RegisterSignal(SStrain_controller, COMSIG_TRAIN_BEGIN_MOVING, PROC_REF(on_train_begin_moving))
	RegisterSignal(SStrain_controller, COMSIG_TRAIN_STOP_MOVING, PROC_REF(on_train_stop_moving))

/obj/effect/landmark/trainstation/object_spawner/Destroy()
	. = ..()

/obj/effect/landmark/trainstation/object_spawner/proc/on_train_begin_moving()
	SIGNAL_HANDLER
	START_PROCESSING(SSobj, src)

/obj/effect/landmark/trainstation/object_spawner/proc/on_train_stop_moving()
	SIGNAL_HANDLER
	STOP_PROCESSING(SSobj, src)

/obj/effect/landmark/trainstation/object_spawner/process(seconds_per_tick)
	. = ..()
	if(!COOLDOWN_FINISHED(src, spawn_cd))
		return
	COOLDOWN_START(src, spawn_cd, rand(min_delay, max_delay))
	attempt_spawn()

/obj/effect/landmark/trainstation/object_spawner/proc/attempt_spawn()
	if(!length(possible_objects))
		return
	var/turf/target_turf = get_turf(src)
	if(accuracy > 0)
		for(var/turf/T as anything in shuffle(RANGE_TURFS(accuracy, src)))
			if(isopenturf(T))
				target_turf = T
				break
	var/selected = pick(possible_objects)
	var/atom/movable/new_obj = new selected(src)
	if(new_obj)
		new_obj.forceMove(target_turf)

/datum/map_template/train_station
	name = "Train Station Template"
	returns_created_atoms = TRUE

/turf/closed/indestructible/train_border
	name = "Iced rock"
	icon_state = "icerock"

/datum/train_station
	var/name = "Train station"
	var/desc = "A generic train station"

	var/datum/map_template/template = null
	var/ambience_sound = null
	var/map_path
	var/visible = TRUE

	var/z_level = 0

	var/list/docking_turfs = list()

/datum/train_station/New()
	. = ..()
	template = new /datum/map_template(map_path, "Train station - [name]", TRUE)
	template.returns_created_atoms = TRUE
	SSmapping.map_templates[template.name] = template

/datum/train_station/proc/load_station(datum/callback/load_callback)
	if(!template)
		return FALSE
	var/start_time = world.realtime
	var/obj/effect/landmark/trainstation/station_spawnpoint/spawnpoint = locate() in GLOB.landmarks_list
	if(!spawnpoint || !istype(spawnpoint))
		CRASH("Failed to load train station [name], no available spawnpoints!")
	var/offset_x = spawnpoint.x
	var/offset_y = spawnpoint.y - template.height + 1
	var/offset_z = spawnpoint.z

	var/turf/actual_spawnpoint = locate(offset_x, offset_y, offset_z)
	if(!actual_spawnpoint)
		CRASH("Failed to load train station [name], template out of bounds")
	var/bounds = template.load(actual_spawnpoint, centered = FALSE)

	docking_turfs = block(
		bounds[MAP_MINX], bounds[MAP_MINY], bounds[MAP_MINZ],
		bounds[MAP_MAXX], bounds[MAP_MAXY], bounds[MAP_MAXZ]
	)
	if(template.width < world.maxx)
		create_indestructible_borders(actual_spawnpoint)

	var/load_in = world.realtime - start_time
	message_admins("TRAINSTATION: Loaded station [name] in [time2text(load_in, "ss")] seconds!")
	if(load_callback)
		load_callback.Invoke()
	return TRUE


/datum/train_station/proc/create_indestructible_borders(turf/bottom_left)
	var/left_x = bottom_left.x - 1
	var/right_x = bottom_left.x + template.width
	var/start_y = bottom_left.y
	var/end_y = bottom_left.y + template.height - 1
	var/z = bottom_left.z

	// Левая линия
	for(var/y = start_y to end_y)
		var/turf/left_turf = locate(left_x, y, z)
		if(left_turf)
			left_turf.ChangeTurf(/turf/closed/indestructible/train_border)
			docking_turfs += left_turf


	for(var/y = start_y to end_y)
		var/turf/right_turf = locate(right_x, y, z)
		if(right_turf)
			right_turf.ChangeTurf(/turf/closed/indestructible/train_border)
			docking_turfs += right_turf


/datum/train_station/proc/unload_station(datum/callback/unload_callback)
	priority_announce("Поезд отходит от станции: [name].", "Поездной эвент")
	for(var/turf/T in docking_turfs)
		for(var/atom/movable/AM in T.contents)
			if(HAS_TRAIT(AM, TRAIT_NO_STATION_UNLOAD))
				continue
			qdel(AM)
		T.ChangeTurf(/turf/open/space)
	docking_turfs.Cut()
	template.created_atoms = null
	if(unload_callback)
		unload_callback.Invoke()

/datum/train_station/start_point
	name = "Start-point"
	map_path = "_maps/modular_events/trainstation/startpoint.dmm"

/datum/train_station/train_backstage
	name = "Iced forest"
	map_path = "_maps/modular_events/trainstation/backstage.dmm"
	visible = FALSE
