/datum/antagonist/custom_rev/head
	name = "\improper Leader Activist"
	antag_hud_name = "headrev"
	antagpanel_category = "Activists Leader (custom revolution)"

/datum/antagonist/custom_rev/head/admin_add(datum/mind/new_owner, mob/admin)
	var/confirm = tgui_alert(admin, "Do you want to create a new team?", "ATTENTION!", list("Yes", "No"))
	if(confirm == "Yes")
		var/given_name = tgui_input_text(admin, "What name will be given to the members?", "Role name")
		if(!given_name)
			return FALSE
		var/given_team_name = tgui_input_text(admin, "What will be the team name?:", "Team name")
		if(!given_team_name)
			return FALSE
		var/given_objective = tgui_input_text(admin, "Enter the team objective", "Objective", multiline = TRUE)
		if(!given_objective)
			return FALSE
		var/mindshield_protection = tgui_alert(admin, "Will mindshield implant protect people from the convertion?", "Mindshield", list("Yes", "No"))
		if(!mindshield_protection)
			return FALSE
		var/agression_factor = tgui_alert(admin, "Does this movement will act against the company, authority, etc?", "Bad Guys?", list("Yes", "No"))
		if(!agression_factor)
			return FALSE
		if(QDELETED(src) || QDELETED(new_owner.current))
			return FALSE

		rev_team = new /datum/team/custom_rev_team

		name = given_name
		rev_team.rev_role_name = given_name
		rev_team.name = given_team_name
		rev_team.ignore_mindshield = (mindshield_protection == "No")
		rev_team.agressive = (agression_factor == "Yes")
		

		var/datum/objective/obj = new()
		obj.team = src
		obj.explanation_text = given_objective 
		obj.update_explanation_text()
		objectives += obj

	else
		var/teams_input_list = list()
		var/teams = list()
		for(var/datum/team/custom_rev_team/someteam in world)
			teams_input_list += someteam.name
			teams[someteam.name] = someteam
		var/team_option = tgui_input_list(admin, "Доступные команды/объединения:", "Team", teams_input_list)
		if(QDELETED(src) || QDELETED(new_owner.current))
			return
		if(!team_option)
			return FALSE
		
		rev_team = teams[team_option]
		
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has rev'ed [key_name_admin(new_owner)].")
	log_admin("[key_name(admin)] has rev'ed [key_name(new_owner)].")
