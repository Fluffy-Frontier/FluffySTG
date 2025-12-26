/obj/item/organ/lungs/too_much_miasma(mob/living/carbon/breather, datum/gas_mixture/breath, miasma_pp, old_miasma_pp)
	. = ..()
	if(!.)
		return

	if(prob(0.5 * miasma_pp))
		var/datum/disease/advance/miasma_disease = new /datum/disease/advance/random(max_symptoms = min(round(max(miasma_pp / 2, 1), 1), 6), max_level = min(round(max(miasma_pp, 1), 1), 8))
		if(breather.CanContractDisease(miasma_disease))
			miasma_disease.name = "Unknown"
			breather.ForceContractDisease(miasma_disease, TRUE)
