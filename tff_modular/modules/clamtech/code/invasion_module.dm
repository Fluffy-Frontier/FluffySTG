/*
 * Attention! Since NRI, on which I based this module, ABSOLUTELY does not work properly,
 * I had to rip the pirate_event.dmm code out. Sorry.
 * Since we're not NOVA and this is meant to be a separate antag, I allowed myself to use the same stuff here
*/

#define NO_ANSWER 0
#define POSITIVE_ANSWER 1
#define NEGATIVE_ANSWER 2

/// Invasion ruleset for dynamic
/datum/dynamic_ruleset/midround/clam
	name = "Clam Invasion"
	midround_ruleset_style = MIDROUND_RULESET_STYLE_HEAVY
	ruleset_category = parent_type::ruleset_category |  RULESET_CATEGORY_NO_WITTING_CREW_ANTAGONISTS
	antag_flag = "Space Pirates"
	required_type = /mob/dead/observer
	required_enemies = list(2,2,1,1,1,1,1,0,0,0)
	required_candidates = 0
	weight = 1
	cost = 20 //Painful. Also meant to hog attention? Feel free to change
	minimum_players = 40
	repeatable = TRUE

/datum/dynamic_ruleset/midround/clam/acceptable(population=0, threat_level=0)
	if (SSmapping.is_planetary())
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/clam/execute()
	send_clam_threat()
	return ..()

//Event control panel
/datum/round_event_control/clam
	name = "Clam Invasion"
	typepath = /datum/round_event/clam
	weight = 30
	max_occurrences = 1
	min_players = 50
	dynamic_should_hijack = TRUE
	category = EVENT_CATEGORY_INVASION
	description = "The crew will either pay mercs, or get curbstomped by clams."
	map_flags = EVENT_SPACE_ONLY

/datum/round_event_control/clam/preRunEvent()
	if (SSmapping.is_planetary())
		return EVENT_CANT_RUN
	return ..()

/datum/map_template/shuttle/pirate/clam
	shuttle_id = "pirate_clam"
	prefix = "tff_modular/modules/clamtech/_maps/"
	suffix = "clam"
	name = "pirate_clam"
	port_x_offset = 4
	port_y_offset = -5

/datum/round_event/clam
	//there used to be some code that would choose a clam, but I can't make even 2 more clams rn
	//go check pirate_event.dmm, I stole it all there

/datum/round_event/clam/start()
	send_clam_threat()

/proc/send_clam_threat()
	var/datum/clam/the_clam = /datum/clam //Possibly very stupid, but so am I
	///That happened once. Dunno why.
	if(!the_clam)
		message_admins("Error attempting to run the clam invasion event. SOMEHOW it couldn't use the given clam variable.")
		return
	//set payoff
	var/payoff = 0
	var/datum/bank_account/account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	if(account)
		payoff = max(PAYOFF_MIN, FLOOR(account.account_balance * 0.80, 1000))
	//the original proc calling thingie broke so, uhhh
	var/built_threat_content = replacetext(the_clam.threat_content, "%SHIPNAME", the_clam.ship_name)
	built_threat_content = replacetext(built_threat_content, "%PAYOFF", payoff)
	var/datum/comm_message/threat = new /datum/comm_message(the_clam.threat_title, built_threat_content, list("Take the cash and go save us!","Is this some kind of joke?"))
	//we do that^ and then send message
	priority_announce("Incoming subspace communication. Secure channel opened at all communication consoles.", "Incoming Message", SSstation.announcer.get_rand_report_sound())
	threat.answer_callback = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(clams_answered), threat, the_clam, payoff, world.time)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(spawn_clam), threat, the_clam), RESPONSE_MAX_TIME)
	GLOB.communications_controller.send_message(threat, unique = TRUE)

//Sorry, still figuring out how to handle procs - they are global FOR NOW
/proc/clams_answered(datum/comm_message/threat, datum/clam/the_clam, payoff, initial_send_time)
	if(world.time > initial_send_time + RESPONSE_MAX_TIME)
		priority_announce(the_clam.response_too_late, sender_override = "Mercenaries update", color_override = "grey")
		return
	if(!threat?.answered)
		return
	if(threat.answered == NEGATIVE_ANSWER)
		priority_announce(the_clam.response_rejected, sender_override = "Mercenaries update", color_override = "grey")
		return

	var/datum/bank_account/plundered_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	if(plundered_account)
		if(plundered_account.adjust_money(-payoff))
			the_clam.paid_off = TRUE
			priority_announce(the_clam.response_received, sender_override = "Mercenaries update", color_override = "grey")
		else
			priority_announce(the_clam.response_not_enough, sender_override = "Mercenaries update", color_override = "grey")

/proc/spawn_clam(datum/comm_message/threat, datum/clam/the_clam)
	if(the_clam.paid_off)
		return

	var/list/candidates = SSpolling.poll_ghost_candidates("Do you wish to be considered for a [span_notice("team of Clam exowarriors?")]", check_jobban = ROLE_TRAITOR, alert_pic = /obj/vehicle/sealed/mecha/clam/kelpwulp, role_name_text = "clammer")
	shuffle_inplace(candidates)

	var/template_key = "pirate_[the_clam.ship_template_id]" //Not nescessary? I'm to afraid to change it. It breaks.
	var/datum/map_template/shuttle/pirate/ship = SSmapping.shuttle_templates[template_key]
	var/x = rand(TRANSITIONEDGE,world.maxx - TRANSITIONEDGE - ship.width)
	var/y = rand(TRANSITIONEDGE,world.maxy - TRANSITIONEDGE - ship.height)
	var/z = SSmapping.empty_space.z_value
	var/turf/T = locate(x,y,z)
	if(!T)
		CRASH("Clam event found no turf to load in")

	if(!ship.load(T))
		CRASH("Loading clam ship failed!")

	for(var/turf/area_turf as anything in ship.get_affected_turfs(T))
		for(var/obj/effect/mob_spawn/ghost_role/human/spawner in area_turf) //Could possibly fix NRI pirates "No spawning automatically" issue. Dunno.
			if(candidates.len > 0)
				var/mob/our_candidate = candidates[1]
				var/mob/spawned_mob = spawner.create_from_ghost(our_candidate, use_loadout = FALSE)
				candidates -= our_candidate
				notify_ghosts(
					"The [the_clam.ship_name] has an object of interest: [spawned_mob]!",
					source = spawned_mob,
					header = "Clammers!",
				)
			else
				notify_ghosts(
					"The [the_clam.ship_name] has an object of interest: [spawner]!",
					source = spawner,
					header = "Clammer Spawn Here!",
				)

	priority_announce(the_clam.arrival_announcement, sender_override = "Mercenaries update")

#undef NO_ANSWER
#undef POSITIVE_ANSWER
#undef NEGATIVE_ANSWER
