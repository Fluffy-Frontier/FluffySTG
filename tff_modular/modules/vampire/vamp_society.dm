SUBSYSTEM_DEF(vsociety)
	name = "Vampire Society"
	wait = 5 MINUTES
	ss_flags = SS_NO_INIT | SS_BACKGROUND
	can_fire = FALSE

	// Are we currently polling?
	var/currently_polling = FALSE

	// Ref to the prince datum
	var/datum/weakref/princedatum

	var/start_time = 0

	var/time_to_wait = 9 MINUTES

/datum/controller/subsystem/vsociety/fire(resumed = FALSE)
	var/time_elapsed = world.time - start_time

	// Give them some breathing room
	if(time_elapsed < time_to_wait)
		return

	if(!princedatum && !currently_polling)
		for(var/datum/antagonist/vampire as anything in GLOB.all_vampires)
			to_chat(vampire.owner.current, span_announce("* Vampire Tip: A vote for Prince will occur soon. If you are interested in leading your fellow kindred, read up on princes in your info panel now!"))
		addtimer(CALLBACK(src, PROC_REF(poll_for_prince)), 2 MINUTES)
		message_admins("Vampire society has fired, and a prince poll will occur in 2 minutes.")
		log_game("Vampire society has fired, and a prince poll will occur soon.")

/datum/controller/subsystem/vsociety/proc/poll_for_prince()
	message_admins("Vampire society is now polling for a new prince.")
	log_game("Vampire society is now polling for a new prince.")

	//Build a list of mobs in GLOB.all_vampires
	var/list/vampire_living_candidates = list()
	var/list/yes_candidate = list()
	for(var/datum/antagonist/vampire as anything in GLOB.all_vampires)
		var/currentmob = vampire.owner?.current

		if(!isliving(currentmob)) //Are we mob/living?
			continue

		var/mob/living/livingmob = currentmob
		if(livingmob.health <= HEALTH_THRESHOLD_DEAD) // we check health instead of stat to avoid skipping out on vamps that are in torpor or something
			continue

		vampire_living_candidates += currentmob
	currently_polling = TRUE
	var/icon/prince_icon = icon('tff_modular/modules/vampire/icons/vampiric.dmi', "prince")
	for(var/mob/living/candidate in vampire_living_candidates)
		yes_candidate = SSpolling.poll_candidates(
			question = "You are eligible for princedom.",
			group = list(candidate),
			poll_time = 3 MINUTES,
			flash_window = TRUE,
			alert_pic = prince_icon,
			role_name_text = "Prince",
			start_signed_up = FALSE,
			announce_chosen = FALSE,
			custom_response_messages = list(
				POLL_RESPONSE_SIGNUP = "You have made your bid for princedom. <br>* Note: Princedom has certain expectations placed upon you. If you are not in a position to enforce the masquerade, consider letting someone else take this burden.",
				POLL_RESPONSE_UNREGISTERED = "You have removed your bid to princedom.",
			),
		)
	prince_icon.Scale(24, 24)
	currently_polling = FALSE
	var/mob/living/chosen_candidate
	if(length(yes_candidate))
		chosen_candidate = pick(yes_candidate)
		var/datum/antagonist/vampire/antag_datum = IS_VAMPIRE(chosen_candidate)
		antag_datum.princify()
	else
		time_to_wait = 30 MINUTES
