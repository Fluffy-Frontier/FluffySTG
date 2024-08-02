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

/obj/machinery/modular_computer/preset/battery_less/console/Initialize(mapload)
    . = ..()

    if (cpu && console_disk)
        var/datum/computer_file/program/filemanager/filemanager = cpu.find_file_by_name("filemanager")
        console_disk = new console_disk(cpu)

        // Oh, preset? Get fancy keyboard for free! (if provided by your program and not overriden)
        if (!icon_keyboard && console_disk.icon_keyboard)
            icon_keyboard = console_disk.icon_keyboard

        filemanager.application_attackby(console_disk)

/obj/machinery/modular_computer/preset/battery_less/console/post_machine_initialize()
    . = ..()
    if (cpu && console_disk && console_disk.installed_clone)
        console_disk.installed_clone.on_start()
        cpu.active_program = console_disk.installed_clone
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
