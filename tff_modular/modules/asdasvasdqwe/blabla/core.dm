#define DIALOG_SAY "say"
#define DIALOG_EMOTE "emote"
#define DIALOG_RESUME "resume"

#define DIALOG_AUTOLOG_COOLDOWN 3 SECONDS

#define DIALOG_MOB_DAMAGED_WEAK (1 << 0)
#define DIALOG_MOB_DAMAGED_MEDIUM (1 << 1)
#define DIALOG_MOB_DAMAGED_CRITICAL (1 << 2)

/datum/dialog
	//CONST NODES?
	var/datum/dialog_options/default_node = /datum/dialog_options/mogeoko_real
	//dialog_options
	var/list/default_nodes = list()
	// list[mob] = list(discussed, options)
	var/mob/living/me
	//last_discussions[mob] = current_dialog
	var/list/last_discussions
	var/my_nickname = null
	//Таймер между логами от сигналов
	var/last_autolog_time

/datum/dialog/New(mob/parent, datum/dialog_options/node)
	me = parent
	default_node = node
	if(isnull(default_node))
		CRASH("No default node provided!")
	last_discussions = list()


	RegisterSignal(me, COMSIG_CLICK_ALT, PROC_REF(try_talking))
	RegisterSignal(me, COMSIG_MOVABLE_PRE_HEAR, PROC_REF(on_hear))
	RegisterSignal(me, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(on_damaged))
	//var/datum/action/cooldown/dialog_callout/callout = new(me, automated_announcements = automated_announcements)
	//callout.Grant(me)

/datum/dialog/Destroy(force)
	default_nodes = null
	last_discussions = null
	UnregisterSignal(me, list(
		COMSIG_CLICK_ALT,
		COMSIG_MOVABLE_PRE_HEAR,
		COMSIG_MOB_AFTER_APPLY_DAMAGE,
	))
	me = null
	return ..()


/datum/dialog/proc/start_dialog(mob/living/player, datum/dialog_options/option = null, over_radio = FALSE, resume = FALSE)
	var/datum/current_dialog/dialog = try_creating_dialog(player)
	dialog.start_dialog()
	//if(resume)

	if(!isnull(dialog.current_node))
		qdel(dialog.current_node)
	if(isnull(option))
		option = default_node
	dialog.current_node = new option()
	if(dialog.current_node.relationship_change)
		update_relationship(dialog)
	start_executing(player, dialog, over_radio)

/datum/dialog/proc/end_dialog(mob/living/player, datum/current_dialog/dialog)
	dialog.start_forgeting()
	return

/datum/dialog/proc/try_creating_dialog(mob/living/player)
	if(isnull(last_discussions[player]))
		last_discussions[player] = new /datum/current_dialog(src)
	return last_discussions[player]

// If true - latest dialog. Else null
/datum/dialog/proc/get_last_discussion(mob/living/player)
	if(player in last_discussions)
		return last_discussions[player]
	return null

/datum/dialog/proc/is_player(mob/living/player)
	if(!isnull(player.client))
		return TRUE
	return FALSE

// приделяется player
/datum/dialog/proc/try_talking(atom/source, mob/user)
	SIGNAL_HANDLER

	if(!is_able_to_talk(user))
		return
	start_dialog(user)
	return CLICK_ACTION_SUCCESS

/datum/dialog/proc/is_able_to_talk(mob/living/player)
	//to_chat(world, "trying to talk")
	/*
	if(get_dist(player, me) > 3)
		//to_chat(world, "failed sanityA")
		return FALSE
	*/
	if(is_player(me))
		//to_chat(world, "failed sanityB")
		return FALSE
	if(me.stat > CONSCIOUS || player.stat > CONSCIOUS)
		//to_chat(world, "failed sanityC")
		return FALSE
	//to_chat(world, "able to talk")
	return TRUE

//Прок перед пошаговым выполнением команд
/datum/dialog/proc/start_executing(mob/living/player, datum/current_dialog/dialog, over_radio = FALSE)
	var/entry
	if(dialog.check_if_old())
		entry = dialog.current_node.get_resume_entry(me, player)
	else
		entry = dialog.current_node.get_entry(me, player)
	var/list/lines = splittext(entry,"\n")
	for(var/line in lines)
		var/prepared_line = trim(line)
		if(!length(prepared_line))
			continue
		var/splitpoint = findtext(prepared_line," ")
		if(!splitpoint)
			continue
		var/command = copytext(prepared_line, 1, splitpoint)
		var/value = copytext(prepared_line, splitpoint + length(prepared_line[splitpoint]))

		dialog.entries += list(list(command, value))
	//to_chat(world, "preexecute")
	execute_text(player, dialog, over_radio)

/datum/dialog/proc/execute_text(mob/living/player, datum/current_dialog/dialog, datum/dialog_options/option, over_radio = FALSE, forced = FALSE, step = 1)
	//to_chat(world, "sanity")
	if(!is_able_to_talk(player))
		return
	//to_chat(world, "sanity")
	var/list/entry
	if(!forced && !isnull(dialog))
		//to_chat(world, "notnull")
		//Установка шага
		if(dialog.current_step > 1)

			//to_chat(world, "AAA")
			entry = dialog.current_node.get_resume_entry(me, player)
		else
			if(step == 1)
				dialog.current_step = 1
				//to_chat(world, "BBB")

			//Проверка текста
			if(!dialog.entries[dialog.current_step])
				//to_chat(world, "CCC")
				return
			entry = dialog.entries[dialog.current_step]
	else if(!isnull(option) && !LAZYLEN(entry))
		//to_chat(world, "getting entry")
		entry = option.get_entry(me)

	//to_chat(world, "entry:")
	//to_chat(world, entry)
	var/command = entry[1]
	//to_chat(world, "command")
	//to_chat(world, command)
	switch(command)
		if(DIALOG_RESUME)
			//var/message = entry[2]
			//if(dialog.current_node.private)
			//	show_message(message, player, message)
			//else
			//	me.say(message, ignore_spam = TRUE)
			//show_answers(player, dialog, TRUE)
		if(DIALOG_SAY)
			//to_chat(world, "say")
			var/message = entry[2]
			if(isnull(player) && forced)
				//to_chat(world, "saya")
				INVOKE_ASYNC(me, TYPE_PROC_REF(/atom/movable, say), message)
			else
				if(dialog.current_node.private)
					show_message(message, player, dialog)
				else
					//to_chat(world, "sayb")
					INVOKE_ASYNC(me, TYPE_PROC_REF(/atom/movable, say), message)
		if(DIALOG_EMOTE)
			var/message = entry[2]
			to_chat(player, message)
			//me.create_chat_message(me, me.get_selected_language(), message, runechat_flags = EMOTE_MESSAGE)
		//if(HOLORECORD_DELAY)
		//	playsound(src, entry[2], 50, TRUE)
		//	//addtimer(CALLBACK(src, PROC_REF(execute_text), player, dialog, dialog.current_step+1), entry[2])
		//	return
		//if(HOLORECORD_LANGUAGE)
		//	var/datum/language_holder/holder = me.get_language_holder()
		//	holder.selected_language = entry[2]
		//if(HOLORECORD_RENAME)
		//	me.name = entry[2]
	dialog.current_step += 1
	//TODO TRIED HERE > -> >=
	//to_chat(world, "saцц")
	if(dialog.current_step >= dialog.entries.len)
		QDEL_LIST(dialog.entries)
		dialog.current_step = 1
		show_answers(player, dialog)// !!!
		//to_chat(world, "sayd")
		return
	.(player, dialog, dialog.current_step)

/datum/dialog/proc/show_message(message, mob/living/player, datum/current_dialog/dialog)
	. = list()
	var/profile = icon2html(me.icon, player)
	. += "[profile ? profile : ""][me.get_examine_name(me)]"
	. += span_game_say(message)
	. = boxed_message(jointext(., "<br>"))
	to_chat(player, span_infoplain(.))
	//to_chat(world, "show_message")
	//to_chat(world, .)

/datum/dialog/proc/show_answers(mob/living/player, datum/current_dialog/dialog, resume = FALSE)
	. = list()
	if(!LAZYLEN(dialog.current_node.choices))
		return
	. += "[player.get_examine_name(player)]"

	if(resume)
		return
	else
		//var/list/tgui_choices = list()
		for(var/choice_index in 1 to LAZYLEN(dialog.current_node.choices))
			var/datum/dialog_options/choice = dialog.current_node.choices[choice_index]
		//	tgui_choices[choice.player_choice_text] = choice
		//var/choice = tgui_choices[tgui_input_list(player, "Choose dialog option", "Dialog Option", tgui_choices)]
//
		//if(!choice)
		//	return

		//start_dialog(player, choice)
			. += "[CHOICE_LINK(player, me, choice, choice_index)] [choice.player_choice_text]"
	. = boxed_message(jointext(., "<br>"))
	to_chat(player, span_infoplain(.))

	//to_chat(world, "answers")
	//to_chat(world, .)

//Текст повторяется при новом сообщении
//ТГУИ ЛИСТЫ


//HEAR
/datum/dialog/proc/on_hear(datum/source, list/hearing_args)
	SIGNAL_HANDLER

	var/message = hearing_args[HEARING_RAW_MESSAGE]
	var/speaker = hearing_args[HEARING_SPEAKER]
	var/over_radio = !!hearing_args[HEARING_RADIO_FREQ]
	if(speaker == source) // don't parrot ourselves
		return

	if(findtext(message, "test"))
		start_dialog(source, default_node, over_radio ? hearing_args[HEARING_RADIO_FREQ] : FALSE)
	return

/datum/dialog/proc/on_damaged()
	SIGNAL_HANDLER

	if(last_autolog_time > world.time)
		return
	last_autolog_time = world.time + DIALOG_AUTOLOG_COOLDOWN
	switch(me.health)
		if(-30 to -10)
			execute_text(option = default_node.get_damaged_entry(DIALOG_MOB_DAMAGED_WEAK))
		if(-70 to -30)
			execute_text(option = default_node.get_damaged_entry(DIALOG_MOB_DAMAGED_MEDIUM))
		if(-100 to -40)
			execute_text(option = default_node.get_damaged_entry(DIALOG_MOB_DAMAGED_CRITICAL))

/datum/dialog/proc/update_relationship(datum/current_dialog/dialog)
	var/change = dialog.current_node.relationship_change
	if(change)
		dialog.relationship += dialog.current_node.relationship_change


#undef DIALOG_AUTOLOG_COOLDOWN



/mob/living/Topic(href, list/href_list)
	. = ..()
	if(href_list["dialog_node"])
		var/datum/dialog_options/choice = locate(href_list["dialog_node"])
		var/mob/living/npc = locate(href_list["origin"])
		npc.my_dialog.start_dialog(src, choice)
