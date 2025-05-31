/datum/disease/piuc
	name = "P.I.U.C"
	form = "Infection"
	max_stages = 4
	spread_text = "Blood and skin"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN
	bypasses_immunity = TRUE
	cure_text = "Ephedrine"
	cures = list(/datum/reagent/medicine/ephedrine)
	agent = "parasites"
	viable_mobtypes = list(/mob/living/carbon/human)
	disease_flags = CAN_CARRY|CAN_RESIST|CURABLE
	cure_chance = 3.2
	cycles_to_beat = 1000 // болезнь не лечится сама.
	spreading_modifier = 0.16 // намного реже чем другие болезни
	desc = "If left untreated, severe vomiting and skin damage will occur at the beginning. Over time, the parasites in the body will grow to huge sizes, starting to come out of the body. \
		The host's body is recovering at the last stage."
	severity = DISEASE_SEVERITY_MEDIUM
	infectable_biotypes = MOB_ORGANIC

/datum/disease/piuc/infect(mob/living/infectee, make_copy = TRUE)
	. = ..()

	infectee.faction |= FACTION_HEMATOCRAT_DISEASE

/datum/disease/piuc/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_notice("You taste iron in your mouth."))
		if(3)
			if(SPT_PROB(1.5, seconds_per_tick))
				affected_mob.vomit(vomit_flags = (MOB_VOMIT_MESSAGE | MOB_VOMIT_HARM), vomit_type = /obj/effect/decal/cleanable/vomit/purple, lost_nutrition = 30, distance = 1)
				affected_mob.Stun(0.7 SECONDS)
			if(SPT_PROB(1.5, seconds_per_tick))
				affected_mob.visible_message(span_userdanger("[pick("You feel a sudden pain across your body.", "You feel something moving inside your skin", "Your skin is peeling off.")]"))
				var/get_damage = rand(10,20)
				affected_mob.take_overall_damage(brute = get_damage, required_bodytype = BODYTYPE_ORGANIC)
		if(4)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.visible_message(
					span_danger("[affected_mob] coughs up a parasite!"),
					span_userdanger("You cough up a parasite!"),
				)
				var/mob/living/basic/living_limb_flesh/disease_team/friend = new (affected_mob.loc)
				friend.befriend(affected_mob)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.visible_message(span_singing("[pick("You feel that your skin is recovering.", "Something is helping you.", "You feel a surge of energy.")]"))
				affected_mob.blood_volume += 5
				affected_mob.adjustBruteLoss(-15)
				affected_mob.adjustFireLoss(-15)
				affected_mob.adjustStaminaLoss(-15)
			if(affected_mob.stat == HARD_CRIT && SPT_PROB(1, seconds_per_tick))
				affected_mob.visible_message(span_singing("You're our home."))
				affected_mob.blood_volume += 30
				affected_mob.adjustBruteLoss(-30)
				affected_mob.adjustFireLoss(-30)
				affected_mob.adjustStaminaLoss(-30)

/datum/disease/piuc/remove_disease()
	affected_mob.faction -= FACTION_HEMATOCRAT_DISEASE
	return ..()
