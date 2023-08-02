/datum/action/cooldown/teshari
	button_icon = 'tff_modular/modules/teshari_reborn/icons/actions.dmi'
	var/current_mode

/datum/action/cooldown/teshari/IsAvailable(feedback)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/human/tesh = owner
	if(!istesharialt(tesh) || isdead(tesh) || tesh.incapacitated(IGNORE_GRAB))
		return FALSE

/datum/action/cooldown/teshari/proc/update_button_state(new_state)
	button_icon_state = new_state
	owner.update_action_buttons()
