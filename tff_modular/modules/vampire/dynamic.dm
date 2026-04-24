/datum/dynamic_ruleset/roundstart/vampire
	name = "Vampire"
	config_tag = "Vampire"
	pref_flag = ROLE_VAMPIRE
	preview_antag_datum = /datum/antagonist/vampire
	weight = 6
	max_antag_cap = 4
	min_pop = 15

/datum/dynamic_ruleset/roundstart/vampire/is_valid_candidate(mob/candidate, client/candidate_client)
	if(is_species(candidate, BLOODSUCKER_RESTRICTED_SPECIES))
		return FALSE
	return ..()

/datum/dynamic_ruleset/roundstart/vampire/assign_role(datum/mind/candidate)
	var/datum/antagonist/vampire/suck_datum = candidate.add_antag_datum(/datum/antagonist/vampire)
	suck_datum.rank_up(VAMPIRE_STARTING_LEVELS)

/datum/dynamic_ruleset/midround/from_living/vampire
	name = "Vampiric Accident"
	config_tag = "Vampiric Accident"
	preview_antag_datum = /datum/antagonist/vampire
	pref_flag = ROLE_VAMPIRIC_ACCIDENT
	midround_type = LIGHT_MIDROUND
	weight = 6
	repeatable = TRUE
	max_antag_cap = 4
	min_pop = 15

/datum/dynamic_ruleset/midround/from_living/vampire/is_valid_candidate(mob/candidate, client/candidate_client)
	if(is_species(candidate, BLOODSUCKER_RESTRICTED_SPECIES))
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_living/vampire/assign_role(datum/mind/candidate)
	var/datum/antagonist/vampire/suck_datum = candidate.add_antag_datum(/datum/antagonist/vampire)
	suck_datum.rank_up(VAMPIRE_STARTING_LEVELS)

/datum/dynamic_ruleset/latejoin/vampire
	name = "Vampiric Accident"
	config_tag = "Vampiric LateJoin"
	preview_antag_datum = /datum/antagonist/vampire
	pref_flag = ROLE_VAMPIRE_LATEJOIN
	weight = 10
	repeatable = TRUE
	max_antag_cap = 4
	min_pop = 15

/datum/dynamic_ruleset/latejoin/vampire/is_valid_candidate(mob/candidate, client/candidate_client)
	if(is_species(candidate, BLOODSUCKER_RESTRICTED_SPECIES))
		return FALSE
	return ..()
