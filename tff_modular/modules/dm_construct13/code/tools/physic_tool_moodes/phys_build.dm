/datum/phystool_mode/build_mode
	name = "Build mode"
	desc = "LMB for build, RMB for remove. Active button for choise build type."

	var/atom/selected_atom

/datum/phystool_mode/build_mode/use_act(mob/user)
	. = ..()
	var/list/choise = list(
		"Wall mode" = image(icon = 'icons/turf/walls.dmi', icon_state = "wall3"),
		"Turf mode" = image(icon = 'icons/turf/walls.dmi', icon_state = "floor"),
		"Structure mode" = image(icon = 'icons/obj/doors/airlocks/external/external.dmi', icon_state = "closed")
	)
	var/choised_mode = show_radial_menu(user, our_tool, choise, require_near = TRUE)
	if(!choised_mode)
		user.balloon_alert(user, "Select one!")
		return
	var/list/pick = list()
	switch(choised_mode)
		if("Wall mode")
			for(var/turf/closed/wall/W in subtypesof(/turf/closed/wall))
				if(isindestructiblewall(W))
					continue
				pick |= W
		if("Turf mode")
			for(var/turf/open/T in subtypesof(/turf/open))
				if(isindestructiblefloor(T))
					continue
				if(istype(T, /turf/open/chasm))
					continue
				pick |= T
		if("Structure mode")
			for(var/obj/machinery/door/D in subtypesof(/obj/machinery/door))
				pick |= D
	selected_atom = tgui_input_list(user, "Selected object:", "Toolgun work", pick)
