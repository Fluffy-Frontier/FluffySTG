/datum/techweb_node/mod_rnd
	id = "mod_rnd"
	display_name = "RND Modular Suits"
	description = "RND modules and suits, provadet by Laplas anomalistic corporation."
	prereq_ids = list("bluespace_travel", "mod_advanced", "adv_engi")
	design_ids = list(
		"rnd_mod_plating",
		"rnd_module_part_replacer",
		"rnd_module_eperiscaner",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4500)
	discount_experiments = list(
		/datum/experiment/ordnance/gaseous/bz = 3000,
	)

/datum/techweb_node/advanced_mod_utility_modules
	id = "advanced_mod_utility_modules"
	display_name = "MOD advanced utility modules"
	description = "Advanced utility modules for MOD suits. Designed by Laplas anomalistic and nanotransen."
	prereq_ids = list("mod_advanced")
	design_ids = list(
		"mod_toolarms_module",
		"mod_rpd_module",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/cyborg_electrical_welding_tool
	id = "cyborg_welding_tool_electrical"
	display_name = "Cyborg electrical welding tool"
	prereq_ids = list("exp_tools", "cyborg_upg_engiminer")
	design_ids = list(
		"borg_electrical_welding_tool"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)

/datum/techweb_node/cyborg_electrical_welding_tool
	id = "item_painter"
	display_name = "Grimdye machine"
	design_ids = list(
		"itempainter"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500)
