// Closest hack into /datum/spy_bounty/machine/init_bounty(datum/spy_bounty_handler/handler) which I can touch without altering original files
/datum/spy_bounty/machine/console
	target_type = /obj/machinery/modular_computer
	var/prg_name

/datum/spy_bounty/machine/console/get_dupe_protection_key(atom/movable/stealing)
	return prg_name

/datum/spy_bounty/machine/console/init_bounty(datum/spy_bounty_handler/handler)
	if(isnull(target_type) || isnull(prg_name))
		return FALSE

	// Blacklisting maintenance in general, as well as any areas that already have a bounty in them.
	var/list/blacklisted_areas = typecacheof(/area/station/maintenance)
	for(var/datum/spy_bounty/machine/existing_bounty in handler.get_all_bounties())
		blacklisted_areas[existing_bounty.location_type] = TRUE

	var/list/obj/machinery/all_possible = list()
	for(var/obj/machinery/found_machine as anything in SSmachines.get_machines_by_type_and_subtypes(target_type))
		if(!is_station_level(found_machine.z) && !is_mining_level(found_machine.z))
			continue
		var/obj/machinery/modular_computer/comp = found_machine
		if(!comp.cpu)
			continue
		if(!comp.cpu.find_file_by_name(prg_name))
			continue
		var/area/found_machine_area = get_area(found_machine)
		if(is_type_in_typecache(found_machine_area, blacklisted_areas))
			continue
		if(!isnull(location_type) && !istype(found_machine_area, location_type))
			continue
		if(!(found_machine_area.area_flags & VALID_TERRITORY)) // only steal from valid station areas
			continue
		all_possible += found_machine

	if(!length(all_possible))
		return FALSE

	var/obj/machinery/machine = pick_n_take(all_possible)
	var/area/machine_area = get_area(machine)
	// Tracks the picked machine, as well as any other machines in the same area
	// (So they can be removed from the room but still count, for clever Spies)
	original_options_weakrefs += WEAKREF(machine)
	for(var/obj/machinery/other_machine as anything in all_possible)
		if(get_area(other_machine) == machine_area)
			original_options_weakrefs += WEAKREF(other_machine)

	location_type = machine_area.type
	name ||= "[machine.name] Burglary"
	help ||= "Steal \a [machine] found in [machine_area]."
	return TRUE

/datum/spy_bounty/machine/console/is_stealable(atom/movable/stealing)
	if(!istype(stealing, target_type))
		return FALSE
	if(WEAKREF(stealing) in original_options_weakrefs)
		return TRUE
	if(istype(get_area(stealing), location_type))
		var/obj/machinery/modular_computer/target = stealing
		if(!target.cpu)
			return FALSE
		if(!target.cpu.find_file_by_name(prg_name))
			return FALSE
		return TRUE
	return FALSE


/datum/spy_bounty/machine/console/random
	/// List of all program names we can randomly draw from
	var/list/random_options = list()

/datum/spy_bounty/machine/console/random/init_bounty(datum/spy_bounty_handler/handler)
	var/list/options = random_options.Copy()
	for(var/datum/spy_bounty/machine/console/existing_bounty in handler.get_all_bounties())
		options -= existing_bounty.prg_name

	for(var/remaining_option in options)
		if(check_dupe(handler, remaining_option, 33))
			options -= remaining_option

	if(!length(options))
		return FALSE

	prg_name = pick(options)
	return ..()

/datum/spy_bounty/machine/console/random/easy
	difficulty = SPY_DIFFICULTY_EASY
	weight = 4 // Increased due to there being many easy options
	random_options = list(
		"operating",
		//obj/machinery/computer/order_console/mining,
		"fullrecordsmedical",
	)

/datum/spy_bounty/machine/console/random/medium
	difficulty = SPY_DIFFICULTY_MEDIUM
	weight = 4 // Increased due to there being many medium options
	random_options = list(
		//obj/machinery/computer/bank_machine,
		//obj/machinery/computer/camera_advanced/xenobio,
		"ordermasterapp", // This includes request-only ones in the public lobby
		"orderslaveapp",
		"crewmonitor",
		//obj/machinery/computer/prisoner/management,
		"experi_track",
		"fullrecordssecurity",
		//obj/machinery/computer/scan_consolenew,
		"secureye", // Requires breaking into a sec checkpoint, but not too hard, many are never visited
	)

/datum/spy_bounty/machine/console/random/hard
	difficulty = SPY_DIFFICULTY_HARD
	random_options = list(
		"accounting",
		//obj/machinery/computer/communications,
		//obj/machinery/computer/upload,
		//obj/machinery/modular_computer/preset/id,
	)


/datum/spy_bounty/machine/console/random/hard/can_claim(mob/user) // These would all be too easy with command level access
	return !(user.mind?.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND)

/datum/spy_bounty/machine/console/random/hard/ai_sat_teleporter
	random_options = list(
		//obj/machinery/computer/teleporter,
	)
	location_type = /area/station/ai_monitored/aisat
