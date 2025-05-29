/datum/disease/piuc
	name = "P.I.U.C"
	form = "Infection"
	max_stages = 3
	spread_text = "Blood"
	spread_flags = DISEASE_SPREAD_BLOOD
	bypasses_immunity = TRUE
	cure_text = "Ephedrine"
	cures = list(/datum/reagent/medicine/ephedrine)
	agent = "infected blood"
	viable_mobtypes = list(/mob/living/carbon/human)
	disease_flags = CAN_CARRY|CAN_RESIST|CURABLE
	cure_chance = 3
	desc = "If left untreated subject will regurgitate parasites."
	severity = DISEASE_SEVERITY_HARMFUL
	infectable_biotypes = MOB_ORGANIC

/datum/disease/piuc/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_notice("You taste iron in your mouth."))
		if(3)
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("You feel something moving in your throat."))
			if(SPT_PROB(0.75, seconds_per_tick))
				affected_mob.visible_message(span_danger("[affected_mob] coughs up a parasite!"), \
													span_userdanger("You cough up a parasite!"))
				new /mob/living/basic/living_limb_flesh/hematocrat_team(affected_mob.loc)
