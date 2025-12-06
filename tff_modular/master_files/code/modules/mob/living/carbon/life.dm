/mob/living/carbon/proc/check_breath(datum/gas_mixture/breath)
	. = TRUE

	if(HAS_TRAIT(src, TRAIT_GODMODE))
		failed_last_breath = FALSE
		clear_alert(ALERT_NOT_ENOUGH_OXYGEN)
		return

	if(HAS_TRAIT(src, TRAIT_NOBREATH))
		return

	// Breath may be null, so use a fallback "empty breath" for convenience.
	if(!breath)
		/// Fallback "empty breath" for convenience.
		var/static/datum/gas_mixture/immutable/empty_breath = new(BREATH_VOLUME)
		breath = empty_breath

	// Ensure gas volumes are present.
	breath.assert_gases(/datum/gas/bz, /datum/gas/carbon_dioxide, /datum/gas/freon, /datum/gas/plasma, /datum/gas/pluoxium, /datum/gas/miasma, /datum/gas/nitrous_oxide, /datum/gas/nitrium, /datum/gas/oxygen)

	/// The list of gases in the breath.
	var/list/breath_gases = breath.gases
	/// Indicates if there are moles of gas in the breath.
	var/has_moles = breath.total_moles() != 0

	var/obj/item/organ/lungs = get_organ_slot(ORGAN_SLOT_LUNGS)
	// Indicates if lungs can breathe without gas.
	if(!lungs)
		// Lungs are missing! Can't breathe.
		// Simulates breathing zero moles of gas.
		has_moles = FALSE
		// Extra damage, let God sort ’em out!
		adjustOxyLoss(2)

	/// Minimum O2 before suffocation.
	var/safe_oxygen_min = 16
	/// Maximum CO2 before side-effects.
	var/safe_co2_max = 10
	/// Maximum Plasma before side-effects.
	var/safe_plas_max = 0.05
	/// Maximum Pluoxum before side-effects.
	var/gas_stimulation_min = 0.002 // For Pluoxium
	// Vars for N2O induced euphoria, stun, and sleep.
	var/n2o_euphoria = EUPHORIA_LAST_FLAG
	var/n2o_para_min = 1
	var/n2o_sleep_min = 5

	// Partial pressures in our breath
	// Main gases.
	var/pluoxium_pp = 0
	var/o2_pp = 0
	var/plasma_pp = 0
	var/co2_pp = 0
	// Trace gases ordered alphabetically.
	var/bz_pp = 0
	var/freon_pp = 0
	var/n2o_pp = 0
	var/nitrium_pp = 0
	var/miasma_pp = 0

	var/can_breathe_vacuum = HAS_TRAIT(src, TRAIT_NO_BREATHLESS_DAMAGE)

	// Check for moles of gas and handle partial pressures / special conditions.
	if(has_moles)
		// Breath has more than 0 moles of gas.
		// Partial pressures of "main gases".
		pluoxium_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/pluoxium][MOLES])
		o2_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/oxygen][MOLES] + (PLUOXIUM_PROPORTION * pluoxium_pp))
		plasma_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/plasma][MOLES])
		co2_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/carbon_dioxide][MOLES])
		// Partial pressures of "trace" gases.
		bz_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/bz][MOLES])
		freon_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/freon][MOLES])
		miasma_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/miasma][MOLES])
		n2o_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/nitrous_oxide][MOLES])
		nitrium_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/nitrium][MOLES])

	// Breath has 0 moles of gas.
	else if(can_breathe_vacuum)
		// The mob can breathe anyways. What are you? Some bottom-feeding, scum-sucking algae eater?
		failed_last_breath = FALSE
		// Vacuum-adapted lungs regenerate oxyloss even when breathing nothing.
		if(health >= crit_threshold)
			adjustOxyLoss(-5)
	else
		// Can't breathe! Lungs are missing, and/or breath is empty.
		. = FALSE
		failed_last_breath = TRUE

	//-- PLUOXIUM --//
	// Behaves like Oxygen with 8X efficacy, but metabolizes into a reagent.
	if(pluoxium_pp)
		// Inhale Pluoxium. Exhale nothing.
		breath_gases[/datum/gas/pluoxium][MOLES] = 0
		// Metabolize to reagent.
		if(pluoxium_pp > gas_stimulation_min)
			var/existing = reagents.get_reagent_amount(/datum/reagent/pluoxium)
			reagents.add_reagent(/datum/reagent/pluoxium, max(0, 1 - existing))

	//-- OXYGEN --//
	// Carbons need only Oxygen to breathe properly.
	var/oxygen_used = 0
	// Minimum Oxygen effects. "Too little oxygen!"
	if(!can_breathe_vacuum && (o2_pp < safe_oxygen_min))
		// Breathe insufficient amount of O2.
		oxygen_used = handle_suffocation(o2_pp, safe_oxygen_min, breath_gases[/datum/gas/oxygen][MOLES])
		if(!HAS_TRAIT(src, TRAIT_ANOSMIA))
			throw_alert(ALERT_NOT_ENOUGH_OXYGEN, /atom/movable/screen/alert/not_enough_oxy)
	else
		// Enough oxygen to breathe.
		failed_last_breath = FALSE
		clear_alert(ALERT_NOT_ENOUGH_OXYGEN)
		if(o2_pp)
			// Inhale O2.
			oxygen_used = breath_gases[/datum/gas/oxygen][MOLES]
			// Heal mob if not in crit.
			if(health >= crit_threshold)
				adjustOxyLoss(-5)
	// Exhale equivalent amount of CO2.
	if(o2_pp)
		breath_gases[/datum/gas/oxygen][MOLES] -= oxygen_used
		breath_gases[/datum/gas/carbon_dioxide][MOLES] += oxygen_used

	//-- CARBON DIOXIDE --//
	// Maximum CO2 effects. "Too much CO2!"
	if(co2_pp > safe_co2_max)
		// CO2 side-effects.
		// Give the mob a chance to notice.
		if(prob(20))
			emote("cough")
		// If it's the first breath with too much CO2 in it, lets start a counter, then have them pass out after 12s or so.
		if(!co2overloadtime)
			co2overloadtime = world.time
		else if((world.time - co2overloadtime) > 12 SECONDS)
			if(!HAS_TRAIT(src, TRAIT_ANOSMIA))
				throw_alert(ALERT_TOO_MUCH_CO2, /atom/movable/screen/alert/too_much_co2)
			Unconscious(6 SECONDS)
			// Lets hurt em a little, let them know we mean business.
			adjustOxyLoss(3)
			// They've been in here 30s now, start to kill them for their own good!
			if((world.time - co2overloadtime) > 30 SECONDS)
				adjustOxyLoss(8)
	else
		// Reset side-effects.
		co2overloadtime = 0
		clear_alert(ALERT_TOO_MUCH_CO2)

	//-- PLASMA --//
	// Maximum Plasma effects. "Too much Plasma!"
	if(plasma_pp > safe_plas_max)
		// Plasma side-effects.
		var/ratio = (breath_gases[/datum/gas/plasma][MOLES] / safe_plas_max) * 10
		adjustToxLoss(clamp(ratio, MIN_TOXIC_GAS_DAMAGE, MAX_TOXIC_GAS_DAMAGE))
		if(!HAS_TRAIT(src, TRAIT_ANOSMIA))
			throw_alert(ALERT_TOO_MUCH_PLASMA, /atom/movable/screen/alert/too_much_plas)
	else
		// Reset side-effects.
		clear_alert(ALERT_TOO_MUCH_PLASMA)

	//-- TRACES --//
	// If there's some other funk in the air lets deal with it here.

	//-- BZ --//
	// (Facepunch port of their Agent B)
	if(bz_pp)
		if(bz_pp > 1)
			adjust_hallucinations(20 SECONDS)
		else if(bz_pp > 0.01)
			adjust_hallucinations(10 SECONDS)

	//-- FREON --//
	if(freon_pp)
		adjustFireLoss(freon_pp * 0.25)

	//-- MIASMA --//
	if(!miasma_pp)
	// Clear moodlet if no miasma at all.
		clear_mood_event("smell")
	else
		// FLUFFY FRONTIER ADDITION START
		// Miasma sickness
		if(prob(1 * miasma_pp))
			var/datum/disease/advance/miasma_disease = new /datum/disease/advance/random(max_symptoms = 2, max_level = 3)
			miasma_disease.name = "Unknown"
			ForceContractDisease(miasma_disease, make_copy = TRUE, del_on_fail = TRUE)
		// FLUFFY FRONTIER ADDITION END
		// Miasma side-effects.
		if (HAS_TRAIT(src, TRAIT_ANOSMIA)) //We can't feel miasma without sense of smell
			return
		switch(miasma_pp)
			if(0.25 to 5)
				// At lower pp, give out a little warning
				clear_mood_event("smell")
				if(prob(5))
					to_chat(src, span_notice("There is an unpleasant smell in the air."))
			if(5 to 20)
				//At somewhat higher pp, warning becomes more obvious
				if(prob(15))
					to_chat(src, span_warning("You smell something horribly decayed inside this room."))
					add_mood_event("smell", /datum/mood_event/disgust/bad_smell)
			if(15 to 30)
				//Small chance to vomit. By now, people have internals on anyway
				if(prob(5))
					to_chat(src, span_warning("The stench of rotting carcasses is unbearable!"))
					add_mood_event("smell", /datum/mood_event/disgust/nauseating_stench)
					vomit(VOMIT_CATEGORY_DEFAULT)
			if(30 to INFINITY)
				//Higher chance to vomit. Let the horror start
				if(prob(25))
					to_chat(src, span_warning("The stench of rotting carcasses is unbearable!"))
					add_mood_event("smell", /datum/mood_event/disgust/nauseating_stench)
					vomit(VOMIT_CATEGORY_DEFAULT)
			else
				clear_mood_event("smell")

	//-- NITROUS OXIDE --//
	if(n2o_pp > n2o_para_min)
		// More N2O, more severe side-effects. Causes stun/sleep.
		n2o_euphoria = EUPHORIA_ACTIVE
		if(!HAS_TRAIT(src, TRAIT_ANOSMIA))
			throw_alert(ALERT_TOO_MUCH_N2O, /atom/movable/screen/alert/too_much_n2o)
		// give them one second of grace to wake up and run away a bit!
		if(!HAS_TRAIT(src, TRAIT_SLEEPIMMUNE))
			Unconscious(6 SECONDS)
		// Enough to make the mob sleep.
		if(n2o_pp > n2o_sleep_min)
			Sleeping(max(AmountSleeping() + 40, 200))
	else if(n2o_pp > 0.01)
		// No alert for small amounts, but the mob randomly feels euphoric.
		if(prob(20))
			n2o_euphoria = EUPHORIA_ACTIVE
			emote(pick("giggle","laugh"))
		else
			n2o_euphoria = EUPHORIA_INACTIVE
	else
	// Reset side-effects, for zero or extremely small amounts of N2O.
		n2o_euphoria = EUPHORIA_INACTIVE
		clear_alert(ALERT_TOO_MUCH_N2O)

	//-- NITRIUM --//
	if(nitrium_pp)
		var/need_mob_update = FALSE
		if(nitrium_pp > 0.5)
			need_mob_update += adjustFireLoss(nitrium_pp * 0.15, updating_health = FALSE)
		if(nitrium_pp > 5)
			need_mob_update += adjustToxLoss(nitrium_pp * 0.05, updating_health = FALSE)
		if(need_mob_update)
			updatehealth()

	// Handle chemical euphoria mood event, caused by N2O.
	if (n2o_euphoria == EUPHORIA_ACTIVE)
		add_mood_event("chemical_euphoria", /datum/mood_event/chemical_euphoria)
	else if (n2o_euphoria == EUPHORIA_INACTIVE)
		clear_mood_event("chemical_euphoria")
	// Activate mood on first flag, remove on second, do nothing on third.

	if(has_moles)
		handle_breath_temperature(breath)

	breath.garbage_collect()
