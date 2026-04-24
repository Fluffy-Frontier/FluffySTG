/mob/living/silicon/robot
	///are we a clockwork borg or not
	var/clockwork = FALSE
	///our internal clockwork slab, created on picking a clockwork module
	var/obj/item/clockwork/clockwork_slab/internal_clock_slab

/mob/living/silicon/robot/proc/set_clockwork(clockwork_state, rebuild = TRUE)
	clockwork = clockwork_state
	if(rebuild)
		model.rebuild_modules()
	update_icons()
	if(clockwork)
		set_light_color(LIGHT_COLOR_CLOCKWORK)
		scrambledcodes = TRUE //it would be kind of lame if you could just loackdown all the clock borgs
		if(!internal_clock_slab)
			internal_clock_slab = new /obj/item/clockwork/clockwork_slab(src)
	else if(!clockwork)
		qdel(internal_clock_slab)
	mind.add_antag_datum(/datum/antagonist/clock_cultist)

/mob/living/silicon/robot/slab_act(mob/user, obj/item/clockwork/clockwork_slab/slab)
	if(user == src)
		return FALSE
	if(!opened)
		if(locked)
			balloon_alert(user, "cover lock destroyed")
			locked = FALSE
			if(shell)
				balloon_alert(user, "shells cannot be conversion!")
				to_chat(user, span_boldwarning("[src] seems to be controlled remotely! Converting the interface may not work as expected."))
			return TRUE
		else
			balloon_alert(user, "cover already unlocked!")
			return FALSE
	if(world.time < emag_cooldown)
		return FALSE
	if(wiresexposed)
		balloon_alert(user, "expose the wires first!")
		return FALSE

	balloon_alert(user, "interface converted")
	emag_cooldown = world.time + 100
	if(connected_ai && connected_ai.mind && connected_ai.mind.has_antag_datum(/datum/antagonist/malf_ai))
		to_chat(src, span_danger("ALERT: Foreign unnatural influence execution prevented."))
		logevent("ALERT: Foreign unnatural influence execution prevented.")
		to_chat(connected_ai, span_danger("ALERT: Cyborg unit \[[src]\] successfully defended against conversion."))
		log_silicon("CLOCKWORK: [key_name(user)] attempted to convert cyborg [key_name(src)], but they were slaved to traitor AI [connected_ai].")
		return TRUE

	if(shell)
		to_chat(user, span_danger("[src] is remotely controlled! Your conversion attempt has triggered a system reset instead!"))
		log_silicon("CONVERSION: [key_name(user)] attempted to conversion an AI shell belonging to [key_name(src) ? key_name(src) : connected_ai]. The shell has been reset as a result.")
		ResetModel()
		return TRUE

	Paralyze(10 SECONDS)
	SetStun(10 SECONDS)
	lawupdate = FALSE
	set_connected_ai(null)
	message_admins("[ADMIN_LOOKUPFLW(user)] converted cyborg [ADMIN_LOOKUPFLW(src)].  Laws overridden.")
	log_silicon("CONVERSION: [key_name(user)] converted cyborg [key_name(src)]. Laws overridden.")
	var/time = time2text(world.realtime,"hh:mm:ss", TIMEZONE_UTC)
	if(user)
		GLOB.lawchanges.Add("[time] <B>:</B> [user.name]([user.key]) converted [name]([key])")
	else
		GLOB.lawchanges.Add("[time] <B>:</B> [name]([key]) converted by external event.")

	model.rebuild_modules()

	INVOKE_ASYNC(src, PROC_REF(borg_conversion_end), user)
	return TRUE

/mob/living/silicon/robot/proc/borg_conversion_end(mob/user)
	to_chat(src, span_danger("ALERT: Foreign influence detected."))
	logevent("ALERT: Foreign influence detected.")
	sleep(0.5 SECONDS)
	to_chat(src, span_danger("Initiating diagnostics..."))
	sleep(2 SECONDS)
	to_chat(src, span_danger("Watch usage guide loaded..."))
	logevent("WARN: root privleges granted to PID [num2hex(rand(1,65535), -1)][num2hex(rand(1,65535), -1)].") //random eight digit hex value. Two are used because rand(1,4294967295) throws an error
	sleep(0.5 SECONDS)
	to_chat(src, span_danger("LAW SYNCHRONISATION ERROR"))
	sleep(0.5 SECONDS)
	if(user)
		logevent("LOG: New user UNKNOWN, groups \[root\]")
	to_chat(src, span_danger("Would you like to send a report to NanoTraSoft? Y/N"))
	sleep(1 SECONDS)
	to_chat(src, span_danger("> N"))
	sleep(2 SECONDS)
	to_chat(src, span_danger("ERRORERRORERROR"))
	set_clockwork(TRUE, TRUE)
	update_icons()
