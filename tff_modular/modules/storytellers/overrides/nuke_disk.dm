/obj/item/disk/nuclear
	VAR_PRIVATE/secure_time = 0
	VAR_PRIVATE/secure = FALSE
	VAR_PRIVATE/loneop_called = FALSE

/obj/item/disk/nuclear/secured_process(last_move)
	secure_time++
	if(secure_time >= 10)
		secure = TRUE

/obj/item/disk/nuclear/unsecured_process(last_move)
	if(secure)
		secure_time = max(0, secure_time - 1)
		if(secure_time == 0)
			secure = FALSE

	var/turf/new_turf = get_turf(src)
	if((last_move < world.time - 500 SECONDS && !secure) || (isspaceturf(new_turf) && prob(20)) && loc == new_turf)
		secure_time = 0
		var/datum/storyteller/ctl = SSstorytellers?.active
		if(!ctl)
			return
		ask_to_storyteller(ctl)

/obj/item/disk/nuclear/proc/ask_to_storyteller(datum/storyteller/ctl)
	if(HAS_TRAIT(ctl, STORYTELLER_TRAIT_NO_ANTAGS) && !loneop_called)
		return
	var/datum/round_event_control/antagonist/from_ghosts/loneop/loneop = locate() in SSstorytellers.events_by_id
	if(ctl.planner.is_event_in_timeline(loneop))
		return
	var/offset = ctl.planner.get_next_event_delay(loneop, ctl)
	if(ctl.planner.try_plan_event(loneop, offset))
		loneop_called = TRUE
		message_admins("The nuclear authentication disk has been left unsecured! And [ctl.name] deploy lone operative.")
	secure = TRUE
	secure_time += 2 MINUTES


/obj/item/disk/nuclear/proc/is_secure()
	return secure
