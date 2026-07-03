/// TGMC_XENOS (old nova sector xenos)

/datum/dynamic_ruleset/midround/from_ghosts/xenomorph/tgmc
	name = "TGMC Alien Infestation"
	config_tag = "XenomorphTGMC"
	ruleset_flags = parent_type::ruleset_flags | RULESET_VARIATION

/datum/dynamic_ruleset/midround/from_ghosts/xenomorph/tgmc/create_ruleset_body()
	return new /mob/living/carbon/alien/larva/tgmc

/datum/dynamic_ruleset/midround/from_ghosts/xenomorph/tgmc/announce_xenos()
	priority_announce("Unusual, highly active unidentified biological signatures detected boarding [station_name()]. All personnel must report irregular movement through maintenance corridors and environmental systems. Maintain vigilance and monitor for breaches.", "Lifesign Alert", ANNOUNCER_ALIENS)
