///Legacy name - now refers to the time between free levels for vampires.
#define TIME_BLOODSUCKER_NIGHT 600

SUBSYSTEM_DEF(sol)
	name = "Sol"
	can_fire = FALSE
	wait = 20 // ticks, not seconds (so this runs every second, actually)
	flags = SS_NO_INIT | SS_BACKGROUND | SS_TICKER | SS_KEEP_TIMING

	///The time between the next cycle.
	var/time_til_cycle = TIME_BLOODSUCKER_NIGHT
	///If Bloodsucker levels for the night has been given out yet.
	var/issued_XP = FALSE

/datum/controller/subsystem/sol/Recover()
	can_fire = SSsol.can_fire
	time_til_cycle = SSsol.time_til_cycle
	issued_XP = SSsol.issued_XP

/datum/controller/subsystem/sol/fire(resumed = FALSE)
	time_til_cycle--

	if (time_til_cycle > 0 && time_til_cycle <= 15)
		if (!issued_XP)
			issued_XP = TRUE
			SEND_SIGNAL(src, COMSIG_SOL_RANKUP_BLOODSUCKERS)

	if (time_til_cycle < 1)
		issued_XP = FALSE
		time_til_cycle = TIME_BLOODSUCKER_NIGHT

#undef TIME_BLOODSUCKER_NIGHT

SUBSYSTEM_DEF(vsociety)
	name = "Vampire Society"
	wait = 5 MINUTES
	flags = SS_NO_INIT | SS_BACKGROUND
	can_fire = FALSE

	var/pooling = FALSE

	var/datum/weakref/princedatum

	var/start_time = 0

/datum/controller/subsystem/vsociety/fire(resumed = FALSE)
	var/time_elapsed = world.time - start_time

	if(time_elapsed < 9 MINUTES)
		return

	if(!princedatum && !pooling)
		for(var/datum/antagonist/vampire as anything in GLOB.all_vampires)
			to_chat(vampire.owner.current, span_announce("*Vampire Tip: A vote for Prince will occur soon. If you are interested in leading your fellow kindred, press voting button!"))
		addtimer(CALLBACK(src, PROC_REF(poll_for_prince)), 2 MINUTES)
		message_admins("Vampire Society has fired, and a prince poll will occur in 2 minutes.")
		log_game("Vampire society has fired, and a prince poll will occur soon.")

/datum/controller/subsystem/vsociety/proc/poll_for_prince()
	message_admins("Vampire society is now polling for a new prince.")
	log_game("Vampire society is now polling for a new prince.")

	var/list/vampire_living_candidates = list()

	for(var/datum/antagonist/vampire as anything in GLOB.all_vampires)
		var/currentmob = vampire.owner?.current

		if(!isliving(currentmob))
			continue

		var/mob/living/livingmob = currentmob
		if(livingmob.health <= HEALTH_THRESHOLD_DEAD)
			continue

		vampire_living_candidates += currentmob

	pooling = TRUE
	var/icon/prince_icon = icon('tff_modular/modules/bloodsucker/icons/bloodsucker.dmi', "prince")
	prince_icon.Scale(24, 24)
	var/list/poolers = SSpolling.poll_candidates(
		"You are eligible for princedom.",
		poll_time = 3 MINUTES,
		flash_window = TRUE,
		group = vampire_living_candidates,
		alert_pic = prince_icon,
		role_name_text = "Prince",
		custom_response_messages = list(
			POLL_RESPONSE_SIGNUP = "You have made your bid for princedom. <br>* Note: Princedom has certain expectations placed upon you. If you are not in a position to enforce a masquerade, consider letting someone else take this burden.",
			POLL_RESPONSE_UNREGISTERED = "You have removed your bid to princedom.",
		),
		amount_to_pick = length(GLOB.all_vampires),
		announce_chosen = FALSE,
	)
	pooling = FALSE

	var/datum/antagonist/bloodsucker/chosen_datum
	var/mob/living/chosen_candidate
	// We have to do this shit because the polling proc doesn't always return a list. Sometimes it just returns a mob.
	var/list/candidates = list()
	candidates += poolers

	for(var/mob/living/current_candidate in candidates)
		var/datum/antagonist/bloodsucker/current_datum = IS_BLOODSUCKER(current_candidate)
		if(!chosen_candidate)
			chosen_candidate = current_candidate
			chosen_datum = IS_BLOODSUCKER(current_candidate)
			continue
		if(current_datum.get_princely_score() >= chosen_datum.get_princely_score())
			chosen_candidate = current_candidate
			chosen_datum = IS_BLOODSUCKER(current_candidate)

		if(chosen_datum)
			chosen_datum.princify()




/datum/antagonist/bloodsucker/proc/check_start_society()
	if(SSvsociety.can_fire)
		return
	if(length(GLOB.all_vampires) >= 3)
		SSvsociety.start_time = world.time
		SSvsociety.can_fire = TRUE
		message_admins("Vampire Society has started, as there are [length(GLOB.all_vampires)] vampires active.")
		log_game("Vampire Society has started, as there are [length(GLOB.all_vampires)] vampires active.")

/datum/antagonist/bloodsucker/proc/check_cancel_society()
	if(!SSvsociety.can_fire)
		return
	if(length(GLOB.all_vampires) < 3)
		SSvsociety.can_fire = FALSE
		message_admins("Vampire Society has paused, as there are only [length(GLOB.all_vampires)] vampires active.")
		log_game("Vampire Society has paused, as there are only [length(GLOB.all_vampires)] vampires active.")

/datum/antagonist/bloodsucker/proc/princify()
	SSvsociety.princedatum = WEAKREF(src)
	AdjustUnspentRank(8)
	to_chat(owner.current, span_cult_bold("As a true prince, you find some of your old power returning to you!"))
	owner.current.playsound_local(null, 'tff_modular/modules/bloodsucker/sound/prince.ogg', 100, FALSE, pressure_affected = FALSE)
	prince = TRUE
	add_team_hud(owner.current)

	var/full_name = return_full_name()
	for(var/datum/antagonist/vampire as anything in GLOB.all_vampires)
		to_chat(vampire.owner.current, span_narsiesmall("[full_name], also known as [owner.name || owner.current.real_name || owner.current.name], has claimed the role of Prince!"))

	BuyPower(/datum/action/cooldown/bloodsucker/targeted/scourgify)

	var/datum/objective/bloodsucker/prince/prince_objective = new()
	objectives += prince_objective
	owner.announce_objectives()

	message_admins("[ADMIN_LOOKUP(owner.current)] has received the role of Vampire Prince. ([get_princely_score()] princely score, with [my_clan?.princely_score_bonus]/[min(50, owner.current?.client?.get_exp_living(TRUE) / 60) / 10] clan/hour bonus.)")
	log_game("[key_name(owner.current)] has become the Vampire Prince. ([get_princely_score()] princely score, with [my_clan?.princely_score_bonus]/[min(50, owner.current?.client?.get_exp_living(TRUE) / 60) / 10] clan/hour bonus.)")

	notify_ghosts(
		"[owner.name] has become the Bloodsucker Prince!",
		source = owner.current,
		header = "All hail the Prince!"
	)

	update_static_data_for_all_viewers()
	tgui_alert(owner.current, "Congratulations, you have been chosen for Princedom.\nPlease note that this entails a certain responsibility. Your job, now, is to keep order, and to enforce the masquerade.", "Welcome, my Prince.", list("I understand"), 30 SECONDS, TRUE)

/datum/antagonist/bloodsucker/proc/scourgify()
	ASSERT(!prince, "Somehow a prince was going to be turned into a scourge")
	AdjustUnspentRank(4)
	to_chat(owner.current, span_cult_bold("As a Camarilla scourge, your newfound purpose empowers you!"))
	owner.current.playsound_local(null, 'tff_modular/modules/bloodsucker/sound/scourge_recruit.ogg', 100, FALSE, pressure_affected = FALSE)
	scourge = TRUE
	add_team_hud(owner.current)
	var/datum/objective/bloodsucker/scourge/scourge_objectives = new()
	objectives += scourge_objectives
	owner.announce_objectives()

	for(var/datum/antagonist/bloodsucker as anything in GLOB.all_vampires)
		to_chat(bloodsucker.owner.current, span_cult_bold(span_big("Under authority of the Prince, [owner.name || owner.current.real_name || owner.current.name] has been raised to the duty of the Scourge!")))
	message_admins("[ADMIN_LOOKUPFLW(owner.current)] has been made a Scourge of the Bloodsuckers!")
	log_game("[key_name(owner.current)] has become a Scourge of the Bloodsuckers.")

	notify_ghosts(
		"[owner.name] has been raised to the duty Scourge of the Bloodsuckers!",
		source = owner.current,
		header = "All hail the Prince!",
	)

	update_static_data_for_all_viewers()

/datum/antagonist/bloodsucker/proc/get_princely_score()
	var/calculated_hour_score = min(50, owner.current?.client?.get_exp_living(TRUE) / 60) / 10
	var/clan_bonus = my_clan?.princely_score_bonus || -10

	return clan_bonus + calculated_hour_score

/datum/objective/bloodsucker/scourge
	name = "Camarilla Scourge"
	explanation_text = "Obey your prince! Ensure order! Safeguard the Masquerade!"
	completed = TRUE

/datum/objective/bloodsucker/prince
	name = "Camarilla Prince"
	explanation_text = "Rule your fellow kindred with an iron fist! Ensure the sanctity of the Masquerade, at ALL costs!"
	completed = TRUE
