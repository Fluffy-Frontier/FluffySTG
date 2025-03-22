/mob/living/basic/guardian/dextrous
    range = 30
    damage_coeff = list(BRUTE = 0.7, BURN = 0.7, TOX = 0.7, STAMINA = 0, OXY = 0.7)

/mob/living/basic/guardian/dextrous/Initialize(mapload, datum/guardian_fluff/theme)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
