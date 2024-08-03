// Actual presets of non disk_binded programms
/obj/item/computer_console_disk/science/rdconsole
	icon_keyboard = "rd_key"
	program = /datum/computer_file/program/science

/obj/machinery/modular_computer/preset/battery_less/console/rdconsole
	name = "R&D Console"
	desc = "A console used to interface with R&D tools."
	console_disk = /obj/item/computer_console_disk/science/rdconsole

// By default TG's app is... tweaked... So it shouldn't be used
/obj/item/computer_console_disk/cargo/budgetorders
	program = /datum/computer_file/program/budgetorders

// For request - remove dep account reading from card. Only cargo-private. Remove requests approval-denial. (WORKS IF NO ACCESS FOR ALL)
// For supply - remove dep account reading from card. Only cargo-private. Add shuttle controls.
/obj/machinery/modular_computer/preset/battery_less/console/cargo_unQoL
	name = "NT IRN console"
	desc = "Nanotrasen Internal Requisition Network interface for supply purchasing using a department budget account."
	console_disk = /obj/item/computer_console_disk/cargo/budgetorders

/obj/item/computer_console_disk/science/aifixer
	icon_keyboard = "tech_key"
	program = /datum/computer_file/program/ai_restorer

/obj/machinery/modular_computer/preset/battery_less/console/aifixer
	name = "\improper AI system integrity restorer"
	desc = "Used with intelliCards containing nonfunctional AIs to restore them to working order."
	console_disk = /obj/item/computer_console_disk/science/aifixer

/obj/item/computer_console_disk/engineering/station_alert
	icon_keyboard = "atmos_key"
	program = /datum/computer_file/program/alarm_monitor

/obj/machinery/modular_computer/preset/battery_less/console/station_alert
	name = "station alert console"
	desc = "Used to access the station's automated alert system."
	console_disk = /obj/item/computer_console_disk/engineering/station_alert

// CAMERAS START
/datum/computer_file/program/secureye/disked
	filename = "secureye"
	filedesc = "SecurEye"
	extended_desc = "This program allows access to standard security camera networks."
	program_open_overlay = "cameras"
	program_flags = PROGRAM_REQUIRES_NTNET
	download_access = list()
	can_run_on_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP

/obj/item/computer_console_disk/security/secureye
	icon_keyboard = "security_key"
	program = /datum/computer_file/program/secureye/disked

/obj/machinery/modular_computer/preset/battery_less/console/security
	name = "security camera console"
	desc = "Used to access the various cameras on the station."
	icon_keyboard = "security_key"
	console_disk = /obj/item/computer_console_disk/security/secureye

/obj/machinery/modular_computer/preset/battery_less/console/security/post_machine_initialize()
	. = ..()
	if (cpu && starting_programs && starting_programs.len == 1)
		cpu.active_program = cpu.find_file_by_name(starting_programs[1].filename)

/datum/computer_file/program/secureye/disked/mining
	filename = "outposteye"
	filedesc = "OutpostEye"
	extended_desc = "This program allows access to outpost camera network."
	// No "mining" overlay?
	program_open_overlay = "forensic"
	network = list(CAMERANET_NETWORK_MINE, CAMERANET_NETWORK_AUXBASE)

/obj/item/computer_console_disk/cargo/secureye
	icon_keyboard = "mining_key"
	program = /datum/computer_file/program/secureye/disked/mining

/obj/machinery/modular_computer/preset/battery_less/console/security/mining
	name = "outpost camera console"
	desc = "Used to access the various cameras on the outpost."
	console_disk = /obj/item/computer_console_disk/cargo/secureye

/datum/computer_file/program/secureye/disked/science
	filename = "scieye"
	filedesc = "SciencEye"
	extended_desc = "This program allows access to research camera network."
	network = list(CAMERANET_NETWORK_RD)

/obj/item/computer_console_disk/science/secureye
	icon_keyboard = "security_key"
	program = /datum/computer_file/program/secureye/disked/science

/obj/machinery/modular_computer/preset/battery_less/console/security/science
	name = "research camera console"
	desc = "Used to access the various cameras in science."
	console_disk = /obj/item/computer_console_disk/science/secureye

/datum/computer_file/program/secureye/disked/hos
	filename = "hoseye"
	filedesc = "HoSEye"
	extended_desc = "This program allows access to security and labor camera networks."
	network = list(CAMERANET_NETWORK_SS13, CAMERANET_NETWORK_LABOR)
	undeletable = TRUE

// Because circuit nulled... If you loose it - its gone
/obj/machinery/modular_computer/preset/battery_less/console/security/hos
	name = "\improper Head of Security's camera console"
	desc = "A custom security console with added access to the labor camp network."
	starting_programs = list(/datum/computer_file/program/secureye/disked/hos)
	console_disk = null

/datum/computer_file/program/secureye/disked/labor
	filename = "laboreye"
	filedesc = "LaborEye"
	extended_desc = "This program allows access to labor camera network."
	network = list(CAMERANET_NETWORK_LABOR)
	undeletable = TRUE

// Because circuit nulled... If you loose it - its gone
/obj/machinery/modular_computer/preset/battery_less/console/security/labor
	name = "labor camp monitoring"
	desc = "Used to access the various cameras on the labor camp."
	starting_programs = list(/datum/computer_file/program/secureye/disked/labor)
	console_disk = null

/datum/computer_file/program/secureye/disked/qm
	filename = "qmeye"
	filedesc = "QMsEye"
	extended_desc = "This program allows access to the mining, auxiliary base and vault camera networks."
	network = list(CAMERANET_NETWORK_MINE, CAMERANET_NETWORK_AUXBASE, CAMERANET_NETWORK_VAULT)
	undeletable = TRUE

// Because circuit nulled... If you loose it - its gone
/obj/machinery/modular_computer/preset/battery_less/console/security/qm
	name = "\improper Quartermaster's camera console"
	desc = "A console with access to the mining, auxiliary base and vault camera networks."
	starting_programs = list(/datum/computer_file/program/secureye/disked/qm)
	console_disk = null

// CAMERAS END

/obj/item/computer_console_disk/engineering/monitor
	icon_keyboard = "power_key"
	program = /datum/computer_file/program/power_monitor
	light_color = COLOR_BRIGHT_ORANGE

/obj/machinery/modular_computer/preset/battery_less/console/monitor
	name = "power monitoring console"
	desc = "It monitors power levels across the station."
	console_disk = /obj/item/computer_console_disk/engineering/monitor
