/obj/vehicle/sealed/mecha/clam/kelpwulp
	desc = "Fast, durable, powerful - this suit is considered by many to be the best one Clams have engineered. It's also the most visually appealing one."
	name = "\improper Kelp Wulp"
	icon_state = "kelpwulp"
	base_icon_state = "kelpwulp"
	accesses = list(ACCESS_SYNDICATE) //cuz the main type doesn't seem to work
	movedelay = 3
	max_integrity = 450
	armor_type = /datum/armor/mecha_kelpwulp
	max_temperature = 30000
	wreckage = /obj/structure/mecha_wreckage/clam/kelpwulp
	mech_type = EXOSUIT_MODULE_KELPWULP
	force = 40
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)

//Maybe we'll want to rebalance them later.
/datum/armor/mecha_kelpwulp
	melee = 50
	bullet = 60
	laser = 60
	energy = 60
	bomb = 50
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/clam/kelpwulp/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_zoom)
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/lurm_strike)

/obj/vehicle/sealed/mecha/clam/kelpwulp/loaded
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy/clam,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy/clam,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster),
	)

/obj/vehicle/sealed/mecha/clam/kelpwulp/loaded/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/clam/kelpwulp/loaded/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/clam/kelpwulp
	name = "\improper Kelp Wulp wreckage"
	icon_state = "kelpwulp-broken"
	desc = "Invasion's over, go home."

//LOTS of stolen code from Ivanov mecha
//Mostly for customization

/**
 * ## reset_button_icon
 *
 * called after an addtimer when the cooldown is finished with the skyfall, resets the icon
 */
/datum/action/vehicle/sealed/mecha/lurm_strike/proc/reset_button_icon()
	button_icon_state = "mech_ivanov"
	build_all_button_icons()

/datum/action/vehicle/sealed/mecha/lurm_strike
	name = "LRM Strike"
	button_icon_state = "mech_ivanov"
	///cooldown time between strike uses
	var/strike_cooldown_time = 20 SECONDS
	///how many rockets can we send with ivanov strike
	var/rockets_left = 0
	var/aiming_missile = FALSE

/datum/action/vehicle/sealed/mecha/lurm_strike/Destroy()
	if(aiming_missile)
		end_missile_targeting()
	return ..()

/datum/action/vehicle/sealed/mecha/lurm_strike/Trigger(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return
	if(TIMER_COOLDOWN_RUNNING(chassis, COOLDOWN_MECHA_MISSILE_STRIKE))
		var/timeleft = S_TIMER_COOLDOWN_TIMELEFT(chassis, COOLDOWN_MECHA_MISSILE_STRIKE)
		to_chat(owner, span_warning("You need to wait [DisplayTimeText(timeleft, 1)] before firing another LRM Strike."))
		return
	if(aiming_missile)
		end_missile_targeting()
	else
		start_missile_targeting()

/**
 * ## start_missile_targeting
 *
 * Called by the ivanov strike datum action, hooks signals into clicking to call drop_missile
 * Plus other flavor like the overlay
 */
/datum/action/vehicle/sealed/mecha/lurm_strike/proc/start_missile_targeting()
	chassis.balloon_alert(owner, "missile mode on (click to target)")
	aiming_missile = TRUE
	rockets_left = 5
	RegisterSignal(chassis, COMSIG_MECHA_MELEE_CLICK, PROC_REF(on_melee_click))
	RegisterSignal(chassis, COMSIG_MECHA_EQUIPMENT_CLICK, PROC_REF(on_equipment_click))
	owner.client.mouse_override_icon = 'icons/effects/mouse_pointers/supplypod_down_target.dmi'
	owner.update_mouse_pointer()
	owner.overlay_fullscreen("lurm", /atom/movable/screen/fullscreen/ivanov_display/clam, 5)
	SEND_SOUND(owner, 'tff_modular/modules/clamtech/sounds/lurm_disp.ogg') //spammable so I don't want to make it audible to anyone else

/**
 * ## end_missile_targeting
 *
 * Called by the ivanov strike datum action or other actions that would end targeting
 * Unhooks signals into clicking to call drop_missile plus other flavor like the overlay
 */
// Yarr, pirate me some code to customize!
/datum/action/vehicle/sealed/mecha/lurm_strike/proc/end_missile_targeting()
	owner.clear_fullscreen("lurm")
	aiming_missile = FALSE
	rockets_left = 0
	UnregisterSignal(chassis, list(COMSIG_MECHA_MELEE_CLICK, COMSIG_MECHA_EQUIPMENT_CLICK))
	owner.client.mouse_override_icon = null
	owner.update_mouse_pointer()

///signal called from clicking with no equipment
/datum/action/vehicle/sealed/mecha/lurm_strike/proc/on_melee_click(datum/source, mob/living/pilot, atom/target, on_cooldown, is_adjacent)
	SIGNAL_HANDLER
	if(!target)
		return
	drop_missile(get_turf(target))

///signal called from clicking with equipment
/datum/action/vehicle/sealed/mecha/lurm_strike/proc/on_equipment_click(datum/source, mob/living/pilot, atom/target)
	SIGNAL_HANDLER
	if(!target)
		return
	drop_missile(get_turf(target))

/**
 * ## drop_missile
 *
 * Called via intercepted clicks when the missile ability is active
 * Spawns a droppod and starts the cooldown of the missile strike ability
 * arguments:
 * * target_turf: turf of the atom that was clicked on
 */
/datum/action/vehicle/sealed/mecha/lurm_strike/proc/drop_missile(turf/target_turf)
	rockets_left--
	owner.clear_fullscreen("lurm")
	if(rockets_left <= 0)
		end_missile_targeting()
	SEND_SOUND(owner, 'tff_modular/modules/clamtech/sounds/lurm_away.ogg')
	S_TIMER_COOLDOWN_START(chassis, COOLDOWN_MECHA_MISSILE_STRIKE, strike_cooldown_time)
	owner.overlay_fullscreen("lurm", /atom/movable/screen/fullscreen/ivanov_display/clam, rockets_left)
	podspawn(list(
		"target" = target_turf,
		"style" = /datum/pod_style/missile/syndicate,
		"effectMissile" = TRUE,
		"explosionSize" = list(0,0,1,2)
	))
	button_icon_state = "mech_ivanov_cooldown"
	build_all_button_icons()
	if(rockets_left <= 0)
		owner.clear_fullscreen("lurm")
	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/action/vehicle/sealed/mecha/lurm_strike, reset_button_icon)), strike_cooldown_time)