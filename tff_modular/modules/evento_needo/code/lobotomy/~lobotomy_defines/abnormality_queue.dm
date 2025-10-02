GLOBAL_LIST_EMPTY(abnormality_ego_set)

/*
* The system was coded as a proof of concept long ago, and might need a good rework.
* Ideally, you should have a certain amount of abnormalities per their threat level.
* For example, an "ideal" composition would be close to this:
* ZAYIN: 2
* TETH: 4
* HE: 6
* WAW: 8
* ALEPH: 4
*/

SUBSYSTEM_DEF(abnormality_queue)
	name = "Abnormality Queue"
	flags = SS_KEEP_TIMING | SS_BACKGROUND | SS_NO_FIRE
	runlevels = RUNLEVEL_GAME
	wait = 10 SECONDS

	/// The abnormality that will spawn on the next fire.
	var/mob/living/simple_animal/hostile/abnormality/queued_abnormality
	/// The subsystem will pick abnormalities of these threat levels.
	var/list/available_levels = list(ZAYIN_LEVEL)
	/// An associative list of potential abnormalities.
	var/list/possible_abnormalities = list(ZAYIN_LEVEL = list(), TETH_LEVEL = list(), HE_LEVEL = list(), WAW_LEVEL = list(), ALEPH_LEVEL = list())
	var/list/spawned_abnormalities = list(ZAYIN_LEVEL = list(), TETH_LEVEL = list(), HE_LEVEL = list(), WAW_LEVEL = list(), ALEPH_LEVEL = list())
	/// Amount of abnormality room spawners at the round-start.
	var/rooms_start = 0
	/// Amount of times PostSpawn() proc has been called. Kept separate from times_fired because admins love to call fire() manually
	var/spawned_abnos = 0
	/// When an abnormality spawns, the time it spawned is here. Purelly used for sephirahs TGUI console
	var/previous_abno_spawn = 0
	// I am using this all because default subsystem waiting and next_fire is done in a very... interesting way.
	/// World time at which new abnormality will be spawned
	var/next_abno_spawn = INFINITY
	/// Wait time for next abno spawn; This time is further affected by amount of abnos in facility
	var/next_abno_spawn_time = 6 MINUTES
	/// Tracks if the current pick is forced
	var/fucked_it_lets_rolled = FALSE
	/// Due to Managers not passing the Litmus Test, divine approval is now necessary for red roll
	var/hardcore_roll_enabled = FALSE

	/// Contains all suppression agents, clears itself of agents that are without a body.
	var/list/active_suppression_agents = list()
	/// the % values of when we give the agents in active_suppression_agents +10 attributes
	var/list/abnormality_milestones = list(0.15, 0.29, 0.44, 0.59, 0.69, 0.79, 1000000)
	/// How far we currently are along the chain of milestones
	var/current_milestone = 1

/datum/controller/subsystem/abnormality_queue/Initialize(timeofday)
	//RegisterSignal(SSdcs, COMSIG_GLOB_ORDEAL_END, PROC_REF(OnOrdealEnd))
	for(var/abn in subtypesof(/mob/living/simple_animal/hostile/abnormality))
		var/mob/living/simple_animal/hostile/abnormality/abno = new abn
		possible_abnormalities[initial(abno.fear_level)] += abn

		if(LAZYLEN(abno.ego_list))
			GLOB.abnormality_ego_set[abno.name] = list(abno.ego_list)
		if(istype(abno.gift_type))
			LAZYADD(GLOB.abnormality_ego_set[abno.name], abno.gift_type)

		qdel(abno)
	return ..()

/datum/controller/subsystem/abnormality_queue/proc/SpawnAbno()
	previous_abno_spawn = world.time
	return SelectAvailableLevels()

// Abno level selection
/datum/controller/subsystem/abnormality_queue/proc/SelectAvailableLevels()

	if(spawned_abnos >= 13)
		available_levels = list(WAW_LEVEL, HE_LEVEL, ALEPH_LEVEL)
	else if(spawned_abnos >= 8 && spawned_abnos < 13)
		available_levels = list(TETH_LEVEL, WAW_LEVEL, HE_LEVEL)
	else if(spawned_abnos >= 4 && spawned_abnos < 8)
		available_levels = list(ZAYIN_LEVEL, TETH_LEVEL, WAW_LEVEL)
	else
		available_levels = list(ZAYIN_LEVEL, TETH_LEVEL)
	// Roll the abnos from available levels
	if(length(possible_abnormalities))
		return PickAbno()
	return FALSE

/datum/controller/subsystem/abnormality_queue/proc/GetAbnoCoreIcon()
	return initial(queued_abnormality.fear_level)

/datum/controller/subsystem/abnormality_queue/proc/PostSpawn()
	if(!queued_abnormality)
		return
	spawned_abnormalities[initial(queued_abnormality.fear_level)] += queued_abnormality
	queued_abnormality = null
	spawned_abnos++

/datum/controller/subsystem/abnormality_queue/proc/PickAbno()
	if(!length(available_levels))
		return FALSE
	/// List of threat levels that we will pick
	var/list/picking_levels = list()
	for(var/threat in available_levels)
		if(!length(possible_abnormalities[threat]))
			continue
		picking_levels |= threat

	if(!length(picking_levels))
		return FALSE

	if(!length(possible_abnormalities))
		return FALSE
	var/lev = pick(picking_levels)
	if(!length(possible_abnormalities[lev]))
		return FALSE
	var/chosen_abno = pick(possible_abnormalities[lev])
	if(!chosen_abno)
		return FALSE
	queued_abnormality = chosen_abno
	return queued_abnormality

// Spawns abnos faster if you lack abnos of that level
/datum/controller/subsystem/abnormality_queue/proc/OnOrdealEnd(datum/source, datum/ordeal/O = null)
	SIGNAL_HANDLER
	return
	//if(!istype(O))
	//	return
	//if(O.level > 3 || O.level < 1)
	//	return
	//var/level_threat = O.level + 2 // Dusk will equal to ALEPH here
	//// Already in there, oops
	//if(level_threat in available_levels)
	//	return
	//priority_announce("Due to [O.name] finishing early, additional abnormalities will be extracted soon.", "M.O.G. ANNOUNCEMENT")
	//INVOKE_ASYNC(src, PROC_REF(SpawnOrdealAbnos), level_threat)

/datum/controller/subsystem/abnormality_queue/proc/SpawnOrdealAbnos(level_threat = 1)
	// Spawn stuff until we reach the desired threat level, or spawn too many things
	for(var/i = 1 to 4)
		SpawnAbno()
		sleep(30 SECONDS)
		if(level_threat in available_levels)
			break
