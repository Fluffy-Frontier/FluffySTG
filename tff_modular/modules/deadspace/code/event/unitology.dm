/datum/antagonist/unitology
	name = "\improper Unitologist"
	show_to_ghosts = FALSE
	silent = FALSE
	show_in_antagpanel = TRUE
	antagpanel_category = "Necromorph"
	show_name_in_check_antagonists = TRUE
	suicide_cry = "FOR THE OBELISK"
	var/datum/team/unitology/uni_team
	hud_icon = 'tff_modular/modules/deadspace/icons/mob/hud/antag_hud.dmi'
	antag_hud_name = "unitologist"

/datum/antagonist/unitology/apply_innate_effects(mob/living/mob_override)
	var/mob/living/unitologist = owner.current || mob_override
	add_team_hud(unitologist, /datum/antagonist/unitology)

/datum/antagonist/unitology/on_mindshield(mob/implanter, mob/living/mob_override)
	. = ..()
	to_chat(implanter, span_hypnophrase("You can feel your mind clearing of thoughts. You feel that the Marker no longer dominates you."))
	implanter.mind?.remove_antag_datum(/datum/antagonist/unitology)

/datum/antagonist/unitology/greet()
	. = ..()
	to_chat(owner, span_userdanger("Help other unitologists and help obelisk. Become whole!"))

/datum/antagonist/unitology/create_team(datum/team/team)
	. = ..()
	if(istype(team, /datum/team/unitology))
		uni_team = team

/datum/antagonist/unitology/get_team()
	return uni_team

/datum/team/unitology
	name = "Unitology"
	member_name = "Unitologist"
