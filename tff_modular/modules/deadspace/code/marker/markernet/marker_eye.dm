#define LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE 128
#define MARKER_SIGNAL_PLANE 250

GLOBAL_LIST_EMPTY(markers_signals)
/mob/eye/marker_signal
	name = "Signal"
	icon_state = "markersignal-"
	icon = 'tff_modular/modules/deadspace/icons/signals/eye.dmi'
	plane = MARKER_SIGNAL_PLANE
	alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	invisibility = INVISIBILITY_MARKER_SIGNAL
	see_invisible = SEE_INVISIBLE_MARKER_SIGNAL
	sight = SEE_MOBS|SEE_OBJS|SEE_TURFS
	mouse_opacity = MOUSE_OPACITY_ICON
	movement_type = PHASING|FLYING
	hud_type = /datum/hud/marker_signal
	interaction_range = null
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM
	faction = list(ROLE_NECROMORPH)
	var/psy_energy = 0
	var/psy_energy_maximum = 900
	var/psy_energy_generation = 1.5
	var/updatedir = null
	var/list/abilities
	var/obj/structure/marker/marker
	//CSS class used by this signal in the chat
	var/necrochat_class = "blob"
	var/body = null

/mob/eye/marker_signal/Initialize(mapload, obj/structure/marker/master)
	abilities = list()
	.=..()
	if(!master)
		return INITIALIZE_HINT_QDEL
	marker = master
	GLOB.markers_signals += src
	icon_state += "[rand(1, 25)]"
	master.marker_signals += src

	for(var/datum/action/cooldown/necro/psy/ability as anything in subtypesof(/datum/action/cooldown/necro/psy))
		if((initial(ability.marker_flags) & SIGNAL_ABILITY_MARKER_ONLY) && !istype(src, /mob/eye/marker_signal/marker))
			continue
		ability = new ability(src)
		abilities += ability
		if(!marker.active)
			if(initial(ability.marker_flags) & SIGNAL_ABILITY_PRE_ACTIVATION)
				ability.Grant(src)
		else
			if(initial(ability.marker_flags) & SIGNAL_ABILITY_POST_ACTIVATION)
				ability.Grant(src)

	if(marker.active)
		var/datum/action/cooldown/necro/corruption/ability = new /datum/action/cooldown/necro/corruption(src)
		ability.Grant(src)

	START_PROCESSING(SSobj, src)

/mob/eye/marker_signal/Destroy()
	STOP_PROCESSING(SSobj, src)
	GLOB.markers_signals -= src
	if(marker)
		marker.marker_signals -= src
		marker.necroqueue -= src
		marker = null
	return ..()

/mob/eye/marker_signal/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	name = "[pick(GLOB.ing_verbs)] [initial(name)] [rand(0, 999)]"

/mob/eye/marker_signal/verb/show_tutorial()
	set name = "Show Info"
	set desc = "Display any information that you can use"
	set category = "Necromorph"

	to_chat(usr, "<b><i>You are Marker's eyes and assistance.</i></b>\n\
	[span_notice("Biomass")] is the main resource needed to build structures. It can be refilled by absorbing some things around the infected area or by other methods.\n\
	[span_notice("Psi energy")] is the main resource for magic tricks. It constantly recharges to the maximum, but you can speed up the process by watching someone else's execution.")

/mob/eye/marker_signal/mind_initialize()
	. = ..()
	var/datum/antagonist/necromorph/signal = mind.has_antag_datum(/datum/antagonist/necromorph)
	if(!signal)
		mind.add_antag_datum(/datum/antagonist/necromorph)

/mob/eye/marker_signal/Topic(href, list/href_list)
	..()
	if(href_list["jump_to_eye"])
		var/mob/eye/marker_signal/signally = locate(href_list["eye_ref"]) in marker.marker_signals
		if(signally)
			abstract_move(get_turf(signally))

/mob/eye/marker_signal/process(delta_time)
	change_psy_energy(psy_energy_generation*delta_time)

/mob/eye/marker_signal/forceMove(atom/destination)
	abstract_move(destination) // move like the wind
	return TRUE

/mob/eye/marker_signal/DblClickOn(atom/A, params)
	if(check_click_intercept(params, A))
		return

	if(istype(A, /mob/living/carbon/human/necromorph))
		possess_necromorph(A)
		return

	// Otherwise just jump to the turf
	if(A.loc)
		abstract_move(get_turf(A))

/mob/eye/marker_signal/ClickOn(atom/A, params)
	if(check_click_intercept(params,A))
		return

	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		if(LAZYACCESS(modifiers, MIDDLE_CLICK))
			ShiftMiddleClickOn(A)
			return
		if(LAZYACCESS(modifiers, CTRL_CLICK))
			CtrlShiftClickOn(A)
			return
		ShiftClickOn(A)
		return
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		if(LAZYACCESS(modifiers, CTRL_CLICK))
			CtrlMiddleClickOn(A)
		else
			MiddleClickOn(A, params)
		return
	if(LAZYACCESS(modifiers, ALT_CLICK))
		base_click_alt(src, A)
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		CtrlClickOn(A)
		return

	if(world.time <= next_move)
		return
	A.attack_marker_signal(src)

/atom/proc/attack_marker_signal(mob/eye/marker_signal/user)
	return FALSE

/mob/eye/marker_signal/verb/leave_horde()
	set name = "Leave the Horde"
	set category = "Necromorph"
	marker.hive_mind_message(marker, span_notice("[name] has quitted the game!"))
	var/datum/antagonist/necromorph/necromorph = mind.has_antag_datum(/datum/antagonist/necromorph)
	if(necromorph)
		mind.remove_antag_datum(/datum/antagonist/necromorph)
	ghostize(FALSE)
	qdel(src)

/mob/eye/marker_signal/verb/switch_necroqueue()
	set name = "Join/Leave Necroqueue"
	set category = "Necromorph"

	if(!marker.active)
		to_chat(src, span_notice("Marker is not active yet!"))
		return
	if(src in marker.necroqueue)
		to_chat(src, span_notice("You have left the necroqueue."))
		marker.necroqueue -= src
	else
		to_chat(src, span_notice("You are now in the necroqueue. When a necromorph vessel is available, you will be automatically placed in control of it. You can still manually posess necromorphs."))
		marker.necroqueue += src

/mob/eye/marker_signal/verb/jump_to_marker()
	set name = "Jump to Marker"
	set category = "Necromorph"

	forceMove(get_turf(marker))

/mob/eye/marker_signal/verb/jump_to_necro()
	set name = "Jump to Necromorph"
	set category = "Necromorph"

	if(!length(marker.necromorphs))
		to_chat(src, span_notice("There are no necromorphs to jump to!"))
		return

	var/mob/living/carbon/human/necromorph/necro = tgui_input_list(src, "Select necromorph to jump to", "Jump To Necromorph", marker.necromorphs)
	if(necro)
		forceMove(get_turf(necro))

/mob/eye/marker_signal/verb/jump_to_span_locs()
	set name = "Jump to Necromorph Spawn Locs"
	set category = "Necromorph"

	var/atom/location = tgui_input_list(src, "Select object to jump to", "Jump To Spawn Loc", marker.necro_spawn_atoms)
	if(location)
		forceMove(get_turf(location))

/mob/eye/marker_signal/proc/possess_necromorph(mob/living/carbon/human/necromorph/necro in world)
	if(necro.stat == DEAD)
		to_chat(src, span_notice("This vessel was damaged beyond use!"))
		return
	if(necro.controlling)
		to_chat(src, span_notice("This vessel is already possessed!"))
		return

	marker.hive_mind_message(marker, "[name] possessed [initial(necro.name)][istype(src, /mob/eye/marker_signal/marker) ? " and released Master signal's role" : ""]!")
	body = necro
	necro.controlling = src
	//To prevent self attack when possesing through a double click
	client.click_intercept_time = world.time + 1
	mind.transfer_to(necro, TRUE)
	abstract_move(null)
	if(istype(src, /mob/eye/marker_signal/marker))
		var/mob/eye/marker_signal/marker/mark = src
		mark.downgrade()

/mob/eye/marker_signal/proc/change_psy_energy(amount)
	psy_energy = clamp(psy_energy+amount, 0, psy_energy_maximum)
	if(hud_used)
		var/datum/hud/marker_signal/our_hud = hud_used
		var/filter = our_hud.psy_energy.get_filter("alpha_filter")
		animate(filter, x = clamp(HUD_METER_PIXEL_WIDTH*(psy_energy/psy_energy_maximum), 0, HUD_METER_PIXEL_WIDTH), time = 0.5 SECONDS)
		our_hud.foreground_psy.maptext = MAPTEXT("[round(psy_energy, 1)]/[psy_energy_maximum] | +[psy_energy_generation] psy/sec")

/mob/eye/marker_signal/proc/update_biomass_hud(hud_override)
	var/datum/hud/marker_signal/our_hud = hud_override || hud_used
	our_hud?.foreground_bio.maptext = MAPTEXT("[round(marker.signal_biomass, 1)] | +[marker.last_biomass_income*marker.signal_biomass_percent] bio/sec")

/mob/eye/marker_signal/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = null, message_range, datum/saymode/saymode, list/message_mods = list())
	if(!message || stat)
		return

	if (src.client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, span_boldwarning("You cannot send IC messages (muted)."))
			return
		if (!(ignore_spam || forced) && src.client.handle_spam_prevention(message,MUTE_IC))
			return

	if(!marker)
		to_chat(src, span_warning("There is no connection between you and the Marker!"))
		return

	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))

	message = "<span class='[necrochat_class]'>[name]: [message]</span>"

	log_talk(message, LOG_SAY, forced_by = forced, custom_say_emote = message_mods[MODE_CUSTOM_SAY_EMOTE])

	marker.hive_mind_message(src, message)

	return TRUE

/mob/eye/marker_signal/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list(), message_range)
	. = ..()
	// Create map text prior to modifying message for goonchat
	if (client?.prefs.read_preference(/datum/preference/toggle/enable_runechat) && (client.prefs.read_preference(/datum/preference/toggle/enable_runechat_non_mobs) || ismob(speaker)))
		create_chat_message(speaker, message_language, raw_message, spans)
	// Recompose the message, because it's scrambled by default
	message = compose_message(speaker, message_language, raw_message, radio_freq, spans, message_mods)
	to_chat(src,
		html = message,
		avoid_highlighting = speaker == src)

/mob/eye/marker_signal/verb/become_master()
	set name = "Become master signal"
	set category = "Necromorph"

	if(!marker.active)
		to_chat(src, span_notice("Marker is not active yet!"))
		return
	if(marker.camera_mob)
		to_chat(src, span_notice("There is a player controlling the marker already!"))
		return
	var/mob/eye/marker_signal/marker/camera = new /mob/eye/marker_signal/marker(get_turf(src), marker)
	marker.hive_mind_message(marker, span_blobannounce("[name] became the Master signal"))
	marker.camera_mob = camera
	camera.fully_replace_character_name(camera.name)
	camera.ckey = src.ckey
	camera.change_psy_energy(psy_energy)
	qdel(src)

/mob/eye/marker_signal/verb/jump_to_signals()
	set name = "Jump to active signals"
	set category = "Necromorph"

	var/list/signals = list()

	for(var/mob/eye/marker_signal/signal as anything in marker.marker_signals)
		if(signal == src)
			continue
		signals += "[SIG_EYEJMPLNK(src, signal)] [signal.name]"

	if(!length(signals))
		to_chat(src, span_notice("You are all alone..."))
	else
		to_chat(src, boxed_message(signals.Join("\n")))

/mob/eye/marker_signal/marker
	name = "Marker"
	icon_state = "mastersignal"
	icon = 'tff_modular/modules/deadspace/icons/signals/mastersignal.dmi'
	interaction_range = null
	pixel_x = -7
	pixel_y = -7
	psy_energy_maximum = 4500
	psy_energy_generation = 3
	necrochat_class = "blobannounce"
	///Necro class of a necromorph we are going to spawn
	var/spawning_necromorph

/mob/eye/marker_signal/marker/Initialize(mapload, obj/structure/marker/master)
	. = ..()
	icon_state = "mastersignal"
	remove_verb(src, list(
		/mob/eye/marker_signal/verb/become_master,
		/mob/eye/marker_signal/verb/switch_necroqueue,
	))

/mob/eye/marker_signal/marker/Destroy()
	marker?.camera_mob = null
	return ..()

/mob/eye/marker_signal/marker/update_biomass_hud(hud_override)
	var/datum/hud/marker_signal/our_hud = hud_override || hud_used
	our_hud?.foreground_bio.maptext = MAPTEXT("[round(marker.marker_biomass, 1)] | +[marker.last_biomass_income*(1-marker.signal_biomass_percent)] bio/sec")

/mob/eye/marker_signal/marker/verb/downgrade()
	set name = "Downgrade to normal signal"
	set category = "Necromorph"

	if(marker)
		marker.hive_mind_message(marker, span_blobannounce("[name] released Master signal's role"))

	var/mob/eye/marker_signal/signal = new /mob/eye/marker_signal(get_turf(src), marker)
	signal.fully_replace_character_name(signal.name)
	signal.ckey = src.ckey
	signal.change_psy_energy(psy_energy)
	qdel(src)

/mob/eye/marker_signal/marker/verb/open_marker_ui()
	set name = "Open Marker UI"
	set category = "Necromorph"

	marker.ui_interact(src)

/mob/eye/marker_signal/marker/ClickOn(atom/A, params)
	if(check_click_intercept(params,A))
		return

	var/list/modifiers = params2list(params)
	if(spawning_necromorph)
		if(LAZYACCESS(modifiers, LEFT_CLICK))
			spawn_necromorph(A)
			return
		else if(LAZYACCESS(modifiers, RIGHT_CLICK))
			return
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		if(LAZYACCESS(modifiers, MIDDLE_CLICK))
			ShiftMiddleClickOn(A)
			return
		if(LAZYACCESS(modifiers, CTRL_CLICK))
			CtrlShiftClickOn(A)
			return
		ShiftClickOn(A)
		return
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		if(LAZYACCESS(modifiers, CTRL_CLICK))
			CtrlMiddleClickOn(A)
		else
			MiddleClickOn(A, params)
		return
	if(LAZYACCESS(modifiers, ALT_CLICK))
		base_click_alt(src, A)
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		CtrlClickOn(A)
		return

	if(world.time <= next_move)
		return
	A.attack_marker_signal(src)

/mob/eye/marker_signal/marker/proc/spawn_necromorph(turf/A)
	if(marker.biomass_invested < marker.necro_classes[spawning_necromorph].biomass_spent_required)
		to_chat(src, span_warning("Not enough biomass spent!"))
		return
	if(marker.marker_biomass < marker.necro_classes[spawning_necromorph].biomass_cost)
		to_chat(src, span_warning("Not enough biomass!"))
		return
	var/datum/necro_class/class = marker.necro_classes[spawning_necromorph]
	if(class.spawn_limit >= 0 && class.spawned_number >= class.spawn_limit)
		to_chat(src, span_warning("You cannot spawn more necromorphs of this type!"))
		return
	A = get_turf(A)
	if(!A)
		return
	if(A.density)
		to_chat(src, span_warning("Location is dense!"))
		return
	for(var/atom/movable/movable as anything in A)
		if(movable.density)
			to_chat(src, span_warning("Location has dense objects on it!"))
			return
	//In case there was a nearby spawnloc but nest was behind a wall
	var/spawnloc_cantsee
	for(var/atom/spawnloc as anything in marker.necro_spawn_atoms)
		if(!IN_GIVEN_RANGE(spawnloc, A, 4))
			continue
		var/turf/turf_loc = get_turf(spawnloc)
		if(!can_see(turf_loc, A, 4))
			spawnloc_cantsee = TRUE
			continue
		marker.change_marker_biomass(-marker.necro_classes[spawning_necromorph].biomass_cost)
		marker.biomass_invested += marker.necro_classes[spawning_necromorph].biomass_cost
		var/path = marker.necro_classes[spawning_necromorph].necromorph_type_path
		++class.spawned_number
		var/mob/living/carbon/human/necromorph/mob = new path(A, marker)
		if(marker.use_necroqueue && length(marker.necroqueue))
			var/list/necroqueue_copy = marker.necroqueue.Copy()
			//If current signal has no key and there are other signals in the queue, pick another one
			while(length(necroqueue_copy))
				var/mob/eye/marker_signal/signal = pick_n_take(necroqueue_copy)
				signal = pick_n_take(necroqueue_copy)
				if(signal.key)
					signal.possess_necromorph(mob)
					return
		return
	if(!spawnloc_cantsee)
		to_chat(src, span_warning("There are no possible spawn locations nearby!"))
	else
		to_chat(src, span_warning("Nearby spawn location cant see this turf!"))

#undef MARKER_SIGNAL_PLANE
#undef LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
