/datum/computer_file/program/disk_binded/records/medical
	filename = "fullrecordsmedical"
	filedesc = "Medical Records Expanded"
	program_open_overlay = "medical"
	extended_desc = "This can be used to check medical records."
	tgui_id = "NtosRecordsMedical"
	program_icon = FA_ICON_FILE_MEDICAL
	download_access = list(ACCESS_MEDICAL, ACCESS_DETECTIVE, ACCESS_GENETICS)
	icon_keyboard = "med_key"

/datum/computer_file/program/disk_binded/records/medical/application_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/photo))
		return NONE
	insert_new_record(user, tool)
	return ITEM_INTERACT_SUCCESS

/datum/computer_file/program/disk_binded/records/medical/ui_data(mob/user)
	var/list/data = ..()

	var/list/records = list()
	for(var/datum/record/crew/target in GLOB.manifest.general)
		var/list/notes = list()
		for(var/datum/medical_note/note in target.medical_notes)
			notes += list(list(
				author = note.author,
				content = note.content,
				note_ref = REF(note),
				time = note.time,
			))

		records += list(list(
			age = target.age,
			chrono_age = target.chrono_age, // NOVA EDIT ADDITION - Chronological age
			blood_type = target.blood_type,
			crew_ref = REF(target),
			dna = target.dna_string,
			gender = target.gender,
			major_disabilities = target.major_disabilities_desc,
			minor_disabilities = target.minor_disabilities_desc,
			physical_status = target.physical_status,
			mental_status = target.mental_status,
			name = target.name,
			notes = notes,
			quirk_notes = target.quirk_notes,
			rank = target.rank,
			species = target.species,
			trim = target.trim,
			// NOVA EDIT ADDITION START - Expanded records!
			past_medical_records = target.past_medical_records,
			past_general_records = target.past_general_records,
			// NOVA EDIT END
		))

	data["records"] = records

	return data

/datum/computer_file/program/disk_binded/records/medical/ui_static_data(mob/user)
	var/list/data = list()
	data["min_age"] = AGE_MIN
	data["max_age"] = AGE_MAX
	data["max_chrono_age"] = AGE_CHRONO_MAX // NOVA EDIT ADDITION - Chronological age
	data["physical_statuses"] = PHYSICAL_STATUSES
	data["mental_statuses"] = MENTAL_STATUSES
	return data

/datum/computer_file/program/disk_binded/records/medical/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	var/datum/record/crew/target
	if(params["crew_ref"])
		target = locate(params["crew_ref"]) in GLOB.manifest.general
	if(!target)
		return FALSE

	switch(action)
		if("add_note")
			if(!params["content"])
				return FALSE
			var/content = trim(params["content"], MAX_MESSAGE_LEN)

			var/datum/medical_note/new_note = new(usr.name, content)
			while(length(target.medical_notes) > 2)
				target.medical_notes.Cut(1, 2)

			target.medical_notes += new_note

			return TRUE

		if("delete_note")
			var/datum/medical_note/old_note = locate(params["note_ref"]) in target.medical_notes
			if(!old_note)
				return FALSE

			target.medical_notes -= old_note
			qdel(old_note)

			return TRUE

		if("set_physical_status")
			var/physical_status = params["physical_status"]
			if(!physical_status || !(physical_status in PHYSICAL_STATUSES))
				return FALSE

			target.physical_status = physical_status

			return TRUE

		if("set_mental_status")
			var/mental_status = params["mental_status"]
			if(!mental_status || !(mental_status in MENTAL_STATUSES))
				return FALSE

			target.mental_status = mental_status

			return TRUE

	return FALSE

/// Deletes medical information from a record.
/datum/computer_file/program/disk_binded/records/medical/expunge_record_info(datum/record/crew/target)
	if(!target)
		return FALSE

	target.age = 18
	target.chrono_age = 18 // NOVA EDIT ADDITION - Chronological age
	target.blood_type = pick(list("A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"))
	target.dna_string = "Unknown"
	target.gender = "Unknown"
	target.major_disabilities = ""
	target.major_disabilities_desc = ""
	target.medical_notes.Cut()
	target.minor_disabilities = ""
	target.minor_disabilities_desc = ""
	target.physical_status = ""
	target.mental_status = ""
	target.name = "Unknown"
	target.quirk_notes = ""
	target.rank = "Unknown"
	target.species = "Unknown"
	target.trim = "Unknown"

	return TRUE

/obj/item/computer_console_disk/medical/records
	program = /datum/computer_file/program/disk_binded/records/medical
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/modular_computer/preset/battery_less/console/records_medical
	name = "medical records console"
	desc = "This can be used to check medical records."
	console_disk = /obj/item/computer_console_disk/medical/records

/datum/computer_file/program/disk_binded/records/medical/syndie
	icon_keyboard = "syndie_key"
	download_access = list(ACCESS_SYNDICATE)

/obj/machinery/modular_computer/preset/battery_less/console/records_medical/syndie
	starting_programs = list(/datum/computer_file/program/disk_binded/records/medical/syndie)
	console_disk = null

/*
TODO: Think about laptops
/obj/machinery/computer/records/medical/laptop
	name = "medical laptop"
	desc = "A cheap Nanotrasen medical laptop, it functions as a medical records computer. It's bolted to the table."
	icon_state = "laptop"
	icon_screen = "medlaptop"
	icon_keyboard = "laptop_key"
	pass_flags = PASSTABLE
*/
