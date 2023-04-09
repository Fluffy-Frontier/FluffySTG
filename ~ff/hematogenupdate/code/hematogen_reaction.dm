// the reagent itself
/datum/reagent/medicine/hematogen_product
	name = "Adapted Blood Mixture (Hematogen)"
	description = "Sweet liquid with iron flavour, able to speed up the regeneration of blood. Slightly worse than Saline-Glucose solution"
	reagent_state = LIQUID
	color = "#611317"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 20
	taste_description = "iron and loads of sugar"
	ph = 5.5
	chemical_flags = REAGENTS_METABOLISM

// what it does
/datum/reagent/hematogen_product/on_mob_life(mob/living/carbon/affected_mob, delta_time, times_fired)
	if(affected_mob.blood_volume < BLOOD_VOLUME_NORMAL)
		affected_mob.blood_volume += 0.30 * delta_time
	..()
// Overdose
/datum/reagent/medicine/hematogen_product/overdose_process(mob/living/affected_mob, delta_time, times_fired)
	if(DT_PROB(1.5, delta_time))
		to_chat(affected_mob, span_warning("You feel VERY sweet."))
		holder.add_reagent(/datum/reagent/consumable/sugar, 3)
		holder.remove_reagent(/datum/reagent/medicine/hematogen_product, 0.5)
	if(DT_PROB(10, delta_time))
		affected_mob.vomit()
		. = TRUE
	..()
// reaction
/datum/chemical_reaction/hematogen_creation
	required_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/milk = 2, /datum/reagent/blood = 10)
	required_temp = 323
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_FOOD

/datum/chemical_reaction/hematogen_creation/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/food/hematogen_bar(location)
