/datum/disease/advance/assign_properties()

	if(properties?.len)
		if(properties["stealth"] >= 2) // ORIGINAL: if(properties["stealth"] >= properties["severity"] && properties["severity"] > 0)
			visibility_flags |= HIDDEN_SCANNER
		else
			visibility_flags &= ~HIDDEN_SCANNER

		if(properties["transmittable"] >= 11)
			set_spread(DISEASE_SPREAD_AIRBORNE)
		else if(properties["transmittable"] >= 7)
			set_spread(DISEASE_SPREAD_CONTACT_SKIN)
		else if(properties["transmittable"] >= 3)
			set_spread(DISEASE_SPREAD_CONTACT_FLUIDS)
		else
			set_spread(DISEASE_SPREAD_BLOOD)

		spreading_modifier = max(CEILING(0.4 * properties["transmittable"], 1), 1)
		cure_chance = clamp(7.5 - (0.5 * properties["resistance"]), 1, 10) // can be between 1 and 10
		stage_prob = max(0.5 * properties["stage_rate"], 1) // ORIGINAL: stage_prob = max(0.3 * properties["stage_rate"], 1)
		set_severity(round(properties["severity"]), 1)
		generate_cure(properties)
	else
		CRASH("Our properties were empty or null!")
