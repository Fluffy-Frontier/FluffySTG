/obj/vehicle/sealed/mecha/clam/tideshark
	name = "\improper TideShark"
	desc = "A respectable, powerful ride, encased in powerful armor, often loaded with two twin ERPCs.  It can even break down walls! Many clam warriors want to pilot one of these; many more from outside the Clam territories wish to salvage one."
	icon_state = "tideshark"
	base_icon_state = "tideshark"
	accesses = list(ACCESS_SYNDICATE) //cuz the main type doesn't seem to work
	movedelay = 5
	max_integrity = 600
	armor_type = /datum/armor/mecha_tideshark
	max_temperature = 50000
	wreckage = /obj/structure/mecha_wreckage/clam/tideshark
	mech_type = EXOSUIT_MODULE_TIDESHARK
	force = 60
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 3,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	bumpsmash = TRUE

//Maybe we'll want to rebalance them later.
/datum/armor/mecha_tideshark
	melee = 50
	bullet = 60
	laser = 60
	energy = 60
	bomb = 50
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/clam/tideshark/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_zoom)

/obj/vehicle/sealed/mecha/clam/tideshark/loaded
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/ion/clam/twinlink,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/ion/clam/twinlink,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster),
	)

/obj/vehicle/sealed/mecha/clam/tideshark/loaded/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/clam/tideshark/loaded/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/clam/tideshark
	name = "\improper TideShark wreckage"
	icon_state = "tideshark-broken"
	desc = "There's always a bigger fish."