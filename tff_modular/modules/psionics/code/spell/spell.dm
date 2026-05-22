// Создаёт ЕМП в месте удара руки
/datum/action/cooldown/spell/psionic/emp
	name = "Ion Blast"
	desc = "Cause a small, but powerful EMP."
	button_icon_state = "tech_overload"
	cooldown_time = 15 SECONDS
	mana_cost = 30
	psionic_level = 2
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/psionic/emp/cast(atom/cast_on)
	. = ..()
	empulse(cast_on.loc, 3, 3)
	playsound(cast_on, 'tff_modular/modules/psionics/sounds/power_fail.ogg', 50, TRUE)
	drain_mana()

/datum/action/cooldown/spell/psionic/focus
	name = "Psionic Focus"
	desc = "Creates a useful reagents inside of you, removing stun."
	button_icon_state = "tech_haste"
	category = "Tier 2"
	cooldown_time = 50 SECONDS
	mana_cost = 20
	point_cost = 1
	psionic_level = 2
	locked = FALSE

/datum/action/cooldown/spell/psionic/focus/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/human_living = cast_on
	if(do_after(human_living, 1 SECONDS, timed_action_flags = IGNORE_SLOWDOWNS | IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM))
		to_chat(human_living, span_warning("A calm rush envelops your mind.."))
		human_living.reagents.add_reagent_list(list(/datum/reagent/medicine/ephedrine = 5, /datum/reagent/medicine/synaptizine = 5, /datum/reagent/medicine/epinephrine = 5))
		human_living.SetStun(0)
		human_living.SetParalyzed(0)
		human_living.SetSleeping(0)
		human_living.SetAllImmobility(0)
		drain_mana()
		playsound(human_living, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	else
		return FALSE

/datum/action/cooldown/spell/psionic/charge
	name = "Psionic Charge"
	desc = "Use this spell on an item with a cell to charge it."
	button_icon_state = "wiz_charge"
	cooldown_time = 60 SECONDS
	mana_cost = 10
	point_cost = 1
	psionic_level = 1
	locked = FALSE

/datum/action/cooldown/spell/psionic/charge/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/psionic/charge/cast(mob/living/cast_on)
	. = ..()

	// Charge people we're pulling first and foremost
	if(isliving(cast_on.pulling) && cast_power >= 2)
		var/mob/living/pulled_living = cast_on.pulling
		var/pulled_has_spells = FALSE

		for(var/datum/action/cooldown/spell/spell in pulled_living.actions)
			spell.reset_spell_cooldown()
			pulled_has_spells = TRUE

		if(pulled_has_spells)
			to_chat(pulled_living, span_notice("You feel psi flowing through you. It feels good!"))
			to_chat(cast_on, span_notice("[pulled_living] suddenly feels very warm!"))
			return

		to_chat(pulled_living, span_notice("You feel very strange for a moment, but then it passes."))

	// Then charge their main hand item, then charge their offhand item
	var/obj/item/to_charge = cast_on.get_active_held_item() || cast_on.get_inactive_held_item()
	if(!to_charge)
		to_chat(cast_on, span_notice("You feel magical power surging through your hands, but the feeling rapidly fades."))
		return

	var/charge_return = SEND_SIGNAL(to_charge, COMSIG_ITEM_MAGICALLY_CHARGED, src, cast_on)

	if(QDELETED(to_charge))
		to_chat(cast_on, span_warning("[src] seems to react adversely with [to_charge]!"))
		return

	if(charge_return & COMPONENT_ITEM_BURNT_OUT)
		to_chat(cast_on, span_warning("[to_charge] seems to react negatively to [src], becoming uncomfortably warm!"))

	else if(charge_return & COMPONENT_ITEM_CHARGED)
		to_chat(cast_on, span_notice("[to_charge] suddenly feels very warm!"))

	else
		to_chat(cast_on, span_notice("[to_charge] doesn't seem to be react to [src]."))

	drain_mana()
	playsound(cast_on, 'tff_modular/modules/psionics/sounds/power_fabrication.ogg', 50, TRUE)

/datum/action/cooldown/spell/psionic/suppression
	name = "Psionic Suppression"
	desc = "Suppress your psionic energy, making you invisible to other psionics, but you can't use psionic abilities."
	button_icon_state = "tech_shield"
	category = "Tier 2"
	cooldown_time = 30 SECONDS
	psionic_level = 2
	mana_cost = 0
	point_cost = 0
	ignore_suppression = TRUE
	locked = FALSE
	var/suppressing = FALSE

/datum/action/cooldown/spell/psionic/suppression/cast(atom/cast_on)
	. = ..()
	if(suppressing || HAS_TRAIT_FROM(cast_on, TRAIT_PSIONIC_SUPPRESSED, ACTION_TRAIT))
		REMOVE_TRAIT(cast_on, TRAIT_PSIONIC_SUPPRESSED, ACTION_TRAIT)
	else
		ADD_TRAIT(cast_on, TRAIT_PSIONIC_SUPPRESSED, ACTION_TRAIT)

/datum/action/cooldown/spell/psionic/sunder
	name = "Psionic Sunder"
	desc = "Destroy a Zona Bovinae of psionic creature you pulling. This will make them force-suppressed."
	button_icon_state = "ling_berserk"
	category = "Tier 2"
	cooldown_time = 10 SECONDS
	psionic_level = 2
	mana_cost = 30
	point_cost = 1
	locked = FALSE

/datum/action/cooldown/spell/psionic/sunder/before_cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/human_living = cast_on
	var/mob/living/carbon/human/victim = human_living.pulling
	var/datum/psionic/victim_psionic = victim.get_psionic()
	if(!victim)
		to_chat(human_living, span_horizonblue("You must grab victim to use this ability!"))
		return FALSE
	if(!victim_psionic)
		to_chat(human_living, span_horizonblue("Not a Psionic!"))
		return FALSE
	if(victim_psionic.get_level() > 1)
		to_chat(human_living, span_horizonblue("Their psi mind is too strong!"))
		return FALSE

/datum/action/cooldown/spell/psionic/sunder/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/human_living = cast_on
	var/mob/living/carbon/human/victim = human_living.pulling
	to_chat(victim, span_big(span_horizonblue("You feel your psionic energy leaving your mind...")))
	if(!do_after(human_living, 10 SECONDS, victim))
		return FALSE
	ADD_TRAIT(victim, TRAIT_PSIONIC_SUPPRESSED, SUNDER_TRAIT)
	playsound(human_living, 'tff_modular/modules/psionics/sounds/power_fabrication.ogg', 50, TRUE)

/datum/action/cooldown/spell/psionic/stamina
	name = "Psionic Stamina Weave"
	desc = "Activate this spell to regenerate your psi-mana a little bit."
	button_icon_state = "tech_mend_template"
	point_cost = 1
	cooldown_time = 20 SECONDS
	mana_cost = 0
	locked = FALSE
	var/charging = FALSE

/datum/action/cooldown/spell/psionic/stamina/cast(atom/cast_on)
	. = ..()
	regenerate_stamina(cast_on)
	return TRUE

/datum/action/cooldown/spell/psionic/stamina/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return charging

/datum/action/cooldown/spell/psionic/stamina/proc/regenerate_stamina(mob/living/carbon/human/human_living)
	if(!do_after(human_living, 1 SECONDS))
		charging = FALSE
		return FALSE
	charging = TRUE
	psionic_datum.adjust_psi_energy(5)
	playsound(human_living, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	regenerate_stamina(human_living)

/datum/action/cooldown/spell/psionic/search
	name = "Psionic Search"
	desc = "Scan your Z-level for Nlom signatures."
	button_icon_state = "wiz_shield"
	mana_cost = 5
	cooldown_time = 10 SECONDS
	point_cost = 1
	locked = FALSE

/datum/action/cooldown/spell/psionic/search/cast(atom/cast_on)
	. = ..()
	var/list/alive_list = list()
	var/mob/living/carbon/human/searcher = cast_on
	for(var/mob/living/carbon/human/alive in world)
		var/datum/psionic/psi_datum = alive.get_psionic()
		if(!is_valid_z_level(alive.loc, searcher.loc))
			continue
		if(alive.stat == DEAD)
			continue
		if(!psi_datum)
			continue
		if(psi_datum.is_suppressed())
			continue
		alive_list += alive

	var/mob/living/carbon/who_to_find = tgui_input_list(searcher, "Who you want to find?", "Psionic Search", alive_list)
	if(!who_to_find || who_to_find.stat == DEAD || QDELETED(searcher))
		return FALSE

	var/area/place = get_area(who_to_find)
	to_chat(searcher, span_horizonblue("The one who you looking for at... [place.name]"))
	playsound(searcher, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)

/datum/action/cooldown/spell/psionic/nlom_eyes
	name = "Nlom Eyes"
	desc = "Roughly locate a mob on your z-level."
	button_icon_state = "tech_control"
	mana_cost = 5
	cooldown_time = 30 SECONDS
	point_cost = 1
	locked = FALSE
	psionic_level = 2
	category = "Tier 2"
	var/datum/status_effect/agent_pinpointer/scan/navigator

/datum/action/cooldown/spell/psionic/nlom_eyes/cast(atom/cast_on)
	. = ..()
	var/list/signatures_list = list()
	for(var/mob/living/carbon/human/mob_signatures as anything in world)
		if(!iscarbon(mob_signatures))
			continue
		if(!is_valid_z_level(cast_on.loc, mob_signatures))
			continue
		if(mob_signatures.stat == DEAD)
			continue
		signatures_list += mob_signatures

	var/mob/living/carbon/who_to_find = tgui_input_list(cast_on, "Choose who you want to find?", "Nlom Eyes", signatures_list)
	if(!who_to_find || who_to_find.stat == DEAD || QDELETED(cast_on))
		return FALSE

	playsound(owner, 'tff_modular/modules/psionics/sounds/power_fabrication.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
	owner.balloon_alert(owner, get_balloon_message(who_to_find))
	drain_mana()

/// Gets the balloon message for who we're tracking.
/datum/action/cooldown/spell/psionic/nlom_eyes/proc/get_balloon_message(atom/tracked_thing)
	var/balloon_message = "error text!"
	var/turf/their_turf = get_turf(tracked_thing)
	var/turf/our_turf = get_turf(owner)
	var/their_z = their_turf?.z
	var/our_z = our_turf?.z

	// One of us is in somewhere we shouldn't be
	if(!our_z || !their_z)
		// "Hell if I know"
		balloon_message = "on another plane!"

	// They're not on the same z-level as us
	else if(our_z != their_z)
		// They're on the station
		if(is_station_level(their_z))
			// We're on a multi-z station
			if(is_station_level(our_z))
				if(our_z > their_z)
					balloon_message = "below you!"
				else
					balloon_message = "above you!"
			// We're off station, they're not
			else
				balloon_message = "on station!"

		// Mining
		else if(is_mining_level(their_z))
			balloon_message = "on lavaland!"

		// In the gateway
		else if(is_away_level(their_z) || is_secret_level(their_z))
			balloon_message = "beyond the gateway!"

		// They're somewhere we probably can't get too - sacrifice z-level, centcom, etc
		else
			balloon_message = "on another plane!"

	// They're on the same z-level as us!
	else
		var/dist = get_dist(our_turf, their_turf)
		var/dir = get_dir(our_turf, their_turf)

		var/arrow_color

		switch(dist)
			if(0 to 15)
				balloon_message = "very near, [dir2text(dir)]!"
				arrow_color = COLOR_CARP_LIGHT_BLUE
			if(16 to 31)
				balloon_message = "near, [dir2text(dir)]!"
				arrow_color = COLOR_BLUE
			if(32 to 127)
				balloon_message = "far, [dir2text(dir)]!"
				arrow_color = COLOR_CARP_DARK_BLUE
			else
				balloon_message = "very far!"
				arrow_color = COLOR_DARK

		if(owner.hud_used)
			var/atom/movable/screen/navigate_arrow/arrow = owner.hud_used.add_screen_object(/atom/movable/screen/navigate_arrow, HUD_PSIONIC_ARROW, HUD_GROUP_INFO, update_screen = TRUE)
			arrow.start_effect(their_turf, arrow_color)

	return balloon_message

/datum/action/cooldown/spell/psionic/shockwave
	name = "Psionic Shockwave"
	desc = "Create a wave of telekinetic energy to pummel the ground around you."
	button_icon_state = "tech_corona"
	category = "Tier 2"
	mana_cost = 20
	cooldown_time = 50 SECONDS
	point_cost = 1
	locked = FALSE
	psionic_level = 2

/datum/action/cooldown/spell/psionic/shockwave/can_cast_spell(feedback)
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_INCAPACITATED))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/psionic/shockwave/before_cast(atom/cast_on)
	. = ..()
	if(isspaceturf(get_turf(cast_on)))
		to_chat(cast_on, span_horizonblue("You charge your shockwave, slam your foot down... and then remember that you're in space."))
		return SPELL_CANCEL_CAST

/datum/action/cooldown/spell/psionic/shockwave/cast(atom/cast_on)
	. = ..()
	for(var/mob/living/victims as anything in get_hearers_in_view(7, cast_on))
		if(!isliving(victims))
			continue
		if(victims == cast_on)
			continue
		shake_camera(victims, 2 SECONDS, 2)
		victims.Paralyze(2 SECONDS)
	cast_on.visible_message(span_horizonblue("[cast_on]'s foot starts to cover in blue energy, and then he stomps on the floor"), span_horizonblue("You channel psionic energy into your foot, and then stomp on the floor."))

/datum/action/cooldown/spell/psionic/time_stop
	name = "Time Stop"
	desc = "Create a wave of telekinetic energy to pummel the ground around you."
	button_icon_state = "tech_control"
	category = "Tier 2"
	mana_cost = 80
	cooldown_time = 120 SECONDS
	point_cost = 3
	locked = FALSE
	psionic_level = 2

/datum/action/cooldown/spell/psionic/time_stop/cast(atom/cast_on)
	. = ..()
	var/list/default_immune_atoms = list()
	default_immune_atoms += cast_on
	new /obj/effect/timestop/magic(get_turf(cast_on), 1, 2 SECONDS * cast_power, default_immune_atoms)

/datum/action/cooldown/spell/psionic/time_stop/can_cast_spell(feedback)
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_INCAPACITATED))
		return FALSE
	return TRUE
