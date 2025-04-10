GLOBAL_LIST_EMPTY_TYPED(phone_transmitters, /obj/structure/transmitter)

#define PHONE_FACTION_SYNDICATE "syndicate"
#define PHONE_FACTION_STATION "station"
#define PHONE_FACTION_STATION_PRIVATE "station_private"

/obj/structure/transmitter
	name = "telephone receiver"
	desc = "It is a wall mounted telephone. The fine text reads: To log your details with the mainframe please insert your keycard into the slot below. Unfortunately the slot is jammed. You can still use the phone, however."
	icon = 'tff_modular/modules/colonial_marines/telephone/icons/phone.dmi'
	icon_state = "wall_phone"
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND
	anchored = 1
	var/phone_category = "Uncategorised"
	var/phone_color = "white"
	var/phone_id
	var/phone_name = "Telephone"
	var/phone_icon

	var/obj/item/tube_phone/attached_to

	var/obj/structure/transmitter/outbound_call
	var/obj/structure/transmitter/inbound_call

	var/next_ring = 0

	var/phone_type = /obj/item/tube_phone

	var/range = 6

	var/enabled = TRUE
	/// Whether or not the phone is receiving calls or not. Varies between on/off or forcibly on/off.
	var/do_not_disturb = PHONE_DND_OFF
	/// The Phone_ID of the last person to call this telephone.
	var/last_caller
	var/datum/call_history/history

	var/timeout_timer_id
	var/timeout_duration = 30 SECONDS

	var/list/networks_receive = list(PHONE_FACTION_STATION)
	var/list/networks_transmit = list(PHONE_FACTION_STATION)

	var/datum/looping_sound/telephone/busy/busy_loop
	var/datum/looping_sound/telephone/hangup/hangup_loop
	var/datum/looping_sound/telephone/ring/outring_loop

	var/snapped = FALSE

	var/only_income = FALSE
	var/only_outcome = FALSE

/obj/structure/transmitter/Initialize(mapload)
	. = ..()
	base_icon_state = icon_state
	if(!phone_id)
		phone_id = assign_random_name()

	attached_to = new phone_type(src)

	history = new(src)

	outring_loop = new(attached_to)
	busy_loop = new(attached_to)
	hangup_loop = new(attached_to)

	if(!get_turf(src))
		return

	GLOB.phone_transmitters += src
	RegisterSignal(src, COMSIG_ATOM_TETHER_SNAPPED, PROC_REF(handle_snap))
	update_icon()

/obj/structure/transmitter/Destroy()
	if(attached_to)
		if(attached_to.loc == src)
			qdel(attached_to)
		else
			attached_to.attached_to = null
		attached_to = null

	GLOB.phone_transmitters -= src
	reset_call(silent = TRUE)
	UnregisterSignal(src, COMSIG_ATOM_TETHER_SNAPPED)
	return ..()

/obj/structure/transmitter/update_icon()
	. = ..()
	SEND_SIGNAL(src, COMSIG_TRANSMITTER_UPDATE_ICON)
	if(attached_to.loc != src)
		icon_state = "[base_icon_state]_ear"
		return

	if(inbound_call)
		icon_state = "[base_icon_state]_ring"
	else
		icon_state = base_icon_state

/obj/structure/transmitter/examine(mob/user)
	. = ..()
	if(snapped)
		. += span_bold("Looks like the cable on the phone is broken. Probably can be fixed with a couple of wires.")

/obj/structure/transmitter/proc/get_status(public = FALSE)
	if(!enabled)
		return PHONE_UNAVAILABLE
	if(!attached_to || snapped)
		return PHONE_UNAVAILABLE
	if(get_calling_phone() || attached_to.loc != src)
		return PHONE_BUSY
	if((do_not_disturb == PHONE_DND_ON) || (do_not_disturb == PHONE_DND_FORCED))
		return PHONE_BUSY
	if(public && (do_not_disturb == PHONE_DND_ON_PUBLIC))
		return PHONE_BUSY
	return PHONE_AVAILABLE

/obj/structure/transmitter/proc/get_transmitters()
	var/list/phone_list = list()

	for(var/possible_phone in GLOB.phone_transmitters)
		var/obj/structure/transmitter/target_phone = possible_phone
		if(!target_phone.get_status() ) // Phone not available
			continue
		if(target_phone.only_outcome)
			continue
		var/net_link = FALSE
		for(var/network in networks_transmit)
			if(network in target_phone.networks_receive)
				net_link = TRUE
				continue
		if(!net_link)
			continue

		var/id = target_phone.phone_id
		phone_list[id] = target_phone

	return phone_list

/obj/structure/transmitter/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(!get_status() || get_calling_phone() || (attached_to.loc != src))
		return UI_CLOSE

/obj/structure/transmitter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PhoneMenu", phone_name)
		ui.open()

/obj/structure/transmitter/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(get_status() == PHONE_UNAVAILABLE)
		return

	if(!ishuman(usr))
		return

	var/mob/living/carbon/human/user = usr

	switch(action)
		if("call_phone")
			make_call(user, params["phone_id"])
			. = TRUE
			SStgui.close_uis(src)
		if("toggle_dnd")
			toggle_dnd(user)

	update_icon()

/obj/structure/transmitter/ui_data(mob/user)
	var/list/data = list()

	data["availability"] = do_not_disturb
	data["last_caller"] = last_caller

	return data

/obj/structure/transmitter/ui_static_data(mob/user)
	. = list()

	.["available_transmitters"] = get_transmitters() - list(phone_id)
	var/list/transmitters = list()
	for(var/i in GLOB.phone_transmitters)
		var/obj/structure/transmitter/T = i
		transmitters += list(list(
			"phone_category" = T.phone_category,
			"phone_color" = T.phone_color,
			"phone_id" = T.phone_id,
			"phone_name" = T.phone_name,
			"phone_icon" = T.phone_icon
		))

	.["transmitters"] = transmitters

/obj/structure/transmitter/can_interact(mob/user)
	. = ..()
	if(!enabled)
		return FALSE
	if(!ishuman(user))
		return FALSE
	if(!attached_to || attached_to.loc != src)
		return FALSE
	if(snapped)
		balloon_alert(user, "cable is broken!")
		return FALSE

/obj/structure/transmitter/interact(mob/user)
	. = ..()
	if(!get_calling_phone() && !only_income)
		SEND_SIGNAL(src, COMSIG_ATOM_UI_INTERACT, user)
		ui_interact(user)
		return

	var/obj/structure/transmitter/T = get_calling_phone()

	if(!T)
		if(only_income)
			return
		CRASH("Something wrong in /obj/structure/transmitter/interact. get_calling_phone() returned null, but it should have returned the transmitter")

	if(T.attached_to)
		if(ismob(T.attached_to.loc))
			var/mob/M = T.attached_to.loc
			to_chat(M, span_purple("[icon2html(src, M)] [phone_name] has picked up."))
		playsound(T.attached_to, 'tff_modular/modules/colonial_marines/telephone/sound/remote_pickup.ogg', 20)

	if(T.timeout_timer_id)
		deltimer(T.timeout_timer_id)
		T.timeout_timer_id = null

	T.outring_loop.stop()

	to_chat(user, span_purple("[icon2html(src, user)] Picked up a call from [T.phone_name]."))
	playsound(get_turf(user), get_sound_file("rtb_handset"), 100)

	attached_to.attempt_pickup(user)
	update_icon()

/obj/structure/transmitter/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(tool == attached_to)
		recall_phone()
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/stack/cable_coil))
		return fix_cable(user, tool) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING
	return ..()

/obj/structure/transmitter/proc/make_call(mob/living/carbon/human/user, calling_phone_id)
	var/list/transmitters = get_transmitters()
	transmitters -= phone_id
	if(!length(transmitters) || !(calling_phone_id in transmitters))
		to_chat(user, span_purple("[icon2html(src, user)] No transmitters could be located to call!"))
		return

	var/obj/structure/transmitter/calling = transmitters[calling_phone_id]

	if(!istype(calling) || QDELETED(calling))
		transmitters -= calling
		CRASH("Qdelled/improper atom inside transmitters list! (istype returned: [istype(calling)], QDELETED returned: [QDELETED(calling)])")

	outring_loop.start()
	to_chat(user, span_purple("[icon2html(src, user)] Dialing [calling.phone_name].."))

	attached_to.attempt_pickup(user)
	playsound(get_turf(user), get_sound_file("rtb_handset"), 100)

	var/calling_status = calling.get_status(only_outcome || only_income)
	switch(calling_status)
		if(PHONE_UNAVAILABLE, PHONE_BUSY)
			timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(reset_call), PHONE_REASON_BUSY), 3 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
		if(PHONE_AVAILABLE)
			timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(try_connect), user, calling), 3 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

	history.add_outbound_call(calling.phone_id)

	START_PROCESSING(SSobj, src)

/obj/structure/transmitter/proc/try_connect(mob/living/carbon/human/user, obj/structure/transmitter/calling)
	var/calling_status = calling.get_status()
	switch(calling_status)
		if(PHONE_UNAVAILABLE, PHONE_BUSY)
			reset_call(PHONE_REASON_BUSY)
			return

	outbound_call = calling
	calling.inbound_call = src

	calling.history.add_inbound_call(phone_id)

	timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(reset_call), PHONE_REASON_TIMEOUT), timeout_duration, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

	calling.update_icon()
	START_PROCESSING(SSobj, calling)

/obj/structure/transmitter/proc/reset_call(reason = PHONE_REASON_NO, silent = FALSE)
	var/obj/structure/transmitter/active_call = get_calling_phone()

	if(!silent)
		if(active_call)
			if(active_call.attached_to && ismob(active_call.attached_to.loc))
				var/mob/M = active_call.attached_to.loc
				to_chat(M, span_purple("[icon2html(src, M)] [phone_name] has hung up on you."))
				active_call.hangup_loop.start()

			if(attached_to && ismob(attached_to.loc))
				var/mob/M = attached_to.loc
				switch(reason)
					if(PHONE_REASON_TIMEOUT)
						to_chat(M, span_purple("[icon2html(src, M)] Your call to [active_call.phone_name] has reached voicemail, nobody picked up the phone."))
					if(PHONE_REASON_NO)
						to_chat(M, span_purple("[icon2html(src, M)] You have hung up on [active_call.phone_name]."))

		if((reason == PHONE_REASON_BUSY) && attached_to && ismob(attached_to.loc))
			var/mob/M = attached_to.loc
			to_chat(M, span_purple("[icon2html(src, M)] The station you are trying to reach is currently busy, please hang on and try again later."))

		switch(reason)
			if(PHONE_REASON_TIMEOUT, PHONE_REASON_BUSY)
				busy_loop.start()

	outring_loop.stop()

	if(outbound_call)
		outbound_call.inbound_call = null
		outbound_call = null

	if(inbound_call)
		inbound_call.outbound_call = null
		inbound_call = null

	if(timeout_timer_id)
		deltimer(timeout_timer_id)
		timeout_timer_id = null

	if(active_call)
		active_call.update_icon()
		STOP_PROCESSING(SSobj, active_call)
	STOP_PROCESSING(SSobj, src)

/obj/structure/transmitter/proc/toggle_dnd(mob/living/carbon/human/user)
	switch(do_not_disturb)
		if(PHONE_DND_ON)
			do_not_disturb = PHONE_DND_OFF
			to_chat(user, span_notice("Do Not Disturb has been disabled. You can now receive calls."))
		if(PHONE_DND_ON_PUBLIC)
			do_not_disturb = PHONE_DND_ON
			to_chat(user, span_warning("Do Not Disturb has been enabled. No calls will be received."))
		if(PHONE_DND_OFF)
			do_not_disturb = PHONE_DND_ON_PUBLIC
			to_chat(user, span_warning("Do Not Disturb has been partially enabled. No calls [span_bold("from public phones")] will be received."))
		else
			return FALSE
	return TRUE

/obj/structure/transmitter/process()
	if(inbound_call)
		if(!attached_to)
			STOP_PROCESSING(SSobj, src)
			return

		if(attached_to.loc == src)
			if(next_ring < world.time)
				playsound(loc, 'tff_modular/modules/colonial_marines/telephone/sound/telephone_ring.ogg', 75)
				visible_message(span_warning("[src] rings vigorously!"))
				next_ring = world.time + 3 SECONDS

	else if(outbound_call)
		var/obj/structure/transmitter/T = get_calling_phone()
		if(!T)
			STOP_PROCESSING(SSobj, src)
			return

		var/obj/item/tube_phone/P = T.attached_to

		if(P && attached_to.loc == src && P.loc == T && next_ring < world.time)
			playsound(get_turf(attached_to), 'tff_modular/modules/colonial_marines/telephone/sound/telephone_ring.ogg', 20, FALSE, 14)
			visible_message(span_warning("[src] rings vigorously!"))
			next_ring = world.time + 3 SECONDS

	else
		STOP_PROCESSING(SSobj, src)
		return

/obj/structure/transmitter/proc/recall_phone()
	attached_to.forceMove(src)
	reset_call()

	playsound(src, get_sound_file("rtb_handset"), 100, FALSE, 7)
	busy_loop.stop()
	outring_loop.stop()
	hangup_loop.stop()

	update_icon()

/obj/structure/transmitter/proc/get_calling_phone()
	if(outbound_call)
		return outbound_call
	else if(inbound_call)
		return inbound_call

	return

/obj/structure/transmitter/proc/handle_speak(message, datum/language/L, mob/speaking)
	if(HAS_TRAIT(speaking, TRAIT_SIGN_LANG))
		return

	var/obj/structure/transmitter/T = get_calling_phone()
	if(!istype(T))
		return

	var/obj/item/tube_phone/P = T.attached_to

	if(!P || !attached_to)
		return

	P.handle_hear(message, L, speaking, src)
	attached_to.handle_hear(message, L, speaking, src)
	playsound(P, get_sound_file("talk_phone"), 5)
	log_say("TELEPHONE: [key_name(speaking)] on Phone '[phone_name]' to '[T.phone_name]' said '[message]'")

/obj/structure/transmitter/proc/handle_snap()
	SIGNAL_HANDLER

	reset_call()
	snapped = TRUE

/obj/structure/transmitter/proc/fix_cable(mob/living/user, obj/item/stack/cable_coil/cable, time = 2 SECONDS)
	PRIVATE_PROC(TRUE)

	if(!snapped)
		return FALSE
	if(attached_to.loc != src)
		balloon_alert(user, "the phone handset should be here!")
		return FALSE
	if(!cable.tool_start_check(user, amount = 5))
		return FALSE
	if(time > 0)
		balloon_alert(user, "fixing cable...")
	if(!cable.use_tool(src, user, time, volume = 50, amount = 5) || !snapped)
		return FALSE

	snapped = FALSE
	return TRUE

/obj/structure/transmitter/GetVoice()
	return "[phone_name]"

/obj/structure/transmitter/proc/get_sound_file(group_name)
	var/sound_file
	switch(group_name)
		if("rtb_handset")
			sound_file = pick(
				'tff_modular/modules/colonial_marines/telephone/sound/rtb_handset_1.ogg',
				'tff_modular/modules/colonial_marines/telephone/sound/rtb_handset_2.ogg',
				'tff_modular/modules/colonial_marines/telephone/sound/rtb_handset_3.ogg',
				'tff_modular/modules/colonial_marines/telephone/sound/rtb_handset_4.ogg',
				'tff_modular/modules/colonial_marines/telephone/sound/rtb_handset_5.ogg',
			)
		if("talk_phone")
			sound_file = pick(
				'tff_modular/modules/colonial_marines/telephone/sound/talk_phone1.ogg',
				'tff_modular/modules/colonial_marines/telephone/sound/talk_phone2.ogg',
				'tff_modular/modules/colonial_marines/telephone/sound/talk_phone3.ogg',
				'tff_modular/modules/colonial_marines/telephone/sound/talk_phone4.ogg',
				'tff_modular/modules/colonial_marines/telephone/sound/talk_phone5.ogg',
				'tff_modular/modules/colonial_marines/telephone/sound/talk_phone6.ogg',
				'tff_modular/modules/colonial_marines/telephone/sound/talk_phone7.ogg',
			)
	return sound_file

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/transmitter, (-32))

// ###########
// Phone item
// ###########

/obj/item/tube_phone
	name = "telephone"
	icon = 'tff_modular/modules/colonial_marines/telephone/icons/phone.dmi'
	lefthand_file = 'tff_modular/modules/colonial_marines/telephone/icons/phone_inhand_lefthand.dmi'
	righthand_file = 'tff_modular/modules/colonial_marines/telephone/icons/phone_inhand_righthand.dmi'
	icon_state = "rpb_phone"
	inhand_icon_state = "rpb_phone"

	w_class = WEIGHT_CLASS_BULKY

	var/obj/structure/transmitter/attached_to

	var/raised = FALSE

/obj/item/tube_phone/Initialize(mapload)
	. = ..()
	if(istype(loc, /obj/structure/transmitter))
		attach_to(loc)

/obj/item/tube_phone/Destroy()
	remove_attached()
	return ..()

/obj/item/tube_phone/proc/attach_to(obj/structure/transmitter/to_attach)
	if(!istype(to_attach))
		return
	if(attached_to)
		remove_attached()
	attached_to = to_attach

/obj/item/tube_phone/proc/remove_attached()
	attached_to.attached_to = null
	attached_to = null
	reset_tether()

/obj/item/tube_phone/proc/handle_speak(datum/source, list/speech_args)
	SIGNAL_HANDLER

	if(!attached_to || loc == attached_to)
		UnregisterSignal(usr, COMSIG_MOB_SAY)
		return

	attached_to.handle_speak(speech_args[SPEECH_MESSAGE], speech_args[SPEECH_LANGUAGE], source)

/obj/item/tube_phone/proc/handle_hear(raw_message, datum/language/L, mob/speaking, obj/structure/transmitter/source)
	var/spans = "purple"
	if(raised)
		spans += " big"

	var/list/hearers = list()

	if(source == attached_to)
		if(loc != speaking)
			return
		hearers += speaking
	else
		hearers = get_hearers_in_view(1, src)

	for(var/mob/hearer in hearers)
		if(HAS_TRAIT(hearer, TRAIT_DEAF))
			continue
		var/dist = get_dist(src, hearer)
		var/message = hearer.translate_language(speaking, L, raw_message)
		if(dist > 0 && !HAS_TRAIT(src, TRAIT_GOOD_HEARING) && !isobserver(src))
			message = stars(message)
		message = compose_message(source, L, message)
		message = "<span class='[spans]'>[message]</span>"
		hearer.show_message(message, MSG_AUDIBLE)

/obj/item/tube_phone/attack_self(mob/user)
	. = ..()
	if(raised)
		set_raised(FALSE, user)
		to_chat(user, span_notice("You lower [src]."))
	else
		set_raised(TRUE, user)
		to_chat(user, span_notice("You raise [src] to your ear."))

/obj/item/tube_phone/proc/set_raised(to_raise, mob/living/carbon/human/H)
	if(!istype(H))
		return

	var/obj/item/radio/R = H.get_item_by_slot(ITEM_SLOT_EARS)
	if(!istype(R))
		R = null

	if(!to_raise)
		raised = FALSE
		inhand_icon_state = "rpb_phone"
		R?.set_on(TRUE)
	else
		raised = TRUE
		inhand_icon_state = "rpb_phone_ear"
		R?.set_on(FALSE)

	H.update_held_items()

/obj/item/tube_phone/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_SAY)
	set_raised(FALSE, user)

/obj/item/tube_phone/on_enter_storage(obj/item/storage/S)
	. = ..()
	if(attached_to)
		attached_to.recall_phone()

/obj/item/tube_phone/forceMove(atom/dest)
	. = ..()
	if(.)
		reset_tether()
	if(ismob(dest))
		RegisterSignal(dest, COMSIG_MOB_SAY, PROC_REF(handle_speak))

/obj/item/tube_phone/proc/reset_tether()
	if(!attached_to)
		return
	if(loc == attached_to)
		SEND_SIGNAL(attached_to, COMSIG_TRANSMITTER_NEED_DELETE_TETHER)
		return
	if(attached_to.snapped)
		SEND_SIGNAL(attached_to, COMSIG_TRANSMITTER_NEED_DELETE_TETHER)
		return
	create_tether()

/obj/item/tube_phone/proc/create_tether()
	var/atom/tether_to = src
	var/atom/tether_from = attached_to

	if(loc != get_turf(src))
		tether_to = loc
		if(tether_to.loc != get_turf(src))
			attached_to.recall_phone()
			return

	if(tether_from == tether_to)
		return

	SEND_SIGNAL(attached_to, COMSIG_TRANSMITTER_NEED_DELETE_TETHER)
	tether_from.AddComponent( \
		/datum/component/transmitter_tether, \
		tether_to, \
		attached_to.range, \
		tether_name = "cable", \
		icon = "wire", \
		icon_file = 'tff_modular/modules/colonial_marines/telephone/icons/phone.dmi', \
	)

// ############
// Call History
// ############

/datum/call_history
	var/list/inbound_calls = list()
	var/list/outbound_calls = list()

/datum/call_history/proc/add_inbound_call(transmitter_id)
	inbound_calls += list("time" = world.time, "id" = transmitter_id)

/datum/call_history/proc/add_outbound_call(transmitter_id)
	outbound_calls += list("time" = world.time, "id" = transmitter_id)

// ####################
// Transmitter subtypes
// ####################

/obj/structure/transmitter/rotary
	name = "rotary telephone"
	icon_state = "rotary_phone"
	desc = "The finger plate is a little stiff."

/obj/structure/transmitter/only_outcome
	phone_name = "Public Phone"
	do_not_disturb = PHONE_DND_FORCED
	only_outcome = TRUE

/obj/structure/transmitter/only_income
	phone_name = "Public Phone"
	only_income = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/transmitter/only_outcome, (-32))
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/transmitter/only_income, (-32))

/obj/structure/transmitter/syndicate
	networks_receive = list(PHONE_FACTION_SYNDICATE)
	networks_transmit = list(PHONE_FACTION_SYNDICATE)

/obj/structure/transmitter/syndicate/rotary
	name = "rotary telephone"
	icon_state = "rotary_phone"
	desc = "The finger plate is a little stiff."


/obj/structure/transmitter/rotary/prefab/bridge
	name = "Bridge Telephone"
	phone_name = "Bridge"
	phone_category = "Command"
	phone_color = "yellow"
	do_not_disturb = PHONE_DND_FORBIDDEN
	networks_receive = list(PHONE_FACTION_STATION_PRIVATE)
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/briefing_room
	name = "Briefing Room Telephone"
	phone_name = "Briefing Room"
	phone_category = "Command"
	phone_color = "yellow"
	do_not_disturb = PHONE_DND_FORBIDDEN
	networks_receive = list(PHONE_FACTION_STATION_PRIVATE)
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/captain
	name = "Captain's Telephone"
	phone_name = "Captain's Office"
	phone_category = "Command"
	phone_color = "yellow"
	networks_receive = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/cmo
	name = "Chief Medical Officer's telephone"
	phone_name = "Chief Medical Officer's Office"
	phone_category = "Command"
	phone_color = "blue"
	networks_receive = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/hos
	name = "Head of Security's telephone"
	phone_name = "Head of Security's Office"
	phone_category = "Command"
	phone_color = "red"
	networks_receive = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/hop
	name = "Head of Personnel's telephone"
	phone_name = "Head of Personnel's Office"
	phone_category = "Command"
	phone_color = "green"
	networks_receive = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/ce
	name = "Chief Engineer's telephone"
	phone_name = "Chief Engineer's Office"
	phone_category = "Command"
	phone_color = "orange"
	networks_receive = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/rd
	name = "Research Director's telephone"
	phone_name = "Research Director's Office"
	phone_category = "Command"
	phone_color = "violet"
	networks_receive = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/qm
	name = "Quartermaster's telephone"
	phone_name = "Quartermaster's Office"
	phone_category = "Command"
	phone_color = "brown"
	networks_receive = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/detective
	name = "Detective's Office telephone"
	phone_name = "Detective's Office"
	phone_category = "Offices"

/obj/structure/transmitter/rotary/prefab/law
	name = "Law Office telephone"
	phone_name = "Law Office"
	phone_category = "Offices"

/obj/structure/transmitter/rotary/prefab/cargo
	name = "Cargo Office telephone"
	phone_name = "Cargo Office"
	phone_category = "Offices"

/obj/structure/transmitter/rotary/prefab/psychology
	name = "Psychology Office telephone"
	phone_name = "Psychology Office"
	phone_category = "Offices"

/obj/structure/transmitter/rotary/prefab/hydro
	name = "Hydroponics telephone"
	phone_name = "Hydroponics"
	phone_category = "Offices"

/obj/structure/transmitter/rotary/prefab/robotics
	name = "Robotics Lab telephone"
	phone_name = "Robotics Lab"
	phone_category = "Offices"

/obj/structure/transmitter/rotary/prefab/rnd
	name = "Research Division telephone"
	phone_name = "Research Division"
	phone_category = "Offices"

/obj/structure/transmitter/rotary/prefab/security
	name = "Security Office telephone"
	phone_name = "Security Office"
	phone_category = "Civilian"
	phone_color = "red"
	do_not_disturb = PHONE_DND_FORBIDDEN
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/medical
	name = "Medical Lobby telephone"
	phone_name = "Medical Lobby"
	phone_category = "Civilian"
	phone_color = "blue"
	do_not_disturb = PHONE_DND_FORBIDDEN
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)

/obj/structure/transmitter/rotary/prefab/engineering
	name = "Engineering Lobby telephone"
	phone_name = "Engineering Lobby"
	phone_category = "Civilian"
	phone_color = "orange"
	do_not_disturb = PHONE_DND_FORBIDDEN
	networks_transmit = list(PHONE_FACTION_STATION, PHONE_FACTION_STATION_PRIVATE)


#undef PHONE_FACTION_SYNDICATE
#undef PHONE_FACTION_STATION
