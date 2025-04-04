GLOBAL_LIST_EMPTY_TYPED(phone_transmitters, /obj/structure/transmitter)


/obj/structure/transmitter
	name = "telephone receiver"
	desc = "It is a wall mounted telephone. The fine text reads: To log your details with the mainframe please insert your keycard into the slot below. Unfortunately the slot is jammed. You can still use the phone, however."
	icon = 'tff_modular/modules/colonial_marines/telephone/icons/phone.dmi'
	icon_state = "wall_phone"
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND
	anchored = 0
	var/phone_category = "Uncategorised"
	var/phone_color = "white"
	var/phone_id = "Telephone"
	var/phone_icon

	var/obj/item/tube_phone/attached_to

	var/obj/structure/transmitter/outbound_call
	var/obj/structure/transmitter/inbound_call

	var/next_ring = 0

	var/phone_type = /obj/item/tube_phone

	var/range = 7

	var/enabled = TRUE
	/// Whether or not the phone is receiving calls or not. Varies between on/off or forcibly on/off.
	var/do_not_disturb = PHONE_DND_OFF
	/// The Phone_ID of the last person to call this telephone.
	var/last_caller

	var/timeout_timer_id
	var/timeout_duration = 30 SECONDS

	var/list/networks_receive = list(FACTION_NEUTRAL)
	var/list/networks_transmit = list(FACTION_NEUTRAL)

	var/datum/looping_sound/telephone/busy/busy_loop
	var/datum/looping_sound/telephone/hangup/hangup_loop
	var/datum/looping_sound/telephone/ring/outring_loop

	var/snapped = FALSE

/obj/structure/transmitter/Initialize(mapload, ...)
	. = ..()
	base_icon_state = icon_state

	attached_to = new phone_type(src)

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
	reset_call()
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
		. += span_bold("Looks like the cable on the phone is broken.")

/obj/structure/transmitter/proc/get_status()
	if(!attached_to)
		return PHONE_UNAVAILABLE
	if(!enabled)
		return PHONE_UNAVAILABLE
	if(get_calling_phone() || attached_to.loc != src || snapped)
		return PHONE_BUSY
	return PHONE_AVAILABLE

/obj/structure/transmitter/proc/get_transmitters()
	var/list/phone_list = list()

	for(var/possible_phone in GLOB.phone_transmitters)
		var/obj/structure/transmitter/target_phone = possible_phone
		var/current_dnd = FALSE
		if((target_phone.do_not_disturb == PHONE_DND_ON) || (target_phone.do_not_disturb == PHONE_DND_FORCED))
			current_dnd = TRUE
		if(!target_phone.get_status() || current_dnd) // Phone not available
			continue
		var/net_link = FALSE
		for(var/network in networks_transmit)
			if(network in target_phone.networks_receive)
				net_link = TRUE
				continue
		if(!net_link)
			continue

		var/id = target_phone.phone_id
		var/num_id = 1
		while(id in phone_list)
			id = "[target_phone.phone_id] [num_id]"
			num_id++

		target_phone.phone_id = id
		phone_list[id] = target_phone

	return phone_list

/obj/structure/transmitter/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(!get_status() || (get_status() == PHONE_BUSY))
		return UI_CLOSE

/obj/structure/transmitter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PhoneMenu", phone_id)
		ui.open()

/obj/structure/transmitter/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!get_status() || (get_status() == PHONE_BUSY))
		return

	if(!ishuman(usr))
		return

	var/mob/living/carbon/human/user = usr

	switch(action)
		if("call_phone")
			call_phone(user, params["phone_id"])
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
	if(!get_calling_phone())
		SEND_SIGNAL(src, COMSIG_ATOM_UI_INTERACT, user)
		ui_interact(user)
		return

	var/obj/structure/transmitter/T = get_calling_phone()

	if(T.attached_to && ismob(T.attached_to.loc))
		var/mob/M = T.attached_to.loc
		to_chat(M, span_purple("[icon2html(src, M)] [phone_id] has picked up."))
		playsound(T.attached_to.loc, 'tff_modular/modules/colonial_marines/telephone/sound/remote_pickup.ogg', 20)
		if(T.timeout_timer_id)
			deltimer(T.timeout_timer_id)
			T.timeout_timer_id = null

	to_chat(user, span_purple("[icon2html(src, user)] Picked up a call from [T.phone_id]."))
	playsound(get_turf(user), get_sound_file("rtb_handset"), 100)

	T.outring_loop.stop()
	attached_to.attempt_pickup(user)
	update_icon()

/obj/structure/transmitter/attackby(obj/item/W, mob/user)
	if(W == attached_to)
		recall_phone()
	else
		. = ..()

/obj/structure/transmitter/proc/call_phone(mob/living/carbon/human/user, calling_phone_id)
	var/list/transmitters = get_transmitters()
	transmitters -= phone_id

	if(!length(transmitters) || !(calling_phone_id in transmitters))
		to_chat(user, span_purple("[icon2html(src, user)] No transmitters could be located to call!"))
		return

	var/obj/structure/transmitter/T = transmitters[calling_phone_id]
	if(!istype(T) || QDELETED(T))
		transmitters -= T
		CRASH("Qdelled/improper atom inside transmitters list! (istype returned: [istype(T)], QDELETED returned: [QDELETED(T)])")

	if(!T.get_status())
		return

	outring_loop.start()
	to_chat(user, span_purple("[icon2html(src, user)] Dialing [calling_phone_id].."))
	playsound(get_turf(user), get_sound_file("rtb_handset"), 100)

	outbound_call = T

	attached_to.attempt_pickup(user)
	START_PROCESSING(SSobj, src)

	if(T.get_status() == PHONE_BUSY)
		timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(reset_call), FALSE, TRUE), 4 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
		return

	outbound_call.inbound_call = src
	outbound_call.last_caller = src.phone_id
	outbound_call.update_icon()
	START_PROCESSING(SSobj, outbound_call)

	timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(reset_call), TRUE), timeout_duration, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

/obj/structure/transmitter/proc/toggle_dnd(mob/living/carbon/human/user)
	switch(do_not_disturb)
		if(PHONE_DND_ON)
			do_not_disturb = PHONE_DND_OFF
			to_chat(user, span_notice("Do Not Disturb has been disabled. You can now receive calls."))
		if(PHONE_DND_OFF)
			do_not_disturb = PHONE_DND_ON
			to_chat(user, span_warning("Do Not Disturb has been enabled. No calls will be received."))
		else
			return FALSE
	return TRUE

/obj/structure/transmitter/proc/reset_call(timeout = FALSE, is_busy = FALSE)
	var/obj/structure/transmitter/T = get_calling_phone()
	if(T)
		SEND_SIGNAL(src, COMSIG_TRANSMITTER_HANG_UP)
		if(T.attached_to && ismob(T.attached_to.loc))
			var/mob/M = T.attached_to.loc
			to_chat(M, span_purple("[icon2html(src, M)] [phone_id] has hung up on you."))
			T.hangup_loop.start()

		if(attached_to && ismob(attached_to.loc))
			var/mob/M = attached_to.loc
			if(timeout)
				to_chat(M, span_purple("[icon2html(src, M)] Your call to [T.phone_id] has reached voicemail, nobody picked up the phone."))
				busy_loop.start()
			else if(is_busy)
				to_chat(M, span_purple("[icon2html(src, M)] The station you are trying to reach is currently busy, please hang on and try again later."))
				busy_loop.start()
			else
				to_chat(M, span_purple("[icon2html(src, M)] You have hung up on [T.phone_id]."))

	if(outbound_call)
		outbound_call.inbound_call = null
		outbound_call = null

	if(inbound_call)
		inbound_call.outbound_call = null
		inbound_call = null

	if(timeout_timer_id)
		deltimer(timeout_timer_id)
		timeout_timer_id = null

	if(T)
		if(T.timeout_timer_id)
			deltimer(T.timeout_timer_id)
			T.timeout_timer_id = null

		T.update_icon()
		STOP_PROCESSING(SSobj, T)

	outring_loop.stop()

	STOP_PROCESSING(SSobj, src)

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
	if(ismob(attached_to.loc))
		var/mob/M = attached_to.loc
		playsound(get_turf(M), get_sound_file("rtb_handset"), 100, FALSE, 7)
		hangup_loop.stop()

	attached_to.forceMove(src)
	reset_call()
	busy_loop.stop()
	outring_loop.stop()

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
	log_say("TELEPHONE: [key_name(speaking)] on Phone '[phone_id]' to '[T.phone_id]' said '[message]'")

/obj/structure/transmitter/proc/handle_snap()
	SIGNAL_HANDLER

	reset_call()
	snapped = TRUE

/obj/structure/transmitter/GetVoice()
	return "[phone_id]"

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
	var/anonymize = FALSE

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
	remove_attached()
	attached_to = to_attach

/obj/item/tube_phone/proc/remove_attached()
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

	for(var/mob/hearer in get_hearers_in_LOS(1))
		if(HAS_TRAIT(hearer, TRAIT_DEAF))
			continue
		var/dist = get_dist(src, hearer)
		var/message = hearer.translate_language(speaking, L, raw_message)
		if(dist > 0 && !HAS_TRAIT(src, TRAIT_GOOD_HEARING) && !isobserver(src))
			message = stars(message)
		message = compose_message(source, L, message)
		message = "<span class='[spans]'>[message]</span>"
		hearer.show_message(message, MSG_AUDIBLE)

/obj/item/tube_phone/attack_hand(mob/user)
	if(attached_to && get_dist(user, attached_to) > attached_to.range)
		return FALSE
	return ..()

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
		SEND_SIGNAL(attached_to, COMSIG_TRANSMITTER_NEED_DELETE_TETHER)
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

	tether_from.AddComponent( \
		/datum/component/transmitter_tether, \
		tether_to, \
		attached_to.range, \
		tether_name = "cable", \
		icon = "wire", \
		icon_file = 'tff_modular/modules/colonial_marines/telephone/icons/phone.dmi', \
	)

// ####################
// Transmitter subtypes
// ####################

/obj/structure/transmitter/rotary
	name = "rotary telephone"
	icon_state = "rotary_phone"
	desc = "The finger plate is a little stiff."
