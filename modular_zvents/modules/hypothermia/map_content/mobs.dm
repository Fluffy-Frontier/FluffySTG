#define SPECIES_MUTANT_ARCTIC "artctic_mutant"

/datum/species/arctic_mutant
	name = "Arctic Mutant"
	id = SPECIES_MUTANT_ARCTIC
	sexes = TRUE
	meat = /obj/item/food/meat/slab/human
	mutanttongue = /obj/item/organ/tongue/arctic_mutant
	inherent_traits = list(
		TRAIT_BLOODY_MESS,
		TRAIT_EASILY_WOUNDED,
		TRAIT_EASYDISMEMBER,
		TRAIT_FAKEDEATH,
		TRAIT_LIMBATTACHMENT,
		TRAIT_LIVERLESS_METABOLISM,
		TRAIT_NOBREATH,
		TRAIT_NODEATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_NOHUNGER,
		TRAIT_NO_DNA_COPY,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_TOXIMMUNE,
		TRAIT_NOBLOOD,
		TRAIT_SUCCUMB_OVERRIDE,
		TRAIT_NIGHT_VISION,
	)
	mutantstomach = null
	mutantheart = null
	mutantliver = null
	mutantlungs = null
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | ERT_SPAWN
	bodytemp_normal = T0C - 100
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_EXIST
	bodytemp_cold_damage_limit = MINIMUM_TEMPERATURE_TO_MOVE - 100
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/arctic_mutant,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/arctic_mutant,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/arctic_mutant,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/arctic_mutant,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/arctic_mutant,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/arctic_mutant
	)

	var/do_spooks = list(
		'modular_zvents/sounds/mobs/mutant_spoke_1.ogg',
		'modular_zvents/sounds/mobs/mutant_spoke_2.ogg',
		'modular_zvents/sounds/mobs/mutant_spoke_3.ogg',
	)

/datum/species/arctic_mutant/spec_life(mob/living/carbon/carbon_mob, seconds_per_tick, times_fired)
	. = ..()
	if(!SPT_PROB(2, seconds_per_tick))
		playsound(carbon_mob, pick(do_spooks), 50, TRUE, 10)

/obj/item/organ/tongue/arctic_mutant
	name = "mutant tongue"
	desc = "Frozen, pale tongue adapted to cold."
	say_mod = "growls"

/obj/item/bodypart/head/arctic_mutant
	color_overrides = list("0" = "#d0d0d0")

/obj/item/bodypart/chest/arctic_mutant
	color_overrides = list("0" = "#d0d0d0")

/obj/item/bodypart/arm/left/arctic_mutant
	color_overrides = list("0" = "#d0d0d0")

/obj/item/bodypart/arm/right/arctic_mutant
	color_overrides = list("0" = "#d0d0d0")

/obj/item/bodypart/leg/left/arctic_mutant
	color_overrides = list("0" = "#d0d0d0")

/obj/item/bodypart/leg/right/arctic_mutant
	color_overrides = list("0" = "#d0d0d0")

/mob/living/basic/arctic_mutant
	name = "Arctic Mutant"
	desc = "A pale, cold-adapted horror from the depths of Zvezda caves."
	icon = 'icons/mob/simple/simple_human.dmi'
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	maxHealth = 150
	health = 150
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/effects/hallucinations/growl1.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	combat_mode = TRUE
	speed = 3
	status_flags = CANPUSH | CANSTUN
	death_message = "collapses into frozen remains!"
	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	faction = list(FACTION_HOSTILE)
	basic_mob_flags = DEL_ON_DEATH
	ai_controller = /datum/ai_controller/basic_controller/arctic_mutant
	var/outfit = /datum/outfit/arctic_survivor
	var/datum/looping_sound/mutant_breath/breath_loop
	ghost_controllable = TRUE

/mob/living/basic/arctic_mutant/Initialize(mapload)
	. = ..()
	apply_dynamic_human_appearance(src, outfit, /datum/species/arctic_mutant, bloody_slots = ITEM_SLOT_OCLOTHING)
	AddElement(/datum/element/death_drops, /obj/effect/decal/remains/human)
	breath_loop = new(src, TRUE)



/mob/living/basic/arctic_mutant/death(gibbed)
	breath_loop.stop()
	. = ..()

/mob/living/basic/arctic_mutant/Destroy()
	. = ..()
	qdel(breath_loop)


/mob/living/basic/arctic_mutant/naked
	name = "Naked Arctic Mutant"
	desc = "A bare, feral mutant from the ice caves."
	outfit = null

/mob/living/basic/arctic_mutant/armored
	name = "Armored Arctic Mutant"
	desc = "A mutant clad in makeshift armor, tougher in the cold."
	outfit = /datum/outfit/arctic_armored
	maxHealth = 200
	health = 200

/mob/living/basic/arctic_mutant/spearman
	name = "Spear-wielding Arctic Mutant"
	desc = "A mutant armed with a crude spear, hunting in the shadows."
	outfit = /datum/outfit/arctic_spear
	melee_damage_lower = 30
	melee_damage_upper = 35

/datum/outfit/arctic_survivor
	name = "Arctic Survivor Corpse"
	suit = /obj/item/clothing/suit/hooded/wintercoat
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/winterboots
	back = /obj/item/storage/backpack

/datum/outfit/arctic_armored
	name = "Armored Arctic Mutant"
	suit = /obj/item/clothing/suit/armor/riot
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/winterboots
	back = /obj/item/storage/backpack

/datum/outfit/arctic_spear
	name = "Spear Arctic Mutant"
	suit = /obj/item/clothing/suit/hooded/wintercoat
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/winterboots
	back = /obj/item/storage/backpack
	r_hand = /obj/item/spear

/datum/ai_planning_subtree/random_speech/arctic_mutant
	speech_chance = 1
	emote_hear = list("growls coldly.", "hisses.")
	emote_see = list("shivers.", "stares blankly.")

/datum/ai_planning_subtree/dash_attack
	var/dash_cooldown = 10 SECONDS
	var/last_dash = 0

/datum/ai_planning_subtree/dash_attack/SelectBehaviors(datum/ai_controller/controller, delta_time)
	if(world.time - last_dash < dash_cooldown)
		return
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target || get_dist(controller.pawn, target) < 3)
		return
	controller.queue_behavior(/datum/ai_behavior/dash_to_target, BB_BASIC_MOB_CURRENT_TARGET)
	last_dash = world.time

/datum/ai_behavior/dash_to_target
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM
	required_distance = 1

/datum/ai_behavior/dash_to_target/perform(delta_time, datum/ai_controller/controller, target_key)
	var/mob/living/pawn = controller.pawn
	var/atom/target = controller.blackboard[target_key]
	if(!target)
		return AI_BEHAVIOR_FAILED
	pawn.visible_message(span_danger("[pawn] dashes towards [target]!"))
	new /obj/effect/temp_visual/decoy/fading(pawn.loc, pawn)
	animate(pawn, pixel_x = 0, pixel_y = 0, time = 0)
	for(var/i = 1 to 3)
		pawn.forceMove(get_step_towards(pawn, target))
	if(get_dist(pawn, target) <= 1)
		controller.queue_behavior(/datum/ai_behavior/basic_melee_attack, target_key)
	return AI_BEHAVIOR_SUCCEEDED

/datum/ai_controller/basic_controller/arctic_mutant
	blackboard = list(
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/random_speech/arctic_mutant,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/dash_attack,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

// Ghost role spawner
/obj/effect/mob_spawn/ghost_role/human/arctic_mutant
	name = "arctic mutant pod"
	desc = "A frozen pod containing a dormant mutant. Ghosts can enter to play as it."
	icon_state = "cryostasis_pod"
	mob_species = /datum/species/mutant
	mob_name = "Arctic Mutant"
	you_are_text = "You are an arctic mutant awakened from cryosleep."
	flavour_text = "Survive in the caves of Zvezda, hunt intruders."
	outfit = /datum/outfit/arctic_survivor
	restricted_species = list(/datum/species/mutant)


/obj/effect/mob_spawn/ghost_role/human/arctic_mutant/special(mob/living/carbon/human/new_spawn)
	. = ..()
	new_spawn.fully_replace_character_name(null,"Arctic Mutant")

/obj/effect/mob_spawn/ghost_role/human/arctic_mutant/naked
	outfit = null

/obj/effect/mob_spawn/ghost_role/human/arctic_mutant/armored
	outfit = /datum/outfit/arctic_armored

/obj/effect/mob_spawn/ghost_role/human/arctic_mutant/spearman
	outfit = /datum/outfit/arctic_spear


/obj/effect/spawner/random/arctic_mutant
	name = "arctic mutant spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x3"
	spawn_loot_count = 4
	loot = list(
		/mob/living/basic/arctic_mutant = 2,
		/mob/living/basic/arctic_mutant/naked = 5,
		/mob/living/basic/arctic_mutant/armored = 1,
		/mob/living/basic/arctic_mutant/spearman = 1,
	)

#undef SPECIES_MUTANT_ARCTIC

/datum/looping_sound/mutant_breath
	mid_sounds = list(
		'modular_zvents/sounds/mobs/mutant_idel_1.ogg' = 1,
		'modular_zvents/sounds/mobs/mutant_idel_2.ogg' = 1,,

	)
	mid_length = 1 SECONDS
	volume = 20
	falloff_exponent = 3
