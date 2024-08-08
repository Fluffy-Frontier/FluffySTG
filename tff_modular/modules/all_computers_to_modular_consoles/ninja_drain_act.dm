/obj/machinery/modular_computer/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module || !cpu)
		return NONE

	var/datum/computer_file/program/filemanager/fm = cpu.find_file_by_name("filemanager")
	if (fm && fm.console_disk)
		var/datum/computer_file/program/prg = fm.console_disk.installed_clone

		switch(prg.type)
			if(/datum/computer_file/program/disk_binded/records/security)
				try_hack_console(ninja, 20 SECONDS, prg)


			else
				return NONE

	return COMPONENT_CANCEL_ATTACK_CHAIN

/// Checks if this console is hackable. Used as a callback during try_hack_console's doafter as well.
/obj/machinery/modular_computer/proc/can_hack(mob/living/hacker, feedback = FALSE, datum/computer_file/program/disk_binded/prg)
	if(machine_stat & (NOPOWER|BROKEN))
		if(feedback && hacker)
			balloon_alert(hacker, "can't hack!")
		return FALSE

	if (obj_flags & EMAGGED)
		if(feedback && hacker)
			balloon_alert(hacker, "already hacked!")
		return FALSE

	var/area/console_area = get_area(src)
	if(!console_area || !(console_area.area_flags & VALID_TERRITORY))
		if(feedback && hacker)
			balloon_alert(hacker, "signal too weak!")
		return FALSE

	if (!QDELETED(prg) && prg.computer && prg.computer.enabled && prg.computer.active_program == prg)
		if (prg.type in list(
			/datum/computer_file/program/disk_binded/records/security,
			))
			return TRUE
		if(feedback && hacker)
			balloon_alert(hacker, "unhackable program!")
		return FALSE
	if(feedback && hacker)
		balloon_alert(hacker, "no active programs!")
	return FALSE

/// Begin the process of hacking into the comms console to call in a threat.
/obj/machinery/modular_computer/proc/try_hack_console(mob/living/hacker, duration = 30 SECONDS, datum/computer_file/program/disk_binded/prg)
	if(!can_hack(hacker, TRUE, prg))
		return FALSE

	AI_notify_hack()
	if(!do_after(hacker, duration, src, extra_checks = CALLBACK(src, PROC_REF(can_hack), hacker, FALSE, prg)))
		return FALSE

	prg.hack_console(hacker)
	return TRUE

