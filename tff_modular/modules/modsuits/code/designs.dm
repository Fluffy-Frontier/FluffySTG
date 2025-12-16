/datum/design/module/mod_stasis
	name = "Stasis module"
	id = "mod_stasis"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium =SMALL_MATERIAL_AMOUNT*3,
	)
	build_path = /obj/item/mod/module/stasis
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)

/datum/design/module/mod_laser_gun
	name = "Energy canon module"
	id = "mod_energy_canon"
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*10,
		/datum/material/silver =SHEET_MATERIAL_AMOUNT*2,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT*4,
		/datum/material/uranium =SHEET_MATERIAL_AMOUNT*2,
	)
	build_path = /obj/item/mod/module/energy_gun
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)


/datum/design/module/mod_energy_spear
	name = "Energy spear module"
	id = "mod_energy_spear"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*2,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*2,
	)
	build_path = /obj/item/mod/module/energy_spear
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)

/datum/design/module/mod_brace_shield
	name = "Brace shield module"
	id = "mod_brace_shield"
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*10,
		/datum/material/silver =SHEET_MATERIAL_AMOUNT*2,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT*2,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*2,
		/datum/material/plastic =SHEET_MATERIAL_AMOUNT*4,
	)
	build_path = /obj/item/mod/module/mod_shield
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)

/datum/design/module/mod_blade
	name = "Blade module"
	id = "mod_blade"
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*4,
		/datum/material/silver =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/diamond =SMALL_MATERIAL_AMOUNT*4,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*4,
	)
	build_path = /obj/item/mod/module/mob_blade
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)

/datum/design/module/mod_robotic_arms_engineerings
	name = "Engineering robotic arms module"
	id = "mod_engineering_robotic_arms"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*3,
		/datum/material/diamond =SMALL_MATERIAL_AMOUNT*2,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*2,
	)
	build_path = /obj/item/mod/module/robotic_arm/engineering
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)

/datum/design/module/mod_robotic_arms
	name = "Robotic arm module"
	id = "mod_robotic_arm"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*3,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*3,
	)
	build_path = /obj/item/mod/module/robotic_arm/workarm
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)

/datum/design/module/mod_rpd
	name = "RPD module"
	id = "mod_rpd"
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*37.5,
		/datum/material/glass=SHEET_MATERIAL_AMOUNT*18.75,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*3,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*3,
	)
	build_path = /obj/item/mod/module/mod_rpd
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)

/datum/design/module/mod_electrocute_immune
	name = "Electrocute absorber module"
	id = "mod_electrocute_absorber"
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/glass=SHEET_MATERIAL_AMOUNT*1,
		/datum/material/silver=SMALL_MATERIAL_AMOUNT*6,
		/datum/material/gold=SMALL_MATERIAL_AMOUNT*4,
		/datum/material/diamond=SHEET_MATERIAL_AMOUNT*2,
	)
	build_path = /obj/item/mod/module/electrocute_absorber
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)

/datum/design/module/mod_smimmune
	name = "Supermatter evacuation module"
	id = "mod_smevac"
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*1,
		/datum/material/silver=SMALL_MATERIAL_AMOUNT*6,
		/datum/material/gold=SMALL_MATERIAL_AMOUNT*6,
		/datum/material/diamond=SHEET_MATERIAL_AMOUNT*2,
		/datum/material/bluespace=SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/cascade_evacuation
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)

/datum/design/module/mod_sprinter
	name = "Sprinter module"
	id = "mod_sprinter"
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*2,
		/datum/material/silver=SMALL_MATERIAL_AMOUNT*4,
		/datum/material/gold=SMALL_MATERIAL_AMOUNT*2,
		/datum/material/diamond=SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/sprinter
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/module/mod_enr_eff
	name = "Energy effective module"
	id = "mod_enr_eff"
	materials = list(
		/datum/material/iron=SMALL_MATERIAL_AMOUNT*2,
		/datum/material/silver=SMALL_MATERIAL_AMOUNT*2,
		/datum/material/gold=SMALL_MATERIAL_AMOUNT*4,
	)
	build_path = /obj/item/mod/module/energy_effective
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/module/mod_speed_eff
	name = "Movement effective module"
	id = "mod_speed_eff"
	materials = list(
		/datum/material/iron=SMALL_MATERIAL_AMOUNT*2,
		/datum/material/silver=SMALL_MATERIAL_AMOUNT*4,
		/datum/material/gold=SMALL_MATERIAL_AMOUNT*4,
		/datum/material/diamond=SHEET_MATERIAL_AMOUNT*4,
	)
	build_path = /obj/item/mod/module/movemenet_effective
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/module/mod_complexity_eff
	name = "Complexity effective module"
	id = "mod_complexity_eff"
	materials = list(
		/datum/material/iron=SMALL_MATERIAL_AMOUNT*2,
		/datum/material/silver=SMALL_MATERIAL_AMOUNT*6,
		/datum/material/gold=SMALL_MATERIAL_AMOUNT*4,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT*4,
	)
	build_path = /obj/item/mod/module/complexity_effective
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/module/mod_neutrilizer
	name = "Anomaly neutrilizer module"
	id = "mod_neutrilizer"
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*4,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
		/datum/material/gold=SMALL_MATERIAL_AMOUNT*6,
		/datum/material/uranium=HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond=SMALL_MATERIAL_AMOUNT*3,
		/datum/material/bluespace=SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/anomaly_locked/anomaly_neutralizer
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SCIENCE
	)

/datum/design/mod_plating/rnd
	name = "MOD Research Plating"
	id = "mod_plating_research"
	build_path = /obj/item/mod/construction/plating/rnd
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*4,
		/datum/material/gold =SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
	research_icon = 'tff_modular/modules/modsuits/icons/items/mod_items.dmi'
	research_icon_state = "rnd-plating"

/datum/design/module/mod_anomaly_neutrilizer
	name = "Anomaly neutrilizer module"
	id = "mod_energy_shield"
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*2,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT,
		/datum/material/gold=SMALL_MATERIAL_AMOUNT*6,
		/datum/material/diamond=SMALL_MATERIAL_AMOUNT*4,
		/datum/material/bluespace=SHEET_MATERIAL_AMOUNT*2,
	)
	build_path = /obj/item/mod/module/advanced_energy_shield/nanotrasen
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUITS_MISC
	)

