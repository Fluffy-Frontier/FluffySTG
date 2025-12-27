/// Used by Ghouls
/datum/action/cooldown/bloodsucker/recuperate
	name = "Sanguine Recuperation"
	desc = "Quickly heals you overtime using your blood."
	button_icon_state = "power_recup"
	power_explanation = "Recuperate:\n\
		Activating this Power will begin to heal your wounds.\n\
		You will heal Brute and Burn\n\
		The power will cancel out if you are dead or unconcious."
	power_flags = BP_CONTINUOUS_EFFECT
	check_flags = AB_CHECK_CONSCIOUS
	bloodsucker_check_flags = NONE
	purchase_flags = BLOODSUCKER_DEFAULT_POWER
	bloodcost = 5
	cooldown_time = 10 SECONDS
	level_current = -1
	constant_bloodcost = 2
	var/healing = -2

/datum/action/cooldown/bloodsucker/recuperate/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return
	if(user.stat >= DEAD || user.incapacitated)
		user.balloon_alert(user, "you are incapacitated...")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/recuperate/ActivatePower(trigger_flags)
	. = ..()
	owner.balloon_alert(owner, "recuperate turned on.")
	return TRUE

/datum/action/cooldown/bloodsucker/recuperate/process(seconds_per_tick)
	. = ..()
	if(!.)
		return

	if(!active)
		return
	var/mob/living/carbon/user = owner
	var/datum/antagonist/ghoul/ghouldatum = IS_GHOUL(user)
	var/datum/antagonist/bloodsucker/suckdatum = IS_BLOODSUCKER(user)
	var/healing_amount = (healing - (suckdatum.GetRank() * 0.25))
	if(ghouldatum && QDELETED(ghouldatum.master))
		to_chat(owner, span_warning("No master to draw blood from!"))
		DeactivatePower()
		return
	user.adjustBruteLoss(healing_amount, updating_health = FALSE)
	user.adjustToxLoss(healing_amount, forced = TRUE, updating_health = FALSE)
	user.adjustFireLoss(healing_amount, updating_health = FALSE)
	user.updatehealth()
	// Stop Bleeding
	if(istype(user) && user.is_bleeding())
		for(var/obj/item/bodypart/part in user.bodyparts)
			part.generic_bleedstacks--


/datum/action/cooldown/bloodsucker/recuperate/ContinueActive(mob/living/user, mob/living/target)
	if(user.stat >= DEAD)
		return FALSE
	if(user.health >= 135)
		return FALSE
	if(INCAPACITATED_IGNORING(user, INCAPABLE_GRAB|INCAPABLE_RESTRAINTS))
		owner?.balloon_alert(owner, "too exhausted...")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/recuperate/DeactivatePower(deactivate_flags)
	. = ..()
	if(!.)
		return
	owner.balloon_alert(owner, "recuperate turned off.")
	return ..()
