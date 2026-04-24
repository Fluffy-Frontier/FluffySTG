/mob/living/carbon/update_worn_legcuffs()
	if(istype(dna.species, /datum/species/nabber))
		remove_overlay(LEGCUFF_LAYER)
		clear_alert("legcuffed")
		return
	..()
