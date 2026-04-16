/datum/deathmatch_controller/ui_interact(mob/user, datum/tgui/ui)
	if(HAS_TRAIT(user, TRAIT_NO_OBSERVE))
		to_chat(user, span_warning("You cannot play or host deathmatch in your current form!"))
		return
	..()

/mob/dead/observer/restore_ghost_appearance()
	if(HAS_TRAIT(src, TRAIT_NO_OBSERVE))
		return
	..()

/mob/dead/observer/join_soulcatcher()
	if(HAS_TRAIT(src, TRAIT_NO_OBSERVE))
		return FALSE
	..()

/datum/client_colour/glass_colour/pink
	color = "#ffcfe9"

/datum/element/art/apply_moodlet(atom/source, mob/living/user, impress)
	. = ..()
	SEND_SIGNAL(user, COMSIG_LIVING_APPRAISE_ART, source)
