/obj/item/weaponcrafting/gunkit/ebow
	name = "energy crossbow part kit (less lethal)"
	desc = "Highly illegal weapons refurbishment kit that allows you to turn the standard proto-kinetic accelerator into a near-duplicate energy crossbow. Almost like the real thing!"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)

/obj/item/weaponcrafting/gunkit/hellgun
	name = "hellfire laser gun degradation kit (warcrime lethal)"
	desc = "Take a perfectly functioning laser gun. Butcher the inside of the gun so it runs hot and mean. You now have a hellfire laser. You monster."

/obj/item/weaponcrafting/gunkit/photon
	name = "photon cannon parts kit (nonlethal)"
	desc = "A suitcase containing the necessary gun parts to construct a photon cannon around a stabilized flux anomaly. Harness the power of the sun, in the palms of your hands."
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5)


/obj/item/weaponcrafting/gunkit/nuclear
	name = "advanced energy gun parts kit (lethal/nonlethal)"
	desc = "A suitcase containing the necessary gun parts to transform a standard energy gun into an advanced energy gun."
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/weaponcrafting/gunkit/tesla
	name = "tesla cannon parts kit (lethal)"
	desc = "A suitcase containing the necessary gun parts to construct a tesla cannon around a stabilized flux anomaly. Handle with care."
	icon_state = "weaponskit_tesla"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/weaponcrafting/gunkit/xray
	name = "x-ray laser gun parts kit (lethal)"
	desc = "A suitcase containing the necessary gun parts to turn a laser gun into a x-ray laser gun. Do not point most parts directly towards face."
	custom_materials = list(
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)

/obj/item/weaponcrafting/gunkit/ion
	name = "ion carbine parts kit (nonlethal/highly destructive/very lethal (silicons))"
	desc = "A suitcase containing the necessary gun parts to transform a standard laser gun into a ion carbine. Perfect against lockers you don't have access to."
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/uranium = SHEET_MATERIAL_AMOUNT)

/obj/item/weaponcrafting/gunkit/temperature
	name = "temperature gun parts kit (less lethal/very lethal (lizardpeople))"
	desc = "A suitcase containing the necessary gun parts to transform a standard energy gun into a temperature gun. Fantastic at birthday parties and killing indigenous populations of lizardpeople."
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5)


/datum/crafting_recipe/advancedegun
	name = "Advanced Energy Gun"
	result = /obj/item/gun/energy/e_gun/nuclear
	reqs = list(
		/obj/item/gun/energy/e_gun = 1,
		/obj/item/weaponcrafting/gunkit/nuclear = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/advancedegun/New()
	LAZYADD(blacklist, typecacheof(/obj/item/gun/energy/e_gun, ignore_root_path = TRUE))
	return ..()

/datum/crafting_recipe/tempgun
	name = "Temperature Gun"
	result = /obj/item/gun/energy/temperature
	reqs = list(
		/obj/item/gun/energy/disabler = 1,
		/obj/item/weaponcrafting/gunkit/temperature = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/tempgun/New()
	LAZYADD(blacklist, typecacheof(/obj/item/gun/energy/e_gun, ignore_root_path = TRUE))
	return ..()


/datum/crafting_recipe/ebow
	name = "Energy Crossbow"
	result = /obj/item/gun/energy/recharge/ebow/large
	reqs = list(
		/obj/item/gun/energy/recharge/kinetic_accelerator = 1,
		/obj/item/weaponcrafting/gunkit/ebow = 1,
		/datum/reagent/uranium/radium = 15,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED


/datum/crafting_recipe/laser/xraylaser
	name = "X-ray Laser Gun"
	result = /obj/item/gun/energy/laser/xray
	reqs = list(
		/obj/item/gun/energy/laser = 1,
		/obj/item/weaponcrafting/gunkit/xray = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/laser/hellgun
	name = "Hellfire Laser Gun"
	result = /obj/item/gun/energy/laser/hellgun
	reqs = list(
		/obj/item/gun/energy/laser = 1,
		/obj/item/weaponcrafting/gunkit/hellgun = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/laser/ioncarbine
	name = "Ion Carbine"
	result = /obj/item/gun/energy/ionrifle/carbine
	reqs = list(
		/obj/item/gun/energy/laser = 1,
		/obj/item/weaponcrafting/gunkit/ion = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/teslacannon
	name = "Tesla Cannon"
	result = /obj/item/gun/energy/tesla_cannon
	reqs = list(
		/obj/item/assembly/signaler/anomaly/flux = 1,
		/obj/item/weaponcrafting/gunkit/tesla = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED


/datum/crafting_recipe/photoncannon
	name = "Photon Cannon"
	result = /obj/item/gun/energy/photon
	reqs = list(
		/obj/item/assembly/signaler/anomaly/flux = 1,
		/obj/item/weaponcrafting/gunkit/photon = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED


/datum/supply_pack/goody/hell_single_gunkit
	name = "Hellgun Kit Single-Pack"
	desc = "Contains one hellgun degradation kit, to convert regular laser guns into an older pattern of laser gun, \
		infamous for its ability to horribly disfigure targets with burns. \
		Technically violates the Space Geneva Convention when used on humanoids."
	cost = PAYCHECK_CREW * 2
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/weaponcrafting/gunkit/hellgun)

/obj/item/gun/energy/recharge/kinetic_accelerator/Initialize(mapload)
	. = ..()
	// Only actual KAs can be converted
	if(type != /obj/item/gun/energy/recharge/kinetic_accelerator)
		return
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/ebow)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)


/obj/item/gun/energy/laser/Initialize(mapload)
	. = ..()
	// Only regular lasguns can be slapcrafted
	if(type != /obj/item/gun/energy/laser)
		return
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/laser/xraylaser, /datum/crafting_recipe/laser/hellgun, /datum/crafting_recipe/laser/ioncarbine)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)


/datum/design/stunrevolver
	name = "Tesla Cannon Part Kit (Lethal)"
	desc = "The kit for a high-tech cannon that fires internal, reusable bolt cartridges in a revolving cylinder. The cartridges can be recharged using conventional rechargers."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcrafting/gunkit/tesla
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/nuclear_gun
	name = "Advanced Energy Gun Part Kit (Lethal/Nonlethal)"
	desc = "The kit for an energy gun with an experimental miniaturized reactor."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/uranium =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcrafting/gunkit/nuclear
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY


/datum/design/temp_gun
	name = "Temperature Gun Part Kit (Less Lethal/Very Lethal (Lizardpeople))"
	desc = "A gun that shoots temperature bullet energythings to change temperature."//Change it if you want
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/weaponcrafting/gunkit/temperature
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY


/datum/design/xray
	name = "X-ray Laser Gun Part Kit (Lethal)"
	desc = "Not quite as menacing as it sounds"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/gold =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2, /datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT, /datum/material/bluespace =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcrafting/gunkit/xray
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ioncarbine
	name = "Ion Carbine Part Kit (Nonlethal/Highly Destructive/Lethal (Silicons))"
	desc = "How to Dismantle a Cyborg: The Gun."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/uranium =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcrafting/gunkit/ion
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY


/datum/design/largecrossbow
	name = "Energy Crossbow Part Kit (Less Lethal/Contraband)"
	desc = "A kit to reverse-engineer a proto-kinetic accelerator into an energy crossbow, favored by syndicate infiltration teams and carp hunters."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/weaponcrafting/gunkit/ebow
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY


/datum/design/photon_cannon
	name = "Photon Cannon Part Kit (Nonlethal)"
	desc = "A kit to reverse-engineer a photon cannon, a weapon that generates a shortly-lived miniature sun. Technically brightens up the room, effectively blinds everyone in it. Requires a flux anomaly core to finish."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcrafting/gunkit/photon
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/obj/effect/spawner/armory_spawn/energyguns
	guns = list(
		/obj/item/gun/energy/e_gun,
		/obj/item/gun/energy/e_gun,
		/obj/item/gun/energy/e_gun,
	)

/obj/effect/spawner/armory_spawn/lasguns
	guns = list(
		/obj/item/gun/energy/laser,
		/obj/item/gun/energy/laser,
		/obj/item/gun/energy/laser,
	)

