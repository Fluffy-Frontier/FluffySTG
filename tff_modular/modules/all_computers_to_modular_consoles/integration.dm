GLOBAL_LIST_INIT(consoles_replacement_map, list(
	// Unique disk_binded consoles
	/obj/machinery/computer/rdservercontrol = /obj/machinery/modular_computer/preset/battery_less/console/rdservercontrol,
	/obj/machinery/computer/cargo = /obj/machinery/modular_computer/preset/battery_less/console/cargo,
	/obj/machinery/computer/cargo/request = /obj/machinery/modular_computer/preset/battery_less/console/cargo/request,

	// Disk_binded disks instead circuits in fabricators
	/obj/item/circuitboard/computer/rdservercontrol = /obj/item/computer_console_disk/command/rdservercontrol,
	/obj/item/circuitboard/computer/cargo = /obj/item/computer_console_disk/cargo/budgetorders/master,
	/obj/item/circuitboard/computer/cargo/request = /obj/item/computer_console_disk/cargo/budgetorders/master/slave,

	// Consoles with regular programs. We just boost behavior with our disks
	/obj/machinery/computer/aifixer = /obj/machinery/modular_computer/preset/battery_less/console/aifixer,
	/obj/machinery/computer/rdconsole = /obj/machinery/modular_computer/preset/battery_less/console/rdconsole,
	/obj/machinery/computer/station_alert = /obj/machinery/modular_computer/preset/battery_less/console/station_alert,
	/obj/machinery/computer/security = /obj/machinery/modular_computer/preset/battery_less/console/security,
	/obj/machinery/computer/security/mining = /obj/machinery/modular_computer/preset/battery_less/console/security/mining,
	/obj/machinery/computer/security/research = /obj/machinery/modular_computer/preset/battery_less/console/security/science,
	/obj/machinery/computer/security/hos = /obj/machinery/modular_computer/preset/battery_less/console/security/hos,
	/obj/machinery/computer/security/labor = /obj/machinery/modular_computer/preset/battery_less/console/security/labor,
	/obj/machinery/computer/security/qm = /obj/machinery/modular_computer/preset/battery_less/console/security/qm,
	/obj/machinery/computer/monitor = /obj/machinery/modular_computer/preset/battery_less/console/monitor,

	// Disk_binded disks instead circuits in fabricators for regular programs
	/obj/item/circuitboard/computer/aifixer = /obj/item/computer_console_disk/science/aifixer,
	/obj/item/circuitboard/computer/rdconsole = /obj/item/computer_console_disk/science/rdconsole,
	/obj/item/circuitboard/computer/stationalert = /obj/item/computer_console_disk/engineering/station_alert,
	/obj/item/circuitboard/computer/security = /obj/item/computer_console_disk/security/secureye,
	/obj/item/circuitboard/computer/mining = /obj/item/computer_console_disk/cargo/secureye,
	/obj/item/circuitboard/computer/research = /obj/item/computer_console_disk/science/secureye,
	/obj/item/circuitboard/computer/powermonitor = /obj/item/computer_console_disk/engineering/monitor,
))

/obj/machinery/computer/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	if (mapload && (src.type in GLOB.consoles_replacement_map))
		var/obj/machinery/modular_computer/preset/battery_less/console/console = GLOB.consoles_replacement_map[src.type]
		console = new console(src.loc)
		transfer_data_to_modular_console(console)
		console.update_appearance()
		return INITIALIZE_HINT_QDEL

/obj/machinery/computer/proc/transfer_data_to_modular_console(obj/machinery/modular_computer/preset/battery_less/console/console)
	SHOULD_CALL_PARENT(TRUE)

	console.setDir(dir)
	console.name = name

	if (console.cpu)
		console.cpu.desc = desc

/datum/design/board/New()
	. = ..()
	if (build_path in GLOB.consoles_replacement_map)
		build_path = GLOB.consoles_replacement_map[build_path]
