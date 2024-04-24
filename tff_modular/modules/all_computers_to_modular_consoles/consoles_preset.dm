/obj/machinery/modular_computer/preset/battery_less
    var/start_on_power_restore = FALSE

/obj/machinery/modular_computer/preset/battery_less/Initialize(mapload)
    . = ..()
    if (!cpu)
        return

    // ugh.. no idea how to change cpu type without breaking everything.. So just let it be and remove it's cell
    var/cell = cpu.internal_cell
    cpu.internal_cell = null
    if (cell)
        qdel(cell)

/obj/machinery/modular_computer/preset/battery_less/power_change()
    if (!start_on_power_restore)
        return ..()

    var/was_unpowered = machine_stat & NOPOWER
    . = ..()
    if (was_unpowered && !(machine_stat & (BROKEN|NOPOWER)) && cpu && !cpu.enabled)        
        // Why not cpu.turn_on()? because its crashes without user =/
        if(cpu.looping_sound)
            cpu.soundloop.start()
        cpu.enabled = TRUE
        cpu.update_appearance()
        SEND_SIGNAL(cpu, COMSIG_MODULAR_COMPUTER_TURNED_ON, null)

/obj/machinery/modular_computer/preset/battery_less/console
    start_on_power_restore = TRUE
    // Disk that will be installed on Initialize()
    var/obj/item/computer_console_disk/console_disk
    // If no disk. But us we making sure, that we autorun always as PC exist
    // No need to fill if console_disk filled
    var/datum/computer_file/program/autorunnable
    // Sprites from consoles file. Written by program on console_disk. Can be overriden by you or mapper
    var/icon_keyboard

/obj/machinery/modular_computer/preset/battery_less/console/Initialize(mapload)
    if (!console_disk && autorunnable && !(autorunnable in starting_programs))
        starting_programs += autorunnable

    . = ..()

    if (cpu && console_disk)
        var/datum/computer_file/program/filemanager/filemanager = cpu.find_file_by_name("filemanager")
        console_disk = new console_disk(cpu)

        // Oh, preset? Get fancy keyboard for free! (if provided by your program and not overriden)
        if (!icon_keyboard && console_disk.program)
            icon_keyboard = console_disk.program.icon_keyboard

        filemanager.application_attackby(console_disk)

    else if (cpu && autorunnable)
        var/datum/computer_file/program/prog = locate(autorunnable) in cpu.stored_files
        // First start for free
        cpu.active_program = prog
        RegisterSignal(cpu, COMSIG_MODULAR_COMPUTER_TURNED_ON, PROC_REF(autorun))

/obj/machinery/modular_computer/preset/battery_less/console/Destroy()
    UnregisterSignal(cpu, COMSIG_MODULAR_COMPUTER_TURNED_ON)
    . = ..()

// Custom keyboard icon for maploaded consoles
/obj/machinery/modular_computer/preset/battery_less/console/update_overlays()
    . = ..()
    if (icon_keyboard)
        // There was keyboard_change_icon var but its always TRUE...
        if(machine_stat & NOPOWER || !cpu?.enabled)
            . += mutable_appearance('icons/obj/machines/computer.dmi', "[icon_keyboard]_off")
        else
            . += mutable_appearance('icons/obj/machines/computer.dmi', icon_keyboard)


// Only for not disked programs like Science Hub or Cargo. Those who accessed ingame via NTnet
/obj/machinery/modular_computer/preset/battery_less/console/proc/autorun(datum/source, mob/user)
    SIGNAL_HANDLER

    if (cpu && autorunnable)
        var/datum/computer_file/program/prog = locate(autorunnable) in cpu.stored_files
        if (prog)
            // Not writing in active_programs so user need to check his access
            cpu.open_program(user, prog, cpu.enabled)
    else if (cpu)
        UnregisterSignal(cpu, COMSIG_MODULAR_COMPUTER_TURNED_ON)
    // If else - something goes wrong

// Actual presets of non console_disk computers
/obj/machinery/modular_computer/preset/battery_less/console/rdconsole_unQoL
    name = "R&D Console"
    desc = "A console used to interface with R&D tools."
    icon_keyboard = "rd_key"
    autorunnable = /datum/computer_file/program/science

/obj/machinery/modular_computer/preset/battery_less/console/cargo_unQoL
    name = "supply console"
    desc = "Used to order supplies, approve requests, and control the shuttle."
    autorunnable = /datum/computer_file/program/budgetorders
