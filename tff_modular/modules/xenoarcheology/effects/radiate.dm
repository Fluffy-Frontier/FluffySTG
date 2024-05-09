/datum/artifact_effect/radiate
	log_name = "Radiate"
	var/radiation_amount

/datum/artifact_effect/radiate/New()
	..()
	radiation_amount = rand(1, 10)
	type_name = pick(ARTIFACT_EFFECT_PARTICLE, ARTIFACT_EFFECT_ORGANIC)

/datum/artifact_effect/radiate/DoEffectTouch(mob/living/user)
	. = ..()
	if(!.)
		return
	radiation_pulse(source = holder, max_range = range + 5, threshold = 0.3, chance = 50)

/datum/artifact_effect/radiate/DoEffectAura()
	. = ..()
	if(!.)
		return
	radiation_pulse(source = holder, max_range = range, threshold = 0.3, chance = 10  * radiation_amount)

/datum/artifact_effect/radiate/DoEffectPulse()
	. = ..()
	if(!.)
		return
	var/used_power = .
	radiation_pulse(source = holder, max_range = range, threshold = 0.3, chance = used_power)

/datum/artifact_effect/radiate/DoEffectDestroy()
	radiation_pulse(source = holder, max_range = range*2, threshold = 0, chance = 75) // Really powerful pulse
