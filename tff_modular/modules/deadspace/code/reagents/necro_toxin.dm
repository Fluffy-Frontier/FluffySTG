
/datum/reagent/toxin/necro
	name = "Necrotoxin"
	description = "A vile substance that gradually corrupts the body."
	taste_description = "rotting flesh"
	color = "#4c3b34"
	overdose_threshold = 100 //Basically impossible to OD on, but turns into a worse toxin
	metabolization_rate = REM * 5

/datum/reagent/toxin/necro/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if(volume > 10) // Short lived effect, warns the player that they've taken too much necrotox in a short period of time.
		affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/oversized)
		affected_mob.reagents.remove_reagent(/datum/reagent/toxin/necro, 10) //Rapidly converts necrotoxin into a worse variant
		affected_mob.reagents.add_reagent(/datum/reagent/toxin/necro/lethal, 5)
		if(prob(75))
			affected_mob.emote("scream");
			to_chat(affected_mob, span_notice("Your insides briefly twist and burn! Something's wrong!"))

/datum/reagent/toxin/necro/on_mob_end_metabolize(mob/living/carbon/our_guy)
	. = ..()

	our_guy.remove_movespeed_modifier(/datum/movespeed_modifier/oversized)

/datum/reagent/toxin/necro/lethal
	name = "Necrax toxin"
	description = "A much deadlier variant of the enigmatic, corrupting substance."
	taste_description = "corpse bile"
	color = "#bd3c3c"
	overdose_threshold = 6 //Technically it takes 62+ necrotox to get a deadly dose here! Difficult to cure without dialysis

/datum/reagent/toxin/necro/lethal/overdose_start(mob/living/affected_mob)
	affected_mob.adjustToxLoss(REM * 4) // 500% base strength, or 10x as strong as normal necrotoxin
	return
