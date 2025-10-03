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
	flags = SS_KEEP_TIMING | SS_BACKGROUND
	wait = 30 MINUTES

	var/list/all_abnormality_datums = list()

	// State at which it will cause qliphoth meltdowns/ordeal
	var/qliphoth_max = 4
	// How many abnormalities will be affected. Cannot be more than current amount of abnos
	var/qliphoth_meltdown_amount = 1

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
		9 = list(),
	)
	// What ordeal level is being rolled for
	var/next_ordeal_level = 1

	var/current_levels_used = 0
	var/max_levels_used = 1 //Максимум 2 события одного уровня
	// Datum of the chosen ordeal. It's stored so manager can know what's about to happen
	var/datum/ordeal/next_ordeal = null
	/// List of currently running ordeals
	var/list/current_ordeals = list()

	/// Stats for Era/Do after an ordeal is done
	var/ordeal_stats = 0

	/// If TRUE - will not count deaths for auto restart
	var/auto_restart_in_progress = FALSE
	var/needed_players = 25

/datum/controller/subsystem/lobotomy_corp/Initialize(timeofday)
	addtimer(CALLBACK(src, PROC_REF(InitializeOrdeals)), 60 SECONDS)

	return ..()

/datum/controller/subsystem/lobotomy_corp/fire(resumed)
	OrdealEvent()

/datum/controller/subsystem/lobotomy_corp/proc/InitializeOrdeals()
	// Build ordeals global list
	for(var/type in subtypesof(/datum/ordeal))
		var/datum/ordeal/O = new type()
		if(O.level < 1)
			qdel(O)
			continue
		all_ordeals[O.level] += O
	RollOrdeal()
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
		if(!LAZYLEN(all_ordeals))
			flags |= SS_NO_FIRE
			return FALSE
		all_ordeals[next_ordeal_level] = null
		next_ordeal_level--
		return .()
	next_ordeal = pick(available_ordeals)
	all_ordeals[next_ordeal_level] -= next_ordeal
	if(current_levels_used > max_levels_used || !LAZYLEN(all_ordeals[next_ordeal_level]) || prob(30)) //Уровень повышается если ордеалей больше не осталось, либо если использовано 2 ордели или просто с шансом 30%
		next_ordeal_level += 1 // Increase difficulty!
		current_levels_used = 0
	else
		current_levels_used++
	message_admins("Next ordeal to occur will be [next_ordeal.name].")
	return TRUE

/datum/controller/subsystem/lobotomy_corp/proc/OrdealEvent()
	if(!next_ordeal)
		return FALSE
	if(GLOB.alive_player_list.len < needed_players || GLOB.dead_player_list.len > (GLOB.alive_player_list.len / 2))
		return
	if(current_ordeals.len > 2)
		return
	next_ordeal.Run()
	next_ordeal = null
	RollOrdeal()
	return TRUE // Very sloppy, but will do for now
