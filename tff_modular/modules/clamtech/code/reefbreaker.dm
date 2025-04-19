/obj/vehicle/sealed/mecha/clam/reefbreaker
	desc = "Fast, INSANELY FAST clam mecha. Don't let it get behind you - its' payload is deadly!"
	name = "\improper ReefBreaker"
	icon_state = "reefbreaker"
	base_icon_state = "reefbreaker"
	accesses = list(ACCESS_SYNDICATE) //cuz the main type doesn't seem to work
	movedelay = 1.5
	max_integrity = 250
	armor_type = /datum/armor/mecha_reefbreaker
	max_temperature = 15000
	wreckage = /obj/structure/mecha_wreckage/clam/reefbreaker
	mech_type = EXOSUIT_MODULE_REEFBREAKER
	force = 20 //No breaking walls
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	pivot_step = TRUE //So that piloting it is not fucking insufferable
	step_energy_drain = 1
	can_use_overclock = TRUE
	overclock_safety_available = TRUE
	overclock_safety = TRUE

//Maybe we'll want to rebalance them later.
/datum/armor/mecha_reefbreaker
	melee = 50
	bullet = 60
	laser = 60
	energy = 60
	bomb = 50
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/clam/reefbreaker/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_zoom)

/obj/vehicle/sealed/mecha/clam/reefbreaker/loaded
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/clam/rapid,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/clam,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster),
	)

/obj/vehicle/sealed/mecha/clam/reefbreaker/loaded/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/clam/reefbreaker/loaded/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/clam/reefbreaker
	name = "\improper ReefBreaker wreckage"
	icon_state = "reefbreaker-broken"
	desc = "It broke as it hit the reef."
