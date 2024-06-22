#define CUSTOM_OBJECTIVES_CONFIG_PATH "config/tff/custom_objectives.json"

GLOBAL_LIST_INIT(antags_to_names, list(
	"TRAITOR" = /datum/antagonist/traitor,
	"CHANGELING" = /datum/antagonist/changeling,
	"WIZARD" = /datum/antagonist/wizard,
	"NINJA" = /datum/antagonist/ninja,
	"BLOOD_BROTHER" = /datum/team/brother_team,
	"SPY" = /datum/antagonist/spy,
	"OBSESSED" = /datum/antagonist/obsessed,
))

GLOBAL_LIST_INIT(custom_objectives, init_custom_objectives())

/datum/custom_objective
	var/desc
	var/unique

/proc/init_custom_objectives()
	. = list()

	for(var/antag_name as anything in GLOB.antags_to_names)
		var/antag_path = GLOB.antags_to_names[antag_name]
		.[antag_path] = list()

	var/config_text = file2text(CUSTOM_OBJECTIVES_CONFIG_PATH)
	if(isnull(config_text) || !length(config_text))
		return
	var/list/config_json = json_decode(config_text)

	for(var/list/json_objective as anything in config_json)
		if(!islist(json_objective))
			continue
		var/datum/custom_objective/custom_obj_to_add = new()
		custom_obj_to_add.desc = json_objective["desc"]
		custom_obj_to_add.unique = json_objective["unique"]
		var/antag_name = json_objective["name"]
		var/antag_path = GLOB.antags_to_names[antag_name]
		.[antag_path] += custom_obj_to_add

/datum/antagonist/proc/add_custom_objectives()
	var/list/custom_objs = GLOB.custom_objectives[type]
	var/list/new_objs = custom_objs?.Copy()

	if(isnull(new_objs) || !length(new_objs))
		return

	var/max_objectives = CONFIG_GET(number/traitor_objectives_amount)

	for(var/i in 1 to max_objectives)
		if(!length(new_objs))
			break
		var/datum/custom_objective/objective = pick_n_take(new_objs)
		var/datum/objective/custom/new_objective = new()
		new_objective.explanation_text = objective.desc
		objectives[i] = new_objective
		if(objective.unique)
			custom_objs.Remove(objective)

/datum/team/proc/add_custom_objectives()
	var/list/custom_objs = GLOB.custom_objectives[type]
	var/list/new_objs = custom_objs?.Copy()

	if(isnull(new_objs) || !length(new_objs))
		return

	var/max_objectives = CONFIG_GET(number/brother_objectives_amount)

	for(var/i in 1 to max_objectives)
		if(!length(new_objs))
			break
		var/datum/custom_objective/objective = pick_n_take(new_objs)
		var/datum/objective/custom/new_objective = new()
		new_objective.explanation_text = objective.desc
		objectives[i] = new_objective
		if(objective.unique)
			custom_objs.Remove(objective)

#undef CUSTOM_OBJECTIVES_CONFIG_PATH
