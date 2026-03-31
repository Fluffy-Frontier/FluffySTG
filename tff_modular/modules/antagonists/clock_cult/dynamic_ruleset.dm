/*
/datum/dynamic_ruleset/roundstart/clock_cult
	name = "Clock Cult"
	config_tag = "Roundstart Clockwork Cult"
	antag_flag = ROLE_CLOCK_CULTIST
	antag_datum = /datum/antagonist/clock_cultist
	minimum_required_age = 14
	blacklisted_roles = list(
		JOB_AI,
		JOB_CAPTAIN,
		JOB_CHAPLAIN,
		JOB_CYBORG,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	min_antag_cap = 2
	max_antag_cap = list("denominator" = 20, "offset" = 1)
	weight = 3
	flags = HIGH_IMPACT_RULESET

	min_pop = 30

/datum/dynamic_ruleset/roundstart/clock_cult/prepare_for_role(datum/mind/candidate)
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(spawn_reebe))
*/
