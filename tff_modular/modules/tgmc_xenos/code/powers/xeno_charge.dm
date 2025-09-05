/// TGMC_XENOS (old nova sector xenos)

// Чардж крашера
/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge
	name = "Charge Attack (125)"
	desc = "Allows you to charge at a position, trampling anything in your path."
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED | AB_CHECK_LYING
	cooldown_time = 2 SECONDS
	charge_delay = 0.3 SECONDS
	charge_distance = 7
	destroy_objects = FALSE
	button_icon = 'tff_modular/modules/tgmc_xenos/icons/xeno_actions.dmi'
	button_icon_state = "crusher_charge"
	unset_after_click = TRUE

	var/living_damage = 40
	var/living_paralyze_time = 5 SECONDS
	var/sharpness = FALSE

	var/obj_damage = 50
	var/mecha_damage = 75
	var/mecha_occupants_stun_time = 5 SECONDS
	var/throw_mecha = TRUE

	var/crush_walls = TRUE
	var/crush_reinforced_walls = TRUE

	var/plasma_cost = 125

/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge/Grant(mob/granted_to)
	. = ..()
	RegisterSignal(granted_to, COMSIG_XENO_PLASMA_ADJUSTED, PROC_REF(on_owner_plasma_change))

/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge/Remove(mob/removed_from)
	. = ..()
	UnregisterSignal(removed_from, COMSIG_XENO_PLASMA_ADJUSTED)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge/proc/on_owner_plasma_change()
	SIGNAL_HANDLER

	build_all_button_icons()

/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge/Activate(atom/target_atom)
	var/mob/living/carbon/carbon_owner = owner
	carbon_owner.adjustPlasma(-plasma_cost)
	return ..()

/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge/IsAvailable(feedback)
	. = ..()
	if(!.)
		return FALSE
	if(!istgmcalien(owner))
		return FALSE
	var/mob/living/carbon/carbon_owner = owner
	if(carbon_owner.getPlasma() < plasma_cost)
		return FALSE

	return TRUE

/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge/do_charge_indicator(atom/charger, atom/charge_target)
	. = ..()
	playsound(charger, 'tff_modular/modules/tgmc_xenos/sound/alien_roar1.ogg', 75, TRUE, 8, 0.9)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge/on_moved(atom/source)
	playsound(source, 'tff_modular/modules/tgmc_xenos/sound/alien_footstep_charge1.ogg', 100, TRUE, 2, TRUE)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge/hit_target(atom/movable/source, atom/target, damage_dealt)
	var/mob/living/carbon/alien/adult/tgmc/charger = owner

	// Столокновение с существами
	if(isliving(target))
		var/mob/living/crushed_living = target
		if(crushed_living.buckled)
			crushed_living.buckled.unbuckle_mob(crushed_living)

		log_combat(charger, crushed_living, "xeno charged")
		var/damage = living_damage
		crushed_living.apply_damage(damage, BRUTE, BODY_ZONE_CHEST, sharpness = sharpness)

		if(crushed_living.density && (crushed_living.mob_size >= charger.mob_size))
			charger.visible_message(span_danger("[charger] rams into [target] and skids to a halt!"), span_alertalien("We ram into [target] and skid to a halt!"))
			do_stop()
			return

		var/fling_dir = pick((charger.dir & (NORTH|SOUTH)) ? list(WEST, EAST, charger.dir|WEST, charger.dir|EAST) : list(NORTH, SOUTH, charger.dir|NORTH, charger.dir|SOUTH))
		var/fling_dist = rand(1, 3)
		var/turf/destination = crushed_living.loc
		var/turf/temp

		for(var/i in 1 to fling_dist)
			temp = get_step(destination, fling_dir)
			if(!temp)
				break
			destination = temp

		if(destination != crushed_living.loc)
			crushed_living.throw_at(destination, fling_dist, 1, charger, TRUE)

		crushed_living.Paralyze(living_paralyze_time)
		charger.visible_message(span_danger("[charger] rams [target]!"), span_alertalien("We ram [target]!"))
		return

	// Столокновение с объектами
	else if(isobj(target))
		var/obj/crushed_obj = target
		if(istype(crushed_obj, /obj/structure/alien))
			return

		var/damage = obj_damage
		if(ismecha(target))
			damage = mecha_damage
			var/obj/vehicle/sealed/mecha/target_mecha = target
			if(target_mecha.defense_mode)
				damage /= 2
		else if(istype(target, /obj/machinery/door/airlock))
			damage = 1000 // Нужно сломать за 1 раз
			do_stop()
		else if(istype(target, /obj/structure/window))
			damage = 1000 // Так же нужно сломать за 1 раз

		crushed_obj.take_damage(damage, BRUTE)
		if(QDELETED(crushed_obj))
			charger.visible_message(span_danger("[charger] crushes [target]!"), span_alertalien("We crush [target]!"))
			return

		if(ismecha(target))
			var/obj/vehicle/sealed/mecha/target_mecha = target

			for(var/mob/living/occupant in target_mecha.occupants)
				occupant.Stun(mecha_occupants_stun_time)

			charger.visible_message(span_danger("[charger] rams into [target] and skids to a halt!"), span_alertalien("We ram into [target] and skid to a halt!"))
			do_stop()

			var/turf/throwtarget = get_edge_target_turf(source, get_dir(source, get_step_away(target, source)))
			var/dist_from_source = get_dist(target, source)
			if(throw_mecha && (target.max_integrity < 400) && (dist_from_source <= 1))
				target_mecha.safe_throw_at(throwtarget, 1, 1, source, spin = FALSE, force = MOVE_FORCE_EXTREMELY_STRONG)

			if(target_mecha.defense_mode)
				target_mecha.use_energy(damage * (STANDARD_CELL_CHARGE / 50))
				for(var/O in target_mecha.occupants)
					var/mob/living/occupant = O
					var/datum/action/vehicle/sealed/mecha/mech_defense_mode/action = LAZYACCESSASSOC(target_mecha.occupant_actions, occupant, /datum/action/vehicle/sealed/mecha/mech_defense_mode)
					if(isnull(action))
						continue
					action.Trigger(TRIGGER_FORCE_AVAILABLE, forced_state = TRUE)
					break

			return

		if(crushed_obj.anchored)
			charger.visible_message(span_danger("[charger] rams into [target] and skids to a halt!"), span_alertalien("We ram into [target] and skid to a halt!"))
			do_stop()
			return

		charger.visible_message("[span_warning("[charger] knocks [target] aside.")]!", span_alertalien("We knock [target] aside."))
		return

	// Столокновение с турфами
	else if(isturf(target))
		var/turf/crushed_turf = target
		if(crush_walls)
			if(!isclosedturf(crushed_turf) || isindestructiblewall(crushed_turf))
				return
			if(!crush_reinforced_walls && istype(crushed_turf, /turf/closed/wall/r_wall))
				return

			crushed_turf.AddComponent(/datum/component/torn_wall)
			if(!QDELETED(crushed_turf) && !istype(crushed_turf, /turf/closed/wall/r_wall))
				crushed_turf.AddComponent(/datum/component/torn_wall)

			if(QDELETED(crushed_turf))
				charger.visible_message(span_danger("[charger] plows straight through [crushed_turf]!"), span_alertalien("We plow straight through [crushed_turf]!"))
				return

			charger.visible_message(span_danger("[charger] rams into [crushed_turf] and skids to a halt!"), span_alertalien("We ram into [crushed_turf] and skid to a halt!"))
			do_stop()
			return

// Останавливает движение чарджера
/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge/proc/do_stop()
	GLOB.move_manager.stop_looping(owner)
