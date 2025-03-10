/datum/antagonist/necromorph
	name = "\improper Necromorph"
	job_rank = ROLE_NECROMORPH
	show_in_antagpanel = TRUE
	antag_hud_name = "traitor"
	antagpanel_category = "Necromorph"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	silent = TRUE
	ui_name = "AntagInfoNecromorph"
	suicide_cry = "FOR THE BRETHREN MOONS"

/datum/antagonist/necromorph/greet()
	owner.announce_objectives()
	. = ..()

/datum/antagonist/necromorph/on_gain()
	forge_objectives()
	return ..()

/datum/antagonist/necromorph/forge_objectives()
	var/datum/objective/necromorph_assist = new /datum/objective/necromorph_assist()
	objectives += necromorph_assist
	var/datum/objective/necromorph_hunt = new /datum/objective/necromorph_hunt()
	objectives += necromorph_hunt
	var/datum/objective/necromorph_rules = new /datum/objective/necromorph_rules()
	objectives += necromorph_rules

/datum/objective/necromorph_assist
	explanation_text = "Assist the Marker at all costs."

/datum/objective/necromorph_hunt
	explanation_text = "Capture organics and find a use for them, or simply kill them."

/datum/objective/necromorph_rules
	explanation_text = "Do not dishonor the Brethrens Moon."
