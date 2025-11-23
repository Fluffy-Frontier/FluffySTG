#define HYPOTHERMIA_PARALYSIS "hypothermia_paralysis"

#define THERMAL_PROTECTION_HEAD 0.3
#define THERMAL_PROTECTION_CHEST 0.15
#define THERMAL_PROTECTION_GROIN 0.15
#define THERMAL_PROTECTION_LEG_LEFT 0.075
#define THERMAL_PROTECTION_LEG_RIGHT 0.075
#define THERMAL_PROTECTION_FOOT_LEFT 0.025
#define THERMAL_PROTECTION_FOOT_RIGHT 0.025
#define THERMAL_PROTECTION_ARM_LEFT 0.075
#define THERMAL_PROTECTION_ARM_RIGHT 0.075
#define THERMAL_PROTECTION_HAND_LEFT 0.025
#define THERMAL_PROTECTION_HAND_RIGHT 0.025


/mob/living/carbon/human/proc/get_cold_protection_flags_improved(temperature)
	var/thermal_protection_flags = 0

	for(var/obj/item/I in get_equipped_items())
		if(!I.min_cold_protection_temperature || !I.max_heat_protection_temperature)
			continue

		var/protection_zone = I.cold_protection
		if(!protection_zone)
			continue

		var/min_temp = I.min_cold_protection_temperature
		var/max_temp = I.max_heat_protection_temperature

		if(temperature >= max_temp)
			thermal_protection_flags |= protection_zone
			continue

		if(temperature < min_temp)
			var/delta = min_temp - temperature
			var/falloff_range = 200
			if(delta > falloff_range)
				delta = falloff_range

			var/factor = 1 - (delta / falloff_range)
			factor = max(factor * factor, 0.05)

			if(protection_zone & HEAD)
				if(factor >= 0.65) thermal_protection_flags |= HEAD
			if(protection_zone & CHEST)
				if(factor >= 0.60) thermal_protection_flags |= CHEST
			if(protection_zone & GROIN)
				if(factor >= 0.60) thermal_protection_flags |= GROIN
			if(protection_zone & LEGS)
				if(factor >= 0.45) thermal_protection_flags |= LEGS
			if(protection_zone & FEET)
				if(factor >= 0.35) thermal_protection_flags |= FEET
			if(protection_zone & ARMS)
				if(factor >= 0.45) thermal_protection_flags |= ARMS
			if(protection_zone & HANDS)
				if(factor >= 0.30) thermal_protection_flags |= HANDS
			continue

		var/factor = (temperature - min_temp) / (max_temp - min_temp)
		factor = clamp(factor, 0, 1)

		if(factor >= 0.85)
			thermal_protection_flags |= protection_zone


	if(!get_equipped_items())
		thermal_protection_flags |= CHEST|GROIN|ARMS|LEGS

	return thermal_protection_flags

/mob/living/carbon/human/proc/get_cold_protection_advanced(temperature = T20C)
	temperature = max(temperature, 2.7)
	var/thermal_protection_flags = get_cold_protection_flags_improved(temperature)

	var/thermal_protection = cold_protection
	if(thermal_protection_flags & HEAD)
		thermal_protection += THERMAL_PROTECTION_HEAD
	if(thermal_protection_flags & CHEST)
		thermal_protection += THERMAL_PROTECTION_CHEST
	if(thermal_protection_flags & GROIN)
		thermal_protection += THERMAL_PROTECTION_GROIN
	if(thermal_protection_flags & LEG_LEFT)
		thermal_protection += THERMAL_PROTECTION_LEG_LEFT
	if(thermal_protection_flags & LEG_RIGHT)
		thermal_protection += THERMAL_PROTECTION_LEG_RIGHT
	if(thermal_protection_flags & FOOT_LEFT)
		thermal_protection += THERMAL_PROTECTION_FOOT_LEFT
	if(thermal_protection_flags & FOOT_RIGHT)
		thermal_protection += THERMAL_PROTECTION_FOOT_RIGHT
	if(thermal_protection_flags & ARM_LEFT)
		thermal_protection += THERMAL_PROTECTION_ARM_LEFT
	if(thermal_protection_flags & ARM_RIGHT)
		thermal_protection += THERMAL_PROTECTION_ARM_RIGHT
	if(thermal_protection_flags & HAND_LEFT)
		thermal_protection += THERMAL_PROTECTION_HAND_LEFT
	if(thermal_protection_flags & HAND_RIGHT)
		thermal_protection += THERMAL_PROTECTION_HAND_RIGHT


	return clamp(round(thermal_protection, 0.001), 0, 1)

/datum/component/hypothermia
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/stored_bodytemperature = 310
	var/cooling_rate = 0.1
	var/max_temp = 310
	var/maximum_diff = -60
	var/base_rate = 0.8
	var/cooling_cooldown = 2 MINUTES
	var/heat_cooldown = 10 SECONDS
	var/lower_cooltreshhold = T0C + 15

	COOLDOWN_DECLARE(temperature_incress_cooldown)
	COOLDOWN_DECLARE(shiver_cooldown)
	COOLDOWN_DECLARE(mild_message_cooldown)
	COOLDOWN_DECLARE(confusion_cooldown)
	COOLDOWN_DECLARE(frostbite_cooldown)
	COOLDOWN_DECLARE(paradox_cooldown)
	COOLDOWN_DECLARE(unconscious_cooldown)
	COOLDOWN_DECLARE(organ_damage_cooldown)
	COOLDOWN_DECLARE(temperature_decress_cooldown)


	var/list/disabled_limbs // assoc: bodypart = end_time (world.time)

/datum/component/hypothermia/Initialize()
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterWithParent()
	disabled_limbs = list()
	COOLDOWN_START(src, temperature_decress_cooldown, cooling_cooldown)

/datum/component/hypothermia/Destroy(force)
	UnregisterFromParent()
	. = ..()

/datum/component/hypothermia/RegisterWithParent()
	var/mob/living/living_parent = parent
	living_parent.add_traits(list(TRAIT_WEATHER_IMMUNE, TRAIT_RESISTCOLD), HYPOTHERMIA_PARALYSIS)
	if(living_parent.bodytemperature < stored_bodytemperature)
		living_parent.bodytemperature = stored_bodytemperature
		stored_bodytemperature = max_temp
	else
		stored_bodytemperature = living_parent.bodytemperature

	RegisterSignal(living_parent, COMSIG_MOB_HEAR_SOURCE_ACT, PROC_REF(on_heat_source_act), TRUE)
	living_parent.AddComponent(/datum/component/perma_death_timer)
	START_PROCESSING(SSobj, src)

/datum/component/hypothermia/UnregisterFromParent()
	var/mob/living/living_parent = parent
	living_parent.remove_traits(list(TRAIT_WEATHER_IMMUNE, TRAIT_RESISTCOLD), HYPOTHERMIA_PARALYSIS)
	UnregisterSignal(living_parent, COMSIG_MOB_HEAR_SOURCE_ACT)
	STOP_PROCESSING(SSobj, src)


/datum/component/hypothermia/proc/on_heat_source_act(mob/target, datum/component/heat_source/source, amount, target_temperature)
	SIGNAL_HANDLER
	if(COOLDOWN_FINISHED(src, temperature_incress_cooldown))
		if(apply_heat(amount * base_rate, target_temperature))
			COOLDOWN_START(src, temperature_incress_cooldown, heat_cooldown)

/datum/component/hypothermia/proc/apply_heat(amount, target_temperature)
	var/mob/living/L = parent
	if(!L)
		return FALSE
	if(amount < 0 || target_temperature < stored_bodytemperature || stored_bodytemperature > target_temperature)
		return FALSE
	stored_bodytemperature += amount
	return TRUE

/datum/component/hypothermia/proc/adjust_scaled_temp(mob/living/living_mob, amount)
	var/area/hypothermia/HA = get_area(living_mob)
	if(!istype(HA))
		return

	var/area_temperature = HA.area_temperature
	var/protection = 0
	if(ishuman(living_mob))
		var/mob/living/carbon/human/H = living_mob
		protection = H.get_cold_protection_advanced(area_temperature)
	else
		protection = 1

	var/effective_multiplier = 1 - (protection * 0.85)
	effective_multiplier = max(effective_multiplier, 0.08)

	var/scaled_amount = amount * base_rate * effective_multiplier

	scaled_amount = clamp(scaled_amount, -1.2, 1.2)

	if(abs(scaled_amount) < 0.01)
		scaled_amount = 0

	stored_bodytemperature += scaled_amount
	stored_bodytemperature = clamp(stored_bodytemperature, T0C - 100, T0C + 500)


/datum/component/hypothermia/process(seconds_per_tick)
	var/mob/living/L = parent
	if(!L)
		return

	L.bodytemperature = stored_bodytemperature
	var/area/hypothermia/HA = get_area(L)
	if(!istype(HA, /area/hypothermia))
		return

	var/temp_diff = HA.area_temperature - stored_bodytemperature
	var/should_cool = (HA.area_temperature <= lower_cooltreshhold)

	if(temp_diff < maximum_diff)
		temp_diff = maximum_diff


	if((temp_diff < 0) && should_cool && COOLDOWN_FINISHED(src, temperature_decress_cooldown))
		adjust_scaled_temp(L, temp_diff * cooling_rate * seconds_per_tick)
		COOLDOWN_START(src, temperature_decress_cooldown, cooling_cooldown)


	else if(HA.area_temperature > lower_cooltreshhold)
		var/scaled_heat = temp_diff * cooling_rate * 0.5 * seconds_per_tick
		stored_bodytemperature += scaled_heat
		stored_bodytemperature = clamp(stored_bodytemperature, T0C - 100, T0C + 500)
		L.bodytemperature = stored_bodytemperature


	for(var/obj/item/bodypart/limb in disabled_limbs)
		if(world.time >= disabled_limbs[limb])
			REMOVE_TRAIT(limb, TRAIT_PARALYSIS, HYPOTHERMIA_PARALYSIS)
			limb.update_disabled()
			disabled_limbs -= limb

	if(issynthetic(L))
		process_synth(L, seconds_per_tick)
		return

	if(HAS_TRAIT(L, TRAIT_STASIS))
		return
	if(L.stat == DEAD)
		if(stored_bodytemperature <= TM70C && !(L.reagents.has_reagent(/datum/reagent/cryostylane, 2)))
			L.reagents.add_reagent(/datum/reagent/cryostylane, 3)
		return

	var/body_temp_c = stored_bodytemperature - T0C
	if(body_temp_c > 35)
		cleanup_effects(L)
		return

	if(body_temp_c <= 35 && body_temp_c > 32) // Mild hypothermia
		L.add_movespeed_modifier(/datum/movespeed_modifier/hypothermia_mild, TRUE)
		if(COOLDOWN_FINISHED(src, shiver_cooldown))
			L.emote(pick(list("shiver", "cough", "sneeze")))
			COOLDOWN_START(src, shiver_cooldown, rand(9 SECONDS, 20 SECONDS))

		if(COOLDOWN_FINISHED(src, mild_message_cooldown))
			to_chat(L, span_warning(pick(list(
				"You feel the cold creeping under your skin...",
				"Your teeth begin to chatter uncontrollably.",
				"Your fingertips are starting to go numb.",
				"Goosebumps cover your arms.",
				"A deep chill settles in your chest."
			))))
			COOLDOWN_START(src, mild_message_cooldown, rand(60, 180) SECONDS)


	else if(body_temp_c <= 32 && body_temp_c > 28)
		L.add_movespeed_modifier(/datum/movespeed_modifier/hypothermia_moderate, TRUE)
		L.adjustStaminaLoss(0.06 * seconds_per_tick)

		if(COOLDOWN_FINISHED(src, confusion_cooldown))
			L.adjust_confusion(10)
			L.adjust_slurring(20)
			L.adjust_jitter(10 SECONDS)
			to_chat(L, span_warning(pick(list(
				"Your thoughts are becoming sluggish and foggy...",
				"The world feels distant and unreal.",
				"You can't remember why you came here...",
				"Everything is starting to blur together.",
				"It's getting harder to focus your eyes."
			))))
			COOLDOWN_START(src, confusion_cooldown, rand(30, 60) SECONDS)

		if(SPT_PROB_RATE(0.03, seconds_per_tick) && COOLDOWN_FINISHED(src, frostbite_cooldown))
			apply_frostbite(L, rand(5, 10))
			COOLDOWN_START(src, frostbite_cooldown, rand(40, 90) SECONDS)

		if(SPT_PROB_RATE(0.01, seconds_per_tick))
			L.emote(pick(list("shiver", "groan", "moan")))


	else if(body_temp_c <= 28 && body_temp_c > 24) // Severe
		L.add_movespeed_modifier(/datum/movespeed_modifier/hypothermia_severe, TRUE)
		L.adjustStaminaLoss(0.25 * seconds_per_tick)

		if(COOLDOWN_FINISHED(src, unconscious_cooldown) && SPT_PROB_RATE(0.6, seconds_per_tick))
			L.Unconscious(rand(2 SECONDS, 4 SECONDS))
			COOLDOWN_START(src, unconscious_cooldown, 45 SECONDS)

		if(SPT_PROB_RATE(0.06, seconds_per_tick))
			L.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.25)
			L.adjustOrganLoss(ORGAN_SLOT_HEART, 0.45)
			L.adjustOxyLoss(1.5)

		if(SPT_PROB_RATE(0.02, seconds_per_tick) && COOLDOWN_FINISHED(src, paradox_cooldown))
			to_chat(L, span_userdanger(pick(list(
				"IT'S TOO HOT! GET THIS IS BURNING ME!",
				"GET IT OFF! I'M ON FIRE!",
				"CLOTHES ARE SUFFOCATING ME!"
			))))
			paradox_undress(L)
			COOLDOWN_START(src, paradox_cooldown, rand(85 SECONDS, 140 SECONDS))

		if(SPT_PROB_RATE(0.08, seconds_per_tick))
			disable_limb(L)
		if(SPT_PROB_RATE(0.09, seconds_per_tick) && COOLDOWN_FINISHED(src, frostbite_cooldown))
			apply_frostbite(L, rand(10, 18))
			COOLDOWN_START(src, frostbite_cooldown, 18 SECONDS)

		if(SPT_PROB_RATE(0.06, seconds_per_tick))
			L.emote(pick(list("collapse", "gasp", "shiver", "pale")))


	else if(body_temp_c <= 24) // Critical
		L.SetAllImmobility(4 SECONDS)
		L.adjustStaminaLoss(0.5 * seconds_per_tick)


		L.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.8 * seconds_per_tick)
		L.adjustOrganLoss(ORGAN_SLOT_HEART, 1.2 * seconds_per_tick)
		L.adjustOrganLoss(ORGAN_SLOT_LUNGS, 0.9 * seconds_per_tick)
		L.adjustOxyLoss(6 * seconds_per_tick)

		if(prob(6))
			apply_frostbite(L, rand(20, 40))

		if(prob(6))
			disable_limb(L)

		if(prob(8))
			to_chat(L, span_userdanger(pick(list(
				"You can't feel anything anymore...",
				"The cold has swallowed everything.",
				"It's so quiet... so peaceful...",
				"Your heart barely beats..."
			))))

		if(prob(4) && L.IsUnconscious())
			L.death()



/datum/component/hypothermia/proc/process_synth(mob/living/carbon/human/synth, seconds_per_tick)
	var/body_temp_c = stored_bodytemperature - T0C
	if(body_temp_c > 35)
		cleanup_effects(synth)
		return

	if(body_temp_c <= 35 && body_temp_c > 32)
		synth.add_movespeed_modifier(/datum/movespeed_modifier/hypothermia_mild, TRUE)
		if(SPT_PROB_RATE(0.03, seconds_per_tick) && COOLDOWN_FINISHED(src, shiver_cooldown))
			do_sparks(2, TRUE, synth)
			COOLDOWN_START(src, shiver_cooldown, rand(12 SECONDS, 40 SECONDS))

		if(COOLDOWN_FINISHED(src, mild_message_cooldown))
			to_chat(synth, span_warning(pick(list(
				"Alert: Cooling detected in chassis...",
				"Warning: Circuitry temperature dropping.",
				"Alert: Hydraulic fluid viscosity increasing.",
				"System notice: Minor power fluctuations due to cold.",
				"Warning: External temperature impacting efficiency."
			))))
			COOLDOWN_START(src, mild_message_cooldown, rand(60, 180) SECONDS)


	else if(body_temp_c <= 32 && body_temp_c > 28) // Moderate: slowdown, glitches
		synth.add_movespeed_modifier(/datum/movespeed_modifier/hypothermia_moderate, TRUE)

		if(COOLDOWN_FINISHED(src, confusion_cooldown))
			synth.adjust_confusion(10)
			synth.adjust_slurring(20)
			synth.adjust_jitter(10 SECONDS)
			to_chat(synth, span_warning(pick(list(
				"Error: Processing delay due to low temperature...",
				"Warning: System glitches detected.",
				"Alert: Sensor data corrupted by cold.",
				"Error: Logic circuits slowing.",
				"Warning: Memory access delayed."
			))))
			COOLDOWN_START(src, confusion_cooldown, rand(30, 60) SECONDS)

		if(SPT_PROB_RATE(0.03, seconds_per_tick) && COOLDOWN_FINISHED(src, frostbite_cooldown))
			apply_frostbite(synth, rand(5, 10))
			COOLDOWN_START(src, frostbite_cooldown, rand(40, 90) SECONDS)

		if(SPT_PROB_RATE(0.01, seconds_per_tick))
			do_sparks(3, TRUE, synth)


	else if(body_temp_c <= 28 && body_temp_c > 24)
		synth.add_movespeed_modifier(/datum/movespeed_modifier/hypothermia_severe, TRUE)

		if(COOLDOWN_FINISHED(src, unconscious_cooldown) && SPT_PROB_RATE(0.06, seconds_per_tick))
			synth.Unconscious(rand(2 SECONDS, 4 SECONDS))
			COOLDOWN_START(src, unconscious_cooldown, 45 SECONDS)

		if(SPT_PROB_RATE(0.06, seconds_per_tick))
			synth.adjustOrganLoss(ORGAN_SLOT_HEART, 0.45)

		if(SPT_PROB_RATE(0.02, seconds_per_tick) && COOLDOWN_FINISHED(src, paradox_cooldown))
			to_chat(synth, span_userdanger(pick(list(
				"ERROR: OVERHEAT DETECTED! EMERGENCY VENTING!",
				"SYSTEM FAULT: THERMAL OVERLOAD!",
				"CRITICAL ERROR: REMOVE EXTERNAL LAYERS!"
			))))
			paradox_undress(synth)
			COOLDOWN_START(src, paradox_cooldown, rand(85 SECONDS, 140 SECONDS))

		if(SPT_PROB_RATE(0.08, seconds_per_tick))
			disable_limb(synth)
		if(SPT_PROB_RATE(0.09, seconds_per_tick) && COOLDOWN_FINISHED(src, frostbite_cooldown))
			apply_frostbite(synth, rand(10, 18))
			COOLDOWN_START(src, frostbite_cooldown, 18 SECONDS)

		if(SPT_PROB_RATE(0.06, seconds_per_tick))
			do_sparks(5, TRUE, synth)


	else if(body_temp_c <= 24)
		synth.adjustOrganLoss(ORGAN_SLOT_HEART, 0.3 * seconds_per_tick)
		if(prob(6))
			apply_frostbite(synth, rand(20, 40))

		if(prob(6))
			disable_limb(synth)

		if(prob(8))
			to_chat(synth, span_userdanger(pick(list(
				"Critical: All systems freezing...",
				"Error: Power failure imminent.",
				"Shutdown sequence initiated...",
				"Alert: Core temperature critical."
			))))

		if(prob(4) && synth.IsUnconscious())
			synth.death()


/datum/component/hypothermia/proc/cleanup_effects(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/hypothermia_mild)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/hypothermia_moderate)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/hypothermia_severe)

	for(var/obj/item/bodypart/limb in disabled_limbs)
		REMOVE_TRAIT(limb, TRAIT_PARALYSIS, HYPOTHERMIA_PARALYSIS)
		limb.update_disabled()
	disabled_limbs.Cut()

	L.set_confusion(0)
	L.set_slurring(0)
	L.set_jitter(0)


/datum/component/hypothermia/proc/disable_limb(mob/living/carbon/C)
	var/static/list/limb_weights = list(
		BODY_ZONE_L_ARM = 15,
		BODY_ZONE_R_ARM = 15,
		BODY_ZONE_L_LEG = 35,
		BODY_ZONE_R_LEG = 35
	)
	var/zone = pick_weight(limb_weights)
	var/obj/item/bodypart/limb = C.get_bodypart(zone)
	if(!limb || HAS_TRAIT(limb, TRAIT_PARALYSIS))
		return

	ADD_TRAIT(limb, TRAIT_PARALYSIS, HYPOTHERMIA_PARALYSIS)
	limb.update_disabled()
	disabled_limbs[limb] = world.time + rand(60 SECONDS, 150 SECONDS)

	to_chat(C, span_userdanger("Your [limb.name] goes completely numb — you can't feel or move it!"))


/datum/component/hypothermia/proc/apply_frostbite(mob/living/L, damage)
	if(!iscarbon(L))
		return
	var/mob/living/carbon/C = L

	var/obj/item/bodypart/affecting = C.get_bodypart(pick(list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_HEAD)))
	if(!affecting)
		return
	affecting.receive_damage(burn = max(1, round(damage * 0.6)), wound_bonus = 8)
	to_chat(L, span_danger("Your [affecting.name] burns with freezing pain and turns black!"))


/datum/component/hypothermia/proc/paradox_undress(mob/living/carbon/C)
	var/list/items = C.get_equipped_items()
	items += C.held_items
	for(var/obj/item/I in shuffle(items))
		if(prob(45))
			C.dropItemToGround(I, force = TRUE)
			to_chat(C, span_notice("Too hot... must... cool down..."))
			break

/datum/movespeed_modifier/hypothermia_mild
	multiplicative_slowdown = 0.2

/datum/movespeed_modifier/hypothermia_moderate
	multiplicative_slowdown = 0.5

/datum/movespeed_modifier/hypothermia_severe
	multiplicative_slowdown = 1.0


#undef HYPOTHERMIA_PARALYSIS
#undef THERMAL_PROTECTION_HEAD
#undef THERMAL_PROTECTION_CHEST
#undef THERMAL_PROTECTION_GROIN
#undef THERMAL_PROTECTION_LEG_LEFT
#undef THERMAL_PROTECTION_LEG_RIGHT
#undef THERMAL_PROTECTION_FOOT_LEFT
#undef THERMAL_PROTECTION_FOOT_RIGHT
#undef THERMAL_PROTECTION_ARM_LEFT
#undef THERMAL_PROTECTION_ARM_RIGHT
#undef THERMAL_PROTECTION_HAND_LEFT
#undef THERMAL_PROTECTION_HAND_RIGHT



/datum/component/heat_source
	dupe_mode = COMPONENT_DUPE_UNIQUE

	var/heat_output = 0
	var/heat_range = 1
	var/target_temperature = T20C

/datum/component/heat_source/Initialize(_heat_output, _heat_power = 1 JOULES, _range = 1, _target_temperature = T20C)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	heat_output = _heat_output * _heat_power
	heat_range = _range
	target_temperature = _target_temperature

	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(on_parent_delete))

	var/area/A = get_area(parent)
	if(istype(A, /area/hypothermia))
		var/area/hypothermia/HA = A
		HA.heat_sources += WEAKREF(src)

	START_PROCESSING(SSobj, src)

/datum/component/heat_source/proc/on_parent_delete(datum/source)
	SIGNAL_HANDLER
	var/area/A = get_area(parent)
	if(istype(A, /area/hypothermia))
		var/area/hypothermia/HA = A
		HA.heat_sources -= WEAKREF(src)
	qdel(src)

/datum/component/heat_source/process(seconds_per_tick)
	var/atom/movable/AM = parent
	if(QDELETED(AM))
		qdel(src)
		return

	var/area/A = get_area(AM)
	if(istype(A, /area/hypothermia) && !A.outdoors)
		var/area/hypothermia/HA = A
		var/heat_energy = heat_output * seconds_per_tick
		var/volume = HA.get_volume()
		if(volume > 0)
			var/temp_delta = heat_energy / (2000 * volume)
			HA.adjust_temperature_scaled(temp_delta, target_temperature)


	if(heat_range > 0)
		for(var/mob/living/L in SSspatial_grid.orthogonal_range_search(get_turf(AM), RECURSIVE_CONTENTS_CLIENT_MOBS, heat_range))
			var/dist = get_dist(AM, L)
			if(dist == 0)
				dist = 1
			var/heat_energy = (heat_output * seconds_per_tick) / 200
			var/effective_heat = heat_energy / (1 + dist * 2)
			SEND_SIGNAL(L, COMSIG_MOB_HEAR_SOURCE_ACT, src, effective_heat * seconds_per_tick, target_temperature)



/datum/component/perma_death_timer
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/time_left = 5 MINUTES
	var/last_decress_time = 0
	var/active = FALSE

/datum/component/perma_death_timer/Initialize()
	. = ..()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(start_timer))
	RegisterSignal(parent, COMSIG_LIVING_REVIVE, PROC_REF(on_revive))

/datum/component/perma_death_timer/Destroy()
	UnregisterSignal(parent, list(COMSIG_LIVING_DEATH, COMSIG_LIVING_REVIVE))
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/component/perma_death_timer/proc/start_timer(datum/source)
	SIGNAL_HANDLER
	if(active)
		return
	to_chat(parent, span_warning("You feel your life force fading... Revival window closing in 5 minutes!"))
	last_decress_time = world.time
	active = TRUE
	START_PROCESSING(SSobj, src)

/datum/component/perma_death_timer/proc/on_revive(datum/source)
	SIGNAL_HANDLER
	active = FALSE
	time_left = initial(time_left)
	STOP_PROCESSING(SSobj, src)

/datum/component/perma_death_timer/process(seconds_per_tick)
	var/delta = world.time - last_decress_time
	var/mob/living/carbon/carbon_parent = parent
	if(HAS_TRAIT(carbon_parent, TRAIT_STASIS))
		return
	if(carbon_parent.bodytemperature <= T0C)
		return
	if(carbon_parent.reagents.has_reagent(/datum/reagent/toxin/formaldehyde, 0.01))
		carbon_parent.reagents.remove_reagent(/datum/reagent/toxin/formaldehyde, 0.01)
		return
	carbon_parent.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.1 * seconds_per_tick)
	time_left -= delta
	last_decress_time = world.time

	if(time_left <= 0)
		make_perma_dead()
		STOP_PROCESSING(SSobj, src)
		active = FALSE

/datum/component/perma_death_timer/proc/make_perma_dead()
	var/mob/living/carbon/human/H = parent
	if(!H || H.stat != DEAD)
		return
	ADD_TRAIT(H, TRAIT_DNR, "perma_death_timer")
	to_chat(H, span_userdanger("Your essence has dissipated... Revival is now impossible."))
