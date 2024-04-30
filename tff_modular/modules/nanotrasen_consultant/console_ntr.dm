// Just copypaste of communications.dm + SolFed Police, thx Nova dev.

#define NT_POLICE_AMT "amount"
#define NT_POLICE_VOTES "votes"
#define NT_POLICE_DECLARED "declared"

#define IMPORTANT_ACTION_COOLDOWN (60 SECONDS)
#define CALL_POLICE_COOLDOWN (360 SECONDS)

GLOBAL_LIST_EMPTY(responding_centcom_consoles)

#define STATE_MAIN "main"
#define STATE_MESSAGES "messages"


/obj/item/circuitboard/computer/comntr
	name = "NTR"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/comntr

/obj/machinery/computer/comntr
	// Имя поменять бы
	name = "NTR console"
	// Да и описание покруче нужно
	desc = "A console special for NTR."
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_CENT_GENERAL)
	circuit = /obj/item/circuitboard/computer/comntr
	light_color = LIGHT_COLOR_BLUEGREEN
	COOLDOWN_DECLARE(static/important_action_cooldown)
	COOLDOWN_DECLARE(static/call_police_cooldown)
	var/state = STATE_MAIN
	var/authorize_name
	var/list/authorize_access
	var/list/datum/comm_message/messages
	var/send_cross_comms_message_timer

/obj/machinery/computer/comntr/Initialize(mapload)
	. = ..()
	GLOB.responding_centcom_consoles += src
	AddComponent(/datum/component/gps, "Unic NTR console Signal")

/obj/machinery/computer/comntr/Destroy()
	GLOB.responding_centcom_consoles -= src
	. = ..()

/obj/machinery/computer/comntr/proc/call_NTSecs()
	call_NTIS("agents")
	return TRUE

/obj/machinery/computer/comntr/proc/calling_NTIS(mob/user)
	message_admins("[ADMIN_LOOKUPFLW(user)] is considering calling the NT Internal Security.")
	var/call_NTIS_msg_are_you_sure = "Are you sure you want to call NT Internal Security?"
	if(tgui_input_list(user, call_NTIS_msg_are_you_sure, "Call the POLICE?!", list("Yes", "No")) != "Yes")
		return
	var/police_responsability_chat = "If pressure on employees has no effect, you have the right to call the corporate police unit to resolve the conflict. Keep in mind that calling the corporate police unnecessarily (threat to your life and health, riots, abuse of weapons) is strictly prohibited. For unnecessary use of the \"panic button,\" charges of negligence and company resource mismanagement will be brought against you; you will likely be replaced by a more capable employee. "
	message_admins("[ADMIN_LOOKUPFLW(user)] has acknowledged the faulty NTIS call consequences.")
	if(tgui_input_list(user, police_responsability_chat, "Call Nanotrasen Internal Security", list("Yes", "No")) != "Yes")
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has read and acknowleged the recommendations for what to call and not call Nanotrasen Internal Security for.")
	var/reason_to_call_NTIS = stripped_input(user, "What do you wish to call Nanotrasen Internal Security for?", "Call NTIS", null, MAX_MESSAGE_LEN)
	if(!reason_to_call_NTIS)
		to_chat(user, "You decide not to call Nanotrasen Internal Security.")
		return
	GLOB.call_NTIS_msg = reason_to_call_NTIS
	GLOB.caller_of_NTIS = user.name
	if(call_NTSecs())
		log_game("[key_name(user)] has called the Nanotrasen Internal Security for the following reason:\n[GLOB.call_NTIS_msg]")
		message_admins("[ADMIN_LOOKUPFLW(user)] has called the Nanotrasen Internal Security for the following reason:\n[GLOB.call_NTIS_msg]")
		deadchat_broadcast(" has called the Nanotrasen Internal Security for the following reason:\n[GLOB.call_NTIS_msg]", span_name("[user.real_name]"), user, message_type = DEADCHAT_ANNOUNCEMENT)
		to_chat(user, span_notice("Authorization confirmed. Nanotrasen Internal Security call dispatched to the Nanotrasen Internal Security."))
		COOLDOWN_START(src, call_police_cooldown, CALL_POLICE_COOLDOWN)
		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)

/obj/machinery/computer/comntr/proc/authenticated(mob/user)
	return authenticated

/obj/machinery/computer/comntr/attackby(obj/I, mob/user, params)
	if(isidcard(I))
		attack_hand(user)
	else
		return ..()

/obj/machinery/computer/comntr/ui_act(action, list/params)
	var/static/list/approved_states = list(STATE_MAIN, STATE_MESSAGES)

	. = ..()
	if (.)
		return

	if (!has_communication())
		return

	. = TRUE

	switch (action)
		if ("setState")
			if (!authenticated(usr))
				return
			if (!(params["state"] in approved_states))
				return
			set_state(usr, params["state"])
			playsound(src, SFX_TERMINAL_TYPE, 50, FALSE)
		if ("callThePolice")
			if(COOLDOWN_FINISHED(src, call_police_cooldown))
				calling_NTIS(usr)
		if ("deleteMessage")
			if (!authenticated(usr))
				return
			var/message_index = text2num(params["message"])
			if (!message_index)
				return
			LAZYREMOVE(messages, LAZYACCESS(messages, message_index))
		if ("messageAssociates")
			if (!COOLDOWN_FINISHED(src, important_action_cooldown))
				return

			playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)
			var/message = trim(html_encode(params["message"]), MAX_MESSAGE_LEN)
			message_centcom(message, usr)
			to_chat(usr, span_notice("Message transmitted to Central Command."))
			usr.log_talk(message, LOG_SAY, tag = "message to CentCom")
			deadchat_broadcast(" has messaged CentCom, \"[message]\" at [span_name("[get_area_name(usr, TRUE)]")].", span_name("[usr.real_name]"), usr, message_type = DEADCHAT_ANNOUNCEMENT)
			COOLDOWN_START(src, important_action_cooldown, IMPORTANT_ACTION_COOLDOWN)
		if ("sendToOtherSector")
			if (!can_send_messages_to_other_sectors(usr))
				return
			if (!COOLDOWN_FINISHED(src, important_action_cooldown))
				return

			var/message = trim(params["message"], MAX_MESSAGE_LEN)
			if (!message)
				return

			GLOB.communications_controller.soft_filtering = FALSE
			var/list/hard_filter_result = is_ic_filtered(message)
			if(hard_filter_result)
				tgui_alert(usr, "Your message contains: (\"[hard_filter_result[CHAT_FILTER_INDEX_WORD]]\"), which is not allowed on this server.")
				return

			var/list/soft_filter_result = is_soft_ooc_filtered(message)
			if(soft_filter_result)
				if(tgui_alert(usr,"Your message contains \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\", Are you sure you want to use it?", "Soft Blocked Word", list("Yes", "No")) != "Yes")
					return
				message_admins("[ADMIN_LOOKUPFLW(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". They may be using a disallowed term for a cross-station message. Increasing delay time to reject.\n\n Message: \"[html_encode(message)]\"")
				log_admin_private("[key_name(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". They may be using a disallowed term for a cross-station message. Increasing delay time to reject.\n\n Message: \"[message]\"")
				GLOB.communications_controller.soft_filtering = TRUE
			playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)

			var/destination = params["destination"]

			usr.log_message("is about to send the following message to [destination]: [message]", LOG_GAME)


			COOLDOWN_START(src, important_action_cooldown, IMPORTANT_ACTION_COOLDOWN)

		if ("toggleAuthentication")
			if (authorize_name)
				authenticated = FALSE
				authorize_access = null
				authorize_name = null
				playsound(src, 'sound/machines/terminal_off.ogg', 50, FALSE)
				return

			if (obj_flags & EMAGGED)
				authenticated = TRUE
				authorize_access = SSid_access.get_region_access_list(list(REGION_ALL_STATION))
				authorize_name = "Unknown"
				to_chat(usr, span_warning("[src] lets out a quiet alarm as its login is overridden."))
				playsound(src, 'sound/machines/terminal_alert.ogg', 25, FALSE)
			else if(isliving(usr))
				var/mob/living/L = usr
				var/obj/item/card/id/id_card = L.get_idcard(hand_first = TRUE)
				if (check_access(id_card))
					authenticated = TRUE
					authorize_access = id_card.access.Copy()
					authorize_name = "[id_card.registered_name] - [id_card.assignment]"

			state = STATE_MAIN
			playsound(src, 'sound/machines/terminal_on.ogg', 50, FALSE)

/obj/machinery/computer/comntr/proc/send_cross_comms_message(mob/user, destination, message)
	send_cross_comms_message_timer = null

	var/list/payload = list()

	payload["sender_ckey"] = usr.ckey
	var/network_name = CONFIG_GET(string/cross_comms_network)
	if(network_name)
		payload["network"] = network_name

	var/name_to_send = "[CONFIG_GET(string/cross_comms_name)]([station_name()])"

	send2otherserver(html_decode(name_to_send), message, "Comms_Console", destination == "all" ? null : list(destination), additional_data = payload) //NOVA EDIT END
	minor_announce(message, title = "Outgoing message to allied station")
	usr.log_talk(message, LOG_SAY, tag = "message to the other server")
	message_admins("[ADMIN_LOOKUPFLW(usr)] has sent a message to the other server\[s].")
	deadchat_broadcast(" has sent an outgoing message to the other station(s).</span>", "<span class='bold'>[usr.real_name]", usr, message_type = DEADCHAT_ANNOUNCEMENT)

/obj/machinery/computer/comntr/ui_data(mob/user)
	var/list/data = list(
		"authenticated" = FALSE,
	)

	var/ui_state = state

	var/has_connection = has_communication()
	data["hasConnection"] = has_connection
	if (authenticated)
		data["authenticated"] = TRUE
		data["page"] = ui_state

	switch (ui_state)
		if (STATE_MAIN)
			data["canMessageAssociates"] = TRUE
			data["importantActionReady"] = COOLDOWN_FINISHED(src, important_action_cooldown)
			data["callPoliceReady"] = COOLDOWN_FINISHED(src, call_police_cooldown)
			data["authorizeName"] = authorize_name
			data["canLogOut"] = !issilicon(user)

			if (can_send_messages_to_other_sectors(user))
				data["canSendToSectors"] = TRUE

				var/list/sectors = list()
				var/our_id = CONFIG_GET(string/cross_comms_name)

				for (var/server in CONFIG_GET(keyed_list/cross_server))
					if (server == our_id)
						continue
					sectors += server

				data["sectors"] = sectors

		if (STATE_MESSAGES)
			data["messages"] = list()

			if (messages)
				for (var/_message in messages)
					var/datum/comm_message/message = _message
					data["messages"] += list(list(
						"answered" = message.answered,
						"content" = message.content,
						"title" = message.title,
						"possibleAnswers" = message.possible_answers,
					))
	return data

/obj/machinery/computer/comntr/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(issilicon(user))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "comNTR")
		ui.open()

/obj/machinery/computer/comntr/ui_static_data(mob/user)
	return list(
		"maxStatusLineLength" = MAX_STATUS_LINE_LENGTH,
		"maxMessageLength" = MAX_MESSAGE_LEN,
	)

/obj/machinery/computer/comntr/Topic(href, href_list)
	if (href_list["reject_cross_comms_message"])
		if (!usr.client?.holder)
			usr.log_message("tried to reject a cross-comms message without being an admin.", LOG_ADMIN)
			message_admins("[key_name(usr)] tried to reject a cross-comms message without being an admin.")
			return

		if (isnull(send_cross_comms_message_timer))
			to_chat(usr, span_warning("It's too late!"))
			return

		deltimer(send_cross_comms_message_timer)
		send_cross_comms_message_timer = null

		log_admin("[key_name(usr)] has cancelled the outgoing cross-comms message.")
		message_admins("[key_name(usr)] has cancelled the outgoing cross-comms message.")

		return TRUE

	return ..()

/obj/machinery/computer/comntr/proc/has_communication()
	var/turf/current_turf = get_turf(src)
	var/z_level = current_turf.z
	return is_station_level(z_level) || is_centcom_level(z_level)

/obj/machinery/computer/comntr/proc/set_state(mob/user, new_state)
	state = new_state

/obj/machinery/computer/comntr/proc/can_send_messages_to_other_sectors(mob/user)
	return length(CONFIG_GET(keyed_list/cross_server)) > 0

/obj/machinery/computer/comntr/proc/override_cooldown()
	COOLDOWN_RESET(src, important_action_cooldown)

/obj/machinery/computer/comntr/proc/add_message(datum/comm_message/new_message)
	LAZYADD(messages, new_message)

/datum/communciations_controller/send_message(datum/comm_message/sending,print = TRUE,unique = FALSE)
	for(var/obj/machinery/computer/comntr/C in GLOB.responding_centcom_consoles)
		if(!(C.machine_stat & (BROKEN|NOPOWER)) && is_station_level(C.z))
			if(unique)
				C.add_message(sending)
			else //We copy the message for each console, answers and deletions won't be shared
				var/datum/comm_message/M = new(sending.title,sending.content,sending.possible_answers.Copy())
				C.add_message(M)
			if(print)
				var/obj/item/paper/printed_paper = new /obj/item/paper(C.loc)
				printed_paper.name = "paper - '[sending.title]'"
				printed_paper.add_raw_text(sending.content)
				printed_paper.update_appearance()
			C.override_cooldown()
	. = ..()


#undef IMPORTANT_ACTION_COOLDOWN
#undef CALL_POLICE_COOLDOWN
#undef STATE_MAIN
#undef STATE_MESSAGES
