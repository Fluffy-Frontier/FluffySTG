/mob/dead/observer/restore_ghost_appearance()
	if(HAS_TRAIT(src, TRAIT_NO_OBSERVE))
		return
	..()
