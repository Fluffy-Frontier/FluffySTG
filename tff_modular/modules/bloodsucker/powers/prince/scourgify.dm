/datum/action/cooldown/bloodsucker/targeted/scourgify
	name = "Select Scourge"
	desc = "Select another kindred or one of your ghoul as your scourge."
	button_icon_state = "power_scourge"
	power_explanation = "Activate to select another kindred, or one of your ghoul, as your personal scourge.\n\n\
						When used on another kindred, they will receive some levels and an objective to obey you.\n\
						When used on your ghoul, you will become their sire, embracing them as a full-blooded vampire.\n\
						They will be part of your own clan, and of course receive some bonus levels as well.\n\n\
						The Scourge is your enforcer, your tool to wield in the name of the Camarilla. Use them to enforce the masquerade, and to keep control over your fellow kindred."
	bloodsucker_check_flags = BP_CANT_USE_IN_TORPOR | BP_CANT_USE_IN_FRENZY
	bloodcost = 0
	cooldown_time = 35 SECONDS
	power_activates_immediately = FALSE
	prefire_message = "Whom will you choose?"
	var/datum/weakref/target_ref
	var/promoting = FALSE

/datum/action/cooldown/bloodsucker/targeted/scourgify/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!isliving(target_atom))
		return FALSE
	var/mob/living/living_target = target_atom
	var/datum/antagonist/bloodsucker/target_vampire = IS_BLOODSUCKER(living_target)
	if(!living_target.mind || !living_target.client)
		owner.balloon_alert(owner, "mindless")
		return FALSE
	if(living_target.stat != CONSCIOUS)
		owner.balloon_alert(owner, "not [(living_target.stat == DEAD || HAS_TRAIT(living_target, TRAIT_FAKEDEATH)) ? "alive" : "conscious"]")
		return FALSE

	if(IS_GHOUL(living_target) && !(IS_GHOUL(living_target) in bloodsuckerdatum_power.ghouls))
		owner.balloon_alert(owner, "not your ghoul")
		return FALSE

	if(!IS_BLOODSUCKER(living_target) && !IS_GHOUL(living_target))
		owner.balloon_alert(owner, "not ghoul or bloodsucker")
		return FALSE

	if(target_vampire && (target_vampire.prince || target_vampire.scourge))
		owner.balloon_alert(owner, "cannot promote elders")
		return FALSE

	if(target_ref || promoting)
		owner.balloon_alert(owner, "already offering!")
		return FALSE

	return TRUE

/datum/action/cooldown/bloodsucker/targeted/scourgify/FireTargetedPower(atom/target, params)
	. = ..()
	var/mob/living/living_target = target

	var/datum/antagonist/ghoul/vassal = IS_GHOUL(living_target)

	promoting = TRUE

	if(vassal) // We don't need to ask a lowly vassal.
		// Pull them into our clan
		var/datum/bloodsucker_clan/masterclan_type = bloodsuckerdatum_power.my_clan?.type

		if(!masterclan_type) // How did a caitiff get prince, bro. Fine.
			owner.balloon_alert(owner, "select clan first!")
			DeactivatePower()
			return

		vassal.silent = TRUE
		living_target.mind.remove_antag_datum(/datum/antagonist/ghoul)

		// Make, then give the datum
		var/datum/antagonist/bloodsucker/scourgedatum = new(living_target.mind)
		scourgedatum.stinger_sound = null // to avoid several sounds stacking on top of each other
		living_target.mind.add_antag_datum(scourgedatum)

		scourgedatum.my_clan = new masterclan_type(scourgedatum)

		// Scourgify and end power
		scourgedatum.scourgify()
		target_ref = null
		PowerActivatedSuccesfully()
		return
	else
		target_ref = WEAKREF(IS_BLOODSUCKER(living_target))

		owner.balloon_alert(owner, "you offer [living_target] the rank of Scourge...")
		living_target.playsound_local(null, 'tff_modular/modules/bloodsucker/sound/scourge_offer.ogg', 100, FALSE, pressure_affected = FALSE)

		ASYNC
			var/choice = tgui_alert(living_target,
				message = "Your Prince has selected you as [owner.p_their()] enforcer. Should you accept, you will receive the rank of 'Scourge', be bound to [owner.p_their()] authority, and increase in power considerably.",
				title = "Scourge Offer",
				buttons = list("Accept", "Refuse"),
				timeout = cooldown_time - 5 SECONDS,
				autofocus = TRUE
			)
			handle_choice(choice)

	addtimer(CALLBACK(src, PROC_REF(choice_timeout)), cooldown_time)
	DeactivatePower()

/datum/action/cooldown/bloodsucker/targeted/scourgify/proc/accepted()
	var/datum/antagonist/bloodsucker/target_datum = target_ref.resolve()
	target_datum.scourgify()
	target_ref = null
	PowerActivatedSuccesfully()
	bloodsuckerdatum_power.RemovePower(src)

/datum/action/cooldown/bloodsucker/targeted/scourgify/proc/refused()
	owner.balloon_alert(owner, "offer refused")
	target_ref = null
	promoting = FALSE

/datum/action/cooldown/bloodsucker/targeted/scourgify/proc/choice_timeout()
	if(owner && target_ref) // This might happen AFTER we remove the power from our owner.
		owner.balloon_alert(owner, "offer ignored")
		target_ref = null
		promoting = FALSE

/datum/action/cooldown/bloodsucker/targeted/scourgify/proc/handle_choice(choice)
	switch(choice)
		if("Accept")
			accepted()
			return
		if("Refuse")
			refused()
			return
