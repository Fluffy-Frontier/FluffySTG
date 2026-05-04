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
