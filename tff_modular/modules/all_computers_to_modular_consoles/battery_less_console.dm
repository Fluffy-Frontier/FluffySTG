/obj/machinery/modular_computer/preset/battery_less

/obj/machinery/modular_computer/preset/battery_less/Initialize(mapload)
	. = ..()
	if (!cpu)
		return

	// ugh.. no idea how to change cpu type without breaking everything.. So just let it be and remove it's cell
	var/cell = cpu.internal_cell
	cpu.internal_cell = null
	if (cell)
		qdel(cell)

/obj/machinery/modular_computer/preset/battery_less/console
	// Disk that will be installed on Initialize()
	var/obj/item/computer_console_disk/console_disk

	// Sprites from consoles file. Written by program on console_disk. Can be overriden by you or mapper
	var/icon_keyboard

/obj/machinery/modular_computer/preset/battery_less/console/post_machine_initialize()
	. = ..()

	if (cpu && console_disk)
		var/datum/computer_file/program/filemanager/filemanager = cpu.find_file_by_name("filemanager")
		console_disk = new console_disk(cpu)

		// Oh, preset? Get fancy keyboard for free! (if provided by your program and not overriden)
		if (!icon_keyboard && console_disk.icon_keyboard)
			icon_keyboard = console_disk.icon_keyboard

		filemanager.application_item_interaction(null, console_disk)

	else if (cpu && starting_programs && starting_programs.len == 1)
		cpu.active_program = cpu.find_file_by_name(starting_programs[1].filename)
		if (istype(cpu.active_program, /datum/computer_file/program/disk_binded))
			var/datum/computer_file/program/disk_binded/db = cpu.active_program
			if (!icon_keyboard && db.icon_keyboard)
				icon_keyboard = db.icon_keyboard

	if (cpu && console_disk && console_disk.installed_clone)
		console_disk.installed_clone.on_start()
		cpu.active_program = console_disk.installed_clone

		// Free roundstart... For everyone
		var/datum/computer_file/program/science/rd = cpu.active_program
		if (istype(rd))
			rd.locked = FALSE

	// Autoenable on init
	// cpu.turn_on() copycode
	if(cpu.use_energy(cpu.base_active_power_usage)) // checks if the PC is powered
		if(cpu.looping_sound)
			cpu.soundloop.skip_starting_sounds = TRUE
			cpu.soundloop.start()
			cpu.soundloop.skip_starting_sounds = initial(cpu.soundloop.skip_starting_sounds)
		cpu.enabled = TRUE
		cpu.update_appearance()
		SEND_SIGNAL(cpu, COMSIG_MODULAR_COMPUTER_TURNED_ON, null)

// Custom keyboard icon for maploaded consoles
/obj/machinery/modular_computer/preset/battery_less/console/update_overlays()
	. = ..()
	if (icon_keyboard)
		// There was keyboard_change_icon var but its always TRUE...
		if(machine_stat & NOPOWER || !cpu?.enabled)
			. += mutable_appearance('icons/obj/machines/computer.dmi', "[icon_keyboard]_off")
		else
			. += mutable_appearance('icons/obj/machines/computer.dmi', icon_keyboard)

// Whoop-whoop cranky overload of RPED interaction
/obj/machinery/modular_computer/exchange_parts(mob/user, obj/item/storage/part_replacer/replacer)
	if(!istype(replacer) || !length(replacer.contents))
		return FALSE

	var/list/circuit_boards = list()
	for(var/obj/item/computer_console_disk/board as anything in replacer)
		if(istype(board, /obj/item/computer_console_disk))
			circuit_boards["[board.program.filedesc] ([board.program.filename])"] = board

	if(!length(circuit_boards))
		return FALSE

	var/datum/computer_file/program/filemanager/fm = cpu?.find_file_by_name("filemanager")
	if(!fm)
		return FALSE
	if(fm.console_disk)
		balloon_alert(user, "disk already installed")
		return TRUE

	//if there is only one board directly install it else pick from list
	var/obj/item/computer_console_disk/target_board
	if(length(circuit_boards) == 1)
		for(var/board_name in circuit_boards)
			target_board = circuit_boards[board_name]

	else
		var/option = tgui_input_list(user, "Select Disk To Install"," Available Disks", circuit_boards)
		target_board = circuit_boards[option]
		// Everything still where it should be after the UI closed?
		if(QDELETED(target_board) || QDELETED(src) || QDELETED(user) || !(target_board in replacer) || !user.is_holding(replacer))
			return FALSE
		// User still within range?
		var/close_enough = replacer.works_from_distance || user.Adjacent(src)
		if(!close_enough)
			return FALSE

	if(!target_board)
		return FALSE

	// No matter success or not we're wzhoohiing that comp!
	fm.application_item_interaction(user, target_board)
	replacer.play_rped_sound()
	return TRUE

// God please let me cook
/obj/item/modular_computer
	allow_chunky = TRUE

/obj/item/modular_computer/handle_deconstruct(disassembled)
	if (disassembled)
		var/datum/computer_file/program/filemanager/fm = find_file_by_name("filemanager")
		if (fm)
			fm.try_eject(null, TRUE)
	. = ..()
