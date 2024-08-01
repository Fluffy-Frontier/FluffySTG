/datum/computer_file/program/disk_binded/holodeck
    filename = "holodeck_admin"
    filedesc = "Holodeck Controls"
    program_open_overlay = "holocontrol"
    extended_desc = "Program for configuring local holodeck."
    program_flags = null
    size = 0
    tgui_id = "NtosHolodeckControl"
    program_icon = FA_ICON_WAND_SPARKLES

    var/safeties = FALSE

    //new vars
    ///what area type this holodeck loads into. linked turns into the nearest instance of this area
    var/area/mapped_start_area = /area/station/holodeck/rec_center

    ///the currently used map template
    var/datum/map_template/holodeck/template

    ///bottom left corner of the loading room, used for placing
    var/turf/bottom_left

    ///if TRUE the holodeck is busy spawning another simulation and should immediately stop loading the newest one
    var/spawning_simulation = FALSE

    //old vars

    ///the area that this holodeck loads templates into, used for power and deleting holo objects that leave it
    var/area/station/holodeck/linked

    ///what program is loaded right now or is about to be loaded
    var/program = "holodeck_offline"
    var/last_program

    ///the default program loaded by this holodeck when spawned and when deactivated
    var/offline_program = "holodeck_offline"

    ///stores all of the unrestricted holodeck map templates that this computer has access to
    var/list/program_cache
    ///stores all of the restricted holodeck map templates that this computer has access to
    var/list/emag_programs

    ///subtypes of this (but not this itself) are loadable programs
    var/program_type = /datum/map_template/holodeck

    ///every holo object created by the holodeck goes in here to track it
    var/list/spawned = list()
    var/list/effects = list() //like above, but for holo effects

    ///special locs that can mess with derez'ing holo spawned objects
    var/list/special_locs = list(
        /obj/item/clothing/head/mob_holder,
    )

    ///TRUE if the holodeck is using extra power because of a program, FALSE otherwise
    var/active = FALSE
    ///increases the holodeck cooldown if TRUE, causing the holodeck to take longer to allow loading new programs
    var/damaged = FALSE

    //creates the timer that determines if another program can be manually loaded
    COOLDOWN_DECLARE(holodeck_cooldown)


/datum/computer_file/program/disk_binded/holodeck/on_install(datum/computer_file/source, obj/item/modular_computer/computer_installing)
    . = ..()

    linked = GLOB.areas_by_type[mapped_start_area]
    if(!linked)
        log_mapping("[src] at [AREACOORD(src)] has no matching holodeck area.")
        qdel(src)
        return

    bottom_left = locate(linked.x, linked.y, src.z)
    if(!bottom_left)
        log_mapping("[src] at [AREACOORD(src)] has an invalid holodeck area.")
        qdel(src)
        return

    var/area/computer_area = get_area(src)
    if(istype(computer_area, /area/station/holodeck))
        log_mapping("Holodeck computer cannot be in a holodeck, This would cause circular power dependency.")
        qdel(src)
        return

    // the following is necessary for power reasons
    if(!offline_program)
        stack_trace("Holodeck console created without an offline program")
        qdel(src)
        return

    linked.linked = src
    var/area/my_area = get_area(src)
    if(my_area)
        linked.energy_usage = my_area.energy_usage
    else
        linked.energy_usage = list(AREA_USAGE_LEN)

    COOLDOWN_START(src, holodeck_cooldown, HOLODECK_CD)
    generate_program_list()
    load_program(offline_program,TRUE)

///adds all programs that this holodeck has access to, and separates the restricted and unrestricted ones
/datum/computer_file/program/disk_binded/holodeck/proc/generate_program_list()
    for(var/typekey in subtypesof(program_type))
        var/datum/map_template/holodeck/program = typekey
        var/list/info_this = list("id" = initial(program.template_id), "name" = initial(program.name))
        if(initial(program.restricted))
            LAZYADD(emag_programs, list(info_this))
        else
            LAZYADD(program_cache, list(info_this))

///shuts down the holodeck and force loads the offline_program
/datum/computer_file/program/disk_binded/proc/emergency_shutdown()
    last_program = program
    active = FALSE
    load_program(offline_program, TRUE)

/datum/computer_file/program/disk_binded/holodeck/ui_data(mob/user)
    var/list/data = list()

    data["default_programs"] = program_cache
    if(computer.obj_flags & EMAGGED || !safeties)
        data["emagged"] = TRUE
        data["emag_programs"] = emag_programs
    data["program"] = program
    data["can_toggle_safety"] = issilicon(user) || isAdminGhostAI(user)
    return data

/datum/computer_file/program/disk_binded/holodeck/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
    . = ..()
    if(.)
        return
    . = TRUE

    switch(action)
        if("load_program")
            var/program_to_load = params["id"]

            var/list/checked = program_cache.Copy()
            if (computer.obj_flags & EMAGGED || !safeties)
                checked |= emag_programs
            var/valid = FALSE //dont tell security about this

            //checks if program_to_load is any one of the loadable programs, if it isnt then it rejects it
            for(var/list/check_list as anything in checked)
                if(check_list["id"] == program_to_load)
                    valid = TRUE
                    break
            if(!valid)
                return FALSE
            //load the map_template that program_to_load represents
            if(program_to_load)
                load_program(program_to_load)
        if("safety")
            if (!(computer.obj_flags & EMAGGED) && !issilicon(usr))
                return
            if(!safeties && program)
                emergency_shutdown()
            nerf(!safeties, FALSE)
            safeties = !safeties
            say("Safeties reset. Restarting...")
            usr.log_message("disabled Holodeck safeties.", LOG_GAME)

///changes all weapons in the holodeck to do stamina damage if set
/datum/computer_file/program/disk_binded/holodeck/proc/nerf(nerf_this, is_loading = TRUE)
    if (!nerf_this && is_loading)
        return
    for(var/obj/item/to_be_nerfed in spawned)
        to_be_nerfed.damtype = nerf_this ? STAMINA : initial(to_be_nerfed.damtype)
    for(var/obj/effect/holodeck_effect/holo_effect as anything in effects)
        holo_effect.safety(nerf_this)
