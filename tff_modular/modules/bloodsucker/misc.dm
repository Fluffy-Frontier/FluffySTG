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
