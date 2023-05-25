/datum/antagonist/custom_rev/head
	name = "\improper Leader Activist"
	antag_hud_name = "rev_head"
	antagpanel_category = "Activists Leader (custom revolution)"

/datum/antagonist/custom_rev/head/admin_add(datum/mind/new_owner, mob/admin)
	var/confirm = tgui_alert(admin, "Создать новую команду?", "АТТЕНШЕН!!", list("Да", "Нет"))
	if(confirm == "Да")
		var/given_name = tgui_input_text(admin, "Имя для члена данного объединения::", "Нейминг")
		if(!given_name)
			return FALSE
		var/given_team_name = tgui_input_text(admin, "Название для объединения:", "Тим Нейминг")
		if(!given_team_name)
			return FALSE
		var/given_objective = tgui_input_text(admin, "Цель движения:", "Обжектив", multiline = TRUE)
		if(!given_objective)
			return FALSE
		var/mindshield_protection = tgui_alert(admin, "Майндшилд будет мешать вступлению?", "Мозго-Промыв", list("Да", "Нет"))
		if(!mindshield_protection)
			return FALSE
		var/agression_factor = tgui_alert(admin, "Ваше объединение враждебно по потношению к власти, компании и прочему?", "Бад-Гайс?", list("Да", "Нет"))
		if(!agression_factor)
			return FALSE
		if(QDELETED(src) || QDELETED(new_owner.current))
			return FALSE

		rev_team = new /datum/team/custom_rev_team

		name = given_name
		rev_team.rev_role_name = given_name
		rev_team.name = given_team_name
		rev_team.ignore_mindshield = (mindshield_protection == "Нет")
		rev_team.agressive = (agression_factor == "Да")
		

		var/datum/objective/obj = new()
		obj.team = src
		obj.explanation_text = given_objective 
		obj.update_explanation_text()
		objectives += obj

		GLOB.custom_rev_teams += rev_team

	else
		var/teams_input_list = list()
		var/teams = list()
		for(var/datum/team/custom_rev_team/someteam in GLOB.custom_rev_teams)
			teams_input_list += someteam.name
			teams[someteam.name] = someteam
		to_chat(admin, span_notice("Если у вас не вывело список доступных команд/объединений - скорее всего их нет."))
		var/team_option = tgui_input_list(admin, "Доступные команды/объединения:", "Тимейты - Дауны", teams_input_list)
		if(QDELETED(src) || QDELETED(new_owner.current))
			return
		if(!team_option)
			return FALSE
		
		rev_team = teams[team_option]
		name = rev_team.rev_role_name
		
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] made [key_name(new_owner)] the leader of [rev_team.name].")
	log_admin("[key_name(admin)] made [key_name(new_owner)] the leader of [rev_team.name].")
