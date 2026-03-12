/datum/bloodsucker_clan/nosferatu
	name = CLAN_NOSFERATU
	description = "The Nosferatu Clan is unable to blend in with the crew, with no abilities such as Masquerade and Veil. \n\
		Additionally, has a permanent bad back and looks like a Bloodsucker upon a simple examine, and their face is disfigured \n\
		they can fit in the vents. \n\
		The Favorite Ghoul is also permanently disfigured, and can also ventcrawl, but only while entirely nude. \n\
		They also have night vision, know what each wire does, and have silent footsteps."
	clan_objective = /datum/objective/bloodsucker/kindred
	join_icon_state = "nosferatu"
	join_description = "You are permanetly disfigured, look like a Bloodsucker to all who examine you, \
		lose your Masquerade ability, but gain the ability to Ventcrawl even while clothed."
	blood_drink_type = BLOODSUCKER_DRINK_INHUMANELY
	var/ventcrawl_time = 10 SECONDS
	princely_score_bonus = 3
	var/static/list/traits_to_add = list(TRAIT_DISFIGURED, TRAIT_VENTCRAWLER_NUDE, TRAIT_UNKNOWN_VOICE, TRAIT_TRUE_NIGHT_VISION, TRAIT_KNOW_ENGI_WIRES, TRAIT_SILENT_FOOTSTEPS)

/datum/bloodsucker_clan/nosferatu/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.powers)
		if(istype(power, /datum/action/cooldown/bloodsucker/masquerade) || istype(power, /datum/action/cooldown/bloodsucker/veil))
			bloodsuckerdatum.RemovePower(power)
	var/mob/living/mob = bloodsuckerdatum.owner.current
	if(!mob.has_quirk(/datum/quirk/badback))
		mob.add_quirk(/datum/quirk/badback)

	mob.add_traits(traits_to_add, BLOODSUCKER_TRAIT)

	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXAMINE, PROC_REF(on_mob_examine))
	RegisterSignal(mob, COMSIG_CAN_VENTCRAWL, PROC_REF(can_ventcrawl))
	RegisterSignal(mob, COMSIG_VENTCRAWL_PRE_ENTER, PROC_REF(on_ventcrawl_enter))
	RegisterSignal(mob, COMSIG_VENTCRAWL_PRE_EXIT, PROC_REF(on_ventcrawl_pre_exit))
	RegisterSignal(mob, COMSIG_VENTCRAWL_EXIT, PROC_REF(on_ventcrawl_exit))
	RegisterSignal(mob, COMSIG_VENTCRAWL_PRE_CANCEL, PROC_REF(on_ventcrawl_cancel))

/datum/bloodsucker_clan/nosferatu/proc/get_ventcrawl_time()
	return max(ventcrawl_time - bloodsuckerdatum.GetRank() SECONDS, 2 SECONDS)

/datum/bloodsucker_clan/nosferatu/proc/can_ventcrawl(mob/living/carbon/human/owner_mob, atom/vent, provide_feedback)
	SIGNAL_HANDLER
	for(var/item in owner_mob.held_items)
		if(isnull(item))
			continue
		if(provide_feedback)
			to_chat(owner_mob, span_warning("You cannot ventcrawl while holding items!"))
		return FALSE
	return TRUE

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_cancel(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	animate(ventcrawl_target)

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_enter(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	var/crawl_time = get_ventcrawl_time()
	ventcrawl_target.Shake(pixelshiftx = 1, pixelshifty = 1, duration = crawl_time, shake_interval = 0.3 SECONDS)
	return crawl_time

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_pre_exit(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	var/crawl_time = get_ventcrawl_time()
	playsound(ventcrawl_target, 'sound/effects/bang.ogg', 25)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), crawl_time, 'sound/effects/bang.ogg', 25), ventcrawl_time * 0.6)
	ventcrawl_target.Shake(pixelshiftx = 1, pixelshifty = 1, duration = crawl_time, shake_interval = 0.3 SECONDS)
	return crawl_time

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_exit(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	// cooldown all non-inherent abilities on exit to prevent instant ambushes
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.powers)
		if(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		power.StartCooldown()

/datum/bloodsucker_clan/nosferatu/proc/on_mob_examine(datum/antagonist/bloodsucker/owner_datum, datum/source, mob/examiner, examine_text)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/ogled = owner_datum.owner.current
	var/mob/living/ogler = examiner
	if(isliving(examiner) && examiner != ogled && !ogler.mob_mood.has_mood_of_category("nosferatu_examine"))
		ogler.add_mood_event("nosferatu_examine", /datum/mood_event/nosferatu_examined, ogled, owner_datum.GetRank())
		ogler.adjust_disgust(owner_datum.GetRank() * 10)

/datum/bloodsucker_clan/nosferatu/Destroy(force)
	var/datum/action/cooldown/bloodsucker/feed/suck = locate() in bloodsuckerdatum.powers
	if(suck)
		bloodsuckerdatum.RemovePower(suck)
	bloodsuckerdatum.give_starting_powers()
	bloodsuckerdatum.owner.current.remove_quirk(/datum/quirk/badback)
	bloodsuckerdatum.owner.current.remove_traits(traits_to_add, BLOODSUCKER_TRAIT)
	UnregisterSignal(bloodsuckerdatum, list(COMSIG_BLOODSUCKER_EXAMINE, COMSIG_CAN_VENTCRAWL, COMSIG_VENTCRAWL_PRE_ENTER, COMSIG_VENTCRAWL_PRE_EXIT, COMSIG_VENTCRAWL_EXIT))
	return ..()

/datum/bloodsucker_clan/nosferatu/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	ghouldatum.owner.current.add_traits(traits_to_add, GHOUL_TRAIT)
	ghouldatum.traits += traits_to_add
	ghouldatum.owner.current.update_sight()
	to_chat(ghouldatum.owner.current, span_notice("Additionally, you can now ventcrawl while naked, and are permanently disfigured. You also have night vision, know how which wires to cut, and have silent footsteps."))

/datum/bloodsucker_clan/nosferatu/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	ghouldatum.owner.current.update_sight()

/datum/bloodsucker_clan/nosferatu/handle_clan_life(datum/antagonist/bloodsucker/source, seconds_per_tick, times_fired)
	var/area/nosferatu_loc = get_area(source.owner.current)
	if(nosferatu_loc == /area/station/maintenance)
		source.owner.current.apply_status_effect(/datum/status_effect/nosferatu_effect)

/datum/status_effect/nosferatu_effect
	id = "nosferatu"
	duration = 1.5 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null

/datum/status_effect/nosferatu_effect/on_apply()
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/human/nosferatu = owner
	nosferatu.add_movespeed_modifier(/datum/movespeed_modifier/nosferatu)

/datum/status_effect/nosferatu_effect/on_remove()
	. = ..()
	var/mob/living/carbon/human/nosferatu = owner
	nosferatu.remove_movespeed_modifier(/datum/movespeed_modifier/nosferatu)

/datum/movespeed_modifier/nosferatu
	multiplicative_slowdown = -0.1
