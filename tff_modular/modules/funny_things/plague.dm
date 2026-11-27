/datum/disease/organ_parasite
	form = "Parasite"
	name = "Parasitic Infection"
	max_stages = 4
	cure_text = "Surgical removal of the liver OR huge amount (>35) of Fluorosulfuric Acid intravenously"
	agent = "Parasites"
	spread_text = "None"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	desc = "An unknown parasite that likely entered the body through improperly prepared food.\
		If left untreated, the patient will lose the infected organ and eventually die."
	visibility_flags = HIDDEN_SCANNER | HIDDEN_PANDEMIC
	disease_flags = CAN_CARRY
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	severity = DISEASE_SEVERITY_MINOR
	required_organ = ORGAN_SLOT_LIVER
	bypasses_immunity = TRUE
	process_dead = TRUE

	var/next_disease_type = /datum/disease/organ_parasite/stomach
	var/spread_done = FALSE

/datum/disease/organ_parasite/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	var/acid_amount = affected_mob.reagents.get_reagent_amount(/datum/reagent/toxin/acid/fluacid)
	if(acid_amount > 35)
		if(SPT_PROB(7, seconds_per_tick))
			update_stage(stage - 1)
			to_chat(affected_mob, span_notice("You can feel the movement in your body becoming weaker."))
			if(stage < 1)
				return

	if(stage > 3 && (visibility_flags & HIDDEN_SCANNER))
		visibility_flags &= ~HIDDEN_SCANNER

	switch(stage)
		if(1)
			if(SPT_PROB(1, seconds_per_tick))
				spread()
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				spread()
		if(3)
			if(SPT_PROB(1.5, seconds_per_tick))
				spread()
		if(4)
			if(SPT_PROB(2, seconds_per_tick))
				spread()

	parasite_effect(seconds_per_tick)

/datum/disease/organ_parasite/proc/parasite_effect(seconds_per_tick)
	switch(stage)
		if(1)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, 1, 170)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_tox_loss(0.5)
		if(2)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, 1.5, 170)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_tox_loss(0.5)
		if(3)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, 2, 170)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_tox_loss(1)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("You feel something moving beneath your ribs."))
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_LIVER, 3, 170)
			if(SPT_PROB(3, seconds_per_tick))
				affected_mob.adjust_tox_loss(1.5)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Your liver aches terribly. Something is eating it from inside!"))
			try_destroy_organ(seconds_per_tick)

/datum/disease/organ_parasite/proc/spread()
	if(!affected_mob || !next_disease_type)
		return

	if(spread_done)
    	if(SPT_PROB(15, seconds_per_tick))
    	    affected_mob.emote("scream")
    	return

	for(var/datum/disease/existing_disease as anything in affected_mob.diseases)
		if(existing_disease.type == next_disease_type)
			spread_done = TRUE
			return

	var/datum/disease/new_disease = new next_disease_type
	new_disease.infect(affected_mob, FALSE)

	spread_done = TRUE
	affected_mob.apply_damage(5, BRUTE, BODY_ZONE_CHEST)
	if(stage >= 3)
		to_chat(affected_mob, span_danger("Something inside your body is moving..."))

/datum/disease/organ_parasite/proc/try_destroy_organ(seconds_per_tick)
	if(stage < 4)
		return FALSE
	if(!SPT_PROB(3, seconds_per_tick))
		return FALSE

	var/obj/item/organ/affected_organ = affected_mob.get_organ_slot(required_organ)
	if(!affected_organ)
		return FALSE
	if(affected_organ.damage < (affected_organ.maxHealth * 0.8))
		return FALSE

	to_chat(affected_mob, span_userdanger("You feel something tear inside your body!"))
	affected_mob.visible_message(
		span_warning("[affected_mob] suddenly clutches their body in pain!"),
		span_userdanger("Something inside your body suddenly tears apart!")
	)
	affected_mob.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 20)
	affected_organ.Remove(affected_mob)
	affected_organ.forceMove(get_turf(affected_mob))
	return TRUE


/datum/disease/organ_parasite/stomach
	cure_text = "Surgical removal of the stomach OR huge amount (>35) of Fluorosulfuric Acid intravenously"
	required_organ = ORGAN_SLOT_STOMACH
	next_disease_type = /datum/disease/organ_parasite/lungs

/datum/disease/organ_parasite/stomach/parasite_effect(seconds_per_tick)
	switch(stage)
		if(1)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_STOMACH, 1, 170)
		if(2)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_STOMACH, 1.5, 170)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.adjust_nutrition(-1)
		if(3)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_STOMACH, 2, 170)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.adjust_nutrition(-2)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("Your stomach feels like something is wriggling inside it."))
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_STOMACH, 3, 170)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.adjust_nutrition(-3)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 10)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("Something is tearing through your stomach!"))
			try_destroy_organ(seconds_per_tick)


/datum/disease/organ_parasite/lungs
	cure_text = "Surgical removal of the lungs OR huge amount (>35) of Fluorosulfuric Acid intravenously"
	severity = DISEASE_SEVERITY_MEDIUM
	required_organ = ORGAN_SLOT_LUNGS
	next_disease_type = /datum/disease/organ_parasite/eyes

/datum/disease/organ_parasite/lungs/parasite_effect(seconds_per_tick)
	switch(stage)
		if(1)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_LUNGS, 1, 170)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("cough")
		if(2)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_LUNGS, 1.5, 170)
			if(SPT_PROB(3, seconds_per_tick))
				affected_mob.adjust_oxy_loss(3)
			if(SPT_PROB(0.75, seconds_per_tick))
				affected_mob.emote("cough")
		if(3)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_LUNGS, 2, 170)
			if(SPT_PROB(0.75, seconds_per_tick))
				affected_mob.adjust_oxy_loss(4)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.75, seconds_per_tick))
				to_chat(affected_mob, span_danger("Your chest feels unusually tight. Something is moving inside your lungs!"))
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_LUNGS, 3, 170)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.adjust_oxy_loss(5)
			if(SPT_PROB(1.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("You can barely breathe. Something is filling your lungs!"))
			try_destroy_organ(seconds_per_tick)


/datum/disease/organ_parasite/eyes
	cure_text = "Surgical removal of the eyes OR huge amount (>35) of Fluorosulfuric Acid intravenously"
	required_organ = ORGAN_SLOT_EYES
	next_disease_type = /datum/disease/organ_parasite/brain

/datum/disease/organ_parasite/eyes/parasite_effect(seconds_per_tick)
	switch(stage)
		if(1)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, 1, 170)
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, 1, 170)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.set_eye_blur_if_lower(2 SECONDS)
		if(3)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, 1, 170)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.set_eye_blur_if_lower(4 SECONDS)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Your vision briefly distorts. Something is moving behind your eyes!"))
		if(4)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, 2, 170)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.set_eye_blur_if_lower(6 SECONDS)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Your vision is spinning. You can feel something crawling inside your eyes!"))


/datum/disease/organ_parasite/brain
	cure_text = "Surgical removal of the brain OR huge amount (>35) of Fluorosulfuric Acid intravenously"
	severity = DISEASE_SEVERITY_HARMFUL
	required_organ = ORGAN_SLOT_BRAIN
	next_disease_type = null

/datum/disease/organ_parasite/brain/parasite_effect(seconds_per_tick)
	switch(stage)
		if(1)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2, 170)
		if(2)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 3, 170)
		if(3)
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 3, 170)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.set_dizzy_if_lower(3 SECONDS)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("You try to remember something important... but can't."))
		if(4)
			if(SPT_PROB(3, seconds_per_tick))
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 4, 170)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("stare")
			if(SPT_PROB(0.3, seconds_per_tick))
				affected_mob.emote("drool")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Strange buzzing fills your head, drowning out your thoughts."))
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.set_dizzy_if_lower(10 SECONDS)
			if(SPT_PROB(0.1, seconds_per_tick))
				to_chat(affected_mob, span_danger("You lose consciousness..."))
				affected_mob.visible_message(
					span_warning("[affected_mob] suddenly collapses!"),
					span_userdanger("You suddenly collapse!")
				)
				affected_mob.Unconscious(rand(100, 150))
