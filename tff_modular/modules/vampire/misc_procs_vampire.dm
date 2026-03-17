/**
 * Helper proc for adding a power
**/
/datum/antagonist/vampire/proc/grant_power(datum/action/cooldown/vampire/power)
	for(var/datum/action/cooldown/vampire/current_powers as anything in powers)
		if(current_powers.type == power.type)
			return FALSE
	powers += power

	power.Grant(owner.current)
	log_vampire_power("[key_name(owner.current)] has purchased: [power].")
	update_static_data_for_all_viewers()
	return TRUE

/**
 * Helper proc for removing a power
**/
/datum/antagonist/vampire/proc/remove_power(datum/action/cooldown/vampire/power)
	if(power.currently_active)
		power.deactivate_power()
	powers -= power
	power.Remove(owner.current)
	update_static_data_for_all_viewers()

/**
 * When a Vampire breaks the Masquerade, they get their HUD icon changed, and Malkavian Vampires get alerted.
**/
/datum/antagonist/vampire/proc/break_masquerade(mob/admin)
	if(broke_masquerade)
		return
	broke_masquerade = TRUE

	owner.current.playsound_local(null, 'tff_modular/modules/vampire/sound/masquerade_violation.ogg', 100, FALSE, pressure_affected = FALSE)
	to_chat(owner.current, span_userdanger("You have broken the Masquerade!"))
	to_chat(owner.current, span_warning("Vampire Tip: When you break the Masquerade, you become open for termination by fellow Vampires, and your vassals are no longer completely loyal to you, as other Vampires can steal them for themselves!"))

	add_team_hud(owner.current)

	SEND_GLOBAL_SIGNAL(COMSIG_VAMPIRE_BROKE_MASQUERADE, src)
	GLOB.masquerade_breakers += src

/**
 * Increment the masquerade infraction counter and warn the vampire accordingly
**/
/datum/antagonist/vampire/proc/give_masquerade_infraction(ignore_cooldown = FALSE)
	if(broke_masquerade)
		return
	if(!ignore_cooldown)
		if(!COOLDOWN_FINISHED(src, masquerade_infraction_cooldown))
			return
		COOLDOWN_START(src, masquerade_infraction_cooldown, 90 SECONDS)
	masquerade_infractions++

	owner.current.playsound_local(null, 'tff_modular/modules/vampire/sound/lunge_warn.ogg', 100, FALSE, pressure_affected = FALSE)

	if(masquerade_infractions >= 3)
		break_masquerade()
	else
		to_chat(owner.current, span_cult_bold("You violated the Masquerade! Break the Masquerade [3 - masquerade_infractions] more times and you will become hunted by all other Vampires!"))

/**
 * Offers the vampire the option to thicken their blood if they've reached their vitae goal.
 * Called when the vampire sleeps in a coffin.
**/
/datum/antagonist/vampire/proc/rank_up_if_goal()
	while(vitae_goal_progress >= current_vitae_goal)
		if(!rank_up(1))
			return

/**
 * Increase our unspent vampire levels by one and try to rank up if inside a coffin
 * Called when sleeping in a coffin, and admin abuse
**/
/datum/antagonist/vampire/proc/rank_up(levels, ignore_reqs = FALSE)
	if(QDELETED(owner) || QDELETED(owner.current))
		return FALSE

	if(vitae_goal_progress < current_vitae_goal && !ignore_reqs)
		to_chat(owner.current, span_notice("Your lack of experience has left you unable to level up. Fulfill your vitae goal next time in order to level up."))
		return FALSE

	vampire_level_unspent += levels
	for(var/limb_slot, current_limb in affected_limbs)
		var/obj/item/bodypart/limb = current_limb
		if(QDELETED(limb) || !(limb_slot in BODY_ZONES_LIMBS))
			continue
		// This affects the hitting power of regular unarmed attacks and Brawn.
		limb.unarmed_damage_low += extra_damage_per_rank
		limb.unarmed_damage_high += extra_damage_per_rank

	if(!my_clan)
		to_chat(owner.current, span_notice("You have grown in power. Join a clan to spend it."))
		return FALSE

	to_chat(owner, span_notice("<EM>You have grown familiar with your powers!</EM>"))

	if(!ignore_reqs)
		vitae_goal_progress = max(vitae_goal_progress - current_vitae_goal, 0)
	/* else
		vitae_goal_progress = 0 */
	current_vitae_goal += VITAE_GOAL_STANDARD

	return TRUE

/**
 * Decrease the unspent vampire levels by one. Only for admins
**/
/datum/antagonist/vampire/proc/rank_down()
	vampire_level_unspent--

/datum/antagonist/vampire/proc/remove_nondefault_powers(return_levels = FALSE)
	for(var/datum/action/cooldown/vampire/power as anything in powers)
		if(power.special_flags & VAMPIRE_DEFAULT_POWER)
			continue
		remove_power(power)
		if(return_levels)
			vampire_level_unspent++

/**
 * Disables all Torpor exclusive powers, if forced is TRUE, disable all powers
**/
/datum/antagonist/vampire/proc/disable_all_powers(forced = FALSE)
	for(var/datum/action/cooldown/vampire/power as anything in powers)
		if(forced || ((power.vampire_check_flags & BP_CANT_USE_IN_TORPOR) && HAS_TRAIT(owner.current, TRAIT_TORPOR)))
			if(power.currently_active)
				power.deactivate_power()

/**
 * Check if we have a stake in our heart
**/
/datum/antagonist/vampire/proc/check_if_staked()
	var/obj/item/bodypart/chosen_bodypart = owner.current?.get_bodypart(BODY_ZONE_CHEST)
	if(locate(/obj/item/stake) in chosen_bodypart?.embedded_objects)
		return TRUE
	return FALSE
/**
 * ##adjust_humanity(count, silent)
 *
 * Adds the specified amount of humanity to the vampire
 * Checks to make sure it doesn't exceed 10,
 * Checks to make sure it doesn't go under 0,
 * Adds the masquerade power at 9 or above
 */
/datum/antagonist/vampire/proc/adjust_humanity(count, silent = FALSE)
	// Step one: Toreadors have doubled gains and losses
	if(istype(my_clan, /datum/vampire_clan/toreador))
		count = count * 2

	// No-op if nothing to change
	if(count == 0)
		return FALSE

	// If trying to add but already at max, there's nothing to do
	if(count > 0 && humanity >= 10)
		return FALSE

	// Same for removing
	if(count < 0 && humanity <= 0)
		return FALSE

	var/temp_humanity = humanity + count

	var/power_given = FALSE
	var/power_removed = FALSE

	// Are we adding or removing?
	if(count > 0)
		// We are adding
		if(temp_humanity >= VAMPIRE_HUMANITY_MASQUERADE_POWER && !is_type_in_list(/datum/action/cooldown/vampire/masquerade, powers))
			// Grant_power might fail, so we need to check if it actually got granted
			var/was_granted = grant_power(new /datum/action/cooldown/vampire/masquerade)
			if(was_granted)
				power_given = TRUE

		// Only run this code if there is an actual increase in humanity. Also don't run it if we wanna be silent.
		if(humanity < temp_humanity && !silent)
			owner.current.playsound_local(null, 'tff_modular/modules/vampire/sound/humanity_gain.ogg', 50, TRUE, pressure_affected = FALSE)
			if(power_given)
				to_chat(owner.current, span_userdanger("Your closeness to humanity has granted you the ability to feign life!"))
			else
				to_chat(owner.current, span_userdanger("You have gained humanity."))
	else
		// We are removing
		if(temp_humanity < VAMPIRE_HUMANITY_MASQUERADE_POWER)
			for(var/datum/action/cooldown/vampire/masquerade/power in powers)
				remove_power(power)
				power_removed = TRUE

		// Only run this code if there is an actual decrease in humanity
		if(humanity > temp_humanity && !silent)
			owner.current.playsound_local(null, 'tff_modular/modules/vampire/sound/humanity_loss.ogg', 50, TRUE, pressure_affected = FALSE)
			if(power_removed)
				to_chat(owner.current, span_userdanger("Your inhuman actions have caused you to lose the masquerade ability!"))
			else
				to_chat(owner.current, span_userdanger("You have lost humanity."))

	// Clamp to valid range, we are so sane we might see the face of god
	if(temp_humanity > 10)
		temp_humanity = 10
	if(temp_humanity < 0)
		temp_humanity = 0

	humanity = temp_humanity
	return TRUE

/// Bacon wanted a signal
/datum/antagonist/vampire/proc/on_track_humanity_gain_signal(datum/source, type, subject)
	SIGNAL_HANDLER
	return track_humanity_gain_progress(type, subject)

/// Signal handler for when the vampire pets an animal
/datum/antagonist/vampire/proc/on_pet_animal(datum/source, mob/living/pet)
	SIGNAL_HANDLER
	return track_humanity_gain_progress(HUMANITY_PETTING_TYPE, pet)

/// Signal handler for when the vampire hugs a carbon
/datum/antagonist/vampire/proc/on_hug_carbon(datum/source, mob/living/carbon/hugged)
	SIGNAL_HANDLER
	if(!hugged.client) // Only count hugs with real players for humanity
		return
	return track_humanity_gain_progress(HUMANITY_HUGGING_TYPE, hugged)

/// Signal handler for when the vampire appraises art
/datum/antagonist/vampire/proc/on_appraise_art(datum/source, atom/art_piece)
	SIGNAL_HANDLER
	return track_humanity_gain_progress(HUMANITY_ART_TYPE, art_piece)

/**
 * ##track_humanity_gain_progress(type, subject)
 *
 * Adds the specified subject to the tracking lists and handles all the other stuff related to it.
 * When a defined threshold is met, hands out humanity as appropriate and stops tracking.
 * Ideally this can be expanded on easily by just defining a new threshold and tracking list in the datum and defines respectively.
 * We return TRUE if it successfully added to tracked, and FALSE if it was already tracked or failed for some other reason.
 */
/datum/antagonist/vampire/proc/track_humanity_gain_progress(type, subject)
	// placeholders to populate // I dunno why this works btw, i thought i made a mistake but it worked anyways.
	var/list/tracking_list = null
	var/goal = null

	if(humanity >= 10) // Don't add anything if we're already at max.
		return

	// map all the placeholders to the correct type, get the list for easier handling
	switch(type)
		if(HUMANITY_HUGGING_TYPE)
			tracking_list = humanity_trackgain_hugged
			goal = humanity_hugging_goal
		if(HUMANITY_PETTING_TYPE)
			tracking_list = humanity_trackgain_petted
			goal = humanity_petting_goal
		if(HUMANITY_ART_TYPE)
			tracking_list = humanity_trackgain_art
			goal = humanity_art_goal
		else
			return FALSE // Cheeky check for type built in? Tsunami you genius!

	if(isatom(subject))
		var/atom/atom_subject = subject
		if(atom_subject.flags_1 & HOLOGRAM_1) // doesn't count!!
			return FALSE

	// track the weakref, not the actual reference
	subject = WEAKREF(subject)

	// already tracked?
	if(subject in tracking_list)
		return FALSE

	// Update the corresponding list
	switch(type)
		if(HUMANITY_HUGGING_TYPE)
			humanity_trackgain_hugged += subject
		if(HUMANITY_PETTING_TYPE)
			humanity_trackgain_petted += subject
		if(HUMANITY_ART_TYPE)
			humanity_trackgain_art += subject

	if(length(tracking_list) >= goal)
		// set the corresponding gained flag and award humanity
		switch(type)
			if(HUMANITY_HUGGING_TYPE)
				humanity_hugging_goal *= 2
			if(HUMANITY_PETTING_TYPE)
				humanity_petting_goal *= 2
			if(HUMANITY_ART_TYPE)
				humanity_art_goal *= 2
		adjust_humanity(1)

	return TRUE

/datum/antagonist/vampire/proc/get_rank_string()
	switch(vampire_level)
		if(0 to 1)
			return "'Initiate'"
		if(2 to 3)
			return "'Novice'"
		if(4 to 5)
			return "'Apprentice'"
		if(6 to 7)
			return "'Adept'"
		if(8 to 9)
			return "'Expert'"
		if(10 to 11)
			return "'Master'"
		if(12 to 24)
			return "'Grand Master'"
		if(25 to INFINITY)
			return "[span_narsiesmall("'Methuselah'")]"

/// This is where we store clan descriptions.
/// We will need to know the description of a clan before we "make" one,
/// because we can't just get the description from the "not-made" clan ref.
/datum/antagonist/vampire/proc/get_clan_description(clan_name)
	/// This makes descriptions about a billion times cleaner: Spans for discipline names and their individual descriptions:
	var/disciplines = "[span_tooltip("Disciplines are the aspects of the original curse bestowed upon caine, of which every kindred suffers/benefits. In terms of gameplay, they are groups of abilities that you level up.", "Disciplines")]"
	var/animalism = "[span_tooltip("Animalism is a Discipline that brings the vampire closer to their animalistic nature. This typically allows them to communicate with and gain dominance over creatures of nature.", "Animalism")]"
	var/auspex = "[span_tooltip("Auspex is a Discipline that grants vampires supernatural senses, letting them peer far further and deeper than any mortal. The malkavians especially have a strong bond with it.", "Auspex")]"
	var/celerity = "[span_tooltip("Celerity is a Discipline that grants vampires supernatural quickness and reflexes.", "Celerity")]"
	var/dominate = "[span_tooltip("Dominate is a Discipline that overwhelms another person's mind with the vampire's will.", "Dominate")]"
	var/fortitude = "[span_tooltip("Fortitude is a Discipline that grants Kindred unearthly toughness.", "Fortitude")]"
	var/obfuscate = "[span_tooltip("Obfuscate is a Discipline that allows vampires to conceal themselves, deceive the mind of others, or make them ignore what the user does not want to be seen.", "Obfuscate")]"
	var/potence = "[span_tooltip("Potence is the Discipline that endows vampires with physical vigor and preternatural strength.", "Potence")]"
	var/presence = "[span_tooltip("Presence is the Discipline of supernatural allure and emotional manipulation which allows Kindred to attract, sway, and control crowds.", "Presence")]"
	var/protean = "[span_tooltip("Protean is a Discipline that gives vampires the ability to change form, from growing feral claws to turning into something entirely different.", "Protean")]"
	var/thaumaturgy = "[span_tooltip("Thaumaturgy is the secret blood-art of the clan tremere. Allowing them all manners of blood-sorcery and pacts.", "Thaumaturgy")]"

	/// All the descriptions:
	var/ventrue = "The Ventrue are the de-facto leaders of the Camarilla. They style themselves as kings and emperors, often inhabiting positions of power.\n\
		<b>IMPORTANT:</b> Members of the Ventrue Clan are the most eligible for princedom. Please remember that princes are expected to behave in a manner befitting their office.\n\
		<b>[disciplines]:</b> [presence], [dominate], [fortitude], [potence], [celerity]"
	var/tremere = "With a powerful ancestry of wizards and magicians, the Tremere wield the secret art of blood magic, which they guard with utmost care.\n\
		<b>[disciplines]:</b> [dominate], [presence], [thaumaturgy], [obfuscate], [potence]"
	var/toreador = "Artists, Pleasure-workers, Celebrities. These are the people of the Toreador clan. They are by far the closest to humanity of all kindred, each a deeply sensitive individual.\n\
		<b>[disciplines]:</b> [celerity], [potence], [presence], [dominate], [obfuscate]"
	var/malkavian = "Completely insane. You gain constant hallucinations, become a prophet with unintelligable rambling, and gain insights better left unknown. You can also travel through Phobetor tears, rifts through spacetime only you can travel through.\n\
		<b>[disciplines]:</b> [auspex], [obfuscate], [dominate], [fortitude], [presence]"
	var/brujah = "A clan now, of mostly rebels. Though some still show fragments of their lost lineage of warrior-poets. They are long split from the Camarilla, and often form their own groups.\n\
		<b>[disciplines]:</b> [celerity], [potence], [presence], [dominate], [fortitude]"

	// Now the logic
	switch(clan_name)
		if(CLAN_TOREADOR)
			return toreador
		if(CLAN_VENTRUE)
			return ventrue
		if(CLAN_BRUJAH)
			return brujah
		if(CLAN_MALKAVIAN)
			return malkavian
		if(CLAN_TREMERE)
			return tremere

	log_runtime("Unknown clan name passed to get_clan_description: [clan_name]")
	return "No description available."

/// Checks to see if an entity counts as a "watcher" for a masquerade breach
/datum/antagonist/vampire/proc/is_masq_watcher(mob/living/watcher, recursion = 1)
	/// List of "weirdo" antags who won't count as masq breaks due to also being supernaturals or supernatural-adjacent.
	var/static/list/weirdo_antags = list(
		/datum/antagonist/changeling,
		/datum/antagonist/heretic,
		/datum/antagonist/heretic_monster,
		/datum/antagonist/nightmare,
		/datum/antagonist/wizard,
	)

	if(!isliving(watcher) || QDELING(watcher))
		return FALSE
	if(!watcher.mind || !watcher.client || watcher.client.is_afk())
		return FALSE
	if(HAS_MIND_TRAIT(watcher, TRAIT_VAMPIRE_ALIGNED))
		return FALSE
	if((FACTION_VAMPIRE in watcher.faction) || (REF(owner.current) in watcher.faction))
		return FALSE
	if(watcher.mind.has_antag_datum_in_list(weirdo_antags))
		return FALSE
	if(isanimal_or_basicmob(watcher))
		return FALSE
	if(watcher.stat != CONSCIOUS || HAS_TRAIT(watcher, TRAIT_RESTRAINED))
		return FALSE
	if(is_jaunting(watcher) || HAS_TRAIT(watcher, TRAIT_MOVE_VENTCRAWLING))
		return FALSE
	if(watcher.is_blind() || watcher.is_nearsighted_currently())
		return FALSE
	if(HAS_SILICON_ACCESS(watcher))
		return FALSE
	if(watcher in owner.current?.get_all_linked_holoparasites())
		return FALSE
	if(recursion > 0)
		var/mob/living/master = watcher.mind.enslaved_to?.resolve()
		if(master)
			return .(master, recursion - 1)
	return TRUE

/**
 * Called when a Vampire reaches Final Death
 * Releases all Vassals.
 */
/datum/antagonist/vampire/proc/free_all_vassals()
	for(var/datum/antagonist/vassal/all_vassals in vassals)
		all_vassals.owner.remove_antag_datum(/datum/antagonist/vassal)

//Returns an in proportion scaled out view, with zoom_amt extra tiles on the y axis.
/proc/get_zoomed_view(view, zoom_amt)
	var/view_x
	var/view_y
	if(IS_SAFE_NUM(view))
		return view + zoom_amt
	else
		var/list/viewrangelist = splittext(view, "x")
		view_x = text2num(viewrangelist[1])
		view_y = text2num(viewrangelist[2])
		var/proportion = view_x / view_x
		view_x += zoom_amt * proportion
		view_y += zoom_amt
	//God, I hate that we have to round this.
	return "[round(view_x, 1)]x[round(view_y, 1)]"

/mob/living/carbon/human/proc/backup_clothing_prefs() as /alist
	return alist(
		"underwear" = underwear,
		"underwear_color" = underwear_color,
		"undershirt" = undershirt,
		"socks" = socks,
		"socks_color" = socks_color,
		"jumpsuit_style" = jumpsuit_style,
	)

/mob/proc/incapacitated(flags)
	return

/mob/living/incapacitated(flags)
	if(!(flags & IGNORE_RESTRAINTS) && HAS_TRAIT(src, TRAIT_RESTRAINED))
		return TRUE
	if(!(flags & IGNORE_GRAB) && pulledby?.grab_state >= GRAB_AGGRESSIVE)
		return TRUE
	if(!(flags & IGNORE_STASIS) && HAS_TRAIT(src, TRAIT_STASIS))
		return TRUE

	if(flags & IGNORE_SOFTCRIT)
		if((stat <= SOFT_CRIT) && !(HAS_TRAIT_NOT_FROM(src, TRAIT_INCAPACITATED, STAT_TRAIT)))
			return FALSE

	if(HAS_TRAIT(src, TRAIT_INCAPACITATED))
		return TRUE

	return FALSE

/mob/living/proc/blood_particles(amount = rand(1, 3), angle = rand(0,360), min_deviation = -30, max_deviation = 30, min_pixel_z = 0, max_pixel_z = 6)
	if(QDELETED(src) || !isturf(loc) || !blood_volume || HAS_TRAIT(src, TRAIT_NOBLOOD))
		return
	var/list/blood_dna = get_blood_dna_list()
	var/blood_color = get_blood_type()?.color
	for(var/i in 1 to amount)
		var/obj/effect/decal/cleanable/blood/particle/droplet = new(loc)
		if(QDELETED(droplet)) // if they're deleting upon init, let's not waste any more time, any others will prolly just do the same thing
			return
		droplet.color = blood_color
		if(blood_dna)
			droplet.add_blood_DNA(blood_dna)
		droplet.pixel_z = rand(min_pixel_z, max_pixel_z)
		droplet.start_movement(angle + rand(min_deviation, max_deviation))

//Just new and forget
//Depricated, use movement loops instead. Exists to support things that want to move more then 10 times a second
/datum/forced_movement
	var/atom/movable/victim
	var/atom/target
	var/last_processed
	var/steps_per_tick
	var/allow_climbing
	var/datum/callback/on_step
	var/moved_at_all = FALSE
															//as fast as ssfastprocess
/datum/forced_movement/New(atom/movable/_victim, atom/_target, _steps_per_tick = 0.5, _allow_climbing = FALSE, datum/callback/_on_step = null)
	victim = _victim
	target = _target
	steps_per_tick = _steps_per_tick
	allow_climbing = _allow_climbing
	on_step = _on_step

	. = ..()

	if(_victim && _target && _steps_per_tick && !_victim.force_moving)
		last_processed = world.time
		_victim.force_moving = src
		START_PROCESSING(SSfastprocess, src)
	else
		qdel(src) //if you want to overwrite the current forced movement, call qdel(victim.force_moving) before creating this

/datum/forced_movement/Destroy()
	if(victim.force_moving == src)
		victim.force_moving = null
		if(moved_at_all)
			victim.forceMove(victim.loc) //get the side effects of moving here that require us to currently not be force_moving aka reslipping on ice
		STOP_PROCESSING(SSfastprocess, src)
	victim = null
	target = null
	on_step = null
	return ..()

//Todo: convert
/datum/forced_movement/process()
	if(QDELETED(victim) || !victim.loc || QDELETED(target) || !target.loc)
		qdel(src)
		return
	var/steps_to_take = round(steps_per_tick * (world.time - last_processed))
	if(steps_to_take)
		for(var/i in 1 to steps_to_take)
			if(TryMove())
				moved_at_all = TRUE
				if(on_step)
					on_step.InvokeAsync()
			else
				qdel(src)
				return
		last_processed = world.time

/datum/forced_movement/proc/TryMove(recursive = FALSE)
	if(QDELETED(src)) //Our previous step caused deletion of this datum
		return

	var/atom/movable/vic = victim //sanic
	var/atom/tar = target

	if(!recursive)
		. = step_towards(vic, tar)

	//shit way for getting around corners
	if(!.) //If stepping towards the target failed
		if(tar.x > vic.x) //If we're going x, step x
			if(step(vic, EAST))
				. = TRUE
		else if(tar.x < vic.x)
			if(step(vic, WEST))
				. = TRUE

		if(!.) //If the x step failed, go y
			if(tar.y > vic.y)
				if(step(vic, NORTH))
					. = TRUE
			else if(tar.y < vic.y)
				if(step(vic, SOUTH))
					. = TRUE

			if(!.) //If both failed, try again for some reason
				if(recursive)
					return FALSE
				else
					. = TryMove(TRUE)

	. = . && (vic.loc != tar.loc)

/atom/movable
	var/datum/forced_movement/force_moving = null

/// Restores the clothing prefs from an alist returned by backup_clothing_prefs()
/mob/living/carbon/human/proc/restore_clothing_prefs(alist/backup)
	if(length(backup) != 6)
		CRASH("Invalid clothing backup alist passed, expected 6 entries!")
	underwear = backup["underwear"]
	underwear_color = backup["underwear_color"]
	undershirt = backup["undershirt"]
	socks = backup["socks"]
	socks_color = backup["socks_color"]
	jumpsuit_style = backup["jumpsuit_style"]
