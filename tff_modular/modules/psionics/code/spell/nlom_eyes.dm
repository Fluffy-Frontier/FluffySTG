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
