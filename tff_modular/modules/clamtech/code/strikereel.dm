/obj/vehicle/sealed/mecha/clam/strikereel
	desc = "A respectable platform made for ambushes... and occasionally hauling objectives. It's quite unpopular among clam warriors."
	name = "\improper Striker Eel"
	icon_state = "strikereel"
	base_icon_state = "strikereel"
	accesses = list(ACCESS_SYNDICATE) //cuz the main type doesn't seem to work
	movedelay = 3
	max_integrity = 380
	armor_type = /datum/armor/mecha_strikereel
	max_temperature = 30000
	wreckage = /obj/structure/mecha_wreckage/clam/strikereel
	mech_type = EXOSUIT_MODULE_STRIKEREEL
	force = 30
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	step_energy_drain = 1
	can_use_overclock = TRUE
	overclock_safety_available = TRUE
	overclock_safety = TRUE
	var/obj/item/mecha_parts/mecha_equipment/ejector/cargo_hold //REQUIRED for clamp to work

/datum/armor/mecha_strikereel
	melee = 50
	bullet = 60
	laser = 60
	energy = 60
	bomb = 50
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/clam/strikereel/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_smoke)
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_sensors)

/obj/vehicle/sealed/mecha/clam/strikereel/loaded
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot/clam,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/clam,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/thrusters/ion, /obj/item/mecha_parts/mecha_equipment/ejector),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster),
	)

/obj/vehicle/sealed/mecha/clam/strikereel/loaded/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/clam/strikereel/loaded/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/clam/strikereel
	name = "\improper Striker Eel wreckage"
	icon_state = "strikereel-broken"
	desc = "Tried to alpha strike, suffered an alpha stroke."

//LOTS of stolen code from Marauder mecha
//This action handles the toggleable thermal vision
/datum/action/vehicle/sealed/mecha/mech_sensors
	name = "Advanced sensors"
	button_icon_state = "mech_zoom_off"

/datum/action/vehicle/sealed/mecha/mech_sensors/Trigger(trigger_flags)
	if(!chassis || !(owner in chassis.occupants))
		REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_MECHA)
		owner.update_sight()
		return
	chassis.defense_mode = !chassis.defense_mode
	button_icon_state = "mech_zoom_[chassis.defense_mode ? "on" : "off"]"
	chassis.log_message("Toggled thermal sensors mode.", LOG_MECHA)
	to_chat(owner, "[icon2html(chassis, owner)]<font color='[chassis.defense_mode?"blue":"red"]'>IR sensors [chassis.defense_mode?"on":"off"]line.</font>")
	if(chassis.defense_mode)
		ADD_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_MECHA)
		owner.update_sight()
		SEND_SOUND(owner, sound('sound/vehicles/mecha/imag_enh.ogg', volume=50))
	else
		REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_MECHA)
		owner.update_sight()
	build_all_button_icons()

//Thus we finish the saga of free clam termals after forced removal. No more bugs hopefully.
/obj/vehicle/sealed/mecha/clam/strikereel/mob_exit(mob/M, silent = FALSE, randomstep = FALSE, forced = FALSE)
	REMOVE_TRAIT(M, TRAIT_THERMAL_VISION, TRAIT_MECHA)
	M.update_sight()
	defense_mode = FALSE
	..()
