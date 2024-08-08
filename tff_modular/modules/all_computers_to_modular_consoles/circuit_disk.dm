/obj/item/computer_console_disk
	name = "Encrypted NTnet Modem"
	desc = "Contains software which allows computer to establish secure connection to NTNet for certain function"
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "datadisk6"
	w_class = WEIGHT_CLASS_TINY
	// Actual program for instalation
	var/datum/computer_file/program/program
	// Pointer to program, cloned into PC, to remove when disk ejecting
	var/datum/computer_file/program/installed_clone

	// Only for consoles
	// If any. To handle power shortages
	var/obj/machinery/modular_computer/physical_console
	var/start_on_power_restore = TRUE
	// Icon_state of the keyboard overlay for PC. If any... (overriden by diskbinded prog)
	var/icon_keyboard

/obj/item/computer_console_disk/Initialize(mapload)
	. = ..()
	if (program)
		if (ispath(program))
			program = new program()

		if (istype(program, /datum/computer_file/program/disk_binded))
			var/datum/computer_file/program/disk_binded/db = program
			icon_keyboard = db.icon_keyboard

		// For regular programs like SciHub or Secureye. Not disk_binded
		program.size = 0
		program.undeletable = TRUE

		name = "encrypted connection driver ([program.filename])"
		desc = "Contains software which allows computer to establish secure connection to NTNet for certain function.\n\n[program.extended_desc]"

/obj/item/computer_console_disk/Destroy(force)
	CloneUnInstalled()
	UnRegisterPC()
	if (program && isdatum(program))
		QDEL_NULL(program)
	if (installed_clone)
		QDEL_NULL(installed_clone)

	. = ..()

/obj/item/computer_console_disk/proc/RegisterPC(obj/item/modular_computer/computer)
	if (computer.physical && ismachinery(computer.physical))
		physical_console = computer.physical
		physical_console.set_light_color(light_color)
		RegisterSignal(physical_console, COMSIG_MACHINERY_POWER_RESTORED, PROC_REF(autoboot))

/obj/item/computer_console_disk/proc/UnRegisterPC()
	if (physical_console)
		// May break console due ALL signals removing... Unsure
		UnregisterSignal(physical_console, COMSIG_MACHINERY_POWER_RESTORED)
		physical_console.set_light_color(initial(physical_console.light_color))
		physical_console = null

/obj/item/computer_console_disk/proc/autoboot()
	SIGNAL_HANDLER

	//Still registering for badmin being able to change behavior for installed disks
	if (!start_on_power_restore)
		return

	if(physical_console && !(physical_console.machine_stat & (BROKEN|NOPOWER)) && physical_console.cpu && !physical_console.cpu.enabled)
		// Why not cpu.turn_on()? because it's crashes without user =/
		if(physical_console.cpu.looping_sound)
			physical_console.cpu.soundloop.start()
		physical_console.cpu.enabled = TRUE
		physical_console.cpu.update_appearance()
		SEND_SIGNAL(physical_console.cpu, COMSIG_MODULAR_COMPUTER_TURNED_ON, null)

/obj/item/computer_console_disk/proc/CloneInstalled()
	RegisterSignal(installed_clone.computer, COMSIG_MODULAR_COMPUTER_TURNED_ON, PROC_REF(autorun))

/obj/item/computer_console_disk/proc/CloneUnInstalled()
	if (installed_clone && !QDELETED(installed_clone.computer))
		UnregisterSignal(installed_clone.computer, COMSIG_MODULAR_COMPUTER_TURNED_ON)

/obj/item/computer_console_disk/proc/autorun(datum/source, mob/user)
	SIGNAL_HANDLER

	installed_clone.computer.open_program(user, installed_clone, installed_clone.computer.enabled)


// Disk subtypes
/obj/item/computer_console_disk/command
	icon_state = "datadisk10"
	light_color = LIGHT_COLOR_BLUE

/obj/item/computer_console_disk/security
	icon_state = "datadisk9"
	light_color = COLOR_SOFT_RED

/obj/item/computer_console_disk/medical
	icon_state = "datadisk7"
	light_color = LIGHT_COLOR_CYAN

/obj/item/computer_console_disk/science
	icon_state = "datadisk5"
	light_color = LIGHT_COLOR_PINK

/obj/item/computer_console_disk/cargo
	icon_state = "cargodisk"
	light_color = COLOR_BRIGHT_ORANGE

/obj/item/computer_console_disk/engineering
	icon_state = "datadisk2"
	light_color = LIGHT_COLOR_CYAN
