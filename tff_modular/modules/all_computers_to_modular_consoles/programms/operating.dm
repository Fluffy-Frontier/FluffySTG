#define MENU_OPERATION 1
#define MENU_SURGERIES 2

/datum/computer_file/program/disk_binded/operating
	filename = "operating"
	filedesc = "Surgeon Assistant"
	extended_desc = "Connect to the nearest operating table to help surgeons with their work."
	program_flags = NONE
	can_run_on_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP
	program_open_overlay = "crew"
	var/obj/structure/table/optable/table
	var/list/advanced_surgeries = list()
	var/datum/techweb/linked_techweb
	program_icon = FA_ICON_HEARTBEAT
	icon_keyboard = "med_key"
	tgui_id = "NtosOperating"
	var/datum/component/experiment_handler/experiment_handler

/datum/computer_file/program/disk_binded/operating/on_install(datum/computer_file/source, obj/item/modular_computer/computer_installing)
	. = ..()
	if(!CONFIG_GET(flag/no_default_techweb_link) && !linked_techweb)
		CONNECT_TO_RND_SERVER_ROUNDSTART(linked_techweb, src)

	experiment_handler = computer.physical.AddComponent(
		/datum/component/experiment_handler, \
		allowed_experiments = list(/datum/experiment/autopsy), \
		config_flags = EXPERIMENT_CONFIG_ALWAYS_ACTIVE, \
		config_mode = COMSIG_UI_ACT, \
		experiment_signals = list(), \
	)
	experiment_handler.RegisterSignal(src, COMSIG_OPERATING_COMPUTER_AUTOPSY_COMPLETE, TYPE_PROC_REF(/datum/component/experiment_handler, try_run_autopsy_experiment))
	RegisterSignal(computer.physical, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))

// Required for autopsy experiment
/datum/computer_file/program/disk_binded/operating/proc/say(
	message,
	bubble_type,
	list/spans = list(),
	sanitize = TRUE,
	datum/language/language,
	ignore_spam = FALSE,
	forced,
	filterproof = FALSE,
	message_range = 7,
	datum/saymode/saymode,
	list/message_mods = list(),
)
	return computer?.say(message, bubble_type, spans, sanitize, language, ignore_spam, forced, filterproof, message_range, saymode, message_mods)

/datum/computer_file/program/disk_binded/operating/on_start(mob/living/user)
	. = ..()
	table = null
	find_table()

/datum/computer_file/program/disk_binded/operating/proc/on_move()
	if(table && table.computer == src)
		table.computer = null
		table = null
	find_table()

/datum/computer_file/program/disk_binded/operating/Destroy()
	if(table && table.computer == src)
		table.computer = null
	if (computer)
		RemoveComponentSource(computer.physical, /datum/component/experiment_handler)
	QDEL_NULL(experiment_handler)
	return ..()

/datum/computer_file/program/disk_binded/operating/application_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/multitool))
		var/obj/item/multitool/attacking_tool = tool
		if(!QDELETED(attacking_tool.buffer) && istype(attacking_tool.buffer, /datum/techweb))
			linked_techweb = attacking_tool.buffer
			computer.say("[filedesc]: Established connection to [linked_techweb.organization] research network.")   //  Network id: [stored_research.id] not sure, id may be OOC info
			return ITEM_INTERACT_SUCCESS

	else if (istype(tool, /obj/item/disk/surgery))
		user.visible_message(span_notice("[user] begins to load \the [tool] in \the [filedesc]..."), \
			span_notice("You begin to load a surgery protocol from \the [tool]..."), \
			span_hear("You hear the chatter of a floppy drive."))
		var/obj/item/disk/surgery/D = tool
		if(do_after(user, 1 SECONDS, target = computer.physical))
			advanced_surgeries |= D.surgeries
			return ITEM_INTERACT_SUCCESS
		return ITEM_INTERACT_BLOCKING
	return NONE

/datum/computer_file/program/disk_binded/operating/proc/sync_surgeries()
	if(!linked_techweb)
		return
	for(var/i in linked_techweb.researched_designs)
		var/datum/design/surgery/D = SSresearch.techweb_design_by_id(i)
		if(!istype(D))
			continue
		advanced_surgeries |= D.surgery

/datum/computer_file/program/disk_binded/operating/proc/find_table()
	for(var/direction in GLOB.alldirs)
		table = locate(/obj/structure/table/optable) in get_step(computer.physical, direction)
		if(table)
			table.computer = src
			break

/datum/computer_file/program/disk_binded/operating/ui_state(mob/user)
	return GLOB.not_incapacitated_state

/datum/computer_file/program/disk_binded/operating/ui_data(mob/user)
	var/list/data = list()
	var/list/all_surgeries = list()
	for(var/datum/surgery/surgeries as anything in advanced_surgeries)
		var/list/surgery = list()
		surgery["name"] = initial(surgeries.name)
		surgery["desc"] = initial(surgeries.desc)
		all_surgeries += list(surgery)
	data["surgeries"] = all_surgeries

	//If there's no patient just hop to it yeah?
	if(!table)
		data["patient"] = null
		return data

	data["table"] = table
	data["patient"] = list()
	data["procedures"] = list()
	if(!table.patient)
		return data
	var/mob/living/carbon/patient = table.patient

	switch(patient.stat)
		if(CONSCIOUS)
			data["patient"]["stat"] = "Conscious"
			data["patient"]["statstate"] = "good"
		if(SOFT_CRIT)
			data["patient"]["stat"] = "Conscious"
			data["patient"]["statstate"] = "average"
		if(UNCONSCIOUS, HARD_CRIT)
			data["patient"]["stat"] = "Unconscious"
			data["patient"]["statstate"] = "average"
		if(DEAD)
			data["patient"]["stat"] = "Dead"
			data["patient"]["statstate"] = "bad"
	data["patient"]["health"] = patient.health

	// check here to see if the patient has standard blood reagent, or special blood (like how ethereals bleed liquid electricity) to show the proper name in the computer
	var/blood_id = patient.get_blood_id()
	if(blood_id == /datum/reagent/blood)
		data["patient"]["blood_type"] = patient.dna?.blood_type
	else
		var/datum/reagent/special_blood = GLOB.chemical_reagents_list[blood_id]
		data["patient"]["blood_type"] = special_blood ? special_blood.name : blood_id

	data["patient"]["maxHealth"] = patient.maxHealth
	data["patient"]["minHealth"] = HEALTH_THRESHOLD_DEAD
	data["patient"]["bruteLoss"] = patient.getBruteLoss()
	data["patient"]["fireLoss"] = patient.getFireLoss()
	data["patient"]["toxLoss"] = patient.getToxLoss()
	data["patient"]["oxyLoss"] = patient.getOxyLoss()
	if(patient.surgeries.len)
		for(var/datum/surgery/procedure in patient.surgeries)
			var/datum/surgery_step/surgery_step = procedure.get_surgery_step()
			var/chems_needed = surgery_step.get_chem_list()
			var/alternative_step
			var/alt_chems_needed = ""
			var/alt_chems_present = FALSE
			if(surgery_step.repeatable)
				var/datum/surgery_step/next_step = procedure.get_surgery_next_step()
				if(next_step)
					alternative_step = capitalize(next_step.name)
					alt_chems_needed = next_step.get_chem_list()
					alt_chems_present = next_step.chem_check(patient)
				else
					alternative_step = "Finish operation"
			data["procedures"] += list(list(
				"name" = capitalize("[patient.parse_zone_with_bodypart(procedure.location)] [procedure.name]"),
				"next_step" = capitalize(surgery_step.name),
				"chems_needed" = chems_needed,
				"alternative_step" = alternative_step,
				"alt_chems_needed" = alt_chems_needed,
				"chems_present" = surgery_step.chem_check(patient),
				"alt_chems_present" = alt_chems_present
			))
	return data

/datum/computer_file/program/disk_binded/operating/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("sync")
			sync_surgeries()
		if("open_experiments")
			experiment_handler.ui_interact(usr)
	return TRUE

#undef MENU_OPERATION
#undef MENU_SURGERIES

// Hack into /datum/surgery/proc/locate_operating_computer should check that its our programm and its working
/datum/surgery/proc/operating_program_instead_of_console_hack(datum/computer_file/program/disk_binded/operating/operating_computer)
	if (!istype(operating_computer))
		return null

	if (operating_computer.computer && operating_computer.computer.enabled && operating_computer.computer.active_program == operating_computer)
		return operating_computer
	return null

/obj/item/computer_console_disk/medical/operating
	program = /datum/computer_file/program/disk_binded/operating
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/modular_computer/preset/battery_less/console/operating
	name = "operating computer"
	desc = "Monitors patient vitals and displays surgery steps. Can be loaded with surgery disks to perform experimental procedures. Automatically syncs to operating tables within its line of sight for surgical tech advancement."
	console_disk = /obj/item/computer_console_disk/medical/operating
	circuit = /obj/item/circuitboard/computer/operating
