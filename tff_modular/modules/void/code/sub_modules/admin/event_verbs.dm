/client/proc/mass_horror()
	set category = "Events"
	set name = "Mass horror crew"

	if(!check_rights(R_FUN))
		return

/client/proc/summon_void_creature()
	set category = "Events.Void"
	set name = "Summon void creature"

	if(!check_rights(R_FUN))
		return

	var/check = tgalert(usr, "Are you sure want release this?", "Void creature escape", "Yes", "Channel")
	if(check == "Channel" || !check)
		return
	message_admins("[usr] spanws void creaute at[ADMIN_JMP(usr.loc)]!")
	var/mob/living/simple_animal/hostile/void_creture/v = new(usr.loc)
	v.toggle_ai(AI_OFF)

/client/proc/make_void_infection()
	set category = "Events.Void"
	set name = "Make void infection"

	if(!check_rights(R_FUN))
		return

	var/check = tgalert(usr, "Are you sure want spawn this?", "Void infection spawn", "Yes", "Channel")
	if(check == "Channel" || !check)
		return
	var/ask_light = tgalert(usr, "Break the light in close area?", "Break light", "Yes", "No")
	for(var/turf/old_turf in RANGE_TURFS(5, usr))
		old_turf.TerraformTurf(/turf/open/void_turf, /turf/open/void_turf, flags = CHANGETURF_INHERIT_AIR)

	if(ask_light == "Yes")
		for(var/obj/machinery/light/L in RANGE_TURFS(10, usr))
			if(L.status == LIGHT_BROKEN)
				continue
			L.break_light_tube()
