/datum/computer_file/program/filemanager
    var/obj/item/computer_console_disk/console_disk

/datum/computer_file/program/filemanager/application_attackby(obj/item/computer_console_disk/attacking_item, mob/living/user)
    if (!istype(attacking_item))
        return FALSE

    if (console_disk)
        to_chat(user, span_warning("It's secure disk drive already occupied!"))
        return FALSE
    if (!attacking_item.program)
        computer.say("I/O ERROR: Unable to access encrypted data disk. Ejecting...")
        return FALSE
    
    if (!attacking_item.program.is_supported_by_hardware(computer.hardware_flag))
        var/list/supported_hardware = list()
        if (attacking_item.program.can_run_on_flags == PROGRAM_ALL)
            supported_hardware += "...Anything... please report info about your PC and program to NT TechSupport."
        else
            if (attacking_item.program.can_run_on_flags & PROGRAM_CONSOLE)
                supported_hardware += "Console"
            if (attacking_item.program.can_run_on_flags & PROGRAM_LAPTOP)
                supported_hardware += "Laptop"
            if (attacking_item.program.can_run_on_flags & PROGRAM_PDA)
                supported_hardware += "PDA"
        computer.say("HARDWARE ERROR: Incompatible software. Ejecting... Supported devices: [supported_hardware.Join(" | ")]")
        return FALSE

    if(!user.transferItemToLoc(attacking_item, src))
        return FALSE
    console_disk = attacking_item
    playsound(src, 'sound/machines/card_slide.ogg', 50)

    if (console_disk.program)
        var/datum/computer_file/program/disk_binded/clone = console_disk.program.clone()
        console_disk.installed_clone = clone
        computer.store_file(clone)
        // Initial start after injecting is free
        clone.run_access = list()
        computer.open_program(user, clone, computer.enabled)
        clone.run_access = console_disk.program.run_access

    return TRUE

/datum/computer_file/program/filemanager/try_eject(mob/living/user, forced = FALSE)
    if (forced || !user || HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
        computer.remove_file(console_disk.installed_clone)
        user.put_in_hands(console_disk)
        console_disk.installed_clone = null
        console_disk = null
        return TRUE
    else
        // 2 to unscrew, 3 to eject glass, cut wires and eject circuit
        user.visible_message(span_warning("[user] tries to rip off [console_disk] from [computer]!"), span_notice("You try to remove stuck [console_disk] from [computer]..."))
        if (do_after(user, 5 SECONDS, computer.physical ? computer.physical : get_turf(computer)))
            computer.remove_file(console_disk.installed_clone)
            user.put_in_hands(console_disk)
            console_disk.installed_clone = null
            console_disk = null
            // TODO add BSOD screen or something
            return TRUE
        to_chat(user, span_warning("You should be near \the [computer.physical ? computer.physical : computer]!"))
    return FALSE
