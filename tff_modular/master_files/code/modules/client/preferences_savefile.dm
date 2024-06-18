/datum/preferences/proc/remove_character(slot)
	SHOULD_NOT_SLEEP(TRUE)
	if(!slot)
		return FALSE
	slot = sanitize_integer(slot, 1, max_save_slots, initial(default_slot))

	var/tree_key = "character[slot]"
	savefile.remove_entry(tree_key)
	return TRUE
