// the reagent itself
/datum/reagent/medicine/hematogen_product
	name = "Adapted Blood Mixture (Hematogen)"
	description = "Sweet liquid with iron flavour, able to speed up the regeneration of blood. Slightly worse than Saline-Glucose solution"
	reagent_state = LIQUID
	color = "#611317"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 40
	taste_description = "iron and loads of sugar"
	var/last_added = 0
	var/maximum_reachable = BLOOD_VOLUME_NORMAL - 10 //So that normal blood regeneration can continue with salglu active
	var/extra_regen = 0.20 // in addition to acting as temporary blood, also add about half this much to their actual blood per second
	ph = 5.5
	chemical_flags = REAGENTS_METABOLISM

// what it does
/datum/reagent/medicine/hematogen_product/on_mob_life(mob/living/carbon/affected_mob, delta_time, times_fired)
	if(last_added)
		affected_mob.blood_volume -= last_added
		last_added = 0
	if(affected_mob.blood_volume < maximum_reachable) //Can only up to double your effective blood level.
		var/amount_to_add = min(affected_mob.blood_volume, 5*volume)
		var/new_blood_level = min(affected_mob.blood_volume + amount_to_add, maximum_reachable)
		last_added = new_blood_level - affected_mob.blood_volume
		affected_mob.blood_volume = new_blood_level + (extra_regen * REM * delta_time)
	..()
// Overdose
/datum/reagent/medicine/salglu_solution/overdose_process(mob/living/affected_mob, delta_time, times_fired)
	if(DT_PROB(1.5, delta_time))
	if(DT_PROB(1.5, delta_time))
		to_chat(affected_mob, span_warning("You feel VERY sweet."))
		holder.add_reagent(/datum/reagent/consumable/sugar, 3)
		holder.remove_reagent(/datum/reagent/medicine/salglu_solution, 0.5)
	if(DT_PROB(18, delta_time))
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
