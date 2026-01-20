/datum/dynamic_ruleset/latejoin/bloodsucker
	name = "Bloodsucker Breakout"
	config_tag = "Latejoin Bloodsucker"
	preview_antag_datum = /datum/antagonist/bloodsucker
	pref_flag = ROLE_BLOODSUCKERBREAKOUT
	jobban_flag = ROLE_BLOODSUCKER
	weight = 5
	repeatable = FALSE

/datum/dynamic_ruleset/latejoin/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.RankUp()

/datum/dynamic_ruleset/midround/from_living/bloodsucker
	name = "Vampiric Accident"
	config_tag = "Midround Bloodsucker"
	preview_antag_datum = /datum/antagonist/bloodsucker
	pref_flag = ROLE_VAMPIRICACCIDENT
	jobban_flag = ROLE_BLOODSUCKER
	midround_type = LIGHT_MIDROUND
	weight = 10
	repeatable = TRUE

/datum/dynamic_ruleset/midround/from_living/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	if(!is_station_level(candidate.z))
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_living/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.RankUp()

/datum/dynamic_ruleset/roundstart/bloodsucker
	name = "bloodsuckers"
	config_tag = "Roundstart Bloodsucker"
	pref_flag = ROLE_BLOODSUCKER
	preview_antag_datum = /datum/antagonist/bloodsucker
	ruleset_flags = RULESET_VARIATION
	jobban_flag = ROLE_BLOODSUCKER
	weight = 10
	max_antag_cap = list("denominator" = 24)

/datum/dynamic_ruleset/roundstart/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.RankUp()
