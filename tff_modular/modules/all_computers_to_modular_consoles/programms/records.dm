/**
 * Records subtype for the shared functionality between medical/security/warrant consoles.
 */

/datum/computer_file/program/disk_binded/records
	/// The character preview view for the UI.
	var/atom/movable/screen/map_view/char_preview/character_preview_view
	var/authenticated = FALSE
	///List of weakrefs of all users watching the program.
	var/list/concurrent_users = list()

/datum/computer_file/program/disk_binded/records/kill_program(mob/user)
	. = ..()
	authenticated = FALSE

/datum/computer_file/program/disk_binded/records/on_install(datum/computer_file/source, obj/item/modular_computer/computer_installing)
	character_preview_view = new()
	character_preview_view.generate_view("records_prewiew[REF(src)]_map")
	. = ..()

/datum/computer_file/program/disk_binded/records/ui_interact(mob/user, datum/tgui/ui)
	var/user_ref = REF(user)
	var/is_living = isliving(user)
	// Ghosts shouldn't count towards concurrent users, which produces
	// an audible terminal_on click.
	if(is_living)
		concurrent_users += user_ref
	// Register map objects
	character_preview_view.display_to(user)

/datum/computer_file/program/disk_binded/records/ui_close(mob/user)
	. = ..()
	var/user_ref = REF(user)
	// Living creature or not, we remove you anyway.
	concurrent_users -= user_ref
	// Unregister map objects
	character_preview_view.hide_from(user)

/datum/computer_file/program/disk_binded/records/ui_data(mob/user)
	var/list/data = ..()

	var/has_access = (authenticated && isliving(user)) || isAdminGhostAI(user)
	data["authenticated"] = has_access
	if(!has_access)
		return data

	data["assigned_view"] = "records_prewiew[REF(src)]_map"
	data["station_z"] = !!(computer.physical.z && is_station_level(computer.physical.z))

	return data

/datum/computer_file/program/disk_binded/records/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return
	var/mob/user = ui.user

	var/datum/record/crew/target
	if(params["crew_ref"])
		target = locate(params["crew_ref"]) in GLOB.manifest.general

	switch(action)
		if("edit_field")
			target = locate(params["ref"]) in GLOB.manifest.general
			var/field = params["field"]
			if(!field || !(field in target?.vars))
				return FALSE

			var/value = trim(params["value"], MAX_BROADCAST_LEN)
			owner_object.investigate_log("[key_name(user)] changed the field: \"[field]\" with value: \"[target.vars[field]]\" to new value: \"[value || "Unknown"]\"", INVESTIGATE_RECORDS)
			target.vars[field] = value || "Unknown"

			return TRUE

		if("expunge_record")
			if(!target)
				return FALSE
			// Don't let people off station futz with the station network.
			if(!is_station_level(computer.physical.z))
				computer.physical.balloon_alert(user, "out of range!")
				return TRUE

			expunge_record_info(target)
			computer.physical.balloon_alert(user, "record expunged")
			playsound(computer.physical, 'sound/machines/terminal_eject.ogg', 70, TRUE)
			owner_object.investigate_log("[key_name(user)] expunged the record of [target.name].", INVESTIGATE_RECORDS)

			return TRUE

		if("login")
			authenticated = secure_login(user)
			owner_object.investigate_log("[key_name(user)] [authenticated ? "successfully logged" : "failed to log"] into the [src].", INVESTIGATE_RECORDS)
			return TRUE

		if("logout")
			computer.physical.balloon_alert(user, "logged out")
			playsound(computer.physical, 'sound/machines/terminal_off.ogg', 70, TRUE)
			authenticated = FALSE

			return TRUE

		if("purge_records")
			// Don't let people off station futz with the station network.
			//NOVA EDIT BEGIN: disable record purging/expunging to stop people messing around with the AI effortlessly
			computer.physical.balloon_alert(usr, "access denied!")
			return TRUE
			/*
			if(!is_station_level(z))
				balloon_alert(user, "out of range!")
				return TRUE

			ui.close()
			balloon_alert(user, "purging records...")
			playsound(src, 'sound/machines/terminal_alert.ogg', 70, TRUE)

			if(do_after(user, 5 SECONDS))
				for(var/datum/record/crew/entry in GLOB.manifest.general)
					expunge_record_info(entry)

				balloon_alert(user, "records purged")
				playsound(src, 'sound/machines/terminal_off.ogg', 70, TRUE)
				investigate_log("[key_name(user)] purged all records.", INVESTIGATE_RECORDS)
			else
				balloon_alert(user, "interrupted!")

			return TRUE
			*/
			//NOVA EDIT END

		if("view_record")
			if(!target)
				return FALSE

			playsound(computer.physical, SFX_TERMINAL_TYPE, 50, TRUE)
			update_preview(user, params["assigned_view"], target)
			return TRUE

	return FALSE

/// Creates a character preview view for the UI.
/datum/computer_file/program/disk_binded/records/proc/create_character_preview_view(mob/user)
	var/assigned_view = USER_PREVIEW_ASSIGNED_VIEW(user.ckey)
	if(user.client?.screen_maps[assigned_view])
		return

	var/atom/movable/screen/map_view/char_preview/new_view = new(null, src)
	new_view.generate_view(assigned_view)
	new_view.display_to(user)
	return new_view

/// Takes a record and updates the character preview view to match it.
/datum/computer_file/program/disk_binded/records/proc/update_preview(mob/user, assigned_view, datum/record/crew/target)
	var/mutable_appearance/preview = new(target.character_appearance)
	preview.underlays += mutable_appearance('icons/effects/effects.dmi', "static_base", alpha = 20)
	preview.add_overlay(mutable_appearance(generate_icon_alpha_mask('icons/effects/effects.dmi', "scanline"), alpha = 20))

	var/atom/movable/screen/map_view/char_preview/old_view = user.client?.screen_maps[assigned_view]?[1]
	if(!old_view)
		return

	old_view.appearance = preview.appearance

/// Expunges info from a record.
/datum/computer_file/program/disk_binded/records/proc/expunge_record_info(datum/record/crew/target)
	return

/// Inserts a new record into GLOB.manifest.general. Requires a photo to be taken.
/datum/computer_file/program/disk_binded/records/proc/insert_new_record(mob/user, obj/item/photo/mugshot)
	if(!mugshot || !computer.enabled || computer.active_program != src || !user.can_perform_action(computer.physical, ALLOW_SILICON_REACH))
		return FALSE

	if(!authenticated && !can_run_Adjacent(user))
		computer.physical.balloon_alert(user, "access denied")
		playsound(computer.physical, 'sound/machines/terminal_error.ogg', 70, TRUE)
		return FALSE

	if(mugshot.picture.psize_x > world.icon_size || mugshot.picture.psize_y > world.icon_size)
		computer.physical.balloon_alert(user, "photo too large!")
		playsound(computer.physical, 'sound/machines/terminal_error.ogg', 70, TRUE)
		return FALSE

	var/trimmed = copytext(mugshot.name, 9, MAX_NAME_LEN) // Remove "photo - "
	var/name = tgui_input_text(user, "Enter the name of the new record.", "New Record", trimmed, MAX_NAME_LEN)
	if(!name || !computer.enabled || computer.active_program != src || !user.can_perform_action(computer.physical, ALLOW_SILICON_REACH) || !mugshot || QDELETED(mugshot) || QDELETED(src))
		return FALSE

	new /datum/record/crew(name = name, character_appearance = mugshot.picture.picture_image)

	computer.physical.balloon_alert(user, "record created")
	playsound(computer.physical, 'sound/machines/terminal_insert_disc.ogg', 70, TRUE)

	qdel(mugshot)

	return TRUE

/// Secure login
/datum/computer_file/program/disk_binded/records/proc/secure_login(mob/user)
	if(!user.can_perform_action(computer.physical, ALLOW_SILICON_REACH))
		return FALSE

	if(!can_run_Adjacent(user))
		computer.physical.balloon_alert(user, "access denied")
		playsound(computer.physical, 'sound/machines/terminal_error.ogg', 70, TRUE)
		return FALSE

	computer.physical.balloon_alert(user, "logged in")
	playsound(computer.physical, 'sound/machines/terminal_on.ogg', 70, TRUE)

	return TRUE
