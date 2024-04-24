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

/datum/computer_file/program/disk_binded/on_install(datum/computer_file/source, obj/item/modular_computer/computer_installing)
    ..()
    RegisterSignal(computer, COMSIG_MODULAR_COMPUTER_TURNED_ON, PROC_REF(autorun))

/datum/computer_file/program/disk_binded/Destroy()
    UnregisterSignal(computer, COMSIG_MODULAR_COMPUTER_TURNED_ON)
    ..()

/datum/computer_file/program/disk_binded/proc/autorun(datum/source, mob/user)
    SIGNAL_HANDLER

    computer.open_program(user, src, computer.enabled)
