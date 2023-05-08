/datum/antagonist/custom_rev
	name = "\improper Activist"
	antagpanel_category = "Activists (custom revolution)"
	job_rank = ROLE_REV
	antag_hud_name = "rev"
	var/datum/team/custom_rev_team/rev_team

/datum/antagonist/rev/admin_add(datum/mind/new_owner, mob/admin)
	var/confirm = tgui_alert(admin, "Хотите создать новое объединение/команду или присоединить его к уже существующей?", "АХТУНГ!", list("Yes", "No"))
	if(confirm == "Yes")
		var/given_name = tgui_input_text(admin, "Введите название роли участников:", "Role name")
		var/given_team_name = tgui_input_text(admin, "Введите название объединения/команды в котором будут состоять участники:", "Team name")
		var/given_objective = tgui_input_text(admin, "Введите цель объединения/команды:", "Objective", multiline = TRUE)
		if(QDELETED(src) || QDELETED(new_owner.current) || !given_name || !given_team_name || !given_objective)
			return

		name = given_name
		rev_team.rev_role_name = given_name
		rev_team.name = given_team_name
		

		var/datum/objective/obj = new()
		obj.team = src
		obj.explanation_text = given_objective 
		obj.update_explanation_text()
		objectives += obj
		
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has rev'ed [key_name_admin(new_owner)].")
	log_admin("[key_name(admin)] has rev'ed [key_name(new_owner)].")

/datum/antagonist/custom_rev/greet()
	. = ..()
	to_chat(owner, span_userdanger("Помогите своим единомышленникам исполнить вашу совместную цель!"))
	owner.announce_objectives()

/datum/antagonist/custom_rev/on_gain()
	. = ..()
	objectives |= rev_team.objectives
	owner.current.log_message("has been converted to the [rev_team.name]!", LOG_ATTACK, color="red")

/datum/antagonist/custom_rev/on_removal()
	objectives -= rev_team.objectives
	. = ..()

/datum/antagonist/custom_rev/get_team()
	return rev_team

/datum/antagonist/custom_rev/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_team_hud(M, /datum/antagonist/rev)

/datum/antagonist/custom_rev/on_mindshield(mob/implanter)
	if(rev_team.can_be_converted_if_mindshield)
		return FALSE
	remove_role(implanter)
	return COMPONENT_MINDSHIELD_DECONVERTED

/datum/antagonist/custom_rev/remove_role(mob/deconverter)
	owner.current.log_message("has been deconverted from the [name] by [ismob(deconverter) ? key_name(deconverter) : deconverter]!", LOG_ATTACK, color="#960000")

/datum/team/custom_rev_team
	name = "\improper Activists"
	var/rev_role_name = "Activist"
	var/can_be_converted_if_mindshield = FALSE
	var/against_nt = TRUE


