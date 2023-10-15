/datum/design/mod_plating/rnd
	name = "RND MOD suit plating"
	desc = "A special RND design MOD suit, by Laplas anomalistic."
	id = "rnd_mod_plating"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 4, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 4, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/mod/construction/plating/rnd
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/module/mod_part_replacer
	name = "MOD part replacer module"
	id = "rnd_module_part_replacer"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/mod/module/itemgive/part_replacer
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/module/mod_experiscaner
	name = "MOD research scaner module"
	id = "rnd_module_eperiscaner"
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4)
	build_path = /obj/item/mod/module/itemgive/experiscanner
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/module/mod_toolarm
	name = "MOD tool arms modules"
	id = "mod_toolarms_module"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 4, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/mod/module/itemgive/tool_arms
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/module/mod_rpd
	name = "MOD RPD module"
	id = "mod_rpd_module"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/mod/module/itemgive/rpd
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/module/mod_module_shock_protect
	name = "MOD shock protection module"
	id = "mod_shock_protection_module"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/mod/module/energy_effective
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/module/mod_energy_effective
	name = "MOD energy effective module"
	id = "mod_energy_eff_module"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/mod/module/energy_effective
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/module/mod_speed_effective
	name = "MOD speed effective module"
	id = "mod_speed_eff_module"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/mod/module/movemenet_effective
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/module/mod_cc_effective
	name = "MOD complexity effective module"
	id = "mod_cc_eff_module"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/mod/module/complexity_effective
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/module/sprinter
	name = "MOD sprinter module"
	id = "mod_sprinter_module"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 4, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 4)
	build_path = /obj/item/mod/module/sprinter
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)
