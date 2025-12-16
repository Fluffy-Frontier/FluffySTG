/datum/action
	/// Extended description of the action, usually shown in an antag UI.
	var/power_explanation = ""

/datum/antagonist
	var/antag_panel_title = "Antagonist Panel"
	var/antag_panel_description = "This is the antagonist panel. It contains all the abilities you have access to as an antagonist. Use them wisely."

/datum/antagonist/proc/ability_ui_data(actions = list())
	var/list/data = list()
	data["title"] = "[antag_panel_title]\n[antag_panel_data()]"
	data["description"] = antag_panel_description
	for(var/datum/action/cooldown/power as anything in actions)
		var/list/power_data = list()

		power_data["power_name"] = power.name
		power_data["power_icon"] = power.button_icon_state
		if(istype(power, /datum/action/cooldown/bloodsucker))
			var/datum/action/cooldown/bloodsucker/bloodsucker_power = power
			power_data["power_explanation"] = bloodsucker_power.get_power_explanation()

		data["powers"] += list(power_data)
	return data

/mob
	/// Can they interact with station electronics
	var/has_unlimited_silicon_privilege = FALSE

/datum/language/vampiric
	name = "Enochian"
	desc = "Rumored to be created by the Dark Father, Caine himself as a way to talk to his Childer, the truth, like many things in unlife is uncertain. Spoken by creatures of the night."
	key = "L"//Capital L, lowercase l is for ashies.
	space_chance = 40
	default_priority = 90

	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	syllables = list(
		"luk","cha","no","kra","pru","chi","busi","tam","pol","spu","och",
		"umf","ora","stu","si","ri","li","ka","red","ani","lup","ala","pro",
		"to","siz","nu","pra","ga","ump","ort","a","ya","yach","tu","lit",
		"wa","mabo","mati","anta","tat","tana","prol",
		"tsa","si","tra","te","ele","fa","inz",
		"nza","est","sti","ra","pral","tsu","ago","esch","chi","kys","praz",
		"froz","etz","tzil",
		"t'","k'","t'","k'","th'","tz'"
		)

	icon_state = "bloodsucker"
	icon = 'tff_modular/modules/bloodsucker/icons/language.dmi'
	secret = TRUE

/datum/job/curator/after_spawn(mob/living/spawned, client/player_client)
	mind_traits += (TRAIT_BLOODSUCKER_HUNTER)
	. = ..()
	var/list/points_of_interest = SSpoints_of_interest.get_other_pois()
	var/obj/item/book/codex_gigas/book_to_spawn
	for(var/poi in points_of_interest)
		var/thing = points_of_interest[poi]
		if(istype(thing, /obj/item/book/codex_gigas))
			return
	book_to_spawn = new(get_turf(spawned))
	if(iscarbon(spawned))
		var/mob/living/carbon/carbon_spawned = spawned
		// Not suspicious but convenient in this case
		carbon_spawned.equip_conspicuous_item(book_to_spawn, FALSE)

/datum/dynamic_ruleset/latejoin/bloodsucker
	name = "Bloodsucker Breakout"
	config_tag = "Latejoin Bloodsucker"
	preview_antag_datum = /datum/antagonist/bloodsucker
	pref_flag = ROLE_BLOODSUCKERBREAKOUT
	jobban_flag = ROLE_BLOODSUCKER
	blacklisted_roles = BLOODSUCKER_BLACKLISTED_ROLES
	weight = 5
	repeatable = FALSE
	/// List of species that cannot be bloodsuckers
	var/list/restricted_species = BLOODSUCKER_RESTRICTED_SPECIES

/datum/dynamic_ruleset/latejoin/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	if(!candidate.mind.valid_bloodsucker_candidate())
		return FALSE
	return ..()

/datum/dynamic_ruleset/latejoin/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.AdjustUnspentRank(rand(2, 3))


/datum/dynamic_ruleset/midround/from_living/bloodsucker
	name = "Vampiric Accident"
	config_tag = "Midround Bloodsucker"
	preview_antag_datum = /datum/antagonist/bloodsucker
	pref_flag = ROLE_VAMPIRICACCIDENT
	jobban_flag = ROLE_BLOODSUCKER
	midround_type = LIGHT_MIDROUND
	blacklisted_roles = BLOODSUCKER_BLACKLISTED_ROLES
	weight = 9
	repeatable = TRUE
	/// List of species that cannot be bloodsuckers
	var/list/restricted_species = BLOODSUCKER_RESTRICTED_SPECIES

/datum/dynamic_ruleset/midround/from_living/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	if(!is_station_level(candidate.z))
		return FALSE
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	if(!candidate.mind.valid_bloodsucker_candidate())
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_living/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.AdjustUnspentRank(rand(3, 4))

/datum/dynamic_ruleset/roundstart/bloodsucker
	name = "bloodsuckers"
	config_tag = "Roundstart Bloodsucker"
	pref_flag = ROLE_BLOODSUCKER
	preview_antag_datum = /datum/antagonist/bloodsucker
	blacklisted_roles = BLOODSUCKER_BLACKLISTED_ROLES
	ruleset_flags = RULESET_VARIATION
	jobban_flag = ROLE_BLOODSUCKER
	weight = 10
	max_antag_cap = list("denominator" = 24)
	var/list/restricted_species = BLOODSUCKER_RESTRICTED_SPECIES

/datum/dynamic_ruleset/roundstart/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	return ..()

/datum/dynamic_ruleset/roundstart/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.AdjustUnspentRank(rand(3, 4))
