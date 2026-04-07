/datum/smite/knee_breaker
	name = "Break Knees"
	var/leg_choice = "both"
	var/evil_mode = FALSE

/datum/smite/knee_breaker/configure(client/user)
	var/choice = tgui_alert(user, "Which legs should be broken?", "Leg Selection", list("Left Leg", "Right Leg", "Both Legs"))

	switch(choice)
		if("Left Leg")
			leg_choice = "left"
		if("Right Leg")
			leg_choice = "right"
		if("Both Legs")
			leg_choice = "both"
		else
			return FALSE

	evil_mode = tgui_alert(user, "Choose the severity:", "Evil Mode", list("Normal (Dislocate)", "Evil (70 damage + fracture)")) == "Evil (70 damage + fracture)"

	return TRUE

/proc/break_knees(mob/living/target, leg_choice, evil = FALSE)
	var/list/legs_to_break = list()

	switch(leg_choice)
		if("left")
			legs_to_break += target.get_bodypart(BODY_ZONE_L_LEG)
		if("right")
			legs_to_break += target.get_bodypart(BODY_ZONE_R_LEG)
		if("both")
			legs_to_break += target.get_bodypart(BODY_ZONE_L_LEG)
			legs_to_break += target.get_bodypart(BODY_ZONE_R_LEG)

	for(var/obj/item/bodypart/leg as anything in legs_to_break)
		if(!leg)
			continue

		if(evil)
			// Evil version: 50 damage + hairline fracture
			target.apply_damage(70, BRUTE, leg.body_zone, wound_bonus = CANT_WOUND)
			leg.force_wound_upwards(/datum/wound/blunt/bone/severe, smited = TRUE)
		else
			// Normal version: just dislocate
			leg.force_wound_upwards(/datum/wound/blunt/bone/moderate, smited = TRUE)

	// Play bone cracking sound
	playsound(get_turf(target), 'sound/effects/wounds/crack2.ogg', 75, FALSE)

// Force cry out in pain
	var/pain_messages = list()
	if(leg_choice == "both")
		pain_messages += "AGH! MY KNEES!"
		pain_messages += "AAAAH! MY LEGS!"
		pain_messages += "FUCK! THAT HURTS!"
		pain_messages += "OH GOD, MY KNEES!"
	else
		pain_messages += "AGH! MY [uppertext(leg_choice)] KNEE!!"
		pain_messages += "AAAAH! MY LEG!"
		pain_messages += "FUCK! THAT HURTS!"
		pain_messages += "OH GOD, MY KNEE!"
	target.say(pick(pain_messages), forced = "knee smite pain")
	target.emote("scream")

	// Make them fall and drop their items
	target.drop_all_held_items()
	target.Knockdown(30 SECONDS)

/datum/smite/knee_breaker/effect(client/user, mob/living/target)
	if (!isliving(target))
		return // This doesn't work on ghosts
	. = ..()
	break_knees(target, leg_choice, evil_mode)
