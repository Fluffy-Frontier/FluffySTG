/datum/computer_file/program/disk_binded
	size = 0
	program_flags = PROGRAM_REQUIRES_NTNET
	can_run_on_flags = PROGRAM_CONSOLE
	undeletable = TRUE
	// Okay. Now about accesses: we are never on NTstore, so download_access doesn't care
	// Meanwhile program run is always (or almost) free, but interactions...
	// So run_access should be empty, but all yours req_access type into download_access
	// So I didn't have to create another access variable
	download_access = list()
	run_access = list()
	// Icon_state of the keyboard overlay for mapload. If any...
	var/icon_keyboard
	// For logs. Prefer disk if not found - PC
	var/obj/owner_object

/datum/computer_file/program/disk_binded/on_install(datum/computer_file/source, obj/item/modular_computer/computer_installing)
	. = ..()
	var/datum/computer_file/program/filemanager/fm = computer.find_file_by_name("filemanager")
	if (fm && fm.console_disk)
		owner_object = fm.console_disk
	if (!owner_object)
		owner_object = computer.physical
