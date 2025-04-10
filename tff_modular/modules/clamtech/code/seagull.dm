//90% of code is just a ripoff from Ivanov mecha, just customized to make it OP. Sure...

///how much time between charge_level going up by 1
#define JUMPJET_SINGLE_CHARGE_TIME (0.5 SECONDS)
///enough charge level to take off, basically done charging
#define JUMPJET_CHARGELEVEL_LAUNCH 5

///how much time you're in the air
#define TOTAL_JUMPJET_LEAP_TIME (3 SECONDS)

/obj/vehicle/sealed/mecha/clam/seagull
	desc = "Fast, INSANELY FAST clam mecha. Don't let it get behind you - its' payload is deadly!"
	name = "\improper Seagull"
	icon_state = "seagull"
	base_icon_state = "seagull"
	accesses = list(ACCESS_SYNDICATE) //cuz the main type doesn't seem to work
	movedelay = 2
	max_integrity = 300
	armor_type = /datum/armor/mecha_seagull
	max_temperature = 25000
	wreckage = /obj/structure/mecha_wreckage/clam/seagull
	mech_type = EXOSUIT_MODULE_SEAGULL
	force = 25
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)

//Maybe we'll want to rebalance them later.
/datum/armor/mecha_seagull
	melee = 50
	bullet = 60
	laser = 60
	energy = 60
	bomb = 50
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/clam/seagull/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_zoom)
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/jumpjet)

/obj/vehicle/sealed/mecha/clam/seagull/loaded
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/clam,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/clam/fire,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster),
	)

/obj/vehicle/sealed/mecha/clam/seagull/loaded/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/clam/seagull/loaded/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/clam/seagull
	name = "\improper Seagull wreckage"
	icon_state = "seagull-broken"
	desc = "This is a no-fly zone, sir. We just fixed the ceiling last week."

//LOTS of stolen code from Ivanov mecha
//Mostly for customisation

///Savannah Skyfall
/datum/action/vehicle/sealed/mecha/jumpjet
	name = "Activate jumpjets"
	button_icon_state = "mech_savannah"
	///cooldown time between skyfall uses
	var/jumpjet_cooldown_time = 40 SECONDS
	///skyfall builds up in charges every 2 seconds, when it reaches 5 charges the ability actually starts
	var/jumpjet_charge_level = 0

/datum/action/vehicle/sealed/mecha/jumpjet/Trigger(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return
	if(chassis.phasing)
		to_chat(owner, span_warning("You're already airborne!"))
		return
	if(TIMER_COOLDOWN_RUNNING(chassis, COOLDOWN_MECHA_SKYFALL))
		var/timeleft = S_TIMER_COOLDOWN_TIMELEFT(chassis, COOLDOWN_MECHA_SKYFALL)
		to_chat(owner, span_warning("You need to wait [DisplayTimeText(timeleft, 1)] before attempting to jump."))
		return
	if(jumpjet_charge_level)
		abort_jumpjet()
		return
	chassis.balloon_alert(owner, "charging jumpjets...")
	INVOKE_ASYNC(src, PROC_REF(jumpjet_charge_loop))

/**
 * ## skyfall_charge_loop
 *
 * The actual skyfall loop itself. Repeatedly calls itself after a do_after, so any interruptions will call abort_skyfall and end the loop
 * the other way the loop ends is if charge level (var it's ticking up) gets to SKYFALL_CHARGELEVEL_LAUNCH, in which case it ends the loop and does the ability.
 */
/datum/action/vehicle/sealed/mecha/jumpjet/proc/jumpjet_charge_loop() //HEY! WE HAVE AN UNSTOPPABLE JUMP HERE! ITS INTENDED!
	/*if(!do_after(owner, JUMPJET_SINGLE_CHARGE_TIME, target = chassis))
		abort_jumpjet()
		return*/
	jumpjet_charge_level++
	switch(jumpjet_charge_level)
		if(1)
			chassis.visible_message(span_warning("[chassis] shakes, its' legs releasing a trail of fire!"))
			playsound(chassis, 'sound/items/tools/rped.ogg', 50, TRUE)
		if(2)
			//chassis.visible_message(span_warning("[chassis] begins to shake, the sounds of electricity growing louder."))
			chassis.Shake(1, 1, JUMPJET_SINGLE_CHARGE_TIME-0.2) // -1 gives space between the animates, so they don't interrupt eachother
		if(3)
			//chassis.visible_message(span_warning("[chassis] assumes a pose as it rattles violently."))
			chassis.Shake(2, 2, JUMPJET_SINGLE_CHARGE_TIME-0.2) // -1 gives space between the animates, so they don't interrupt eachother
			chassis.spark_system.start()
			chassis.update_appearance(UPDATE_ICON_STATE)
		if(4)
			//chassis.visible_message(span_warning("[chassis] sparks and shutters as it finalizes preparation."))
			playsound(chassis, 'sound/vehicles/mecha/skyfall_power_up.ogg', 50, TRUE)
			chassis.Shake(3, 3, JUMPJET_SINGLE_CHARGE_TIME-0.2) // -1 gives space between the animates, so they don't interrupt eachother
			chassis.spark_system.start()
		if(JUMPJET_CHARGELEVEL_LAUNCH)
			chassis.visible_message(span_danger("[chassis] leaps into the air!"))
			playsound(chassis, 'sound/items/weapons/gun/general/rocket_launch.ogg', 50, TRUE)
	if(jumpjet_charge_level != JUMPJET_CHARGELEVEL_LAUNCH)
		jumpjet_charge_loop()
		return
	S_TIMER_COOLDOWN_START(chassis, COOLDOWN_MECHA_SKYFALL, jumpjet_cooldown_time)
	button_icon_state = "mech_savannah_cooldown"
	build_all_button_icons()
	addtimer(CALLBACK(src, PROC_REF(reset_button_icon)), jumpjet_cooldown_time)
	for(var/mob/living/shaken in range(7, chassis))
		shake_camera(shaken, 3, 3)

	var/turf/launch_turf = get_turf(chassis)
	new /obj/effect/hotspot(launch_turf)
	launch_turf.hotspot_expose(700, 50, 1)
	new /obj/effect/skyfall_landingzone(launch_turf, chassis)
	chassis.resistance_flags |= INDESTRUCTIBLE //not while jumping at least
	chassis.mecha_flags |= QUIET_STEPS|QUIET_TURNS|CANNOT_INTERACT
	chassis.phasing = "flying"
	chassis.movedelay = 1
	chassis.density = FALSE
	chassis.layer = ABOVE_ALL_MOB_LAYER
	animate(chassis, alpha = 0, time = 8, easing = QUAD_EASING|EASE_IN, flags = ANIMATION_PARALLEL)
	animate(chassis, pixel_z = 400, time = 10, easing = QUAD_EASING|EASE_IN, flags = ANIMATION_PARALLEL) //Animate our rising mech (just like pods hehe)
	addtimer(CALLBACK(src, PROC_REF(begin_landing)), 2 SECONDS)

/**
 * ## begin_landing
 *
 * Called by skyfall_charge_loop after some time if it reaches full charge level.
 * it's just the animations of the mecha coming down + another timer for the final landing effect
 */
/datum/action/vehicle/sealed/mecha/jumpjet/proc/begin_landing()
	animate(chassis, pixel_z = 0, time = 10, easing = QUAD_EASING|EASE_IN, flags = ANIMATION_PARALLEL)
	animate(chassis, alpha = 255, time = 8, easing = QUAD_EASING|EASE_IN, flags = ANIMATION_PARALLEL)
	addtimer(CALLBACK(src, PROC_REF(land)), 1 SECONDS)

/**
 * ## land
 *
 * Called by skyfall_charge_loop after some time if it reaches full charge level.
 * it's just the animations of the mecha coming down + another timer for the final landing effect
 */
/datum/action/vehicle/sealed/mecha/jumpjet/proc/land()
	var/turf/landed_on = get_turf(chassis)
	chassis.visible_message(span_danger("[chassis] lands from above!"))
	playsound(chassis, 'sound/effects/explosion/explosion1.ogg', 50, 1)
	chassis.resistance_flags &= ~INDESTRUCTIBLE
	chassis.mecha_flags &= ~(QUIET_STEPS|QUIET_TURNS|CANNOT_INTERACT)
	chassis.phasing = initial(chassis.phasing)
	chassis.movedelay = initial(chassis.movedelay)
	chassis.density = TRUE
	chassis.layer = initial(chassis.layer)
	SET_PLANE(chassis, initial(chassis.plane), landed_on)
	jumpjet_charge_level = 0
	chassis.update_appearance(UPDATE_ICON_STATE)
	for(var/mob/living/shaken in range(7, chassis))
		shake_camera(shaken, 5, 5)
	for(var/thing in range(1, chassis))
		if(isopenturf(thing))
			var/turf/open/floor/crushed_tile = thing
			crushed_tile.break_tile()
			continue
		if(isclosedturf(thing) && thing == landed_on)
			var/turf/closed/crushed_wall = thing
			crushed_wall.ScrapeAway()
			continue
		if(isobj(thing))
			var/obj/crushed_object = thing
			if(crushed_object == chassis || crushed_object.loc == chassis)
				continue
			crushed_object.take_damage(150) //same as a hulk punch, makes sense to me
			continue
		if(isliving(thing))
			var/mob/living/crushed_victim = thing
			if(crushed_victim in chassis.occupants)
				continue
			if(!(crushed_victim in landed_on))
				to_chat(crushed_victim, span_userdanger("The tremors from [chassis] landing sends you flying!"))
				var/fly_away_direction = get_dir(chassis, crushed_victim)
				crushed_victim.throw_at(get_edge_target_turf(crushed_victim, fly_away_direction), 4, 3)
				crushed_victim.adjustBruteLoss(15)
				continue
			to_chat(crushed_victim, span_userdanger("[chassis] crashes down on you from above!"))
			if(crushed_victim.stat != CONSCIOUS)
				crushed_victim.investigate_log("has been gibbed by a falling Savannah Ivanov mech.", INVESTIGATE_DEATHS)
				crushed_victim.gib(DROP_ALL_REMAINS)
				continue
			crushed_victim.adjustBruteLoss(80)

/**
 * ## abort_skyfall
 *
 * Called by skyfall_charge_loop if the charging is interrupted.
 * Applies cooldown and resets charge level
 */
/datum/action/vehicle/sealed/mecha/jumpjet/proc/abort_jumpjet()
	chassis.balloon_alert(owner, "Jump aborted")
	S_TIMER_COOLDOWN_START(chassis, COOLDOWN_MECHA_MISSILE_STRIKE, jumpjet_charge_level * 10 SECONDS) //so aborting skyfall later in the process imposes a longer cooldown
	jumpjet_charge_level = 0
	chassis.update_appearance(UPDATE_ICON_STATE)

/**
 * ## reset_button_icon
 *
 * called after an addtimer when the cooldown is finished with the skyfall, resets the icon
 */
/datum/action/vehicle/sealed/mecha/jumpjet/proc/reset_button_icon()
	button_icon_state = "mech_savannah"
	build_all_button_icons()

#undef JUMPJET_SINGLE_CHARGE_TIME
#undef JUMPJET_CHARGELEVEL_LAUNCH

#undef TOTAL_JUMPJET_LEAP_TIME
