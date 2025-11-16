/// TGMC_XENOS (old nova sector xenos)

/obj/structure/alien/egg/tgmc
	child_path = /obj/item/clothing/mask/facehugger/tgmc

	var/leap_range = 2
	var/return_timer

/obj/structure/alien/egg/tgmc/Grow()
	. = ..()
	proximity_monitor.set_range(leap_range - 1)

/obj/structure/alien/egg/tgmc/finish_bursting(kill = TRUE)
	if(child)
		var/obj/item/clothing/mask/facehugger/tgmc/child_hugger = child
		child_hugger.forceMove(get_turf(src))
		if(istype(child_hugger, child_path))
			if(kill)
				child_hugger.Die()
			else
				if(!child_hugger.ProximityLeap(leap_range))
					return_timer = addtimer(CALLBACK(src, PROC_REF(return_child)), 15 SECONDS, TIMER_UNIQUE|TIMER_DELETE_ME)
	return ..()

/obj/structure/alien/egg/tgmc/proc/return_child(obj/item/clothing/mask/facehugger/hugger)
	if(isnull(hugger))
		hugger = locate(child_path) in loc

	if(isnull(hugger) || !istype(hugger, child_path))
		return FALSE

	hugger.forceMove(src)
	child = hugger
	proximity_monitor.set_range(leap_range - 1)

	status = "grown"
	update_appearance()
	return TRUE

/obj/structure/alien/egg/tgmc/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, child_path))
		return return_child(tool) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_FAILURE
	return ..()


/obj/structure/alien/weeds/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	// Мы подняли температуру, при которой начинает наноситься урон до ~72 градусов. Иначе на какой-нибудь серенити обычный атмос улицы будет убивать резину
	return exposed_temperature > 345
