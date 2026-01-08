/datum/antagonist/necromorph
	name = "\improper Necromorph"
	pref_flag = ROLE_NECROMORPH
	show_in_antagpanel = TRUE
	hud_icon = 'tff_modular/modules/deadspace/icons/mob/hud/antag_hud.dmi'
	antag_hud_name = "unitologist"
	antagpanel_category = "Necromorph"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	silent = TRUE
	ui_name = null
	suicide_cry = "FOR THE BRETHREN MOONS"
	var/datum/team/unitology/uni_team

/datum/antagonist/necromorph/apply_innate_effects(mob/living/mob_override)
	var/mob/living/unitologist = owner.current || mob_override
	add_team_hud(unitologist, /datum/antagonist/necromorph)

/datum/antagonist/necromorph/greet()
	. = ..()
	to_chat(owner, span_userdanger("Help the obelisk. Become whole!"))

/datum/antagonist/necromorph/create_team(datum/team/team)
	. = ..()
	if(istype(team, /datum/team/unitology))
		uni_team = team

/datum/antagonist/necromorph/get_team()
	return uni_team

/datum/team/unitology
	name = "Unitology"
	member_name = "Unitologist"
