SUBSYSTEM_DEF(magnet_mining)
	name = "Magnet Mining"
	flags = SS_NO_FIRE
	var/list/asteroid_blocked_turfs = list()
	var/turf/magnetic_center = null // какого хуя
	var/area/mining/magnet/magnet_area = null
	var/max_magnet_spawn_size = 7
	var/min_magnet_spawn_size = 4
	var/list/erase_protected = list()
	var/list/mining_encounters_all = list()
	var/list/mining_encounters_common = list()
	var/list/mining_encounters_uncommon = list()
	var/list/mining_encounters_rare = list()
	var/list/small_encounters = list()
	var/list/mining_encounters_selectable = list()

	var/list/magnet_markers = list()
	var/list/magnet_chassis = list()

/datum/controller/subsystem/magnet_mining/Initialize()
	erase_protected += typecacheof(list(/obj/effect/landmark/magnet_center, /obj/narsie, /obj/singularity, /obj/effect/dummy, /obj/effect/wisp, /obj/effect/forcefield/mining))
	GLOB.nova_plasteel_recipes += new/datum/stack_recipe("mineral magnet chassis", /obj/machinery/magnet_chassis, 25, time = 20 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE)
	for(var/X in subtypesof(/datum/mining_encounter))
		var/datum/mining_encounter/MC = new X
		if(MC.no_pick)
			mining_encounters_all += MC
			continue

		switch(MC.rarity_tier)
			if(3)
				mining_encounters_rare += MC
			if(2)
				mining_encounters_uncommon += MC
			if(1)
				mining_encounters_common += MC
			if(-1)
				small_encounters += MC
			else
				qdel(MC)
				continue
		mining_encounters_all += MC
	return SS_INIT_SUCCESS

/datum/controller/subsystem/magnet_mining/proc/select_encounter(var/rarity_mod)
	if(!isnum(rarity_mod))
		rarity_mod = 0
	var/chosen = pick((max(0, 16 - rarity_mod));1 , 3;2 , 1;3) // 80% обычный 15% необычный и 5% редкий, модификатор уменьшает шанс обычного ивента

	var/list/category = mining_encounters_common
	switch(chosen)
		if(2)
			category = mining_encounters_uncommon
		if(3)
			category = mining_encounters_rare

	if(length(category) < 1)
		category = mining_encounters_common

	return pick(category)

/datum/controller/subsystem/magnet_mining/proc/select_small_encounter(var/rarity_mod)
	return pick(small_encounters)

/datum/controller/subsystem/magnet_mining/proc/add_selectable_encounter(var/datum/mining_encounter/A)
	if(!A)
		return

	var/number = "[(mining_encounters_selectable.len + 1)]"
	mining_encounters_selectable += number
	mining_encounters_selectable[number] = A

/datum/controller/subsystem/magnet_mining/proc/remove_selectable_encounter(var/number_id)
	if(!mining_encounters_selectable.Find(number_id))
		return

	mining_encounters_selectable.Remove(number_id)

	var/list/rebuiltList = list()
	var/count = 1

	for(var/X in mining_encounters_selectable)
		rebuiltList.Add("[count]")
		rebuiltList["[count]"] = mining_encounters_selectable[X]
		count++

	mining_encounters_selectable = rebuiltList

/datum/controller/subsystem/magnet_mining/proc/get_encounter_by_name(var/enc_name = null)
	if(!enc_name)
		return

	for(var/datum/mining_encounter/A in mining_encounters_all)
		if(A.name == enc_name)
			return A
