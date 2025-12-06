/obj/item/organ/lungs/proc/too_much_miasma(mob/living/carbon/breather, datum/gas_mixture/breath, miasma_pp, old_miasma_pp)
	// Inhale Miasma. Exhale nothing.
	breathe_gas_volume(breath, /datum/gas/miasma)
	// FLUFFY FRONTIER ADDITION START
	// Miasma sickness
	if(prob(0.5 * miasma_pp))
		var/datum/disease/advance/miasma_disease = new /datum/disease/advance/random(max_symptoms = min(round(max(miasma_pp / 2, 1), 1), 6), max_level = min(round(max(miasma_pp, 1), 1), 8))
		// tl;dr the first argument chooses the smaller of miasma_pp/2 or 6(typical max virus symptoms), the second chooses the smaller of miasma_pp or 8(max virus symptom level)
		// Each argument has a minimum of 1 and rounds to the nearest value. Feel free to change the pp scaling I couldn't decide on good numbers for it.
		if(breather.CanContractDisease(miasma_disease))
			miasma_disease.name = "Unknown"
			breather.contract_airborne_disease(miasma_disease)
	// FLUFFY FRONTIER ADDITION END
	// Miasma side effects
	if (HAS_TRAIT(breather, TRAIT_ANOSMIA)) //Anosmia quirk holder cannot smell miasma, but can get diseases from it.
		return
	switch(miasma_pp)
		if(0.25 to 5)
			// At lower pp, give out a little warning
			breather.clear_mood_event("smell")
			if(prob(5))
				to_chat(breather, span_notice("There is an unpleasant smell in the air."))
		if(5 to 15)
			//At somewhat higher pp, warning becomes more obvious
			if(prob(15))
				to_chat(breather, span_warning("You smell something horribly decayed inside this room."))
				breather.add_mood_event("smell", /datum/mood_event/disgust/bad_smell)
		if(15 to 30)
			//Small chance to vomit. By now, people have internals on anyway
			if(prob(5))
				to_chat(breather, span_warning("The stench of rotting carcasses is unbearable!"))
				breather.add_mood_event("smell", /datum/mood_event/disgust/nauseating_stench)
				breather.vomit(VOMIT_CATEGORY_DEFAULT)
		if(30 to INFINITY)
			//Higher chance to vomit. Let the horror start
			if(prob(15))
				to_chat(breather, span_warning("The stench of rotting carcasses is unbearable!"))
				breather.add_mood_event("smell", /datum/mood_event/disgust/nauseating_stench)
				breather.vomit(VOMIT_CATEGORY_DEFAULT)
		else
			breather.clear_mood_event("smell")
	// In a full miasma atmosphere with 101.34 pKa, about 10 disgust per breath, is pretty low compared to threshholds
	// Then again, this is a purely hypothetical scenario and hardly reachable
	breather.adjust_disgust(0.1 * miasma_pp)
