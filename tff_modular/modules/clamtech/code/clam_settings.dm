//A pirate gang themed around powerful unique mechs
/datum/clam
	var/name = "Clam"
	var/ship_template_id = "clam"
	var/threat_title = "Mercenary contract offering"
	var/threat_content = "Well hello there, station crew! \n\
		We are an elite merc company called RetConmandos - ever heard of us? Not that's importand right now. You see, \
		for a month or so, we were observing a local militia fighting an unknown force; exosuits, mainly. \
		The draftee-rookie army was both too broke to buy our services and too stupid to handle the issue themselves, \
		so now the planet is a massive logistics depot for further invasions into your sector. \
		In fact, we do track a ship named %SHIPNAME headed your way! \
		Our offer is simple. \
		Pay us and we'll take care of the vessel, or suffer from your decisions. That'll be %PAYOFF credits, by the way."
	var/arrival_announcement = "Welp, there they are. Have fun."
	var/possible_answers = list("Take the cash and go save us!","Is this some kind of joke?")

	var/response_received = "And their dropship is destroyed, just like that. You know, we might just consider garrisoning at your place one day."
	var/response_rejected = "You want to fight all by yourself? Well, good luck dealing with a full boarding team."
	var/response_too_late = "What took you so long? Our fighters are already at the base. Deal with the invaders yourself."
	var/response_not_enough = "That's all you can pay? I'm not risking my men's lives for this much - you better prepare for boarding."
	var/paid_off = FALSE
	var/ship_name

/datum/clam/New()
	. = ..()
	ship_name = pick_n_take(list("Rising Star", "Hidden Cope", "Strana Roboty", "Memory of Tookaido", "Blood of Caribbski", "Sea League Dropship 'Fearmonger'"))

/obj/effect/mob_spawn/ghost_role/human/clam/create(mob/mob_possessor, newname)
	if(fluff_spawn)
		new fluff_spawn(drop_location())
	return ..()

/obj/effect/mob_spawn/ghost_role/human/clam/proc/generate_clam_name(mob/living/carbon/human/spawned_human)
	var/first_name = pick(GLOB.first_names)
	spawned_human.fully_replace_character_name(null, "[rank] [first_name]")

/obj/effect/mob_spawn/ghost_role/human/clam/special(mob/living/carbon/human/spawned_human)
	. = ..()
	generate_clam_name(spawned_human)
	spawned_human.mind.add_antag_datum(/datum/antagonist/clam)
	spawned_human.grant_language(/datum/language/carptongue, source = LANGUAGE_SPAWNER)
	to_chat(spawned_human, "[span_bold("'We are Clam Wulp, Children of Caribbsky'")] \
	- so start the lyrics of a massive rock ballad in which your Clam's history is written. \
	You are a Clam Exowarrior - one of the best among the best, supplied with top-of-the-shelf equipment. \
	You greatly value honor, [span_bold("discipline")] and ritualistic one-on-one combat ([span_bold("preferably without the dishonorable practice of melee")]), \
	and now's about time to fight again. Try to do it with least blood possible.")
	to_chat(spawned_human, span_boldwarning("For the love of god, please do not stop the crew from leaving the station."))

/datum/outfit/pirate/clam/post_equip(mob/living/carbon/human/spawned_human) //mob/living/carbon/human/equipped
	spawned_human.faction |= FACTION_PIRATE

	var/obj/item/radio/outfit_radio = spawned_human.ears
	if(outfit_radio)
		outfit_radio.set_frequency(FREQ_SYNDICATE)
		outfit_radio.freqlock = RADIO_FREQENCY_LOCKED

	var/obj/item/card/id/id_card = spawned_human.wear_id
	if(istype(id_card))
		id_card.registered_name = spawned_human.real_name
		id_card.update_icon()
		id_card.update_label()

	var/obj/item/clothing/under/pirate_uniform = spawned_human.w_uniform
	if(pirate_uniform)
		pirate_uniform.has_sensor = NO_SENSORS
		pirate_uniform.sensor_mode = SENSOR_OFF
		spawned_human.update_suit_sensors()

//antag and team

/datum/antagonist/clam
	name = "\improper Clam Exowarrior"
	job_rank = ROLE_SPACE_PIRATE
	roundend_category = "Clammers"
	antagpanel_category = "Clam"
	antag_moodlet = /datum/mood_event/focused
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	suicide_cry = "Forgive me, oh Great Father!!"
	///Team datum for admin tracking
	var/datum/team/clam/crew

/datum/antagonist/clam/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/clam/get_team()
	return crew

/datum/antagonist/clam/create_team(datum/team/clam/new_team)
	if(!new_team)
		for(var/datum/antagonist/clam/clam in GLOB.antagonists)
			if(!clam.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [clam]")
				continue
			if(clam.crew)
				crew = clam.crew
				return
		// No existing team was found, time to create one.
		crew = new /datum/team/clam
		crew.forge_objectives()
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization: [new_team.type].")
	crew = new_team

/datum/antagonist/clam/on_gain()
	if(crew)
		objectives |= crew.objectives
	return ..()

/datum/team/clam
	name = "\improper Clam Pentaglyph"

//Objectives
//Custom objectives dun work... Oh wait, they do now

/datum/team/clam/proc/forge_objectives() //No loot objective, so yeah
	add_objective(new /datum/objective/clamdiscipline)
	add_objective(new /datum/objective/clamesecure)
	add_objective(new /datum/objective/survive)
	for(var/datum/mind/member_mind in members)
		var/datum/antagonist/clam/clam = member_mind.has_antag_datum(/datum/antagonist/clam)
		if(!clam)
			continue
		clam.objectives |= objectives

/datum/objective/clamdiscipline
	name = "Clam: Comply"
	explanation_text = "Remember your strict command structure. Obey your commander's orders. Make sure that so does everyone else."
	martyr_compatible = TRUE
	completed = TRUE

/datum/objective/clamesecure
	name = "Clam: Conquer"
	explanation_text = "Secure the station. If possible, send back as many supplies and materials to continue the Invasion."
	martyr_compatible = TRUE //As long as your dead body is the last one aboard

/datum/objective/clamesecure/check_completion()
	var/list/owners = get_owners()
	for(var/datum/mind/mind as anything in owners)
		if(SSmapping.level_has_any_trait(mind.current.z, list(ZTRAIT_STATION))) //ended round on station
			return TRUE
	return FALSE