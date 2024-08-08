/datum/computer_file/program/disk_binded/atmos_alert
	filename = "atmosalert"
	filedesc = "Atmos Alert"
	program_open_overlay = "alert-green"
	extended_desc = "Connect to local atmospherics server for remotely oversee breathable atmosphere."
	program_flags = PROGRAM_REQUIRES_NTNET
	tgui_id = "NtosAtmosAlert"
	program_icon = "bell"
	icon_keyboard = "atmos_key"
	ui_header = "alarm_green.gif"

	var/list/priority_alarms = list()
	var/list/minor_alarms = list()

/datum/computer_file/program/disk_binded/atmos_alert/ui_data(mob/user)
	var/list/data = list()

	data["priority"] = list()
	for(var/zone in priority_alarms)
		data["priority"] += zone
	data["minor"] = list()
	for(var/zone in minor_alarms)
		data["minor"] += zone

	return data

/datum/computer_file/program/disk_binded/atmos_alert/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("clear")
			var/zone = params["zone"]
			if(zone in priority_alarms)
				to_chat(usr, span_notice("Priority alarm for [zone] cleared."))
				priority_alarms -= zone
				. = TRUE
			if(zone in minor_alarms)
				to_chat(usr, span_notice("Minor alarm for [zone] cleared."))
				minor_alarms -= zone
				. = TRUE
	update_alarm_display()


/datum/computer_file/program/disk_binded/atmos_alert/process_tick(seconds_per_tick)
	. = ..()
	if (!.)
		return FALSE

	var/alarm_count = priority_alarms.len + minor_alarms.len

	priority_alarms.Cut()
	minor_alarms.Cut()

	for (var/obj/machinery/airalarm/air_alarm as anything in GLOB.air_alarms)
		var/turf/T = get_turf(computer.physical)
		if (air_alarm.z != T.z)
			continue

		switch (air_alarm.danger_level)
			if (AIR_ALARM_ALERT_NONE)
				continue
			if (AIR_ALARM_ALERT_WARNING)
				minor_alarms += get_area_name(air_alarm, format_text = TRUE)
			if (AIR_ALARM_ALERT_HAZARD)
				priority_alarms += get_area_name(air_alarm, format_text = TRUE)

	// Either we got new alarms, or we have no alarms anymore
	if ((alarm_count == 0) != (minor_alarms.len + priority_alarms.len == 0))
		update_alarm_display()

	return TRUE

/datum/computer_file/program/disk_binded/atmos_alert/proc/update_alarm_display()
	if(priority_alarms.len || minor_alarms.len)
		program_open_overlay = "alert-red"
		ui_header = "alarm_red.gif"
	else
		program_open_overlay = "alert-green"
		ui_header = "alarm_green.gif"
	update_computer_icon() // Always update the icon after we check our conditional because we might've changed it

/obj/item/computer_console_disk/engineering/station_alert
	light_color = LIGHT_COLOR_CYAN
	program = /datum/computer_file/program/disk_binded/atmos_alert

/obj/machinery/modular_computer/preset/battery_less/console/atmos_alert
	name = "atmospheric alert console"
	desc = "Used to monitor the station's air alarms."
	console_disk = /obj/item/computer_console_disk/engineering/station_alert
