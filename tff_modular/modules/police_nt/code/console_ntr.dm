// Just copypaste of communications.dm
#define IMPORTANT_ACTION_COOLDOWN (60 SECONDS)
#define CALL_POLICE_COOLDOWN (360 SECONDS)
GLOBAL_LIST_EMPTY(responding_centcom_consoles)
#define STATE_MAIN "main"
#define STATE_MESSAGES "messages"
#define EMERGENCY_RESPONSE_POLICE "WOOP WOOP THAT'S THE SOUND OF THE POLICE"

/obj/item/circuitboard/computer/comntr
	name = "NTR"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/comntr

/obj/machinery/computer/comntr
	name = "NTR console"
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
	// Костыльный способ развернуть консоль жопкой к стенке.
	/*
	if(!SSticker.HasRoundStarted())
		var/list/adjacent_walls = list()
		var/turf/closed/new_turf = get_step(src, NORTH)
		adjacent_walls += new_turf
		new_turf = get_step(src, SOUTH)
		adjacent_walls += new_turf
		new_turf = get_step(src, EAST)
		adjacent_walls += new_turf
		new_turf = get_step(src, WEST)
		adjacent_walls += new_turf
		var/turf/closed/random_wall = pick(adjacent_walls)
		src.setDir(get_dir(src, random_wall))*/

	GLOB.responding_centcom_consoles += src
	AddComponent(/datum/component/gps, "Unic NTR console Signal")

/obj/machinery/computer/comntr/proc/authenticated(mob/user)
	return authenticated

/obj/machinery/computer/comntr/attackby(obj/I, mob/user, params)
	if(isidcard(I))
		attack_hand(user)
	else
		return ..()

/obj/machinery/computer/comntr/proc/call_911(ordered_team)
	var/team_size
	var/datum/antagonist/ert/cops_to_send
	var/announcement_message = "teshari dance"
	var/announcer = "NT Central Command"
	var/poll_question = "raize youre tails!"
	var/list_to_use = "911_responders"
	switch(ordered_team)
		if(EMERGENCY_RESPONSE_POLICE)
			team_size = 3
			cops_to_send = /datum/antagonist/ert/request_911/police
			announcement_message = "Attention, personnel of [station_name()]. \n NT Internal Security on the line. We've received a request from your corporate consultant, and we're sending a unit shortly. \n In case of any kind of escalation or injury to an Internal Security officers, a tactical squad will be dispatched to handle this issue. \n\n Stay safe, Glory to Nanotrasen."
			announcer = "NT Central Command"
			poll_question = "The station has called for the NT Internal Security. Will you respond?"
	priority_announce(announcement_message, announcer, 'sound/effects/families_police.ogg', has_important_message=TRUE, color_override = "yellow")
	var/list/candidates = SSpolling.poll_ghost_candidates(
		poll_question,
		check_jobban = ROLE_DEATHSQUAD,
		pic_source = /obj/item/solfed_reporter,
		role_name_text = cops_to_send::name,
	)

	if(length(candidates))
		//Pick the (un)lucky players
		var/agents_number = min(team_size, candidates.len)

		var/list/spawnpoints = GLOB.emergencyresponseteamspawn
		var/index = 0
		GLOB.solfed_responder_info[list_to_use][SOLFED_AMT] = agents_number
		while(agents_number && candidates.len)
			var/spawn_loc = spawnpoints[index + 1]
			//loop through spawnpoints one at a time
			index = (index + 1) % spawnpoints.len
			var/mob/dead/observer/chosen_candidate = pick(candidates)
			candidates -= chosen_candidate
			if(!chosen_candidate.key)
				continue

			//Spawn the body
			var/mob/living/carbon/human/cop = new(spawn_loc)
			chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
			cop.key = chosen_candidate.key

			//Give antag datum
			var/datum/antagonist/ert/request_911/ert_antag = new cops_to_send

			cop.mind.add_antag_datum(ert_antag)
			cop.mind.set_assigned_role(SSjob.GetJobType(ert_antag.ert_job_path))
			SSjob.SendToLateJoin(cop)
			cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)

			if(cops_to_send == /datum/antagonist/ert/request_911/atmos) // charge for atmos techs
				var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
				station_balance?.adjust_money(GLOB.solfed_tech_charge)

			//Logging and cleanup
			log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
			if(cops_to_send == /datum/antagonist/ert/request_911/atmos)
				log_game("[abs(GLOB.solfed_tech_charge)] has been charged from the station budget for [key_name(cop)]")
			agents_number--
	GLOB.cops_arrived = TRUE
	return TRUE

/obj/machinery/computer/comntr/proc/calling_911(mob/user, called_group_pretty = "EMTs", called_group = EMERGENCY_RESPONSE_POLICE)
	message_admins("[ADMIN_LOOKUPFLW(user)] is considering calling the Sol Federation [called_group_pretty].")
	var/call_911_msg_are_you_sure = "Are you sure you want to call 911? Faulty 911 calls results in a $20,000 fine and a 5 year superjail \
		sentence."
	if(tgui_input_list(user, call_911_msg_are_you_sure, "Call 911", list("Yes", "No")) != "Yes")
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has acknowledged the faulty 911 call consequences.")
	if(tgui_input_list(user, GLOB.call911_do_and_do_not[called_group], "Call [called_group_pretty]", list("Yes", "No")) != "Yes")
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has read and acknowleged the recommendations for what to call and not call [called_group_pretty] for.")
	var/reason_to_call_911 = stripped_input(user, "What do you wish to call 911 [called_group_pretty] for?", "Call 911", null, MAX_MESSAGE_LEN)
	if(!reason_to_call_911)
		to_chat(user, "You decide not to call 911.")
		return
	GLOB.cops_arrived = TRUE
	GLOB.call_911_msg = reason_to_call_911
	GLOB.caller_of_911 = user.name
	log_game("[key_name(user)] has called the Sol Federation [called_group_pretty] for the following reason:\n[GLOB.call_911_msg]")
	message_admins("[ADMIN_LOOKUPFLW(user)] has called the Sol Federation [called_group_pretty] for the following reason:\n[GLOB.call_911_msg]")
	deadchat_broadcast(" has called the Sol Federation [called_group_pretty] for the following reason:\n[GLOB.call_911_msg]", span_name("[user.real_name]"), user, message_type = DEADCHAT_ANNOUNCEMENT)

	call_911(called_group)

	to_chat(user, span_notice("Authorization confirmed. 911 call dispatched to the Sol Federation [called_group_pretty]."))
	playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)

/obj/machinery/computer/comntr/ui_act(action, list/params)
	var/static/list/approved_states = list(STATE_MAIN, STATE_MESSAGES)

	. = ..()
	if (.)
		return

	if (!has_communication())
		return

	. = TRUE

	switch (action)
		if ("answerMessage")
			if (!authenticated(usr))
				return

			var/answer_index = params["answer"]
			var/message_index = params["message"]

			// If either of these aren't numbers, then bad voodoo.
			if(!isnum(answer_index) || !isnum(message_index))
				message_admins("[ADMIN_LOOKUPFLW(usr)] provided an invalid index type when replying to a message on [src] [ADMIN_JMP(src)]. This should not happen. Please check with a maintainer and/or consult tgui logs.")
				CRASH("Non-numeric index provided when answering comms console message.")

			if (!answer_index || !message_index || answer_index < 1 || message_index < 1)
				return
			var/datum/comm_message/message = messages[message_index]
			if (message.answered)
				return
			message.answered = answer_index
			message.answer_callback.InvokeAsync()
		if ("setState")
			if (!authenticated(usr))
				return
			if (!(params["state"] in approved_states))
				return
			set_state(usr, params["state"])
			playsound(src, SFX_TERMINAL_TYPE, 50, FALSE)
		if ("callThePolice")
			if(COOLDOWN_FINISHED(src, call_police_cooldown))
				COOLDOWN_START(src, call_police_cooldown, CALL_POLICE_COOLDOWN)
				calling_911(usr, "Marshals", EMERGENCY_RESPONSE_POLICE)
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

			SScommunications.soft_filtering = FALSE
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
				SScommunications.soft_filtering = TRUE
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

	var/name_to_send = "[CONFIG_GET(string/cross_comms_name)]([station_name()])" //NOVA EDIT ADDITION

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
			data["alertLevel"] = SSsecurity_level.get_current_level_as_text()
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

/obj/machinery/computer/comntr/proc/get_communication_players()
	return GLOB.player_list

/obj/machinery/computer/comntr/proc/post_status(command, data1, data2)

	var/datum/radio_frequency/frequency = SSradio.return_frequency(FREQ_STATUS_DISPLAYS)

	if(!frequency)
		return

	var/datum/signal/status_signal = new(list("command" = command))
	switch(command)
		if("message")
			status_signal.data["top_text"] = data1
			status_signal.data["bottom_text"] = data2
			log_game("[key_name(usr)] has changed the station status display message to \"[data1] [data2]\" [loc_name(usr)]")

		if("alert")
			status_signal.data["picture_state"] = data1
			log_game("[key_name(usr)] has changed the station status display message to \"[data1]\" [loc_name(usr)]")


	frequency.post_signal(src, status_signal)

/obj/machinery/computer/comntr/proc/override_cooldown()
	COOLDOWN_RESET(src, important_action_cooldown)

/obj/machinery/computer/comntr/proc/add_message(datum/comm_message/new_message)
	LAZYADD(messages, new_message)

/datum/controller/subsystem/communications/send_message(datum/comm_message/sending,print = TRUE,unique = FALSE)
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
	. = ..()

#undef IMPORTANT_ACTION_COOLDOWN
#undef CALL_POLICE_COOLDOWN
#undef STATE_MAIN
#undef STATE_MESSAGES
#undef EMERGENCY_RESPONSE_POLICE
