GLOBAL_LIST_INIT(custom_rev_teams, list())

/datum/antagonist/custom_rev
	name = "\improper Activist"
	antagpanel_category = "Activists (custom revolution)"
	job_rank = ROLE_REV
	antag_hud_name = "rev"
	var/datum/team/custom_rev_team/rev_team

/datum/antagonist/custom_rev/admin_add(datum/mind/new_owner, mob/admin)
	to_chat(admin, span_notice("Данная роль не рассчитана на standalone спавн. Если хотите продолжить и присоединить участника к одной из существующих команд - нажмите \"Продолжить\"."))
	var/confirm = tgui_alert(admin, "Прочтите предупреждение об standalone спавне в чате.", "АХТУНГ!", list("Продолжить", "Отмена"))
	if(confirm != "Продолжить")
		return FALSE

	var/teams_input_list = list()
	var/teams = list()
	for(var/datum/team/custom_rev_team/someteam in GLOB.custom_rev_teams)
		teams_input_list += someteam.name
		teams[someteam.name] = someteam
	to_chat(admin, span_notice("Если у вас не вывело список доступных команд/объединений - скорее всего их нет."))
	var/team_option = tgui_input_list(admin, "Доступные команды:", "Team", teams_input_list)
	if(QDELETED(src) || QDELETED(new_owner.current))
		return
	if(!team_option)
		return FALSE
	
	rev_team = teams[team_option]
		
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] made [key_name(new_owner)] the member of [rev_team.name].")
	log_admin("[key_name(admin)] made [key_name(new_owner)] the member of [rev_team.name].")

/datum/antagonist/custom_rev/greet()
	. = ..()
	to_chat(owner, span_userdanger("Cooperate with your union in order to accomplish your goals!"))
	owner.announce_objectives()

/datum/antagonist/custom_rev/on_gain()
	name = rev_team.rev_role_name
	objectives |= rev_team.objectives
	. = ..()
	owner.current.log_message("has been converted to the [rev_team.name]!", LOG_GAME, color="red")

/datum/antagonist/custom_rev/on_removal()
	to_chat(owner.current, span_doyourjobidiot("You are no longer [rev_team.rev_role_name]! Memories about events during you being part of that union vanish like snowflakes on the water."), confidential = TRUE)
	objectives -= rev_team.objectives
	. = ..()

/datum/antagonist/custom_rev/get_team()
	return rev_team

/datum/antagonist/custom_rev/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_team_hud(M, rev_team)

/// Удаляем роль при введении майндшилда.
/datum/antagonist/custom_rev/on_mindshield(mob/implanter)
	var/mob/antag_mob = owner.current
	if(rev_team.ignore_mindshield)
		return FALSE
	remove_role(implanter)
	for(var/mob/M in view(3, antag_mob))
		to_chat(M, span_doyourjobidiot("[antag_mob] starts looking around in confusion."), confidential = TRUE)
	return COMPONENT_MINDSHIELD_DECONVERTED

/datum/antagonist/custom_rev/proc/remove_role(mob/deconverter)
	owner.current.log_message("has been deconverted from the [name] by [ismob(deconverter) ? key_name(deconverter) : deconverter]!", LOG_ATTACK, color="#960000")
	owner.remove_antag_datum(type)

/datum/team/custom_rev_team
	name = "\improper Activists"
	member_name = "\improper activists"
	var/rev_role_name = "Activist"
	var/ignore_mindshield = FALSE
