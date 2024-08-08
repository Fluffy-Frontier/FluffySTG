/datum/computer_file/program/disk_binded/crewmonitor
	filename = "crewmonitor"
	filedesc = "Employee Tracking Interface"
	program_open_overlay = "crew"
	extended_desc = "Connect to crewmembers undies to track their vitals."
	program_flags = PROGRAM_REQUIRES_NTNET
	tgui_id = "NtosCrewMonitor"
	program_icon = "heartbeat"
	icon_keyboard = "med_key"
	ui_header = "borg_mon.gif"
	circuit_comp_type = /obj/item/circuit_component/mod_program/crewmonitor

/obj/item/circuit_component/mod_program/crewmonitor
	display_name = "Crew Monitoring Data"
	desc = "Outputs the medical statuses of people on the crew monitoring computer, where it can then be filtered with a Select Query component."
	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL|CIRCUIT_FLAG_OUTPUT_SIGNAL
	associated_program = /datum/computer_file/program/disk_binded/crewmonitor

	/// The records retrieved
	var/datum/port/output/records

	var/obj/attached_console

/obj/item/circuit_component/mod_program/crewmonitor/populate_ports()
	. = ..()
	records = add_output_port("Crew Monitoring Data", PORT_TYPE_TABLE)

/obj/item/circuit_component/mod_program/crewmonitor/register_usb_parent(atom/movable/shell)
	. = ..()
	attached_console = associated_program.computer.physical

/obj/item/circuit_component/mod_program/crewmonitor/unregister_usb_parent(atom/movable/shell)
	attached_console = null
	return ..()

/obj/item/circuit_component/mod_program/crewmonitor/get_ui_notices()
	. = ..()
	. += create_table_notices(list(
		"name",
		"job",
		"is_robot", //NOVA EDIT ADDITION - Displaying robotic species Icon
		"life_status",
		"suffocation",
		"toxin",
		"burn",
		"brute",
		"location",
		"health",
	))

/obj/item/circuit_component/mod_program/crewmonitor/input_received(datum/port/input/port)
	if(!attached_console || !GLOB.crewmonitor)
		return

	var/list/new_table = list()
	for(var/list/player_record as anything in GLOB.crewmonitor.update_data(attached_console.z))
		var/list/entry = list()
		entry["name"] = player_record["name"]
		entry["job"] = player_record["assignment"]
		entry["is_robot"] = player_record["is_robot"] //NOVA EDIT ADDITION - Displaying robotic species Icon
		entry["life_status"] = player_record["life_status"]
		entry["suffocation"] = player_record["oxydam"]
		entry["toxin"] = player_record["toxdam"]
		entry["burn"] = player_record["burndam"]
		entry["brute"] = player_record["brutedam"]
		entry["location"] = player_record["area"]
		entry["health"] = player_record["health"]
		new_table += list(entry)

	records.set_output(new_table)

/datum/computer_file/program/disk_binded/crewmonitor/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	GLOB.crewmonitor.ui_sources[WEAKREF(user)] = WEAKREF(src)

/datum/computer_file/program/disk_binded/crewmonitor/ui_data(mob/user)
	. = ..()
	. += GLOB.crewmonitor.ui_data(user)

/datum/computer_file/program/disk_binded/crewmonitor/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if (.)
		return GLOB.crewmonitor.ui_act(action, params)

/obj/item/computer_console_disk/medical/crewmonitor
	program = /datum/computer_file/program/disk_binded/crewmonitor
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/modular_computer/preset/battery_less/console/crewmonitor
	name = "crew monitoring console"
	desc = "Used to monitor active health sensors built into most of the crew's uniforms."
	console_disk = /obj/item/computer_console_disk/medical/crewmonitor

/obj/machinery/modular_computer/preset/battery_less/console/crewmonitor/syndie
	icon_keyboard = "syndie_key"
