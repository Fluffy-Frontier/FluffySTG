/datum/antagonist/hematocrat
	name = "\improper Hematocrat"
	roundend_category = "hematocrats"
	antag_hud_name = "hematocrat"
	antagpanel_category = "Hematocrats"
	job_rank = ROLE_HEMATOCRAT
	hijack_speed = 1
	show_to_ghosts = TRUE
	ui_name = "AntagInfoHematocrat" // скоро будет добавлено.
	var/special_role = ROLE_HEMATOCRAT
	var/datum/team/hematocrats/hematocrat_team
	hud_icon = 'tff_modular/modules/hematocrat/icons/hematocrathud.dmi'
	var/datum/action/cooldown/choose_class/class = new
	var/datum/action/cooldown/spell/conjure/heart/heart = new
	var/datum/action/cooldown/spell/summon_flesh/flesh = new
	var/datum/action/cooldown/spell/touch/flesh_harvest/harvest = new
	var/datum/action/cooldown/spell/touch/flesh_transform/transform = new

/datum/antagonist/hematocrat/on_gain()
	. = ..()
	owner.special_role = special_role

/datum/antagonist/hematocrat/on_removal()
	owner.special_role = null
	return ..()

/datum/antagonist/hematocrat/Destroy()
	QDEL_NULL(class)
	QDEL_NULL(heart)
	QDEL_NULL(flesh)
	QDEL_NULL(harvest)
	QDEL_NULL(transform)
	return ..()

/datum/antagonist/hematocrat/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/the_mob = owner.current || mob_override
	add_team_hud(the_mob, hematocrat_team)
	handle_clown_mutation(the_mob, "Your training has allowed you to overcome your clownish nature, allowing you to wield weapons without harming yourself.")
	the_mob.faction |= FACTION_HEMATOCRAT
	the_mob.AddComponent(/datum/component/heart_eater_hematocrat)
	class.Grant(the_mob)
	heart.Grant(the_mob)
	flesh.Grant(the_mob)
	harvest.Grant(the_mob)
	transform.Grant(the_mob)

/datum/antagonist/hematocrat/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/the_mob = owner.current || mob_override
	the_mob.faction -= FACTION_HEMATOCRAT
	handle_clown_mutation(the_mob, removing = FALSE)
	REMOVE_TRAIT(the_mob, TRAIT_HEMATOCRAT, ACTION_TRAIT)
	the_mob.RemoveComponentSource(type, /datum/component/heart_eater_hematocrat)
	class.Remove(the_mob)
	heart.Remove(the_mob)
	flesh.Remove(the_mob)
	harvest.Remove(the_mob)
	transform.Remove(the_mob)

/datum/antagonist/hematocrat/get_team()
	return hematocrat_team

/datum/antagonist/hematocrat/create_team(datum/team/hematocrats/new_team)
	if(!new_team)
		for(var/datum/antagonist/hematocrat/H in GLOB.antagonists)
			if(!H.owner)
				continue
			if(H.hematocrat_team)
				hematocrat_team = H.hematocrat_team
				return
		hematocrat_team = new /datum/team/hematocrats
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	hematocrat_team = new_team

// Тоже самое что и обычный, но может имплантировать опухоли для выдачи антага. Выдается только опфором/админабузом
/datum/antagonist/hematocrat/leader
	name = "\improper Hematocrat Leader"
	var/datum/action/cooldown/spell/conjure_item/bbtumor/convert = new

/datum/antagonist/hematocrat/leader/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/the_mob = owner.current || mob_override
	convert.Grant(the_mob)

/datum/antagonist/hematocrat/leader/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/the_mob = owner.current || mob_override
	convert.Remove(the_mob)

/datum/antagonist/hematocrat/leader/Destroy()
	QDEL_NULL(convert)
	return ..()

// Команда
/datum/team/hematocrats
	name = "\improper Hematocrats"
	member_name = "Hematocrat"
	var/hematocrats = 0

/datum/team/hematocrats/add_member(datum/mind/new_member)
	. = ..()
	if (!new_member.has_antag_datum(/datum/antagonist/hematocrat))
		add_hematocrat(new_member.current)

/datum/team/hematocrats/remove_member(datum/mind/member)
	if (!(member in members))
		return
	. = ..()
	member.remove_antag_datum(/datum/antagonist/hematocrat)
	if (!length(members))
		qdel(src)
		return
	if (isnull(member.current))
		return

/datum/team/hematocrats/proc/add_hematocrat(mob/living/new_hematocrat, source)
#ifndef TESTING
	if (isnull(new_hematocrat) || isnull(new_hematocrat.mind) || !GET_CLIENT(new_hematocrat) || new_hematocrat.mind.has_antag_datum(/datum/antagonist/hematocrat))
		return FALSE
#else
	if (isnull(new_hematocrat) || new_hematocrat.mind.has_antag_datum(/datum/antagonist/hematocrat))
		return FALSE
#endif

	new_hematocrat.mind.add_antag_datum(/datum/antagonist/hematocrat, src)

	return TRUE
