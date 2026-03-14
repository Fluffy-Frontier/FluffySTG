/datum/dynamic_ruleset/roundstart/vampire
	name = "Vampire"
	config_tag = "Vampire"
	pref_flag = ROLE_VAMPIRE
	preview_antag_datum = /datum/antagonist/vampire
	weight = 10
	max_antag_cap = 4

/datum/dynamic_ruleset/roundstart/vampire/assign_role(datum/mind/candidate)
	var/datum/antagonist/vampire/suck_datum = candidate.add_antag_datum(/datum/antagonist/vampire)
	suck_datum.rank_up(rand(3, 4))

/datum/dynamic_ruleset/midround/from_living/vampire
	name = "Vampiric Accident"
	config_tag = "Vampiric Accident"
	preview_antag_datum = /datum/antagonist/vampire
	pref_flag = ROLE_VAMPIRIC_ACCIDENT
	midround_type = LIGHT_MIDROUND
	weight = 10
	repeatable = TRUE
	max_antag_cap = 4

/datum/dynamic_ruleset/midround/from_living/vampire/is_valid_candidate(mob/candidate, client/candidate_client)
	if(!is_station_level(candidate.z))
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_living/vampire/assign_role(datum/mind/candidate)
	var/datum/antagonist/vampire/suck_datum = candidate.add_antag_datum(/datum/antagonist/vampire)
	suck_datum.rank_up(rand(3, 4))
