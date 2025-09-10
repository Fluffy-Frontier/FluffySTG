/*
* This Proc converts armor values into
* mob defense values
*/
/mob/living/simple_animal/hostile/proc/UpdateArmor(list/damage_list = list(BURN = 1, BRAIN = 1, BRUTE = 1, TOX = 1))
	var/obj/item/clothing/suit/armor/host_armor = locate(/obj/item/clothing/suit/armor) in contents
	//var/fortitude
	//var/prudence
	//var/temperance
	//var/justice
	if(host_armor)
	//	if(host_armor.armor[BRUTE])
	//		fortitude = 1 - (host_armor.armor[BRUTE] / 100) // 100 armor / 100 = 1
	//		if(fortitude <= damage_list[BRUTE] && fortitude > 0) //if armor is less than current red armor and is more than 0 since anything 0 or below is healing or immune to damage
	//			damage_list[BRUTE] = fortitude
	//	if(host_armor.armor[BRUTE])
	//		prudence = 1 - (host_armor.armor[BRUTE] / 100)
	//		if(prudence <= damage_list[BRUTE] && prudence > 0)
	//			damage_list[BRUTE] = prudence
	//	if(host_armor.armor[BRUTE])
	//		temperance = 1 - (host_armor.armor[BRUTE] / 100)
	//		if(temperance > 0)
	//			damage_list[BRUTE] = temperance
	//	if(host_armor.armor[BRUTE])
	//		justice = 1 - (host_armor.armor[BRUTE] / 100)
	//		if(justice > 0)
	//			damage_list[BRUTE] = justice
	//	ChangeResistances(damage_list)
		return TRUE

/*
* Moves all things that are considered hard clothing.
*/
/mob/living/simple_animal/hostile/proc/dropHardClothing(mob/living/carbon/C, turf/our_stuff)
	if(!iscarbon(C))
		return FALSE
	var/list/things_to_drop = list()
	//Things we drop.
	LAZYADD(things_to_drop, C.get_item_by_slot(ITEM_SLOT_SUITSTORE))
	LAZYADD(things_to_drop, C.get_item_by_slot(ITEM_SLOT_BELT))
	LAZYADD(things_to_drop, C.get_item_by_slot(ITEM_SLOT_BACK))
	LAZYADD(things_to_drop, C.get_item_by_slot(ITEM_SLOT_OCLOTHING))
	for(var/obj/i in things_to_drop)
		i.forceMove(our_stuff)
	return TRUE

/*
* Used in tile check to make sure that creatures
* can cross something when dashing
*/
/mob/living/simple_animal/hostile/proc/ClearSky(turf/T)
	if(!T || isclosedturf(T) || T == loc)
		return FALSE
	if(locate(/obj/structure/window) in T.contents)
		return FALSE
	if(locate(/obj/structure/table) in T.contents)
		return FALSE
	if(locate(/obj/structure/railing) in T.contents)
		return FALSE
	for(var/obj/machinery/door/D in T.contents)
		if(D.density)
			return FALSE
	return TRUE
