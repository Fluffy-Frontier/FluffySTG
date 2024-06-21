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
	if(config_text == null || config_text == "")
		return .
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
	var/list/custom_objs
	for(var/antag_path as anything in GLOB.custom_objectives)
		if(istype(src, antag_path))
			custom_objs = GLOB.custom_objectives[antag_path]
	if(isnull(custom_objs) || !length(custom_objs))
		return
	var/list/objs2add = custom_objs.Copy()
	while(objs2add.len > objectives.len)
		pick_n_take(objs2add)
	for(var/datum/custom_objective/obj as anything in objs2add)
		var/datum/objective/custom/new_objective = new()
		new_objective.explanation_text = obj.desc
		objectives.Insert(1, new_objective)
		if(obj.unique)
			custom_objs.Remove(obj)

/datum/team/proc/add_custom_objectives()
	var/list/custom_objs
	for(var/antag_path as anything in GLOB.custom_objectives)
		if(istype(src, antag_path))
			custom_objs = GLOB.custom_objectives[antag_path]
	if(isnull(custom_objs) || !length(custom_objs))
		return
	var/list/objs2add = custom_objs.Copy()
	while(objs2add.len > objectives.len)
		pick_n_take(objs2add)
	for(var/datum/custom_objective/obj as anything in objs2add)
		var/datum/objective/custom/new_objective = new()
		new_objective.explanation_text = obj.desc
		objectives.Insert(1, new_objective)
		if(obj.unique)
			custom_objs.Remove(obj)

#undef CUSTOM_OBJECTIVES_CONFIG_PATH
