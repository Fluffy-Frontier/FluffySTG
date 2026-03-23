#define ROLE_MIDROUND_HERETIC "Midround Heretic"

/datum/dynamic_ruleset/midround/from_living/heretic
	name = "Midround Heretic"
	config_tag = "Midround Heretic"
	preview_antag_datum = /datum/antagonist/heretic
	pref_flag = ROLE_MIDROUND_HERETIC
	jobban_flag = ROLE_HERETIC
	weight = 10
	min_pop = 15
	midround_type = LIGHT_MIDROUND

/datum/dynamic_ruleset/midround/from_living/heretic/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/heretic)
