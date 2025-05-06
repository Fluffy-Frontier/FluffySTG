// Модульно так модульно :)

#define HEMOPHAGE_DRAIN_AMOUNT 50
#define BLOOD_DRAIN_MULTIPLIER_CKEY 1.15

/datum/action/cooldown/hemophage/drain_victim/drain_victim(mob/living/carbon/hemophage, mob/living/carbon/victim)
	var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - hemophage.blood_volume //How much capacity we have left to absorb blood
	// We start by checking that the victim is a human and they have a client, so we can give them the
	// beneficial status effect for drinking higher-quality blood.
	var/is_target_human_with_client = istype(victim, /mob/living/carbon/human) && victim.client
	var/horrible_feeding = FALSE

	if(ismonkey(victim))
		is_target_human_with_client = FALSE // Sorry, not going to get the status effect from monkeys, even if they have a client in them.
		hemophage.add_mood_event("gross_food", /datum/mood_event/disgust/hemophage_feed_monkey) // drinking from a monkey is inherently gross, like, REALLY gross
		hemophage.adjust_disgust(TUMOR_DISLIKED_FOOD_DISGUST, TUMOR_DISLIKED_FOOD_DISGUST)
		blood_volume_difference = BLOOD_VOLUME_NORMAL - hemophage.blood_volume
		horrible_feeding = TRUE

	if(istype(victim, /mob/living/carbon/human/species/monkey))
		is_target_human_with_client = FALSE // yep you're still not getting the status effect from humonkeys either. your tumour knows.
		hemophage.add_mood_event("gross_food", /datum/mood_event/disgust/hemophage_feed_humonkey)
		hemophage.adjust_disgust(DISGUST_LEVEL_GROSS / 4, TUMOR_DISLIKED_FOOD_DISGUST) // it's still gross but nowhere near as bad, though.
		horrible_feeding = TRUE

	StartCooldown()

	if(!do_after(hemophage, 3 SECONDS, target = victim))
		hemophage.balloon_alert(hemophage, "stopped feeding")
		return

	var/drained_blood = min(victim.blood_volume, HEMOPHAGE_DRAIN_AMOUNT, blood_volume_difference)
	// if you drained from a human with a client, congrats
	var/drained_multiplier = (is_target_human_with_client ? BLOOD_DRAIN_MULTIPLIER_CKEY : 1)

	var/obj/item/organ/stomach/hemophage/stomach_reference = hemophage.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(isnull(stomach_reference))
		victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)

	else
		if(!victim.transfer_blood_to(stomach_reference, drained_blood, forced = TRUE))
			victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
	hemophage.blood_volume = clamp(hemophage.blood_volume + (drained_blood * drained_multiplier), 0, BLOOD_VOLUME_MAXIMUM)

	log_combat(hemophage, victim, "drained [drained_blood]u of blood from", addition = " (NEW BLOOD VOLUME: [victim.blood_volume] cL)")
	victim.show_message(span_danger("[hemophage] drains some of your blood!"))

	if(horrible_feeding)
		if(istype(victim, /mob/living/carbon/human/species/monkey))
			to_chat(hemophage, span_notice("You take tentative draws of blood from [victim], each mouthful awash with the taste of ozone and a strange artificial twinge."))
		else
			to_chat(hemophage, span_warning("You choke back tepid mouthfuls of foul blood from [victim]. The taste is absolutely vile."))
	else
		to_chat(hemophage, span_notice("You pull greedy gulps of precious lifeblood from [victim]'s veins![is_target_human_with_client ? " That tasted particularly good!" : ""]"))

	playsound(hemophage, 'sound/items/drink.ogg', 30, TRUE, -2)

	// just let the hemophage know they're capped out on blood if they're trying to go for an exsanguinate and wondering why it isn't working
	if(drained_blood != HEMOPHAGE_DRAIN_AMOUNT && hemophage.blood_volume >= (BLOOD_VOLUME_MAXIMUM - HEMOPHAGE_DRAIN_AMOUNT))
		to_chat(hemophage, span_boldnotice("Your thirst is temporarily slaked, and you can digest no more new blood for the moment."))

	if(victim.blood_volume <= BLOOD_VOLUME_OKAY)
		to_chat(hemophage, span_warning("That definitely left them looking pale..."))
		to_chat(victim, span_warning("A groaning lethargy creeps into your muscles as you begin to feel slightly clammy...")) //let the victim know too

	if(is_target_human_with_client)
		hemophage.apply_status_effect(/datum/status_effect/blood_thirst_satiated)
		hemophage.add_mood_event("drank_human_blood", /datum/mood_event/hemophage_feed_human) // absolutely scrumptious
		hemophage.clear_mood_event("gross_food") // it's a real palate cleanser, you know
		hemophage.disgust *= 0.85 //also clears a little bit of disgust too

	// for this to ever occur, the hemophage actually has to be decently hungry, otherwise they'll cap their own blood reserves and be unable to pull it off.
	if(!victim.blood_volume || victim.blood_volume <= BLOOD_VOLUME_SURVIVE)
		to_chat(hemophage, span_boldwarning("A final sputter of blood trickles from [victim]'s collapsing veins as your terrible hunger drains them almost completely dry."))
	else if ((victim.blood_volume + HEMOPHAGE_DRAIN_AMOUNT) <= BLOOD_VOLUME_SURVIVE)
		to_chat(hemophage, span_warning("A sense of hesitation gnaws: you know for certain that taking much more blood from [victim] WILL kill them. <b>...but another part of you sees only opportunity.</b>"))

	/// FLUFFY FRONTIER CHANGE
	// Жертва будет уязвима к урону в течение 5 минут
	if(!victim.has_status_effect(/datum/status_effect/vulnerable_to_damage))
		victim.apply_status_effect(/datum/status_effect/vulnerable_to_damage)

#undef HEMOPHAGE_DRAIN_AMOUNT
#undef BLOOD_DRAIN_MULTIPLIER_CKEY
