#define TECHWEB_NODE_MINERAL_MAGNET "mineral_magnet"

/datum/techweb_node/mineral_magnet
	id = TECHWEB_NODE_MINERAL_MAGNET
	display_name = "Mineral Magnet"
	description = "Studying magnetic technology to gain access to the asteroid attraction system."
	prereq_ids = list(TECHWEB_NODE_LOW_PRESSURE_EXCAVATION)
	design_ids = list(
		"magnetizer",
		"magnet_parts",
		"magnet_parts_small",
		"mining_magnet_board",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)

/obj/item/magnet_parts/construction/small
	name = "small mineral magnet parts"
	constructed_magnet = /obj/machinery/mining_magnet/small

/datum/design/magnetizer
	name = "Magnetizer"
	id = "magnetizer"
	build_type = PROTOLATHE
	materials = list(/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/magnetizer
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/magnet_parts
	name = "Magnet Parts"
	id = "magnet_parts"
	build_type = PROTOLATHE
	materials = list(/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 5, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 20)
	build_path = /obj/item/magnet_parts
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/magnet_parts_small
	name = "Small Magnet Parts"
	id = "magnet_parts_small"
	build_type = PROTOLATHE
	materials = list(/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 5, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 20)
	build_path = /obj/item/magnet_parts/small
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/mining_magnet_board
	name = "Mining Magnet Console Board"
	desc = "Allows for the construction of circuit boards used to build an Mining Magnet Console."
	id = "mining_magnet_board"//the coder reading this
	build_type = IMPRINTER
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/circuitboard/computer/mining_magnet
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
