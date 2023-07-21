/datum/antagonist/custom_rev/head
	name = "\improper Leader Activist"
	antag_hud_name = "rev_head"
	antagpanel_category = "Activists (custom revolution)"
	var/datum/action/cooldown/create_brochure/create_brochure_action
	var/max_convert_brochures = 3
	var/list/convert_brochures_list = list()

/datum/antagonist/custom_rev/head/admin_add(datum/mind/new_owner, mob/admin)
	var/confirm = tgui_alert(admin, "Создать новую команду?", "Команда", list("Да", "Нет"))
	if(confirm == "Да")
		var/given_name = tgui_input_text(admin, "Название участника данного объединения:", "Название роли")
		if(!given_name)
			return FALSE
		var/given_team_name = tgui_input_text(admin, "Название объединения:", "Название команды")
		if(!given_team_name)
			return FALSE
		to_chat(admin, span_doyourjobidiot("Цель, ввиду своей не механической натуры, считается выполненой по умолчанию. При желании вы можете сами менять её статус через ТП любого члена объединения."))
		var/given_objective = tgui_input_text(admin, "Прочитайте сообщение в чате и введите цель объединения:", "Цель", multiline = TRUE)
		if(!given_objective)
			return FALSE
		var/mindshield_protection = tgui_alert(admin, "Майндшилд будет мешать вступлению?", "Майндшилд", list("Да", "Нет"))
		if(!mindshield_protection)
			return FALSE
		var/machine_deconvert = tgui_alert(admin, "Особое устройство сможет деконвертировать участников?", "Деконверт-Девайс", list("Да", "Нет"))
		if(!mindshield_protection)
			return FALSE
		var/brochure_message = tgui_input_text(admin, "Зазывающий текст в брошюре:", "Брошюра")
		if(!brochure_message)
			return FALSE
		if(QDELETED(src) || QDELETED(new_owner.current))
			return FALSE

		rev_team = new /datum/team/custom_rev_team

		rev_team.member_name = given_name
		rev_team.name = given_team_name

		rev_team.brochure_message = brochure_message

		rev_team.ignore_mindshield = (mindshield_protection == "Нет")
		rev_team.ignore_deconvert_machine = (machine_deconvert == "Нет")

		
		

		var/datum/objective/obj = new()
		obj.team = rev_team
		obj.explanation_text = given_objective 
		obj.update_explanation_text()
		obj.completed = TRUE

		rev_team.objectives |= obj
		GLOB.custom_rev_teams += rev_team

	else
		var/teams_input_list = list()
		var/teams = list()
		for(var/datum/team/custom_rev_team/someteam in GLOB.custom_rev_teams)
			teams_input_list += someteam.name
			teams[someteam.name] = someteam
		to_chat(admin, span_notice("Если у вас не вывело список доступных команд/объединений - скорее всего их нет."))
		var/team_option = tgui_input_list(admin, "Доступные команды/объединения:", "Команды", teams_input_list)
		if(QDELETED(src) || QDELETED(new_owner.current))
			return
		if(!team_option)
			return FALSE
		
		rev_team = teams[team_option]
		name = rev_team.member_name
	
	var/datum/objective/headrev_obj = new()
	headrev_obj.explanation_text = "Recruit people in order to accomplish your goals!"
	headrev_obj.update_explanation_text()
	headrev_obj.completed = TRUE
	objectives += headrev_obj

	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] made [key_name(new_owner)] the leader of [rev_team.name].")
	log_admin("[key_name(admin)] made [key_name(new_owner)] the leader of [rev_team.name].")

/datum/antagonist/custom_rev/head/greet()
	. = ..()
	to_chat(owner, span_doyourjobidiot("As leader your primary task is recruiting new members!"))

/datum/antagonist/custom_rev/head/on_gain()
	. = ..()
	create_brochure_action = new()
	create_brochure_action.link_to(owner.current)
	create_brochure_action.owner_antag_datum_ref = WEAKREF(src)
	create_brochure_action.Grant(owner.current)

/datum/antagonist/custom_rev/head/on_removal()
	. = ..()
	create_brochure_action.HideFrom(owner.current)
	create_brochure_action.Remove(owner.current)
	qdel(create_brochure_action)

// Special action for headrev

/datum/action/cooldown/create_brochure
	name = "Create brochure"
	cooldown_time = 30 // 30 ticks = 3 sec
	var/datum/weakref/owner_antag_datum_ref = new()
	button_icon = 'tff_modular/modules/custom_revolution/icons/items.dmi'
	button_icon_state = "brochure"

/datum/action/cooldown/create_brochure/Activate(atom/target)
	. = ..()
	var/datum/antagonist/custom_rev/head/owner_antag_datum = owner_antag_datum_ref.resolve()
	if(owner_antag_datum.convert_brochures_list.len >= owner_antag_datum.max_convert_brochures)
		var/obj/item/custom_rev_brochure/old_brochure = owner_antag_datum.convert_brochures_list[1]
		owner_antag_datum.convert_brochures_list -= old_brochure
		old_brochure.fancy_destroy()
	var/obj/item/custom_rev_brochure/brochure = new /obj/item/custom_rev_brochure
	brochure.link_to_headrev(owner_antag_datum)
	owner.put_in_hands(brochure)
	to_chat(owner, span_notice("[brochure] suddenly appears, distorting space a bit in the process."), confidential = TRUE)
