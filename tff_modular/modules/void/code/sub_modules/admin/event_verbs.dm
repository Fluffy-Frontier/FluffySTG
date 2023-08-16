/client/proc/summon_void_creature()
	set category = "Events.Void"
	set name = "Summon void creature"

	if(!check_rights(R_FUN))
		return
	if(!usr)
		return

	var/check = tgalert(usr, "Are you sure want release this?", "Void creature escape", "Yes", "Channel")
	if(check == "Channel" || !check)
		return
	message_admins("[usr] spanws void creaute at[ADMIN_JMP(usr.loc)]!")
	var/mob/living/simple_animal/hostile/void_creture/v = new(usr.loc)

/client/proc/make_void_infection()
	set category = "Events.Void"
	set name = "Make void infection"

	if(!check_rights(R_FUN))
		return
	if(!usr)
		return

	var/check = tgalert(usr, "Are you sure want spawn this?", "Void infection spawn", "Yes", "Channel")
	if(check == "Channel" || !check)
		return

	for(var/atom/AO in range(7, usr.loc))
		qdel(AO)
