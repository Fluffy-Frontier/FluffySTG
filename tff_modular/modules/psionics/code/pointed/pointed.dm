// Тут все заклинания, которые являются направленными, но не прожектайлами.

// Станит на непродолжительный срок и заставляет выкинуть вещи из рук
/datum/action/cooldown/spell/pointed/psionic/spasm
	name = "Psionic Spasm"
	desc = "Force a target to drop the items in its hands. Note that this has a hefty power use and cooldown."
	button_icon = 'tff_modular/modules/psionics/icons/actions.dmi'
	button_icon_state = "spasm"
	cooldown_time = 100 SECONDS
	mana_cost = 20
	psionic_level = 2
	target_msg = "Your muscles spasm!"
	active_msg = "You prepare to stun a target..."
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/spasm/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE

	if(issynthetic(cast_on) && cast_power < 2)
		to_chat(owner, span_notice("I dont know how to work with synths."))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/psionic/spasm/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(cast_on, span_warning("Your body is assaulted with psionic energy!"))
	else
		to_chat(cast_on, span_warning(target_msg))
	log_combat(owner, cast_on, "psionically spasmed")
	cast_on.Stun(1 SECONDS * cast_power)
	drain_mana()
	return TRUE

// Мед сканер на расстоянии
/datum/action/cooldown/spell/pointed/psionic/skinsight
	name = "Skinsight"
	desc = "Try to read target's vital energy and determine their state."
	button_icon = 'tff_modular/modules/psionics/icons/actions.dmi'
	button_icon_state = "roentgen"
	cooldown_time = 1 SECONDS
	point_cost = 0
	mana_cost = 10
	target_msg = "You feel like someone is looking deep into you."
	active_msg = "You prepare to scan a target..."
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/skinsight/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/psionic/skinsight/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(cast_on, span_notice("Your body is being read by a psionic nearby."))
	else
		to_chat(cast_on, span_warning(target_msg))
	if(cast_power >= 2)
		healthscan(owner, cast_on, SCANNER_VERBOSE, TRUE, tochat = TRUE)
	else
		healthscan(owner, cast_on, SCANNER_VERBOSE, FALSE, tochat = TRUE)
	drain_mana()
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/jump
	name = "Psionic Jump"
	desc = "Teleport to a destination you click on."
	button_icon_state = "warp_strike"
	cooldown_time = 15 SECONDS
	psionic_level = 2
	mana_cost = 20
	point_cost = 2
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/jump/is_valid_target(atom/cast_on)
	. = ..()
	if(isclosedturf(cast_on))
		return FALSE
	if(isobj(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/jump/cast(atom/cast_on)
	. = ..()
	if(isliving(cast_on))
		do_teleport(owner, cast_on.loc, effectin = /obj/effect/temp_visual/wizard, effectout = /obj/effect/temp_visual/wizard/out)
	else if(isturf(cast_on))
		do_teleport(owner, cast_on.loc, effectin = /obj/effect/temp_visual/wizard, effectout = /obj/effect/temp_visual/wizard/out)
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/emotional_suggestion
	name = "Psionic Emotional Suggestion"
	desc = "Allows you to psionically commune with the target using emotions."
	cooldown_time = 2 SECONDS
	mana_cost = 5
	point_cost = 0
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/emotional_suggestion/cast(atom/cast_on)
	. = ..()
	if(iscarbon(cast_on))
		emotional_suggestion(cast_on, owner)
		return TRUE
	else
		return FALSE

/datum/action/cooldown/spell/pointed/psionic/emotional_suggestion/proc/emotional_suggestion(atom/hit_atom, mob/living/user)
	if(!isliving(hit_atom))
		return

	var/mob/living/carbon/target = hit_atom
	if(target.stat == DEAD)
		to_chat(user, span_warning("Not even a psion of your level can suggest to the dead."))
		return

	var/text = tgui_input_list(user, "Which emotion would you like to suggest?", "Emotional Suggestion", list("Calm", "Happiness", "Sadness", "Fear", "Anger", "Stress", "Confusion"))
	if(!text)
		return

	text = lowertext(text)

	if(target.stat == DEAD)
		to_chat(user, span_warning("Not even a psion of your level can suggest to the dead."))
		return

	log_say("[key_name(user)] suggested an emotion to [key_name(target)]: [text]")

	to_chat(user, span_horizonblue("You psionically suggest an emotion to [target]: [text]"))

	var/mob/living/carbon/human/H = target
	var/datum/psionic/target_sensitivity = H.get_psionic()
	if(target_sensitivity)
		to_chat(H, span_notice("<i>[user] blinks, their eyes briefly developing an unnatural shine.</i>"))
		to_chat(H, span_notice("You sense [user]'s psyche link with your own, and an emotion of <b>[text]</b> washes through your mind."))
	else
		to_chat(H, span_notice("An emotion from outside your consciousness slips into your mind: <b>[text]</b>."))
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/rejuvenate
	name = "Rejuvenate"
	desc = "Restore a creature's blood and tried to and try to revive it."
	button_icon_state = "mend_all"
	cast_range = 3
	point_cost = 3
	mana_cost = 80
	psionic_level = 2
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/rejuvenate/is_valid_target(atom/cast_on)
	. = ..()
	if(!isliving(cast_on))
		return FALSE
	if(!isdead(cast_on))
		return FALSE
	var/mob/living/carbon/reviving = cast_on
	if(HAS_TRAIT(reviving, TRAIT_DNR))
		owner.balloon_alert(owner, "no soul!")
		return FALSE
	if(!reviving.get_organ_slot(ORGAN_SLOT_BRAIN))
		owner.balloon_alert(owner, "no brain!")
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/rejuvenate/cast(atom/cast_on)
	. = ..()
	if(isbasicmob(cast_on))
		var/mob/living/basic/basic_living = cast_on
		for(var/i in 1 to 3)
			if (!do_after(owner, 3 SECONDS, basic_living, timed_action_flags = IGNORE_INCAPACITATED | IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE))
				return FALSE

			basic_living.heal_overall_damage(30, 30)

			playsound(basic_living, 'sound/effects/singlebeat.ogg', vol = 50, vary = TRUE, ignore_walls = FALSE)

			var/original_transform = basic_living.transform
			animate(basic_living, transform = basic_living.transform.Translate(0, 3), time = 0.2 SECONDS, easing = CUBIC_EASING | EASE_OUT, flags = ANIMATION_PARALLEL)
			animate(transform = original_transform, time = 0.2 SECONDS, easing = CUBIC_EASING | EASE_IN, flags = ANIMATION_PARALLEL)

			basic_living.visible_message(
				message = span_danger("\The [basic_living] shake[basic_living.p_their()] violently!"),
				ignored_mobs = owner
			)

		if(!basic_living.revive())
			owner.balloon_alert(owner, "revival failed!")
			return FALSE

		drain_mana()
		to_chat(owner, span_green("You successfully revive \the [owner]!"))
		return TRUE

	else if(iscarbon(cast_on))
		var/mob/living/carbon/carbon_living = cast_on
		for(var/i in 1 to 3)
			if (!do_after(owner, 5 SECONDS, carbon_living, timed_action_flags = IGNORE_INCAPACITATED | IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE))
				return FALSE

			carbon_living.heal_overall_damage(30, 30)
			playsound(carbon_living, 'sound/effects/singlebeat.ogg', vol = 50, vary = TRUE, ignore_walls = FALSE)

			var/original_transform = carbon_living.transform
			animate(carbon_living, transform = carbon_living.transform.Translate(0, 3), time = 0.2 SECONDS, easing = CUBIC_EASING | EASE_OUT, flags = ANIMATION_PARALLEL)
			animate(transform = original_transform, time = 0.2 SECONDS, easing = CUBIC_EASING | EASE_IN, flags = ANIMATION_PARALLEL)

			carbon_living.visible_message(
				message = span_danger("\The [carbon_living] shake[carbon_living.p_their()] violently!"),
				ignored_mobs = owner
			)

		carbon_living.cure_husk()
		carbon_living.regenerate_organs(TRUE)
		carbon_living.regenerate_limbs()
		carbon_living.adjust_blood_volume(BLOOD_VOLUME_NORMAL, 0, BLOOD_VOLUME_NORMAL)
		if(!carbon_living.revive())
			owner.balloon_alert(owner, "revival failed!")
			return FALSE

		to_chat(owner, span_green("You successfully revive \the [owner]!"))
		drain_mana()
		return TRUE

/datum/action/cooldown/spell/pointed/psionic/stasis
	name = "Stasis"
	desc = "Condenses the Nlom field around one person at a time. This immobilises them and also applies stasis to them."
	button_icon_state = "condensation"
	point_cost = 1
	psionic_level = 2
	mana_cost = 30
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/stasis/is_valid_target(atom/cast_on)
	. = ..()
	if(!isliving(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/stasis/cast(atom/cast_on)
	. = ..()
	var/mob/living/freezing = cast_on
	var/duration = cast_power * 4 SECONDS
	freezing.set_timed_status_effect(duration, /datum/status_effect/freon/watcher)

/datum/action/cooldown/spell/pointed/psionic/bubble
	name = "Psionic Bubble"
	desc = "Create a protective bubble around you or target that removes your need to breathe or wear space protection!"
	button_icon_state = "shield"
	point_cost = 1
	cooldown_time = 30 SECONDS
	mana_cost = 10
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/bubble/is_valid_target(atom/cast_on)
	. = ..()
	if(!isliving(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/bubble/cast(atom/cast_on)
	. = ..()
	var/mob/living/living_living = cast_on
	var/duration = cast_power * 15 SECONDS
	living_living.set_timed_status_effect(duration, /datum/status_effect/psi_bubble)

/datum/status_effect/psi_bubble
	id = "psi_bubble"
	alert_type = /atom/movable/screen/alert/psi_bubble
	duration = 15 SECONDS
	var/icon/bubbleicon

/datum/status_effect/psi_bubble/on_apply()
	. = ..()
	bubbleicon = icon(icon = 'icons/effects/effects.dmi', icon_state = "shield2")
	owner.add_overlay(bubbleicon)
	owner.add_traits(list(TRAIT_OXYIMMUNE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD))

/datum/status_effect/psi_bubble/on_remove()
	. = ..()
	owner.cut_overlay(bubbleicon)

/atom/movable/screen/alert/psi_bubble
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield2"
	name = "Air Bubble"
	desc = "There is a protective bubble around you that removes your need to breathe or wear space protection!"
