// Тут все заклинания, которые являются направленными, но не прожектайлами.

// Станит на непродолжительный срок и заставляет выкинуть вещи из рук
/datum/action/cooldown/spell/pointed/psionic/spasm
	name = "Psionic Spasm"
	desc = "Force a target to drop the items in its hands. Note that this has a hefty power use and cooldown."
	button_icon_state = "genetics_closed"
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
	playsound(cast_on, 'tff_modular/modules/psionics/sounds/power_evoke.ogg', 50, TRUE)
	return TRUE

// Мед сканер на расстоянии
/datum/action/cooldown/spell/pointed/psionic/skinsight
	name = "Skinsight"
	desc = "Try to read target's vital energy and determine their state."
	button_icon_state = "wiz_blind"
	cooldown_time = 1 SECONDS
	point_cost = 0
	mana_cost = 5
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
	playsound(cast_on, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/jump
	name = "Psionic Jump"
	desc = "Teleport to a destination you click on."
	button_icon_state = "tech_dispel"
	cooldown_time = 30 SECONDS
	psionic_level = 2
	mana_cost = 20
	point_cost = 2
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/jump/can_cast_spell(feedback)
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_NO_TRANSFORM))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/jump/is_valid_target(atom/cast_on)
	if(isclosedturf(cast_on))
		return FALSE
	if(isobj(cast_on))
		return FALSE
	if(!(cast_on in view(owner.client.view, owner)))
		owner.balloon_alert(owner, "out of view!")
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/jump/cast(atom/cast_on)
	. = ..()
	do_teleport(owner, get_turf(cast_on), 1, /obj/effect/temp_visual/dir_setting/ninja, /obj/effect/temp_visual/dir_setting/ninja, 'tff_modular/modules/psionics/sounds/power_fabrication.ogg', channel = TELEPORT_CHANNEL_MAGIC)
	drain_mana()
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/emotional_suggestion
	name = "Psionic Emotional Suggestion"
	desc = "Allows you to psionically commune with the target using emotions."
	button_icon_state = "tech_gambit"
	cooldown_time = 2 SECONDS
	mana_cost = 5
	point_cost = 0
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/is_valid_target(atom/cast_on)
	if(!iscarbon(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/emotional_suggestion/cast(atom/cast_on)
	. = ..()
	emotional_suggestion(cast_on, owner)
	drain_mana()
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/emotional_suggestion/proc/emotional_suggestion(atom/hit_atom, mob/living/user)
	var/mob/living/target = hit_atom
	if(target.stat == DEAD)
		to_chat(user, span_warning("Not even a psion of your level can suggest to the dead."))
		return

	var/text = tgui_input_list(user, "Which emotion would you like to suggest?", "Emotional Suggestion", list("Calm", "Happiness", "Sadness", "Fear", "Anger", "Stress", "Confusion"))
	if(!text)
		return

	text = lowertext(text)

	log_say("[key_name(user)] suggested an emotion to [key_name(target)]: [text]")

	to_chat(user, span_horizonblue("You psionically suggest an emotion to [target]: [text]"))

	var/mob/living/carbon/human/H = target
	var/datum/psionic/target_sensitivity = H.get_psionic()
	if(target_sensitivity)
		to_chat(H, span_notice("<i>[user] blinks, their eyes briefly developing an unnatural shine.</i>"))
		to_chat(H, span_notice("You sense [user]'s psyche link with your own, and an emotion of <b>[text]</b> washes through your mind."))
	else
		to_chat(H, span_notice("An emotion from outside your consciousness slips into your mind: <b>[text]</b>."))

	playsound(H, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/rejuvenate
	name = "Psionic Rejuvenate"
	desc = "Restore a creature's blood and tried to and try to revive it."
	button_icon_state = "tech_resurrect"
	cast_range = 3
	point_cost = 3
	mana_cost = 80
	psionic_level = 2
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/rejuvenate/is_valid_target(atom/cast_on)
	if(iscarbon(cast_on))
		var/mob/living/carbon/human = cast_on
		if(human.stat == DEAD)
			return TRUE
		return FALSE
	return FALSE

/datum/action/cooldown/spell/pointed/psionic/rejuvenate/cast(atom/cast_on)
	. = ..()
	if(iscarbon(cast_on))
		var/mob/living/carbon/carbon_living = cast_on
		for(var/i in 1 to 3)
			if(!do_after(owner, 5 SECONDS, carbon_living, timed_action_flags = IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE))
				return FALSE

			carbon_living.heal_overall_damage(30, 30)
			playsound(carbon_living, 'sound/effects/singlebeat.ogg', vol = 50, vary = TRUE, ignore_walls = FALSE)
			playsound(carbon_living, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
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

		to_chat(owner, span_horizonblue("You successfully revive \the [owner]!"))
		drain_mana()
	else
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/stasis
	name = "Psionic Stasis"
	desc = "Condenses the Nlom field around one person at a time. This immobilises them and also applies stasis to them."
	button_icon_state = "gen_ice"
	cooldown_time = 60 SECONDS
	point_cost = 1
	psionic_level = 2
	mana_cost = 30
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/stasis/is_valid_target(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/stasis/cast(atom/cast_on)
	. = ..()
	var/mob/living/freezing = cast_on
	if(!do_after(owner, 2 SECONDS, freezing, IGNORE_TARGET_LOC_CHANGE | IGNORE_USER_LOC_CHANGE | IGNORE_SLOWDOWNS | IGNORE_HELD_ITEM))
		return FALSE
	var/duration = cast_power * 4 SECONDS
	freezing.apply_status_effect(/datum/status_effect/freon/watcher/psionic, duration)
	playsound(freezing, 'tff_modular/modules/psionics/sounds/power_evoke.ogg', 50, TRUE)

/datum/status_effect/freon/watcher/psionic/on_creation(mob/living/new_owner, new_duration)
	. = ..()
	duration = new_duration

/datum/action/cooldown/spell/pointed/psionic/bubble
	name = "Psionic Bubble"
	desc = "Create a protective bubble around you or target that removes your need to breathe or wear space protection!"
	button_icon_state = "tech_condensation"
	point_cost = 1
	cooldown_time = 30 SECONDS
	mana_cost = 10
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/bubble/is_valid_target(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/bubble/cast(atom/cast_on)
	. = ..()
	var/mob/living/living_living = cast_on
	var/duration = cast_power * 15 SECONDS
	living_living.apply_status_effect(/datum/status_effect/psi_bubble, duration)
	playsound(cast_on, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	return TRUE

/datum/status_effect/psi_bubble
	id = "psi_bubble"
	alert_type = /atom/movable/screen/alert/status_effect/psi_bubble
	tick_interval = STATUS_EFFECT_AUTO_TICK
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	duration = 15 SECONDS
	show_duration = TRUE
	var/icon/bubbleicon

/datum/status_effect/psi_bubble/on_creation(mob/living/new_owner, set_duration)
	if(isnum(set_duration))
		duration = set_duration
	return ..()

/datum/status_effect/psi_bubble/on_apply()
	. = ..()
	bubbleicon = icon(icon = 'icons/effects/effects.dmi', icon_state = "bubbles")
	owner.add_overlay(bubbleicon)
	owner.add_traits(list(TRAIT_OXYIMMUNE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD), PSIONIC_TRAIT)
	RegisterSignal(owner, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	return TRUE

/datum/status_effect/psi_bubble/on_remove()
	. = ..()
	owner.cut_overlay(bubbleicon)
	owner.remove_traits(list(TRAIT_OXYIMMUNE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD), PSIONIC_TRAIT)
	UnregisterSignal(owner, COMSIG_ATOM_EXAMINE)
	return TRUE

/datum/status_effect/psi_bubble/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_horizonblue("[source.p_Theyre()] covered with strange bubbles!")

/atom/movable/screen/alert/status_effect/psi_bubble
	name = "Air Bubble"
	desc = "There is a protective bubble around you that removes your need to breathe or wear space protection!"
	overlay_icon = 'icons/effects/effects.dmi'
	overlay_state = "shield2"

/datum/action/cooldown/spell/pointed/psionic/barrier
	name = "Barrier"
	desc = "Give yourself or a target psionic armour."
	button_icon_state = "tech_frostaura"
	category = "Tier 2"
	cooldown_time = 60 SECONDS
	psionic_level = 2
	point_cost = 1
	mana_cost = 30
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/barrier/is_valid_target(atom/cast_on)
	. = ..()
	if(!ishuman(cast_on))
		return FALSE

/datum/action/cooldown/spell/pointed/psionic/barrier/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/artificer = cast_on
	var/duration = 20 SECONDS * cast_power
	artificer.apply_status_effect(/datum/status_effect/psionic_armour, duration)
	playsound(artificer, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	return TRUE

/datum/status_effect/psionic_armour
	id = "psionic_armour"
	duration = 20 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/psionic_armour
	show_duration = TRUE

/datum/status_effect/psionic_armour/on_creation(mob/living/new_owner, new_duration)
	. = ..()
	duration = new_duration

/datum/status_effect/psionic_armour/on_apply()
	. = ..()
	var/mob/living/carbon/human/affected = owner
	ADD_TRAIT(affected, TRAIT_HARDLY_WOUNDED, PSIONIC_TRAIT)
	affected.physiology.brute_mod *= 0.75
	affected.physiology.burn_mod *= 0.75
	affected.physiology.stamina_mod *= 0.25
	return TRUE

/datum/status_effect/psionic_armour/on_remove()
	. = ..()
	var/mob/living/carbon/human/affected = owner
	REMOVE_TRAIT(affected, TRAIT_HARDLY_WOUNDED, PSIONIC_TRAIT)
	affected.physiology.brute_mod /= 0.75
	affected.physiology.burn_mod /= 0.75
	affected.physiology.stamina_mod /= 0.25
	return TRUE

/atom/movable/screen/alert/status_effect/psionic_armour
	name = "Psionic Armour"
	desc = "You covered with Psi Armour, and any damage you receive is reduced!"
	overlay_icon = 'tff_modular/modules/psionics/icons/spells.dmi'
	overlay_state = "tech_frostaura"

/datum/action/cooldown/spell/pointed/psionic/psi_throw
	name = "Psionic Throw"
	desc = "Throw an object in the opposite direction from yourself. Works on living beings."
	button_icon_state = "wiz_mm"
	category = "Tier 2"
	cooldown_time = 30 SECONDS
	psionic_level = 2
	point_cost = 2
	mana_cost = 20
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/psi_throw/is_valid_target(atom/cast_on)
	if(cast_on == owner)
		return FALSE
	if(isobj(cast_on) || isliving(cast_on))
		var/atom/movable/AM = cast_on
		if(AM.anchored)
			return FALSE
		return TRUE
	return FALSE

/datum/action/cooldown/spell/pointed/psionic/psi_throw/cast(atom/cast_on)
	. = ..()
	var/turf/throwtarget = get_edge_target_turf(owner, get_dir(owner, get_step_away(cast_on, owner)))
	var/dist_from_caster = get_dist(cast_on, owner)
	if(dist_from_caster == 0)
		if(isliving(cast_on))
			var/mob/living/victim = cast_on
			victim.Paralyze(10 SECONDS)
			victim.adjust_brute_loss(5)
			to_chat(victim, span_userdanger("You're psionically slammed into the floor by [owner]!"))
	else
		if(isliving(cast_on))
			var/mob/living/victim = cast_on
			victim.Paralyze(2 SECONDS)
			to_chat(victim, span_userdanger("You're psionically thrown back by [owner]!"))

		var/atom/movable/to_throw = cast_on
		to_throw.safe_throw_at(
			target = throwtarget,
			range = 4 * cast_power,
			speed = 2,
			thrower = owner,
			force = MOVE_FORCE_STRONG,
		)

	playsound(owner, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	drain_mana()
	return TRUE


/datum/action/cooldown/spell/pointed/psionic/mind_muddle
	name = "Psionic Mind Muddle"
	desc = "Use this at range to confuse a target and give them a little bit of pain."
	button_icon_state = "wiz_tele"
	cooldown_time = 20 SECONDS
	psionic_level = 1
	point_cost = 2
	mana_cost = 10
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/mind_muddle/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/mind_muddle/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/victim = cast_on
	if(!do_after(owner, 2 SECONDS, victim, IGNORE_TARGET_LOC_CHANGE | IGNORE_USER_LOC_CHANGE | IGNORE_SLOWDOWNS | IGNORE_HELD_ITEM))
		return FALSE
	victim.adjust_stamina_loss(20 * cast_power)
	victim.adjust_confusion(3 SECONDS * cast_power)
	playsound(victim, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/drain
	name = "Psionic Drain"
	desc = "Drain psi-stamina from a living being."
	button_icon_state = "gen_project"
	cooldown_time = 10 SECONDS
	psionic_level = 1
	point_cost = 2
	mana_cost = 0
	locked = FALSE
	cast_range = 3

/datum/action/cooldown/spell/pointed/psionic/drain/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/drain/cast(atom/cast_on)
	. = ..()
	drain_psi_stamina(cast_on)
	to_chat(cast_on, span_horizonblue("You begin to feel weak..."))

/datum/action/cooldown/spell/pointed/psionic/drain/proc/drain_psi_stamina(atom/cast_on)
	var/mob/living/carbon/human/victim = cast_on
	if(!do_after(owner, 1 SECONDS, victim, IGNORE_TARGET_LOC_CHANGE))
		return FALSE
	victim.adjust_stamina_loss(10)
	psionic_datum.adjust_psi_energy(10)
	to_chat(victim, span_horizonblue("You're getting worse..."))
	playsound(victim, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	drain_psi_stamina(victim)

/datum/action/cooldown/spell/pointed/psionic/warp
	name = "Psionic Warp"
	desc = "Warp through objects."
	button_icon_state = "tech_blink"
	category = "Tier 2"
	cooldown_time = 60 SECONDS
	psionic_level = 2
	point_cost = 2
	mana_cost = 30
	locked = FALSE
	cast_range = 2
	var/turf/target_turf

/datum/action/cooldown/spell/pointed/psionic/warp/is_valid_target(atom/cast_on)
	. = ..()
	var/turf/closed/wall/turf_we_check = cast_on
	if(!iswallturf(turf_we_check))
		to_chat(owner, span_horizonblue("Target must be a wall!"))
		return FALSE
	if(!turf_we_check.density)
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/warp/cast(atom/cast_on)
	. = ..()
	var/turf/closed/wall/density_object = cast_on
	density_object.warp()
	drain_mana()

/turf/closed/wall
	var/warped = FALSE

/turf/closed/wall/proc/warp()
	density = 0
	animate(src, alpha = 75, time = 2 SECONDS)
	warped = TRUE
	RegisterSignal(src, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/turf/closed/wall/proc/unwarp()
	density = initial(density)
	animate(src, alpha = initial(alpha), time = 2 SECONDS)
	warped = FALSE
	UnregisterSignal(src, COMSIG_ATOM_EXAMINE)

/turf/closed/wall/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(warped)
		to_chat(user, span_horizonblue("The wall begins to return to its condition... For some reason."))
		unwarp()

/turf/closed/wall/proc/on_examine(datum/source, mob/user, text)
	SIGNAL_HANDLER
	text += span_horizonblue("This wall... Doesn't exist?")

/datum/action/cooldown/spell/pointed/psionic/pull
	name = "Psionic Pull"
	desc = "Pulls the target straight towards the user. Even if the item is big, it's cant harm you on impact. Note that you can catch items you pull to yourself if you toggle throw mode before pulling an item."
	button_icon_state = "tech_passwall"
	category = "Tier 2"
	cooldown_time = 60 SECONDS
	psionic_level = 2
	point_cost = 1
	mana_cost = 30
	locked = FALSE
	cast_range = 5

/datum/action/cooldown/spell/pointed/psionic/pull/is_valid_target(atom/cast_on)
	if(cast_on == owner)
		return FALSE
	if(isobj(cast_on) || isliving(cast_on))
		var/atom/movable/AM = cast_on
		if(AM.anchored)
			return FALSE
		return TRUE
	return FALSE

/datum/action/cooldown/spell/pointed/psionic/pull/cast(atom/cast_on)
	. = ..()
	var/atom/movable/AM = cast_on
	var/mob/living/carbon/human/user = owner
	if(isobj(cast_on))
		var/obj/object = cast_on
		if(object.anchored)
			to_chat(user, span_warning("That object cant be moved!"))
			return
	user.visible_message(span_warning("[user] extends [user.p_their()] hand at [cast_on] and pulls!"), span_warning("You mimic pulling at [cast_on]!"))
	if(ismob(cast_on))
		to_chat(cast_on, span_warning("A psychic force pulls you!"))
	AM.safe_throw_at(user, 10, 1, user, gentle = TRUE)
	playsound(user, 'tff_modular/modules/psionics/sounds/power_evoke.ogg', 40)
	drain_mana()

/datum/action/cooldown/spell/pointed/psionic/expansion
	name = "Psionic Expansion"
	desc = "Allows the selected target to see living creatures through walls."
	button_icon_state = "gen_rmind"
	category = "Tier 2"
	cooldown_time = 40 SECONDS
	psionic_level = 2
	point_cost = 1
	mana_cost = 10
	locked = FALSE
	cast_range = 5

/datum/action/cooldown/spell/pointed/psionic/expansion/is_valid_target(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	if(HAS_TRAIT(cast_on, TRAIT_THERMAL_VISION))
		to_chat(cast_on, span_warning("The target doesn't need it!"))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/expansion/cast(atom/cast_on)
	. = ..()
	var/mob/living/getting_vision = cast_on
	var/new_duration = 15 SECONDS * cast_power
	getting_vision.apply_status_effect(/datum/status_effect/thermal_vision, new_duration)
	drain_mana()

/datum/status_effect/thermal_vision
	id = "thermal_vision"
	duration = 15 SECONDS
	show_duration = TRUE
	alert_type = null

/datum/status_effect/thermal_vision/on_creation(mob/living/new_owner, new_duration)
	. = ..()
	duration = new_duration

/datum/status_effect/thermal_vision/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, PSIONIC_TRAIT)
	owner.update_sight()

/datum/status_effect/thermal_vision/on_remove()
	. = ..()
	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, PSIONIC_TRAIT)
	owner.update_sight()

/datum/action/cooldown/spell/pointed/psionic/singularity
	name = "Psionic Singularity"
	desc = "Creates a psionic illusion. Anyone within four tiles of it is forced to walk towards it. It will dissipate after ten seconds."
	button_icon_state = "tech_energysiphon"
	category = "Tier 2"
	point_cost = 2
	cooldown_time = 40 SECONDS
	psionic_level = 2
	mana_cost = 10
	locked = FALSE
	cast_range = 3

/datum/action/cooldown/spell/pointed/psionic/singularity/is_valid_target(atom/cast_on)
	if(isturf(cast_on))
		return TRUE
	return FALSE

/datum/action/cooldown/spell/pointed/psionic/singularity/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_horizonblue("[owner] raises his hands up, directing a strange energy to the floor near him..."), span_horizonblue("You're now directing a strange energy, creating Singularity."))
	new /obj/effect/singularity(get_turf(cast_on))
	drain_mana()
	return TRUE

/obj/effect/singularity
	anchored = TRUE
	name = "Singularity"
	desc = "It's so......"
	icon = 'icons/obj/machines/engine/singularity.dmi'
	icon_state = "dark_matter_s1"
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/list/immune = list()
	var/hypnorange = 2
	var/duration = 100

/obj/effect/singularity/Initialize(mapload, radius, time, list/immune_atoms)
	. = ..()
	if(!isnull(time))
		duration = time
	if(!isnull(radius))
		hypnorange = radius
	if(!isnull(immune_atoms))
		for(var/mob/living/A in immune_atoms)
			immune += A
	START_PROCESSING(SSobj, src)

/obj/effect/singularity/process(seconds_per_tick)
	. = ..()
	for(var/mob/living/carbon/victims as anything in view(hypnorange, get_turf(src)))
		if(victims.can_block_magic(MAGIC_RESISTANCE_MIND, charge_cost = 0))
			continue
		if(victims.Adjacent(src))
			continue
		step_towards(victims, src, 1)

	duration -= seconds_per_tick
	if(duration <= 0)
		qdel(src)

/obj/effect/singularity/Destroy(force)
	. = ..()
	STOP_PROCESSING(SSobj, src)
