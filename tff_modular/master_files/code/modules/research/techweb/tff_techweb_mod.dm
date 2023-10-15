/datum/techweb_node/mod_rnd
	id = "mod_rnd"
	display_name = "MOD research and develop modular suits"
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
	prereq_ids = list("mod_advanced", "adv_engi")
	design_ids = list(
		"mod_toolarms_module",
		"mod_shock_protection_module",
		"mod_rpd_module",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/utility_effection_mod_module
	id = "effective_mod_utility_modules"
	display_name = "MOD part effective modules"
	description = "Utility modules, what can upgrade MOD part effective."
	prereq_ids = list("mod_advanced")
	design_ids = list(
		"mod_energy_eff_module",
		"mod_speed_eff_module",
		"mod_cc_eff_module",
		"mod_sprinter_module",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	discount_experiments = list(
		/datum/experiment/ordnance/gaseous/bz = 4000,
	)
