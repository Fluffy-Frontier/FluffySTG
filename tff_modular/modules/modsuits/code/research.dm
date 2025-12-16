/datum/techweb_node/mod_basic_combat
	id = "basic_combat_modules"
	display_name = "Combat modular suits"
	description = "Combat mod suit modules."
	prereq_ids = list(TECHWEB_NODE_MOD_SECURITY, TECHWEB_NODE_RIOT_SUPRESSION, TECHWEB_NODE_MOD_ENGI_ADV)
	design_ids = list(
		"mod_energy_spear",
		"mod_brace_shield",
		"mod_energy_canon",
		"mod_blade",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_SECURITY)

/datum/techweb_node/mod_engi_stasis
	id = "mod_stasis_module"
	display_name = "Stasis module"
	description = "A module capable of slowing down matter on a physical level."
	prereq_ids = list(TECHWEB_NODE_MOD_ENGI_ADV)
	design_ids = list("mod_stasis")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/mod_engi_applied
	id = "mod_eng_applied"
	display_name = "Applied engineering modules"
	description = "Leading-edge engineering modules."
	prereq_ids = list(TECHWEB_NODE_MOD_ENGI_ADV)
	design_ids = list(
		"mod_engineering_robotic_arms",
		"mod_robotic_arm",
		"mod_rpd",
		"mod_electrocute_absorber",
		"mod_smevac",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/mod_general_advanced
	id = "mod_general_advanced"
	display_name = "Advanced general modules"
	description = "Advanced general-purpose modules aimed at optimizing usage."
	prereq_ids = list(TECHWEB_NODE_MOD_ENGI_ADV)
	design_ids = list(
		"mod_sprinter",
		"mod_enr_eff",
		"mod_speed_eff",
		"mod_complexity_eff",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mod_suits_research
	id = "mod_research_modsuits"
	display_name = "Science Modular modsuits"
	description = "Advanced MOD suits designed for use in harsh environments."
	prereq_ids = list(TECHWEB_NODE_MOD_ENGI_ADV)
	design_ids = list(
		"mod_plating_research",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mod_anomaly_neutrilizer
	id = "mod_module_neutrilizer"
	display_name = "Anomaly Neutrilizer Module"
	description = "A high-tech module designed for active combat and suppression of anomalies."
	prereq_ids = list("mod_research_modsuits", TECHWEB_NODE_MOD_ANOMALY)
	design_ids = list(
		"mod_neutrilizer",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/mod_energy_shield
	id = "mod_module_energy_shield"
	display_name = "An cutting-edge module that provides users with absolute protection from external influences."
	prereq_ids = list("basic_combat_modules", TECHWEB_NODE_SYNDICATE_BASIC)
	design_ids = list(
		"mod_energy_shield",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
