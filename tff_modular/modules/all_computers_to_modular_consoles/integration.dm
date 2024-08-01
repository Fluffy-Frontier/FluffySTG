GLOBAL_LIST_INIT(consoles_replacement_map, list(
    /obj/machinery/computer/rdservercontrol = /obj/machinery/modular_computer/preset/battery_less/console/rdservercontrol,
    /obj/item/circuitboard/computer/rdservercontrol = /obj/item/computer_console_disk/command/rdservercontrol,
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
