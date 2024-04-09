#define RND_TECH_DISK    "tech"
#define RND_DESIGN_DISK    "design"

/datum/computer_file/program/science
    /// The stored technology disk, if present
    var/obj/item/disk/tech_disk/t_disk
    /// The stored design disk, if present
    var/obj/item/disk/design_disk/d_disk
    var/techweb_tracked = FALSE

/datum/computer_file/program/science/proc/handle_rnd_control_install()
    if (stored_research)
        if (!techweb_tracked)
            // Do not count PDAs in nullspace, please
            if (computer.loc && !(src in stored_research.apps_accessing))
                stored_research.apps_accessing += src
                techweb_tracked = TRUE
            // Oh wait, you are off-station or emgged? Be unlocked, please!
            if (!istype(stored_research, /datum/techweb/science) || (computer.obj_flags & EMAGGED))
                locked = FALSE

/datum/computer_file/program/science/proc/handle_rnd_control_remove()
    if (stored_research)
        stored_research.apps_accessing -= src
    techweb_tracked = FALSE

/datum/computer_file/program/science/Destroy()
    handle_rnd_control_remove()
    . = ..()

/datum/computer_file/program/science/on_start(mob/living/user)
    . = ..()
    if (!techweb_tracked)
        handle_rnd_control_install()

/datum/computer_file/program/science/clone()
    var/datum/computer_file/program/science/temp = ..()
    // No, you can't reassemble console to reset access lock
    temp.locked = TRUE
    return temp

/*
/datum/computer_file/program/science/on_examine(obj/item/modular_computer/source, mob/user)
	var/list/examine_text = list()
	if(!t_disk && !d_disk)
		examine_text += "It has a slot installed for science data disk."
		return examine_text

	if(computer.Adjacent(user))
		examine_text += "It has a slot installed for science data which contains: [t_disk ? t_disk.name : d_disk.name]"
	else
		examine_text += "It has a slot installed for science data, which appears to be occupied."
	examine_text += span_info("Alt-click to eject the science data disk.")
	return examine_text
*/

/datum/computer_file/program/science/proc/handle_disks_insertion(obj/item/D, mob/living/user)
    // No disks in PDA please
    if (!(computer.hardware_flag & PROGRAM_CONSOLE))
        to_chat(user, span_warning("You fail to insert [D]. Maybe you should try stationary console?"))
        return FALSE
    // Unfortunatly eject code doesn't support diffrent ejectables
    if (t_disk || d_disk)
        to_chat(user, span_warning("Science data disk slot already occupied!"))
        return FALSE
    if(istype(D, /obj/item/disk/tech_disk))
        if(!user.transferItemToLoc(D, computer))
            to_chat(user, span_warning("[D] is stuck to your hand!"))
            return FALSE
        t_disk = D
    else if (istype(D, /obj/item/disk/design_disk))
        if(!user.transferItemToLoc(D, computer))
            to_chat(user, span_warning("[D] is stuck to your hand!"))
            return FALSE
        d_disk = D
    to_chat(user, span_notice("You insert [D] into \the [computer.name]!"))
    playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
    return TRUE

/datum/computer_file/program/science/proc/handle_disks_ui_data(list/data)
    if (t_disk)
        data["t_disk"] = list (
            "stored_research" = t_disk.stored_research.researched_nodes,
        )
    if (d_disk)
        data["d_disk"] = list("blueprints" = list())
        for (var/datum/design/D in d_disk.blueprints)
            data["d_disk"]["blueprints"] += D.id

    return data

/datum/computer_file/program/science/proc/handle_disks_ui_act(action, list/params)

    switch(action)
        if ("ejectDisk")
            return try_eject()
        if ("uploadDisk")
            if (params["type"] == RND_DESIGN_DISK)
                if(QDELETED(d_disk))
                    computer.say("No design disk inserted!")
                    return TRUE
                for(var/D in d_disk.blueprints)
                    if(D)
                        stored_research.add_design(D, TRUE)
                computer.say("Uploading blueprints from disk.")
                d_disk.on_upload(stored_research)
                return TRUE
            if (params["type"] == RND_TECH_DISK)
                if (QDELETED(t_disk))
                    computer.say("No tech disk inserted!")
                    return TRUE
                computer.say("Uploading technology disk.")
                t_disk.stored_research.copy_research_to(stored_research)
            return TRUE
        //Tech disk-only action.
        if ("loadTech")
            if(QDELETED(t_disk))
                computer.say("No tech disk inserted!")
                return
            stored_research.copy_research_to(t_disk.stored_research)
            computer.say("Downloading to technology disk.")
            return TRUE

/datum/computer_file/program/science/try_eject(mob/living/user, forced = FALSE)
    if (!t_disk && !d_disk)
        if (user)
            to_chat(user, span_warning("There is no card in \the [computer.name]."))
        return FALSE

    var/obj/item/disk = t_disk ? t_disk : d_disk
    if(user && computer.Adjacent(user))
        to_chat(user, span_notice("You remove [disk] from [computer.name]."))
        user.put_in_hands(disk)
    else
        disk.forceMove(computer.drop_location())
    
    t_disk = null
    d_disk = null

    return TRUE

#undef RND_TECH_DISK
#undef RND_DESIGN_DISK
