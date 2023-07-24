/mob/living/carbon/human/is_shove_knockdown_blocked()
	if(HAS_TRAIT(src, TRAIT_KNOCKDOWN_IMMUNE))
		return TRUE
	..()
