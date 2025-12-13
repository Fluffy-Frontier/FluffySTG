
/**
 * # Status effect
 *
 * This is the status effect given to Bloodsuckers in a Frenzy
 * This deals with everything entering/exiting Frenzy is meant to deal with.
 */

/datum/status_effect/frenzy
	id = "Frenzy"
	status_type = STATUS_EFFECT_UNIQUE
	duration = STATUS_EFFECT_PERMANENT
	alert_type = /atom/movable/screen/alert/status_effect/frenzy
	///Boolean on whether they were an AdvancedToolUser, to give the trait back upon exiting.
	var/was_tooluser = FALSE
	/// The stored Bloodsucker antag datum
	var/datum/antagonist/bloodsucker/bloodsuckerdatum
	var/trait_list = list(TRAIT_MUTE, TRAIT_DEAF, TRAIT_STRONG_GRABBER)

/datum/status_effect/frenzy/get_examine_text()
	return span_notice("They seem... inhumane, and feral!")

/datum/status_effect/frenzy/on_apply()
	var/mob/living/carbon/human/user = owner
	bloodsuckerdatum = IS_BLOODSUCKER(user)

	// Disable ALL Powers and notify their entry
	bloodsuckerdatum.DisableAllPowers(forced = TRUE)
	to_chat(owner, span_userdanger("<FONT size = 3>Blood! You need Blood, now! You enter a total Frenzy! You will DIE if you do not get BLOOD."))
	to_chat(owner, span_announce("* Bloodsucker Tip: While in Frenzy, you quickly accrue burn damage, instantly Aggresively grab, have stun resistance, cannot speak, hear, or use any powers outside of Feed and Trespass (If you have it)."))
	owner.balloon_alert(owner, "you enter a frenzy! Drink blood, or you will die!")
	SEND_SIGNAL(bloodsuckerdatum, COMSIG_BLOODSUCKER_ENTERS_FRENZY)

	// Give the other Frenzy effects
	owner.add_traits(trait_list, FRENZY_TRAIT)
	if(HAS_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER))
		was_tooluser = TRUE
		REMOVE_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/frenzy_speedup)
	owner.add_client_colour(/datum/client_colour/manual_heart_blood, REF(src))
	var/obj/cuffs = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
	var/obj/legcuffs = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
	if((user.handcuffed && cuffs) || (user.legcuffed && legcuffs))
		user.clear_cuffs(cuffs, TRUE)
		user.clear_cuffs(legcuffs, TRUE)
	bloodsuckerdatum.frenzied = TRUE
	return ..()

/datum/status_effect/frenzy/on_remove()
	owner.balloon_alert(owner, "you come back to your senses.")
	owner.remove_traits(trait_list, FRENZY_TRAIT)
	if(was_tooluser)
		ADD_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
		was_tooluser = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/frenzy_speedup)
	owner.remove_client_colour(REF(src))

	SEND_SIGNAL(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXITS_FRENZY)
	bloodsuckerdatum.frenzied = FALSE
	return ..()

/datum/status_effect/frenzy/tick()
	var/mob/living/carbon/human/user = owner
	// If duration is not -1, that means we're about to loose frenzy, let's give them some safe time.
	if(!bloodsuckerdatum.frenzied || duration > 0 || user.stat != CONSCIOUS )
		return
	user.adjustFireLoss(1 + (bloodsuckerdatum.GetHumanityLost() / 10))

/datum/movespeed_modifier/frenzy_speedup
	blacklisted_movetypes = (FLYING|FLOATING)
	multiplicative_slowdown = -0.4

/datum/movespeed_modifier/mesmerize_slowdown
	blacklisted_movetypes = (FLYING|FLOATING)
	multiplicative_slowdown = 0.5

/datum/actionspeed_modifier/bloodsucker
	multiplicative_slowdown = -0.2

/datum/status_effect/brujah
	id = "Brujah"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 20 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/frenzy/brujah
	var/datum/antagonist/bloodsucker/bloodsuckerdatum
	var/trait_list = list(TRAIT_MUTE, TRAIT_DEAF, TRAIT_STRONG_GRABBER)

/datum/status_effect/brujah/get_examine_text()
	return span_notice("They seem... inhumane, and feral!")

/datum/status_effect/brujah/on_apply()
	var/mob/living/carbon/human/user = owner
	bloodsuckerdatum = IS_BLOODSUCKER(user)

	bloodsuckerdatum.DisableAllPowers(forced = TRUE)
	to_chat(owner, span_userdanger("<FONT size = 3>Blood! You need Blood, now! You enter a total Frenzy!"))
	to_chat(owner, span_announce("* Bloodsucker Tip: While in Frenzy, you instantly Aggresively grab, have stun resistance, cannot speak, hear"))
	owner.balloon_alert(owner, "you enter a frenzy!")
	owner.add_movespeed_modifier(/datum/movespeed_modifier/frenzy_speedup)
	owner.add_client_colour(/datum/client_colour/manual_heart_blood, REF(src))
	var/obj/cuffs = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
	var/obj/legcuffs = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
	if((user.handcuffed && cuffs) || (user.legcuffed && legcuffs))
		user.clear_cuffs(cuffs, TRUE)
		user.clear_cuffs(legcuffs, TRUE)
	return ..()

/datum/status_effect/brujah/on_remove()
	owner.balloon_alert(owner, "you come back to your senses.")
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/frenzy_speedup)
	owner.remove_client_colour(REF(src))
	return ..()
