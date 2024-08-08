/obj/item/modular_computer/proc/handle_ui_removable_media_insert(mob/user)
    var/list/removable_media = list()

    // Removable console data disk
    var/datum/computer_file/program/filemanager/fm = locate() in stored_files
    if (fm?.console_disk)
        removable_media += "[HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES) ? "Safe removal:" : "Unsafe eject:"] [fm.console_disk.program?.filename] driver"

    // Science Hub disks
    var/datum/computer_file/program/science/rnd = locate() in stored_files
    if (rnd?.t_disk)
        removable_media += "Technology Disk"
    if (rnd?.d_disk)
        removable_media += "Design Disk"
    
    return removable_media

/obj/item/modular_computer/proc/handle_ui_removable_media_eject(param, mob/user)
    // Removable console data disk (switch wants constant expression)
    var/datum/computer_file/program/filemanager/fm = locate() in stored_files
    if (param == "[HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES) ? "Safe removal:" : "Unsafe eject:"] [fm?.console_disk?.program?.filename] driver")
        if (fm?.try_eject(user))
            playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
            return TRUE
        return
    switch(param)
        // Science Hub disks
        if ("Technology Disk", "Design Disk")
            var/datum/computer_file/program/science/rnd = locate() in stored_files
            if (!rnd)
                return
            if(rnd.try_eject(user))
                playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
                return TRUE
    
    return
