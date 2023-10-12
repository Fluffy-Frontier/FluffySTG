/datum/design/borg_electrical_welding_tool
	name = "Electical welding tool"
	id = "borg_electrical_welding_tool"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/cyborg_electical_welding_tool
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*1, /datum/material/glass =SHEET_MATERIAL_AMOUNT*2, /datum/material/diamond =SHEET_MATERIAL_AMOUNT)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)
