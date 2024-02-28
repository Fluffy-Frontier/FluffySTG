/datum/area_replace_obj/comntr_console
	target_areas = list(/area/station/command/heads_quarters/nt_rep)
	desired_atom = /obj/machinery/computer/comntr
	target_obj = /obj/machinery/modular_computer/preset/command

/datum/controller/subsystem/area_spawn/Initialize()
	for(var/iterating_type in subtypesof(/datum/area_replace_obj))
		var/datum/area_replace_obj/iterating_area_replace_obj = new iterating_type
		iterating_area_replace_obj.try_spawn()
		qdel(iterating_area_replace_obj)
	. = ..()
/**
 * Spawns an atom ensted of atom or object.
 */
/datum/area_replace_obj
	var/list/target_areas
	/// The atom type that we want to spawn
	var/desired_atom
	/// Whom we will kill for replace
	var/target_obj
	/// Map blacklist, this is used to determine what maps we should not spawn on.
	var/list/blacklisted_stations = list("Runtime Station", "MultiZ Debug", "Gateway Test")

/**
 * Spawn the atoms.
 */
/datum/area_replace_obj/proc/try_spawn()
	// Ищем область где будем искать объект под замену.
	if(SSmapping.config.map_name in blacklisted_stations)
		return

	for(var/area_type in target_areas)
		var/area/found_area = GLOB.areas_by_type[area_type]
		if(!found_area)
			continue
		// Каждую клетку прогоняем.
		for(var/list/zlevel_turfs as anything in found_area.get_zlevel_turf_lists())
			for(var/turf/candidate_turf as anything in zlevel_turfs)
				if(is_type_on_turf(candidate_turf, target_obj))
					//Нашли клетку где стоит наш объект под замену.
					var/obj/mytarget = pick(candidate_turf.get_all_contents_type(target_obj))
					if(is_type_on_turf(candidate_turf, target_obj))
						// Направление меняем.
						var/obj/some =  new desired_atom(candidate_turf)
						some.setDir(mytarget.dir)
						qdel(mytarget)
						break
