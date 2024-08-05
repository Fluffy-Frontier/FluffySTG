/datum/reagent/consumable/skrelluq
	name = "Skrelluq"
	description = "A popular skrell drink made from plasma and citrus, causes numbness!"
	taste_description = "You feel extreme bitterness and wetness. The tip of your tongue is suddenly numb."
	color = "#570099"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	quality = DRINK_VERYGOOD
	glass_price = DRINK_PRICE_MEDIUM
	overdose_threshold = 40

/datum/reagent/consumable/skrelluq/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.emote("wurble")

/datum/reagent/consumable/skrelluq/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.set_jitter_if_lower(10 SECONDS * REM * seconds_per_tick)
	affected_mob.add_mood_event("numb", /datum/mood_event/narcotic_medium, name) //comfortably numb
