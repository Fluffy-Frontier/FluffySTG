/*
/datum/keybinding/marker_signal
	category = CATEGORY_NECRO

/datum/keybinding/marker_signal/can_use(client/user)
	return ismarkersignal(user.mob)

/datum/keybinding/marker_signal/rotate_necromorph_structure
	hotkey_keys = list("")
	name = "rotate_necromorph_structure"
	full_name = "Rotate structure"
	description = "Rotates necromorph structure while in placing mode."
	keybind_signal = COMSIG_KB_MSIGNAL_ROTATE_STRUCTURE_DOWN

/datum/keybinding/marker_signal/rotate_necromorph_structure/down(client/user)
	. = ..()
	if(.)
		return
	if(istype(user.mob.click_intercept, /datum/action/cooldown/necro/corruption))
		var/datum/action/cooldown/necro/corruption/placement_action = user.mob.click_intercept
		var/obj/structure/necromorph/structure = placement_action.place_structure
		structure.dir = turn(structure.dir, 45)
		user.mob.balloon_alert(user, "direction is [dir2text(structure.dir)]")
	return TRUE
*/
