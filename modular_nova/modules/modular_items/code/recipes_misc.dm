/datum/crafting_recipe/makeshift/crowbar
	name = "Makeshift Crowbar"
	result = /obj/item/crowbar/makeshift
	reqs = list(
		/obj/item/stack/sheet/iron = 4,
		/obj/item/stack/sheet/cloth = 1,
	)
	time = 60
	category = CAT_MISC

/datum/crafting_recipe/makeshift/screwdriver
	name = "Makeshift Screwdriver"
	tool_paths = list(/obj/item/crowbar/makeshift)
	result = /obj/item/screwdriver/makeshift
	reqs = list(
		/obj/item/stack/sheet/cloth = 2,
		/obj/item/stack/rods = 2,
	)
	time = 60
	category = CAT_MISC

/datum/crafting_recipe/makeshift/welder
	name = "Makeshift Welder"
	tool_paths = list(/obj/item/crowbar/makeshift)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/weldingtool/makeshift
	reqs = list(
		/obj/item/tank/internals/emergency_oxygen = 1,
		/obj/item/stack/sheet/iron = 6,
		/obj/item/lighter = 1,
	)
	time = 60
	category = CAT_MISC

/datum/crafting_recipe/makeshift/wirecutters
	name = "Makeshift Wirecutters"
	tool_paths = list(/obj/item/crowbar/makeshift)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	result = /obj/item/wirecutters/makeshift
	reqs = list(/obj/item/stack/rods = 4)
	time = 60
	category = CAT_MISC

/datum/crafting_recipe/makeshift/wrench
	name = "Makeshift Wrench"
	tool_paths = list(/obj/item/crowbar/makeshift)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	result = /obj/item/wrench/makeshift
	reqs = list(
		/obj/item/stack/sheet/iron = 3,
		/obj/item/stack/rods = 1,
		/obj/item/stack/sheet/cloth = 2,
	)
	time = 60
	category = CAT_MISC
