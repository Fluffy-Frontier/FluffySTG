/obj/structure/marker/Initialize(mapload)
	.=..()
	name = "Marker #[++GLOB.round_statistics.total_markers]"

	GLOB.necromorph_markers += src

	for(var/datum/necro_class/class as anything in subtypesof(/datum/necro_class))
		//Temp check to see if this class is implemented
		if(initial(class.implemented))
			necro_classes[class] = new class()

	necro_spawn_atoms += src

	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_MARKER)
	soundloop = new(src, FALSE)
	START_PROCESSING(SSobj, src)

/obj/structure/marker/Destroy()
	STOP_PROCESSING(SSobj, src)
	for(var/datum/biomass_source/source as anything in biomass_sources)
		remove_biomass_source(source)
	necro_spawn_atoms = null
	GLOB.necromorph_markers -= src
	for(var/mob/eye/marker_signal/signal as anything in marker_signals)
		signal.show_message(span_userdanger("You feel like your connection with the Marker breaks!"))
		signal.ghostize()
		qdel(signal)
	for(var/mob/living/carbon/human/necromorph/necro as anything in necromorphs)
		necro.show_message(span_userdanger("Your body turns to dust!"))
		necro.dust()
	marker_signals = null
	necromorphs = null
	QDEL_NULL(soundloop)
	return ..()

/obj/structure/marker/emp_act(severity)
	. = ..()
	activate()

/obj/structure/marker/update_icon_state()
	icon_state = (active ? "marker_giant_active_anim" : "marker_giant_dormant")
	return ..()

/obj/structure/marker/process(delta_time)
	var/income = 0
	for(var/datum/biomass_source/source as anything in biomass_sources)
		income += source.absorb_biomass(delta_time)
	change_marker_biomass(income*(1-signal_biomass_percent))
	change_signal_biomass(income*signal_biomass_percent)
	//Income per second
	last_biomass_income = income / delta_time

/obj/structure/marker/proc/change_marker_biomass(amount)
	marker_biomass = max(0, marker_biomass+amount)
	camera_mob?.update_biomass_hud()

/obj/structure/marker/proc/change_signal_biomass(amount)
	signal_biomass = max(0, signal_biomass+amount)
	for(var/mob/eye/marker_signal/signal as anything in marker_signals)
		signal.update_biomass_hud()

/obj/structure/marker/proc/hive_mind_message(mob/sender, message)
	if(!message)
		return

	src.log_talk(message, LOG_SAY)

	for(var/mob/ghost as anything in GLOB.dead_mob_list)
		to_chat(ghost, "[FOLLOW_LINK(ghost, sender)] [message]", MESSAGE_TYPE_RADIO)

	for(var/mob/eye/marker_signal/signal as anything in marker_signals)
		to_chat(signal, "[SIG_EYEJMPLNK(sender, signal)] [message]", MESSAGE_TYPE_RADIO)

	for(var/mob/living/carbon/human/necromorph/necro as anything in necromorphs)
		to_chat(necro, message, MESSAGE_TYPE_RADIO)

/obj/structure/marker/proc/add_necro(mob/living/carbon/human/necromorph/necro)
	// If the necro is part of another hivemind, they should be removed from that one first
	if(necro.marker != src)
		necro.marker.remove_necro(necro, TRUE)
	necro.marker = src
	necromorphs |= necro

/obj/structure/marker/proc/remove_necro(mob/living/carbon/human/necromorph/necro, hard=FALSE, light_mode = FALSE)
	if(necro.marker != src)
		return
	necromorphs -= necro
	necro.marker = null

/obj/structure/marker/proc/activate(announce = FALSE)
	if(active)
		return
	active = TRUE
	change_marker_biomass(250) //Marker given a biomass injection, enough for a small team and some growing
	change_signal_biomass(50) //Signals given biomass injection for general spreading
	add_biomass_source(/datum/biomass_source/baseline, src) //Base income for marker
	for(var/mob/eye/marker_signal/eye as anything in marker_signals)
		var/datum/action/cooldown/necro/corruption/ability = new /datum/action/cooldown/necro/corruption(eye)
		ability.Grant(eye)
	new /datum/corruption_node/atom/marker(src, src)
	update_icon(UPDATE_ICON_STATE)
	light_power = 1
	light_range = 4
	light_color = "#EC3232"
	update_light()
	soundloop.start()
	if(announce)
		announce_activation()

/obj/structure/marker/proc/announce_activation()
	. += "<center><b><h2>CEC Corporation Report</h2></b></center><hr><br />"
	. += "Your ship is currently in Cygnus System not far from Aegis VII planet. It is resricted area of space and you shold avoid outside contancts. Your task is to extract alien artifact on the planet surface and deliver it to the rendezvous point. Make sure Earth Government or crew without priority access will not find out about your location, task or cargo. "

	print_command_report(., "CEC Corporation Report", announce=FALSE)
	priority_announce("Thanks to the tireless efforts of our security and intelligence divisions, there are currently no credible threats to [station_name()]. All station construction projects have been authorized. Have a secure shift!", "Security Report", "", SSstation.announcer.get_rand_report_sound())

/mob/dead/observer/verb/join_horde()
	set name = "Join the Horde"
	set category = "Ghost"

	if(!length(GLOB.necromorph_markers))
		to_chat(src, span_notice("There are no markers to join!"))
	else
		if(!check_respawn_delay())
			return

		var/obj/structure/marker/marker = tgui_input_list(src, "Pick a marker to join", "Join Horde", GLOB.necromorph_markers)
		if(QDELETED(marker))
			return
		var/mob/eye/marker_signal/eye = new(get_turf(marker), marker)
		eye.ckey = src.ckey

/obj/structure/marker/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NecromorphMarker", "Marker")
		ui.open()

/obj/structure/marker/ui_state(mob/user)
	return GLOB.always_state

/obj/structure/marker/can_interact(mob/user)
	if(!ismarkersignal(user) || !ismarkermark(user))
		return FALSE
	return TRUE

/obj/structure/marker/ui_data(mob/user)
	. = list()
	.["biomass"] = marker_biomass
	.["biomass_income"] = last_biomass_income
	.["biomass_invested"] = biomass_invested
	.["use_necroqueue"] = use_necroqueue
	.["signal_biomass"] = signal_biomass
	.["signal_biomass_percent"] = signal_biomass_percent

/obj/structure/marker/ui_static_data(mob/user)
	. = list()
	.["necromorphs"] = list()
	for(var/datum/necro_class/class as anything in necro_classes)
		class = necro_classes[class]
		.["necromorphs"] += list(list(
			"name" = class.display_name,
			"desc" = class.desc,
			"cost" = class.biomass_cost,
			"type" = class.type,
			"biomass_required" = class.biomass_spent_required,
		))

/obj/structure/marker/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return

	switch(action)
		if("switch_necroqueue")
			use_necroqueue = !use_necroqueue
			return TRUE
		if("spawn_necromorph")
			var/class = text2path(params["class"])
			if(!class || !(class in necro_classes))
				return
			if(camera_mob.spawning_necromorph)
				camera_mob.spawning_necromorph = null
				to_chat(camera_mob, span_notice("Necromorph selection has been canceled"))
			else
				camera_mob.spawning_necromorph = necro_classes[class].type
				to_chat(camera_mob, span_notice("Selected necromorph: [necro_classes[class].display_name]"))
		if("set_signal_biomass_percent")
			var/percent = text2num(params["percentage"])
			if(isnull(percent))
				percent = 0.1
			signal_biomass_percent = CLAMP01(percent)
			for(var/mob/eye/marker_signal/signal as anything in marker_signals)
				signal.update_biomass_hud()
		if("change_signal_biomass")
			var/add_signal_biomass = text2num(params["biomass"])
			if(!add_signal_biomass)
				return
			add_signal_biomass = clamp(add_signal_biomass, -signal_biomass, marker_biomass)
			change_marker_biomass(-add_signal_biomass)
			change_signal_biomass(add_signal_biomass)
			return TRUE

/obj/structure/marker/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	//Marker shouldn't block corruption
	if(istype(mover, /obj/structure/corruption))
		return TRUE

/obj/structure/marker/proc/add_biomass_source(source_type, datum/source)
	var/datum/biomass_source/new_source = new source_type(src, source)
	biomass_sources += new_source
	return new_source

/obj/structure/marker/proc/remove_biomass_source(datum/biomass_source/source)
	biomass_sources -= source
	qdel(source)
