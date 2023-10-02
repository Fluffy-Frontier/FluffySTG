/datum/phystool_mode
	var/name = "Defualt mode"
	var/desc = "Coder button."

/datum/phystool_mode/proc/on_selected()
	return TRUE

/datum/phystool_mode/proc/main_act(atom/target, mob/user)
	return TRUE

/datum/phystool_mode/proc/secondnary_act(atom/target, mob/user)
	return TRUE

/datum/phystool_mode/proc/use_act()
	return TRUE
