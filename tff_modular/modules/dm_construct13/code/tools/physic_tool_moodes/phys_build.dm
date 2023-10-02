/datum/phystool_mode/build_mode
	name = "Build mode"
	desc = "LMB for build, RMB for remove. Active button for choise build type."

	var/turf/selected_turf

/datum/phystool_mode/use_act()
	. = ..()
	var/choise = list(
		"Wall mode" = image(icon = '', icon_state = "")
	)
