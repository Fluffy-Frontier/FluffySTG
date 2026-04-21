/mob/dead/observer/join_soulcatcher()
	if(HAS_TRAIT(src, TRAIT_NO_OBSERVE))
		return FALSE
	..()
