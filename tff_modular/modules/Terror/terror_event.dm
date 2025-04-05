/datum/round_event_control/terror
	name = "Spawn Terror"
	typepath = /datum/round_event/ghost_role/terror
	weight = 0
	max_occurrences = 0
	category = EVENT_CATEGORY_ENTITIES
	description = "Spawns a hungry, fat and really scary spider - Terror."
	min_wizard_trigger_potency = 4
	max_wizard_trigger_potency = 7

/datum/round_event/ghost_role/terror
	minimum_required = 1
	role_name = "Terror"

/datum/round_event/ghost_role/terror/spawn_role()
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(check_jobban = ROLE_ALIEN, role = ROLE_ALIEN, alert_pic = /mob/living/basic/spider/giant/terror, role_name_text = "terror", amount_to_pick = 1)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS
	var/datum/mind/player_mind = new /datum/mind(chosen_one.key)
	player_mind.active = TRUE

	var/turf/spawn_loc = find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = FALSE)
	if(isnull(spawn_loc))
		return MAP_ERROR

	var/mob/living/basic/spider/giant/terror/terror_spawn = new(spawn_loc)
	player_mind.transfer_to(terror_spawn)
	SEND_SOUND(terror_spawn, sound('sound/effects/his_grace/his_grace_ascend.ogg'))
	message_admins("[ADMIN_LOOKUPFLW(terror_spawn)] has been made into a terror by an event.")
	terror_spawn.log_message("was spawned as a terror by an event.", LOG_GAME)
	spawned_mobs += terror_spawn
	return SUCCESSFUL_SPAWN
