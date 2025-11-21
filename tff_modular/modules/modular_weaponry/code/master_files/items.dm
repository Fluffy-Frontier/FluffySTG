///Intended for interactions with guns, like racking
/obj/item/proc/unique_action(mob/living/user)
	return TRUE

///Called before unique action, if any other associated items should do a unique action or override it.
/obj/item/proc/pre_unique_action(mob/living/user)
	if(SEND_SIGNAL(src,COMSIG_CLICK_UNIQUE_ACTION,user) & OVERRIDE_UNIQUE_ACTION)
		return TRUE
	return FALSE //return true if the proc should end here
