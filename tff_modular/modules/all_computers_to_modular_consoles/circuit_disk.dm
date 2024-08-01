/obj/item/computer_console_disk
    name = "Encrypted NTnet Modem"
    desc = "Contains software which allows computer to establish secure connection to NTNet for certain function"
    icon = 'icons/obj/devices/circuitry_n_data.dmi'
    icon_state = "datadisk6"
    // Actual program for instalation
    var/datum/computer_file/program/disk_binded/program
    // Pointer to program, cloned into PC, to remove when disk ejecting
    var/datum/computer_file/program/disk_binded/installed_clone

/obj/item/computer_console_disk/Initialize(mapload)
    . = ..()
    if (program)
        if (ispath(program))
            program = new program()
        name = "encrypted connection driver ([program.filename])"
        desc = "Contains software which allows computer to establish secure connection to NTNet for certain function.\n\n[program.extended_desc]"

/obj/item/computer_console_disk/Destroy(force)
    if (program && isdatum(program))
        QDEL_NULL(program)
    if (installed_clone)
        QDEL_NULL(installed_clone)

    . = ..()

/obj/item/computer_console_disk/command
    icon_state = "datadisk7"
