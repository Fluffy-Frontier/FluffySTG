
/datum/reagent/toxin/necro
	name = "Necrotoxin"
	description = "A vile substance that gradually corrupts the body."
	taste_description = "rotting flesh"
	color = "#4c3b34"
	overdose_threshold = 100 //Basically impossible to OD on, but turns into a worse toxin
	metabolization_rate = REM * 2

/datum/reagent/toxin/necro/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if(volume > 10) // Short lived effect, warns the player that they've taken too much necrotox in a short period of time.
		affected_mob.reagents.remove_reagent(/datum/reagent/toxin/necro, 10) //Rapidly converts necrotoxin into a worse variant
		affected_mob.reagents.add_reagent(/datum/reagent/toxin/necro/lethal, 7)
		if(prob(75))
			affected_mob.emote("scream");
			to_chat(affected_mob, span_notice("Your insides briefly twist and burn! Something's wrong!"))

/datum/reagent/toxin/necro/lethal
	name = "Necrax toxin"
	description = "A much deadlier variant of the enigmatic, corrupting substance."
	taste_description = "corpse bile"
	color = "#bd3c3c"
	metabolization_rate = REM * 5
	toxpwr = 4.5
