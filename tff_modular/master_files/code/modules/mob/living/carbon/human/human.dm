/mob/living/carbon/human/fully_heal(heal_flags = HEAL_ALL)
	if(istype(dna.species, /datum/species/nabber))
		heal_flags &= ~HEAL_RESTRAINTS
	..()
