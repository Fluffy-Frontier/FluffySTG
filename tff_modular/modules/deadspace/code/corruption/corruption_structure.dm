/obj/structure/necromorph
	name = "necromorph sturcture"
	desc = "There is something scary in it."
	icon = 'tff_modular/modules/deadspace/icons/effects/corruption.dmi'
	icon_state = "maw"
	anchored = TRUE
	max_integrity = 25
	resistance_flags = UNACIDABLE
	obj_flags = CAN_BE_HIT
	/// If we are growing or decaying
	var/state = null
	var/can_place_in_sight = FALSE
	var/cost = 2
	var/placement_range = 3
	var/marker_only = FALSE

/obj/structure/necromorph/Initialize(mapload)
	..()
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, PROC_REF(on_integrity_change))
	return INITIALIZE_HINT_LATELOAD

/obj/structure/necromorph/LateInitialize()
	update_signals(null, loc)

/obj/structure/necromorph/Destroy()
	STOP_PROCESSING(SSnecrocorruption, src)
	return ..()

/obj/structure/necromorph/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	..()
	update_signals(old_loc, loc)
	return TRUE

/obj/structure/necromorph/proc/update_signals(atom/old_loc, turf/new_loc)
	if(old_loc)
		UnregisterSignal(old_loc, list(COMSIG_TURF_NECRO_CORRUPTED, COMSIG_TURF_NECRO_UNCORRUPTED))
	if(new_loc)
		if(istype(new_loc) && new_loc.necro_corrupted)
			RegisterSignal(new_loc, COMSIG_TURF_NECRO_UNCORRUPTED, PROC_REF(on_turf_uncorrupted))
			state = GROWING_STRUCTURE
			START_PROCESSING(SSnecrocorruption, src)
		else
			RegisterSignal(new_loc, COMSIG_TURF_NECRO_CORRUPTED, PROC_REF(on_turf_corrupted))
			state = DECAYING_STRUCTURE
			START_PROCESSING(SSnecrocorruption, src)

/obj/structure/necromorph/proc/on_turf_uncorrupted(turf/source)
	SIGNAL_HANDLER
	state = DECAYING_STRUCTURE
	START_PROCESSING(SSnecrocorruption, src)

/obj/structure/necromorph/proc/on_turf_corrupted(turf/source)
	SIGNAL_HANDLER
	state = GROWING_STRUCTURE
	START_PROCESSING(SSnecrocorruption, src)

/obj/structure/necromorph/process(delta_time)
	if(state == GROWING_STRUCTURE)
		repair_damage(3*delta_time)
	else if(state == DECAYING_STRUCTURE)
		take_damage(3*delta_time)
	else
		. = PROCESS_KILL
		CRASH("Corruption was processing while state was [isnull(state) ? "NULL" : state]")

/obj/structure/necromorph/proc/on_integrity_change(atom/source, old_integrity, new_integrity)
	SIGNAL_HANDLER
	if((old_integrity >= new_integrity) && state != DECAYING_STRUCTURE)
		state = GROWING_STRUCTURE
		START_PROCESSING(SSnecrocorruption, src)
	else if(new_integrity >= max_integrity)
		state = null
		STOP_PROCESSING(SSnecrocorruption, src)

/obj/structure/necromorph/play_attack_sound(damage_amount, damage_type, damage_flag)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/blob/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/items/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/structure/necromorph/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	switch(damage_type)
		if(BRUTE)
			damage_amount *= 0.25
		if(BURN)
			damage_amount *= 2
	return ..()

/obj/structure/necromorph/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	//Necromorph structures shouldn't block corruption
	if(istype(mover, /obj/structure/corruption))
		return TRUE
