// Warning // Screamers and Monster //

// Screamers
/atom/movable/screen/fullscreen/screamers
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/void/screamers.dmi'
	plane = SPLASHSCREEN_PLANE
	screen_loc = "CENTER-7,SOUTH"
	icon_state = ""

// Monster
/mob/living/basic/void_monster
	name = "\improper The fuck?"
	desc = "Their eyes follow you."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/void/babaika.dmi'
	icon_state = "babaika"
	health = 500
	maxHealth = 500
	ai_controller = /datum/ai_controller/basic_controller/void_monster
	var/user_name

	hud_possible = list(ANTAG_HUD)

	lighting_cutoff_red = 15
	lighting_cutoff_green = 10
	lighting_cutoff_blue = 25

	sight = SEE_SELF|SEE_MOBS|SEE_OBJS|SEE_TURFS

	gender = NEUTER
	combat_mode = TRUE
	mob_biotypes = MOB_HUMANOID
	gold_core_spawnable = NO_SPAWN

	response_help_continuous = "touches"
	response_help_simple = "touch"
	response_disarm_continuous = "pushes"
	response_disarm_simple = "push"

	speed = 0.5
	obj_damage = 100
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/effects/hallucinations/look_up2.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	melee_attack_cooldown = 2 SECONDS

	faction = list(FACTION_STATUE)
	speak_emote = list("TURN AROUND!")
	death_message = "Uuugh... It's unreal..."
	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 0

/mob/living/basic/void_monster/examine(mob/user)
	. = ..()
	if(user.client?.ckey)
		user_name = user.client.ckey
	else
		user_name = user.name
	desc = "It's me? [user_name]???"
	death_message = "I will find you in the REALITY, [user_name]!"

/mob/living/basic/void_monster/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/squeak, list('sound/effects/hallucinations/radio_static.ogg' = 1), 100, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)

/mob/living/basic/void_monster/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	if(ishuman(target) && .)
		var/mob/living/carbon/human/user = target
		var/sound/sound = sound('tff_modular/modules/evento_needo/ark_station_stuff/void/trip_blast.wav')
		sound.environment = 23
		sound.volume = 100
		SEND_SOUND(user.client, sound)
		user.emote("agony")
		user.overlay_fullscreen("screamers", /atom/movable/screen/fullscreen/screamers, rand(1, 23))
		user.clear_fullscreen("screamers", rand(15, 60))
	return ..()

/datum/ai_controller/basic_controller/void_monster
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_AGGRO_RANGE = 14,
	)

	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/walk_near_target/void
	planning_subtrees = list(
		/datum/ai_planning_subtree/find_and_hunt_target/void_monster,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/datum/idle_behavior/walk_near_target/void
	walk_chance = 25
	minimum_distance = 5

//
/datum/ai_planning_subtree/find_and_hunt_target/void_monster
	target_key = BB_LOW_PRIORITY_HUNTING_TARGET
	finding_behavior = /datum/ai_behavior/find_hunt_target/void_monster
	hunting_behavior = /datum/ai_behavior/hunt_target/unarmed_attack_target/void_monster
	hunt_targets = list(/mob/living/carbon)
	hunt_range = 30

/datum/ai_behavior/hunt_target/unarmed_attack_target/void_monster
	hunt_cooldown = 1 SECONDS
	always_reset_target = TRUE

/datum/ai_behavior/find_hunt_target/void_monster

/datum/ai_behavior/find_hunt_target/void_monster/valid_dinner(mob/living/source, mob/living/carbon/dinner, radius)
	if(dinner.stat == DEAD)
		return FALSE

	return can_see(source, dinner, radius)
