/datum/phystool_mode
	var/name = "Defualt mode"
	var/desc = "Coder button."
	var/mode_icon = 'icons/effects/effects.dmi'
	var/mode_icon_state = "slapglove"

/datum/phystool_mode/proc/main_act(atom/target, mob/user)
	return TRUE

/datum/phystool_mode/proc/secondnary_act(atom/target, mob/user)
	return TRUE

/datum/phystool_mode/proc/use_act()
	return TRUE
