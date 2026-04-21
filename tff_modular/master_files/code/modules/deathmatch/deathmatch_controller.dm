/datum/deathmatch_controller/ui_interact(mob/user, datum/tgui/ui)
	if(HAS_TRAIT(user, TRAIT_NO_OBSERVE))
		to_chat(user, span_warning("You cannot play or host deathmatch in your current form!"))
		return
	..()
