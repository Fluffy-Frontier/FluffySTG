/datum/computer_file/program/disk_binded/rdservercontrol
	filename = "sci_net_admin"
	filedesc = "Researh Network Admin Panel"
	program_open_overlay = "research"
	extended_desc = "Connect to the internal science server in order to control their behavior."
	program_flags = PROGRAM_REQUIRES_NTNET
	tgui_id = "NtosServerControl"
	program_icon = FA_ICON_SERVER
	download_access = list(ACCESS_RD)
	icon_keyboard = "rd_key"
	// Reference to global science techweb
	var/datum/techweb/stored_research

/datum/computer_file/program/disk_binded/rdservercontrol/on_install(datum/computer_file/source, obj/item/modular_computer/computer_installing)
	. = ..()
	if(!CONFIG_GET(flag/no_default_techweb_link) && !stored_research)
		CONNECT_TO_RND_SERVER_ROUNDSTART(stored_research, computer)

/datum/computer_file/program/disk_binded/rdservercontrol/application_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/multitool))
		return NONE
	var/obj/item/multitool/attacking_tool = tool
	if(!QDELETED(attacking_tool.buffer) && istype(attacking_tool.buffer, /datum/techweb))
		stored_research = attacking_tool.buffer
		computer.say("[filedesc]: Established connection to [stored_research.organization] research network.")   //  Network id: [stored_research.id] not sure, id may be OOC info
		return ITEM_INTERACT_SUCCESS
	return NONE

/datum/computer_file/program/disk_binded/rdservercontrol/ui_data(mob/user)
	var/list/data = list()

	data["server_connected"] = !!stored_research

	if(stored_research)
		data["logs"] += stored_research.research_logs

		for(var/obj/machinery/rnd/server/server as anything in stored_research.techweb_servers)
			data["servers"] += list(list(
				"server_name" = server,
				"server_details" = server.get_status_text(),
				"server_disabled" = server.research_disabled,
				"server_ref" = REF(server),
			))

		for(var/obj/machinery/computer/rdconsole/console as anything in stored_research.consoles_accessing)
			data["consoles"] += list(list(
				"console_name" = console,
				"console_location" = console.loc == null ? "UNKNOWN" : get_area(console),
				"console_locked" = console.locked,
				"console_ref" = REF(console),
			))
		for (var/datum/computer_file/program/science/app in stored_research.apps_accessing)
			data["consoles"] += list(list(
				"console_name" = app.computer,
				"console_location" = app.computer.loc == null ? "UNKNOWN" : get_area(app.computer),
				"console_locked" = app.locked,
				"console_ref" = REF(app),
			))

	return data

/datum/computer_file/program/disk_binded/rdservercontrol/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return TRUE
	if(!can_run_Adjacent(usr) && !(computer.obj_flags & EMAGGED))
		computer.say("Access denied!")
		playsound(computer, 'sound/machines/terminal_error.ogg', 20, TRUE)
		return TRUE

	switch(action)
		if("lockdown_server")
			var/obj/machinery/rnd/server/server_selected = locate(params["selected_server"]) in stored_research.techweb_servers
			if(!server_selected)
				return FALSE
			server_selected.toggle_disable(usr)
			return TRUE
		if("lock_console")
			var/obj/machinery/computer/rdconsole/console_selected = locate(params["selected_console"]) in stored_research.consoles_accessing
			if(!console_selected)
				var/datum/computer_file/program/science/app = locate(params["selected_console"]) in stored_research.apps_accessing
				if (!app)
					return FALSE
				app.locked = !app.locked
				return TRUE
			console_selected.locked = !console_selected.locked
			return TRUE

// Legacy computer code
// Inject into console code to add science app tracking
/*
/obj/machinery/computer/rdservercontrol/proc/handle_ui_data_apps_insertion()
	var/list/data = list()

	for (var/datum/computer_file/program/science/app in stored_research.apps_accessing)
		data += list(list(
			"console_name" = app.computer,
			"console_location" = app.computer.loc == null ? "UNKNOWN" : get_area(app.computer),
			"console_locked" = app.locked,
			"console_ref" = REF(app),
		))
	return data

/obj/machinery/computer/rdservercontrol/proc/handle_ui_act_apps_lock(choosen_app)
	var/datum/computer_file/program/science/app = locate(choosen_app) in stored_research.apps_accessing
	if (!app)
		return FALSE
	app.locked = !app.locked
	return TRUE
*/
/obj/item/computer_console_disk/command/rdservercontrol
	program = /datum/computer_file/program/disk_binded/rdservercontrol
	light_color = LIGHT_COLOR_PINK

/obj/machinery/modular_computer/preset/battery_less/console/rdservercontrol
	name = "R&D Server Controller"
	desc = "Manages access to research databases and consoles."
	console_disk = /obj/item/computer_console_disk/command/rdservercontrol
