/client/proc/mass_horror()
	set category = "Events.Horror"
	set name = "Make horror"

	if(!check_rights(R_FUN))
		return

	var/check = tgui_alert(usr, "Are you sure want do it?", "Horror crew", list("Yes", "No"))
	if(check == "No" || !check)
		return
	var/horror_radius = tgui_input_list(usr, "Chose a raius:", "Horror crew", list("Everyone", "In Z level", "In view", "In range"))
	var/new_value = tgui_input_number(usr, "Input value:", "Horror value", 0, 5, 0)
	var/time = tgui_input_number(usr, "Input time in secons:", "Horror time", 1, 240, 0)
	time *= 10
	switch(horror_radius)
		if("Everyone")
			for(var/mob/living/carbon/human/H in GLOB.human_list)
				if(isdead(H))
					continue
				H.set_horror_state(new_value, time)
		if("In Z level")
			for(var/mob/living/carbon/human/H in usr.z)
				if(isdead(H))
					continue
				H.set_horror_state(new_value, time)
		if("In view")
			for(var/mob/living/carbon/human/H in view(usr))
				if(isdead(H))
					continue
				H.set_horror_state(new_value, time)
		if("In range")
			var/r = tgui_input_number(usr, "Input value:", "Horror range", 0, 60, 0)
			for(var/mob/living/carbon/human/H in range(r, usr))
				if(isdead(H))
					continue
				H.set_horror_state(new_value, time)
	message_admins("[key_name(usr)] mass horrored crew!")

/client/proc/enable_horror_mode()
	set category = "Events.Horror"
	set name = "Enable horror mode"

	if(!check_rights(R_FUN))
		return

	GLOB.world_horror_mode = TRUE
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		SEND_SIGNAL(H, COMSIG_WORLD_HORROR_MODE_ENABLED)
	message_admins("[key_name(usr)] enabled horror mode!")

/client/proc/disable_horror_mode()
	set category = "Events.Horror"
	set name = "Disable horror mode"

	if(!check_rights(R_FUN))
		return

	GLOB.world_horror_mode = FALSE
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		SEND_SIGNAL(H, COMSIG_WORLD_HORROR_MODE_DISABLED)
	message_admins("[key_name(usr)] disabled horror mode!")

/client/proc/summon_void_creature()
	set category = "Events.Void"
	set name = "Summon void creature"

	if(!check_rights(R_FUN))
		return
	if(GLOB.void_creature)
		to_chat(usr, span_warning("There a one void creature already exist. Can not be twice."))
		return
	var/check = tgui_alert(usr, "Are you sure want do it?", "Summon void creature", list("Yes", "No"))
	if(check == "No" || !check)
		return
	message_admins("[key_name(usr)] spanws void creaute at[ADMIN_JMP(usr.loc)]!")
	var/mob/living/basic/void_creture/v = new(usr.loc, TRUE)
	GLOB.void_creature = v

/client/proc/jump_to_void()
	set category = "Events.Void"
	set name = "Jump to void creature"

	if(!check_rights(R_FUN))
		return
	if(!GLOB.void_creature)
		to_chat(usr, span_warning("There a not active void creatures. Create one."))
		return

	do_teleport(usr, GLOB.void_creature, no_effects=TRUE, channel= TELEPORT_CHANNEL_FREE)

/client/proc/get_void()
	set category = "Events.Void"
	set name = "Get void creature"

	if(!check_rights(R_FUN))
		return
	if(!GLOB.void_creature)
		to_chat(usr, span_warning("There a not active void creatures. Create one."))
		return
	var/check = tgui_alert(usr, "Are you sure want do it?", "Get void creature", list("Yes", "No"))
	if(check == "No" || !check)
		return

	do_teleport(GLOB.void_creature, usr, no_effects=TRUE, channel= TELEPORT_CHANNEL_FREE)

/client/proc/make_void_infection()
	set category = "Events.Void"
	set name = "Make void infection"

	if(!check_rights(R_FUN))
		return

	var/check = tgui_alert(usr, "Are you sure want do it?", "Spread void infection", list("Yes", "No"))
	if(check == "No" || !check)
		return

	var/ask_light = tgui_alert(usr, "Break the light in close area?", "Break light", list("Yes", "No"))
	var/r = tgui_input_number(usr, "Void infection spread redius", "Void spread", 1, 15, 1)
	for(var/turf/old_turf in RANGE_TURFS(r, usr))
		old_turf.TerraformTurf(/turf/open/void_turf, /turf/open/void_turf, flags = CHANGETURF_INHERIT_AIR)

	if(ask_light == "Yes")
		for(var/obj/machinery/light/L in RANGE_TURFS(r*2, usr))
			if(L.status == LIGHT_BROKEN)
				continue
			L.break_light_tube()
