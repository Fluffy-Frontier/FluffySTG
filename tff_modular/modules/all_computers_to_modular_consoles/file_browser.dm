#define EJECT_TIME_SKILLED		0 SECONDS
// 2 to unscrew, 3 to eject glass, cut wires and eject circuit
#define EJECT_TIME_UNSKILLED	5 SECONDS

/datum/computer_file/program/filemanager
    var/obj/item/computer_console_disk/console_disk

/datum/computer_file/program/filemanager/application_attackby(obj/item/computer_console_disk/attacking_item, mob/living/user)
    if (!istype(attacking_item))
        return FALSE

    if (console_disk)
        if (user)
            to_chat(user, span_warning("It's secure disk drive already occupied!"))
        return FALSE
    if (!attacking_item.program)
        computer.say("I/O ERROR: Unable to access encrypted data disk. Ejecting...")
        return FALSE

    if (!attacking_item.program.is_supported_by_hardware(computer.hardware_flag))
        var/supported_hardware = attacking_item.program.can_run_on_flags_to_text()
        if (supported_hardware == "Anything")
            // how you aren't supported, if you support anything?!
            computer.say("HARDWARE ERROR: Software compatibility mismatch! Please report that info to NTTechSupport. PC hardware code: [computer.hardware_flag]. Filename: [attacking_item.program.filename].[lowertext(attacking_item.program.filetype)]")
            return FALSE
        else
            computer.say("HARDWARE ERROR: Incompatible software. Ejecting... Supported devices: [supported_hardware]")
            return FALSE

    if(user && !user.transferItemToLoc(attacking_item, computer))
        return FALSE
    console_disk = attacking_item
    playsound(computer, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
    console_disk.RegisterPC(computer)

    if (console_disk.program)
        // Remove BSOD if present
        var/datum/computer_file/program/bsod/bsod = computer.find_file_by_name("nt_recovery")
        if (bsod)
            computer.remove_file(bsod)

        var/datum/computer_file/program/clone = console_disk.program.clone()
        console_disk.installed_clone = clone
        computer.store_file(clone)
        console_disk.CloneInstalled()
        // Initial start
        computer.open_program(user, clone, computer.enabled)

    return TRUE

/datum/computer_file/program/filemanager/try_eject(mob/living/user, forced = FALSE)
    if (forced || !user || HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
        if (user)
            user.visible_message(span_notice("[user] quickly presses few buttons on [computer]."), span_notice("You use 'Safely Remove Hardware' option to eject [console_disk] from [computer].."))
            if (do_after(user, EJECT_TIME_SKILLED, computer.physical ? computer.physical : get_turf(computer)))
                user.put_in_hands(console_disk)
                user.visible_message(span_warning("[user] removes [console_disk] from [computer]!"), span_notice("[computer] spews [console_disk] out."))
            else
                to_chat(user, span_warning("You should be near \the [computer.physical ? computer.physical : computer]!"))
                return FALSE
        else
            console_disk.forceMove(computer.drop_location())
        console_disk.CloneUnInstalled()
        computer.remove_file(console_disk.installed_clone)
        console_disk.UnRegisterPC()
        console_disk.installed_clone = null
        console_disk = null
        return TRUE
    else
        user.visible_message(span_warning("[user] tries to rip off [console_disk] from [computer]!"), span_notice("You try to forcibly remove stuck [console_disk] from [computer]..."))
        if (do_after(user, EJECT_TIME_UNSKILLED, computer.physical ? computer.physical : get_turf(computer)))
            var/datum/computer_file/program/bsod/bsod = new(lowertext("[console_disk.program.filename].[console_disk.program.filetype]"))

            console_disk.CloneUnInstalled()
            computer.remove_file(console_disk.installed_clone)
            user.put_in_hands(console_disk)
            console_disk.UnRegisterPC()
            console_disk.installed_clone = null
            console_disk = null

            computer.store_file(bsod)
            return TRUE
        to_chat(user, span_warning("You should be near \the [computer.physical ? computer.physical : computer]!"))
    return FALSE

#undef EJECT_TIME_UNSKILLED
#undef EJECT_TIME_SKILLED
