/datum/abnormality
	var/name = "Abnormality"
	var/desc = "An abnormality of unknown type."
	/// Current state of the qliphoth
	var/qliphoth_meter = 0
	/// Maximum level of qliphoth. If 0 or below - it has no effects
	var/qliphoth_meter_max = 0
	/// Path of the mob it contains
	var/mob/living/simple_animal/hostile/abnormality/abno_path
	/// Reference to current mob, if alive
	var/mob/living/simple_animal/hostile/abnormality/current

	/// List of available EGO for purchase
	var/list/ego_datums = list()
	///if the abno spawns with a slime radio or not
	var/abno_radio = FALSE
	// Object = list(x tile offset, y tile offset)
	/// List of connected structures; Used to teleport and delete them when abnormality is swapped or deleted
	var/list/connected_structures = list()

	//Check for Neutral abnormalities
	var/good_hater = FALSE

/datum/abnormality/New(new_type = null)
	if(!ispath(new_type))
		CRASH("Abnormality datum was created without a path to the mob.")
	abno_path = new_type
	name = initial(abno_path.name)
	desc = initial(abno_path.desc)
	RespawnAbno()
	FillEgoList()

/datum/abnormality/Destroy()
	for(var/datum/ego_datum/ED in ego_datums)
		qdel(ED)
	for(var/atom/A in connected_structures)
		qdel(A)
	QDEL_NULL(current)
	ego_datums = null
	connected_structures = null
	return ..()

/datum/abnormality/proc/RespawnAbno(datum/source)
	if(!ispath(abno_path))
		CRASH("Abnormality tried to respawn a mob, but abnormality path wasn't valid.")
	if(istype(current))
		return
	var/turf/T = get_turf(source)
	current = new abno_path(T)
	current.toggle_ai(AI_OFF)
	ADD_TRAIT(current, TRAIT_GODMODE, ADMIN_TRAIT)
	current.setDir(EAST)

	if(abno_radio)
		current.AbnoRadio()
	current.PostSpawn()

/datum/abnormality/proc/FillEgoList()
	if(!current || !current.ego_list)
		return FALSE
	for(var/thing in current.ego_list)
		var/datum/ego_datum/ED = new thing(src)
		ego_datums += ED
		GLOB.ego_datums["[ED.name][ED.item_category]"] = ED
	return TRUE

/datum/abnormality/proc/GetName()
	if(current)
		return current.GetName()
	return name
