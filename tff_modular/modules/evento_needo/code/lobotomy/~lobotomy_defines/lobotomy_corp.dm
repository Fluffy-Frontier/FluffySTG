// Meltdown types
#define MELTDOWN_NORMAL 1
#define MELTDOWN_GRAY 2
#define MELTDOWN_GOLD 3
#define MELTDOWN_PURPLE 4
#define MELTDOWN_CYAN 5
#define MELTDOWN_BLACK 6

// TODO: Do something about it, idk
SUBSYSTEM_DEF(lobotomy_corp)
	name = "Lobotomy Corporation"
	flags = SS_KEEP_TIMING | SS_BACKGROUND | SS_NO_FIRE
	wait = 5 MINUTES

	var/list/all_abnormality_datums = list()

	// How many qliphoth_events were called so far
	var/qliphoth_state = 0
	// Current level of the qliphoth meter
	var/qliphoth_meter = 0
	// State at which it will cause qliphoth meltdowns/ordeal
	var/qliphoth_max = 4
	// How many abnormalities will be affected. Cannot be more than current amount of abnos
	var/qliphoth_meltdown_amount = 1
	// What abnormality threat levels are affected by meltdowns
	var/list/qliphoth_meltdown_affected = list(
		ZAYIN_LEVEL,
		TETH_LEVEL,
		HE_LEVEL,
		WAW_LEVEL,
		ALEPH_LEVEL
		)

	// Assoc list of ordeals by level
	var/list/all_ordeals = list(
							1 = list(),
							2 = list(),
							3 = list(),
							4 = list(),
							5 = list(),
							6 = list(),
							7 = list(),
							8 = list(),
							9 = list()
							)
	// At what qliphoth_state next ordeal will happen
	var/next_ordeal_time = 1
	// What ordeal level is being rolled for
	var/next_ordeal_level = 1
	// Minimum time for each ordeal level to occur. If requirement is not met - normal meltdown will occur
	var/list/ordeal_timelock = list(20 MINUTES, 40 MINUTES, 60 MINUTES, 90 MINUTES, 0, 0, 0, 0, 0)
	// Datum of the chosen ordeal. It's stored so manager can know what's about to happen
	var/datum/ordeal/next_ordeal = null
	/// List of currently running ordeals
	var/list/current_ordeals = list()
	// Currently running core suppression
	var/datum/suppression/core_suppression = null
	// List of active core suppressions; Different from above, as there can only be one "main" core
	var/list/active_core_suppressions = list()
	// List of available core suppressions for manager to choose
	var/list/available_core_suppressions = list()
	// State of the core suppression
	var/core_suppression_state = 0
	// Work logs from all abnormalities
	var/list/work_logs = list()
	// Work logs, but from agent perspective. Used mainly for round-end report
	var/list/work_stats = list()
	// List of facility upgrade datums
	var/list/upgrades = list()

	/// When TRUE - abnormalities can be possessed by ghosts
	var/enable_possession = FALSE
	/// Stats for Era/Do after an ordeal is done
	var/ordeal_stats = 0

	/// If TRUE - will not count deaths for auto restart
	var/auto_restart_in_progress = FALSE

/datum/controller/subsystem/lobotomy_corp/Initialize(timeofday)
	addtimer(CALLBACK(src, PROC_REF(InitializeOrdeals)), 60 SECONDS)

	return ..()

/datum/controller/subsystem/lobotomy_corp/proc/InitializeOrdeals()
	// Build ordeals global list
	for(var/type in subtypesof(/datum/ordeal))
		var/datum/ordeal/O = new type()
		if(O.level < 1)
			qdel(O)
			continue
		all_ordeals[O.level] += O

	return TRUE

/datum/controller/subsystem/lobotomy_corp/proc/NewAbnormality(datum/abnormality/new_abno)
	if(!istype(new_abno))
		return FALSE
	all_abnormality_datums += new_abno
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_ABNORMALITY_SPAWN, new_abno)
	return TRUE

/datum/controller/subsystem/lobotomy_corp/proc/RollOrdeal()
	if(!islist(all_ordeals[next_ordeal_level]) || !LAZYLEN(all_ordeals[next_ordeal_level]))
		return FALSE
	var/list/available_ordeals = list()
	for(var/datum/ordeal/O in all_ordeals[next_ordeal_level])
		if(O.AbleToRun())
			available_ordeals += O
	if(!LAZYLEN(available_ordeals))
		return FALSE
	next_ordeal = pick(available_ordeals)
	all_ordeals[next_ordeal_level] -= next_ordeal
	next_ordeal_time = max(3, qliphoth_state + next_ordeal.delay + (next_ordeal.random_delay ? rand(-1, 1) : 0))
	next_ordeal_level += 1 // Increase difficulty!
	message_admins("Next ordeal to occur will be [next_ordeal.name].")
	return TRUE

/datum/controller/subsystem/lobotomy_corp/proc/OrdealEvent()
	if(!next_ordeal)
		return FALSE
	if(ordeal_timelock[next_ordeal.level] > ROUND_TIME())
		return FALSE // Time lock
	next_ordeal.Run()
	next_ordeal = null
	RollOrdeal()
	return TRUE // Very sloppy, but will do for now
