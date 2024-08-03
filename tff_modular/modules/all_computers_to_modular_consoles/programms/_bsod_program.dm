/datum/computer_file/program/bsod
    filename = "nt_recovery"
    filedesc = "System Recovery"
    extended_desc = "When something goes wrong this program should tell you how to fix it."
    undeletable = TRUE
    size = 0
    power_cell_use = NONE
    program_flags = PROGRAM_HEADER | PROGRAM_RUNS_WITHOUT_POWER
    program_open_overlay = "command"
    program_icon = "bug-slash"
    tgui_id = "NtosConsolesRevamp"

    var/bsod_reason = "unknown.dbg"
    var/initial_icon_state_menu = "menu"
    var/modular_icon_state_menu = "menu"
    var/modular_icon_state_screensaver = "standby"

/datum/computer_file/program/bsod/New(bsod_source)
    . = ..()
    if (bsod_source)
        bsod_reason = bsod_source

/datum/computer_file/program/bsod/on_install(datum/computer_file/source, obj/item/modular_computer/computer_installing)
    ..()
    RegisterSignal(computer, COMSIG_MODULAR_COMPUTER_TURNED_ON, PROC_REF(computer_on))

    playsound(computer, 'sound/machines/terminal_alert.ogg', 100)
    initial_icon_state_menu = computer_installing.icon_state_menu

    // Show BSOD in any condition
    computer_installing.icon_state_menu = "command"
    if (computer_installing.physical && istype(computer_installing.physical, /obj/machinery/modular_computer))
        var/obj/machinery/modular_computer/console = computer_installing.physical
        modular_icon_state_menu = console.screen_icon_state_menu
        modular_icon_state_screensaver = console.screen_icon_screensaver

        console.screen_icon_state_menu = "command"
        console.screen_icon_screensaver = "bsod"

    if(!computer.open_program(null, src, computer_installing.enabled))
        // Opening program will update icon, so we need to do this only if program wasn't opened
        update_computer_icon()

/datum/computer_file/program/bsod/Destroy()
    computer.icon_state_menu = initial_icon_state_menu

    // Curse you staionary console!
    if (!QDELETED(computer) && computer.physical && istype(computer.physical, /obj/machinery/modular_computer))
        var/obj/machinery/modular_computer/console = computer.physical
        console.screen_icon_state_menu = modular_icon_state_menu
        console.screen_icon_screensaver = modular_icon_state_screensaver

    computer?.physical?.visible_message(span_notice("\The [computer] flashes its screen few times as it reboots from safe mode."))
    playsound(computer, 'sound/machines/computer/computer_start.ogg', 10)
    update_computer_icon()
    UnregisterSignal(computer, COMSIG_MODULAR_COMPUTER_TURNED_ON)
    . = ..()

/datum/computer_file/program/bsod/on_examine(obj/item/modular_computer/source, mob/user)
    var/list/examine_text = list()
    examine_text += span_warning("Its screen tells you that previous session of <b>[bsod_reason]</b> finished incorrectly.")
    examine_text += span_notice("However you can reboot [computer]\s driver with <b>multitool</b> to remove that noisy message.\nOr just install another similar program.")
    return examine_text

/datum/computer_file/program/bsod/application_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
    if(!istype(tool, /obj/item/multitool))
        return NONE

    user.visible_message(span_notice("[user] tries to diagnose [computer]\s BSOD reason."), span_notice("You plug [tool] pins into [computer] to force restart its drivers..."))
    playsound(computer, 'sound/machines/terminal_processing.ogg', 50)
    if (do_after(user, 10 SECONDS, computer.physical ? computer.physical : get_turf(computer)))
        playsound(computer, 'sound/machines/high_tech_confirm.ogg', 50)
        computer.remove_file(src)
        return ITEM_INTERACT_SUCCESS
	// You can't do anything until fixing me
    return ITEM_INTERACT_BLOCKING

/datum/computer_file/program/bsod/ui_static_data(mob/user)
    var/list/data = list()
    data["show_imprint"] = istype(computer, /obj/item/modular_computer/pda)
    return data

// If PC has active program it won't sent us any data.
// But for fancy "Overlay" we still need it. So we will collect it manualy
/datum/computer_file/program/bsod/ui_data(mob/user)
    var/list/data = list()
    data["pai"] = computer.inserted_pai
    data["has_light"] = computer.has_light
    data["light_on"] = computer.light_on
    data["comp_light_color"] = computer.comp_light_color

    data["login"] = list(
        IDName = computer.saved_identification || "Unknown",
        IDJob = computer.saved_job || "Unknown",
    )

    data["proposed_login"] = list(
        IDInserted = computer.computer_id_slot ? TRUE : FALSE,
        IDName = computer.computer_id_slot?.registered_name,
        IDJob = computer.computer_id_slot?.assignment,
    )

    data["removable_media"] = list()
    if(computer.inserted_disk)
        data["removable_media"] += "Eject Disk"
    var/datum/computer_file/program/ai_restorer/airestore_app = locate() in computer.stored_files
    if(airestore_app?.stored_card)
        data["removable_media"] += "intelliCard"
    data["removable_media"] += computer.handle_ui_removable_media_insert(user)

    data["programs"] = list()
    for(var/datum/computer_file/program/program in computer.stored_files)
        data["programs"] += list(list(
            "name" = program.filename,
            "desc" = program.filedesc,
            "header_program" = !!(program.program_flags & PROGRAM_HEADER),
            "running" = !!(program in computer.idle_threads),
            "icon" = program.program_icon,
            "alert" = program.alert_pending,
        ))

    // Nope no way to avoid us
    data["PC_showexitprogram"] = FALSE
    data["reason"] = bsod_reason
    return data

// I am inevitable
/datum/computer_file/program/bsod/proc/computer_on(datum/source, mob/user)
    SIGNAL_HANDLER
    computer.open_program(user, src, TRUE)
