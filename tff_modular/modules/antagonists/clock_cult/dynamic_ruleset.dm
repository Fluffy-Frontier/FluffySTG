/datum/dynamic_ruleset/roundstart/clock_cultist
	name = "Clockwork Cult"
	config_tag = "Roundstart Clockwork Cultist"
	pref_flag = ROLE_ROUNDSTART_CLOCK_CULTIST
	preview_antag_datum = /datum/antagonist/clock_cultist
	blacklisted_roles = list(
		JOB_AI,
		JOB_CAPTAIN,
		JOB_SECURITY_OFFICER,
		JOB_CHAPLAIN,
		JOB_CYBORG,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_WARDEN,
	)
	weight = 6
	min_pop = 20
	max_antag_cap = list("denominator" = 18)

/datum/dynamic_ruleset/roundstart/clock_cultist/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/clock_cultist/solo)

/datum/dynamic_ruleset/midround/clock_cultist
	name = "Midround Clockwork Cult"
	config_tag = "Midround Clockwork Cultist"
	pref_flag = ROLE_MIDROUND_CLOCK_CULTIST
	midround_type = LIGHT_MIDROUND
	preview_antag_datum = /datum/antagonist/clock_cultist
	blacklisted_roles = list(
		JOB_AI,
		JOB_CAPTAIN,
		JOB_SECURITY_OFFICER,
		JOB_CHAPLAIN,
		JOB_CYBORG,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_WARDEN,
	)
	weight = 6
	min_pop = 20
	max_antag_cap = list("denominator" = 18)
	repeatable_weight_decrease = 3

/datum/dynamic_ruleset/midround/clock_cultist/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/clock_cultist/solo)

/datum/dynamic_ruleset/roundstart/clock_cult
	name = "Clockwork Cult"
	config_tag = "Clockwork Cult"
	pref_flag = ROLE_ROUNDSTART_CLOCK_CULTIST
	ruleset_flags = RULESET_VARIATION | RULESET_HIGH_IMPACT
	preview_antag_datum = /datum/antagonist/clock_cultist
	blacklisted_roles = list(
		JOB_AI,
		JOB_CAPTAIN,
		JOB_SECURITY_OFFICER,
		JOB_CHAPLAIN,
		JOB_CYBORG,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_WARDEN,
	)
	weight = 1
	min_pop = 25
	max_antag_cap = list("denominator" = 18, "offset" = 1)
	repeatable = FALSE

/datum/dynamic_ruleset/roundstart/clock_cult/get_always_blacklisted_roles()
	return ..() | JOB_CHAPLAIN

/datum/dynamic_ruleset/roundstart/clock_cult/create_execute_args()
	return list(
		new /datum/team/clock_cult(),
		get_most_experienced(selected_minds, pref_flag),
	)

/datum/dynamic_ruleset/roundstart/clock_cult/execute()
	. = ..()
	// future todo, find a cleaner way to get this from execute args
	var/datum/team/clock_cult/main_cult = locate() in GLOB.antagonist_teams
	main_cult.setup_objectives()

/datum/dynamic_ruleset/roundstart/clock_cult/assign_role(datum/mind/candidate, datum/team/clock_cult/cult, datum/mind/most_experienced)
	candidate.add_antag_datum(/datum/antagonist/clock_cultist, cult)
