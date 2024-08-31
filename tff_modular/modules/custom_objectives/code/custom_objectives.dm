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
	if(!config_text)
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
	var/list/glob_custom_objs
	for(var/antag_path as anything in GLOB.custom_objectives)
		if(istype(src, antag_path))
			glob_custom_objs = GLOB.custom_objectives[antag_path]
			break
	if(isnull(glob_custom_objs) || !length(glob_custom_objs))
		return

	var/list/custom_objs = glob_custom_objs.Copy()
	var/custom_objs_amount = min(objectives.len, custom_objs.len)
	var/list/objs_to_add = list()
	while(objs_to_add.len < custom_objs_amount)
		objs_to_add += pick_n_take(custom_objs)

	for(var/datum/custom_objective/obj as anything in objs_to_add)
		var/datum/objective/custom/new_objective = new()
		new_objective.explanation_text = obj.desc
		objectives.Insert(1, new_objective)
		if(obj.unique)
			glob_custom_objs.Remove(obj)

/datum/team/proc/add_custom_objectives()
	var/list/glob_custom_objs
	for(var/antag_path as anything in GLOB.custom_objectives)
		if(istype(src, antag_path))
			glob_custom_objs = GLOB.custom_objectives[antag_path]
			break
	if(isnull(glob_custom_objs) || !length(glob_custom_objs))
		return

	var/list/custom_objs = glob_custom_objs.Copy()
	var/custom_objs_amount = min(objectives.len, custom_objs.len)
	var/list/objs_to_add = list()
	while(objs_to_add.len < custom_objs_amount)
		objs_to_add += pick_n_take(custom_objs)

	for(var/datum/custom_objective/obj as anything in objs_to_add)
		var/datum/objective/custom/new_objective = new()
		new_objective.explanation_text = obj.desc
		objectives.Insert(1, new_objective)
		if(obj.unique)
			glob_custom_objs.Remove(obj)

#undef CUSTOM_OBJECTIVES_CONFIG_PATH
