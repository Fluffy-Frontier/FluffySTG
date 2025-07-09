/mob/living/basic/spider/giant/baron
	pass_flags = PASSTABLE

/mob/living/basic/spider/growing/young/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

//Web changes:
/obj/structure/spider/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	switch(damage_type)
		if(BURN)
			damage_amount *= 1.25
		if(BRUTE)
			damage_amount *= 0.45
	return ..()

/obj/structure/spider/stickyweb/sealed/reflector/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	switch(damage_type)
		if(BURN)
			damage_amount *= 1.25
		if(BRUTE)
			damage_amount *= 1
	return ..()


/**
 * # Giant Spider
 *
 * A mob which can be created by dynamic event, botany, or xenobiology.
 * The basic type is the guard, which is slow but sturdy and outputs good damage.
 * All spiders can produce webbing.
 */
/mob/living/basic/spider/giant
	name = "giant spider"
	desc = "Furry and black, it makes you shudder to look at it. This one has deep red eyes."
	icon_state = "guard"
	icon_living = "guard"
	icon_dead = "guard_dead"
	speed = 5
	maxHealth = 150
	health = 150
	obj_damage = 40
	wound_bonus = 0
	melee_damage_lower = 20
	melee_damage_upper = 20
	gold_core_spawnable = HOSTILE_SPAWN
	ai_controller = /datum/ai_controller/basic_controller/giant_spider
	bite_injection_flags = INJECT_CHECK_PENETRATE_THICK
	max_grab = GRAB_AGGRESSIVE
	/// Actions to grant on Initialize
	var/list/innate_actions = null
	regeneration_per_tick = -3
	/// MED HUD for every spidy!
	var/health_hud = DATA_HUD_MEDICAL_ADVANCED

/mob/living/basic/spider/giant/Initialize(mapload)
	. = ..()
	grant_actions_by_list(innate_actions)
	var/datum/atom_hud/datahud = GLOB.huds[health_hud]
	datahud.show_to(src)

/mob/living/basic/spider/giant/Login(message)
	. = ..()
	if(!. || !client)
		return FALSE
	log_talk(message, LOG_SAY, tag = "Spider telepathy")
	var/rendered = span_hierophant("<b>\[Spider Telepathy\] [name]</b> has just grew up! Now she can benefit the hive.")
	relay_to_list_and_observers(rendered, GLOB.spider_telepathy_mobs, src, MESSAGE_TYPE_RADIO)

/**
 * ### Ambush Spider
 * A subtype of the giant spider which is slower, stronger and able to sneak into its surroundings to pull pray aggressively.
 * This spider is only slightly slower than a human.
 */
/mob/living/basic/spider/giant/ambush
	name = "ambush spider"
	desc = "Furry and white, it makes you shudder to look at it. This one has sparkling pink eyes."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "ambush"
	icon_living = "ambush"
	icon_dead = "ambush_dead"
	gender = FEMALE
	maxHealth = 140
	health = 140
	obj_damage = 50
	armour_penetration = 25
	melee_damage_lower = 15
	melee_damage_upper = 15
	wound_bonus = 0
	speed = 4
	player_speed_modifier = -3.1
	web_speed = 0.25
	menu_description = "medium-speed spider with small damage and medium health, but with good regeneration. When on the web, causes insane damage."
	innate_actions = list(/datum/action/cooldown/mob_cooldown/invisibility)
	regeneration_per_tick = -2.5

/mob/living/basic/spider/giant/ambush/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/average_web)

/mob/living/basic/spider/giant/ambush/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !isliving(target))
		return
	var/obj/structure/spider/web = locate() in src.loc
	var/mob/living/human = target
	if(web)
		human.apply_damage(17.5, BRUTE, wound_bonus = 0)

/**
 * ### Guard Spider
 * A subtype of the giant spider which is similar on every single way,
 * This spider is only slightly slower than a human.
 */
/mob/living/basic/spider/giant/guard
	name = "guard spider"
	desc = "Furry and black, it makes you shudder to look at it. This one has deep red eyes."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "guard"
	icon_living = "guard"
	icon_dead = "guard_dead"
	gender = FEMALE
	maxHealth = 250
	health = 250
	melee_damage_lower = 15
	melee_damage_upper = 20
	armour_penetration = 25
	wound_bonus = 15
	obj_damage = 60
	speed = 4
	damage_coeff = list(BRUTE = 1, BURN = 1, STAMINA = 1, TOX = 1, OXY = 1)
	player_speed_modifier = -4
	menu_description = "Tanky and strong able to shed a carcass for protection."
	innate_actions = list(/datum/action/cooldown/mob_cooldown/web_effigy)
	regeneration_per_tick = -2

/mob/living/basic/spider/giant/guard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/average_web)

/mob/living/basic/spider/giant/guard/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !isliving(target))
		return
	var/mob/living/carbon/human = target
	if(prob(15))
		human.AdjustKnockdown(1 SECONDS)

/**
 * ### Hunter Spider
 * A subtype of the giant spider which is faster, has toxin injection, but less health and damage.
 * This spider is only slightly slower than a human.
 */
/mob/living/basic/spider/giant/hunter
	name = "hunter spider"
	desc = "Furry and black, it makes you shudder to look at it. This one has sparkling purple eyes."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "hunter"
	icon_living = "hunter"
	icon_dead = "hunter_dead"
	maxHealth = 135
	health = 135
	melee_damage_lower = 15
	melee_damage_upper = 20
	melee_attack_cooldown = 7
	armour_penetration = 20
	wound_bonus = -15
	obj_damage = 60
	speed = 2.8
	player_speed_modifier = -3.1
	sharpness = SHARP_EDGED
	menu_description = "Fast spider with vampirism, has good damage and health, but its passively losing health."
	has_regeneration = FALSE
	var/damage_per_tick = 3 // Thats hurts

/mob/living/basic/spider/giant/hunter/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/fast_web)
	AddElement(/datum/element/lifesteal, flat_heal = 30)
	RegisterSignal(src, COMSIG_LIVING_LIFE, PROC_REF(damaging))

/mob/living/basic/spider/giant/hunter/proc/damaging(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	if(!isliving(source) || source.stat == DEAD || !source.mind)
		return

	source.adjustBruteLoss(damage_per_tick)

/mob/living/basic/spider/giant/hunter/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !isliving(target) || target == src)
		return
	var/mob/living/carbon/who_attack = target
	if(isliving(who_attack))
		who_attack.blood_volume -= 15
	return TRUE

/mob/living/basic/spider/giant/hunter/away_caves
	minimum_survivable_temperature = 0
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/spider/giant/scout
	name = "scout spider"
	desc = "Furry and blueish black, it makes you shudder to look at it. This one has sparkling blue eyes."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "scout"
	icon_living = "scout"
	icon_dead = "scout_dead"
	maxHealth = 100
	health = 100
	obj_damage = 80
	melee_damage_lower = 5
	melee_damage_upper = 5
	armour_penetration = 25
	wound_bonus = 0
	speed = 3
	poison_type = /datum/reagent/toxin/mutetoxin
	poison_per_bite = 3
	player_speed_modifier = -3.1
	web_speed = 0.75
	sight = SEE_SELF|SEE_MOBS|SEE_TURFS
	menu_description = "Spider that able to see enemies through walls, has ability to travel in vents. Has low amount of health and damage, but on attack, it's injects mutetoxin and deals stamina damage"
	regeneration_per_tick = -2
	innate_actions = list(/datum/action/cooldown/spell/scream)

/mob/living/basic/spider/giant/scout/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/basic/spider/giant/scout/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if(!isliving(target))
		return
	var/mob/living/mob = target
	mob.apply_damage(20, STAMINA)

/**
 * ### Nurse Spider
 *
 * A subtype of the giant spider which specializes in support skills.
 * Nurses can place down webbing in a quarter of the time that other species can and can wrap other spiders' wounds, healing them.
 * Note that it cannot heal itself.
 */
/mob/living/basic/spider/giant/nurse
	name = "nurse spider"
	desc = "Furry and black, it makes you shudder to look at it. This one has brilliant green eyes."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "nurse"
	icon_living = "nurse"
	icon_dead = "nurse_dead"
	gender = FEMALE
	butcher_results = list(/obj/item/food/meat/slab/spider = 2, /obj/item/food/spiderleg = 8, /obj/item/food/spidereggs = 4)
	maxHealth = 60
	health = 60
	melee_damage_lower = 5
	melee_damage_upper = 10
	wound_bonus = 0
	speed = 2.8
	player_speed_modifier = -3.1
	web_speed = 0.25
	web_type = /datum/action/cooldown/mob_cooldown/lay_web/sealer
	menu_description = "Avarage speed spider able to heal other spiders and itself together with a fast web laying capability, has low damage and health."
	///The health HUD applied to the mob.
	innate_actions = list(/datum/action/cooldown/heal_aura_spider)

///Used in the caves away mission.
/mob/living/basic/spider/giant/nurse/away_caves
	minimum_survivable_temperature = 0
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/spider/giant/nurse/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/healing_touch,\
		heal_brute = 30, \
		heal_burn = 30, \
		heal_time = 2 SECONDS,\
		interaction_key = DOAFTER_SOURCE_SPIDER,\
		valid_targets_typecache = typecacheof(list(/mob/living/basic/spider/giant)),\
		action_text = "%SOURCE% begins wrapping the wounds of %TARGET%.",\
		complete_text = "%SOURCE% wraps the wounds of %TARGET%.",\
	)

	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/average_web)

/**
 * ### Tangle Spider
 *
 * A subtype of the giant spider which specializes in support skills.
 * Tangle spiders can place down webbing in a quarter of the time that other species plus has an expanded arsenal of traps and web structures to place to benefit the nest.
 */
/mob/living/basic/spider/giant/tangle
	name = "tangle spider"
	desc = "Furry and brown, it makes you shudder to look at it. This one has dim brown eyes."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "tangle"
	icon_living = "tangle"
	icon_dead = "tangle_dead"
	gender = FEMALE
	butcher_results = list(/obj/item/food/meat/slab/spider = 2, /obj/item/food/spiderleg = 8, /obj/item/food/spidereggs = 4)
	maxHealth = 150
	health = 150
	melee_damage_lower = 5
	melee_damage_upper = 10
	wound_bonus = 0
	obj_damage = 80
	web_speed = 0.1
	player_speed_modifier = -4
	speed = 3.5
	regeneration_per_tick = -4
	poison_type = /datum/reagent/inverse/lentslurri
	poison_per_bite = 3.5
	web_type = /datum/action/cooldown/mob_cooldown/lay_web/sealer
	sight = SEE_SELF|SEE_TURFS
	menu_description = "Drone spider with multiple web types to reinforce the nest with little damage. Slowdowns on hit. Able to destroy weak walls. \
		When dealing melee damage to this type of spider, it deals some damage to the enemy."
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/lay_web/sticky_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		/datum/action/cooldown/mob_cooldown/lay_web/web_spikes,
	)

/mob/living/basic/spider/giant/tangle/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/average_web)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	AddElement(/datum/element/wall_tearer, allow_reinforced = FALSE)

/**
 * ### Spider Tank
 * A subtype of the giant spider, specialized in taking damage.
 * This spider is only slightly slower than a human.
 */
/mob/living/basic/spider/giant/tank
	name = "tank spider"
	desc = "Furry and Purple with a white top, it makes you shudder to look at it. This one has bright yellow eyes."
	icon_state = "tank"
	icon_living = "tank"
	icon_dead = "tank_dead"
	maxHealth = 500
	health = 500
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 1, OXY = 1)
	melee_damage_lower = 10
	melee_damage_upper = 15
	armour_penetration = 15
	wound_bonus = 0
	obj_damage = 65
	speed = 3.8
	poison_type = /datum/reagent/inverse/lentslurri
	poison_per_bite = 3.5
	player_speed_modifier = -4.5
	menu_description = "Extremely tanky with very poor offence. Has insane regeneration."
	regeneration_per_tick = -9
	pass_flags = PASSTABLE

/mob/living/basic/spider/giant/tank/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/lay_web/web_reflector/reflector_web = new(src)
	reflector_web.Grant(src)

	var/datum/action/cooldown/mob_cooldown/lay_web/web_passage/passage_web = new(src)
	passage_web.Grant(src)

	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/below_average_web)

/**
 * ### Spider Breacher
 * A subtype of the giant spider, specialized in breaching and invasion.
 * This spider is only slightly slower than a human.
 */
/mob/living/basic/spider/giant/breacher
	name = "breacher spider"
	desc = "Furry and light brown with dark brown and red highlights, it makes you shudder to look at it. This one has bright red eyes."
	icon_state = "breacher"
	icon_living = "breacher"
	icon_dead = "breacher_dead"
	maxHealth = 175
	health = 175
	melee_damage_lower = 15
	melee_damage_upper = 15
	armour_penetration = 20
	poison_type = /datum/reagent/toxin/heparin
	poison_per_bite = 3
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 75
	maximum_survivable_temperature = 700
	unsuitable_cold_damage = 0
	wound_bonus = 25
	exposed_wound_bonus = 50
	sharpness = SHARP_EDGED
	obj_damage = 80
	web_speed = 0.25
	limb_destroyer = 50
	speed = 5
	player_speed_modifier = -4
	sight = SEE_TURFS
	menu_description = "Has the ability to destroy walls and limbs, has additional damage against synthetic humans and cyborgs."
	regeneration_per_tick = -4

/mob/living/basic/spider/giant/breacher/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/lay_web/solid_web/web_solid = new(src)
	web_solid.Grant(src)

	AddElement(/datum/element/wall_tearer)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/average_web)

/mob/living/basic/spider/giant/breacher/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	var/mob/living/human = target
	if(issynthetic(human) || isandroid(human) || iscyborg(human) || isbot(human))
		human.apply_damage(15, BRUTE)

/**
 * ### Tarantula
 *
 * A subtype of the giant spider which specializes in pure strength and staying power.
 * Is slowed down when not on webbing, but can lunge to throw off attackers and possibly to stun them.
 */
/mob/living/basic/spider/giant/tarantula
	name = "tarantula"
	desc = "Furry and black, it makes you shudder to look at it. This one has abyssal red eyes."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "tarantula"
	icon_living = "tarantula"
	icon_dead = "tarantula_dead"
	maxHealth = 400 // woah nelly
	health = 400
	wound_bonus = -15
	melee_damage_lower = 35
	melee_damage_upper = 40
	armour_penetration = 35
	obj_damage = 150
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 0, OXY = 1)
	speed = 6
	player_speed_modifier = -5.5 // Doesn't seem that slow but it gets a debuff off web
	mob_size = MOB_SIZE_LARGE
	gold_core_spawnable = NO_SPAWN
	web_speed = 0.6
	web_type = /datum/action/cooldown/mob_cooldown/lay_web/sealer
	regeneration_per_tick = -5
	pass_flags = PASSTABLE
	menu_description = "Tank spider variant with an enormous amount of health and damage, but is very slow when not on webbing. It also has a charge ability to close distance with a target after a small windup."
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/charge/basic_charge/spider,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
	)
	/// Charging ability, kept seperate from innate_actions due to implementation details
	var/datum/action/cooldown/mob_cooldown/charge/basic_charge/spider/charge

/mob/living/basic/spider/giant/tarantula/Initialize(mapload)
	. = ..()
	charge = new /datum/action/cooldown/mob_cooldown/charge/basic_charge/spider()
	charge.Grant(src)

	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/below_average_web)

/mob/living/basic/spider/giant/tarantula/melee_attack(obj/vehicle/sealed/mecha/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !ismecha(target))
		return
	target.take_damage(30, BRUTE, MELEE)

/mob/living/basic/spider/giant/tarantula/Destroy()
	QDEL_NULL(charge)
	return ..()

/// Lunge if you click something at range
/mob/living/basic/spider/giant/tarantula/ranged_secondary_attack(atom/atom_target, modifiers)
	charge.Trigger(target = atom_target)

/**
 * ### Spider Viper
 *
 * A subtype of the giant spider which specializes in speed and poison.
 * Injects a deadlier toxin than other spiders, moves extremely fast, but has a limited amount of health.
 */
/mob/living/basic/spider/giant/viper
	name = "viper spider"
	desc = "Furry and black, it makes you shudder to look at it. This one has effervescent purple eyes."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "viper"
	icon_living = "viper"
	icon_dead = "viper_dead"
	maxHealth = 80
	health = 80
	melee_damage_lower = 10
	melee_damage_upper = 15
	armour_penetration = 10
	poison_per_bite = 8
	poison_type = /datum/reagent/toxin/viperspider
	speed = 2.8
	player_speed_modifier = -2.5
	gold_core_spawnable = NO_SPAWN
	regeneration_per_tick = -2
	menu_description = "Assassin spider variant with an unmatched speed and very deadly poison, but has very low amount of health and damage."
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/defensive_mode,
	)
	var/lastfired = 0
	var/shot_delay = 15
	var/shoot_sound = 'sound/effects/meatslap.ogg'
	var/projectile = /obj/projectile/toxin/viper

/mob/living/basic/spider/giant/viper/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/bonus_damage)

/mob/living/basic/spider/giant/viper/ranged_secondary_attack(atom/target, modifiers)
	if(world.time <= lastfired + shot_delay)
		return
	lastfired = world.time
	var/turf/T = loc
	var/turf/U = get_turf(target)
	if(!U)
		return
	if(!isturf(T))
		return
	if(!projectile)
		return

	var/obj/projectile/fired_bullet = new projectile(loc)
	playsound(src, shoot_sound, 50, TRUE)
	fired_bullet.aim_projectile(target, src)
	fired_bullet.fire()

/**
 * ### Spider Broodmother
 *
 * A subtype of the giant spider which is the crux of a spider horde, and the way which it grows.
 * Has very little offensive capabilities but can lay eggs at any time to create more basic spiders.
 * After consuming human bodies can lay specialised eggs including more broodmothers.
 * They are also capable of sending messages to all living spiders and setting directives for their children.
 */
/mob/living/basic/spider/giant/midwife
	name = "broodmother spider"
	desc = "Furry and black, it makes you shudder to look at it. This one has scintillating green eyes. Might also be hiding a real knife somewhere."
	gender = FEMALE
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "midwife"
	icon_living = "midwife"
	icon_dead = "midwife_dead"
	maxHealth = 300
	health = 300
	melee_damage_lower = 20
	melee_damage_upper = 25
	armour_penetration = 30
	speed = 3
	obj_damage = 80
	player_speed_modifier = -3.1
	gold_core_spawnable = NO_SPAWN
	web_speed = 0.2
	web_type = /datum/action/cooldown/mob_cooldown/lay_web/sealer
	menu_description = "Royal spider variant specializing in reproduction and leadership, deals medium damage."
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders,
		/datum/action/cooldown/mob_cooldown/lay_eggs,
		/datum/action/cooldown/mob_cooldown/lay_eggs/abnormal,
		/datum/action/cooldown/mob_cooldown/lay_eggs/enriched,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/lay_web/sticky_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		/datum/action/cooldown/mob_cooldown/lay_web/web_spikes,
		/datum/action/cooldown/mob_cooldown/set_spider_directive,
		/datum/action/cooldown/mob_cooldown/wrap,
		/datum/action/cooldown/spell/scream,
	)

/mob/living/basic/spider/giant/midwife/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/average_web)

/**
 * ### Giant Ice Spider
 *
 * A subtype of the giant spider which is immune to temperature damage, unlike its normal counterpart.
 * Currently unused in the game unless spawned by admins.
 */
/mob/living/basic/spider/giant/ice
	name = "giant ice spider"
	habitable_atmos = null
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	color = rgb(114,228,250)
	gold_core_spawnable = NO_SPAWN
	menu_description = "Versatile ice spider variant for frontline combat with high health and damage. Immune to temperature damage."

/**
 * ### Ice Nurse Spider
 *
 * A temperature-proof nurse spider. Also unused.
 */
/mob/living/basic/spider/giant/nurse/ice
	name = "giant ice spider"
	habitable_atmos = null
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	poison_type = /datum/reagent/consumable/frostoil
	color = rgb(114,228,250)
	menu_description = "Support ice spider variant specializing in healing their brethren and placing webbings very swiftly, but has very low amount of health and deals low damage. Immune to temperature damage."

/**
 * ### Ice Hunter Spider
 *
 * A temperature-proof hunter with chilling venom. Also unused.
 */
/mob/living/basic/spider/giant/hunter/ice
	name = "giant ice spider"
	habitable_atmos = null
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	poison_type = /datum/reagent/consumable/frostoil
	color = rgb(114,228,250)
	gold_core_spawnable = NO_SPAWN
	menu_description = "Fast ice spider variant specializing in catching running prey and frost oil injection, but has less health and damage. Immune to temperature damage."

/**
 * ### Scrawny Hunter Spider
 *
 * A hunter spider that trades damage for health, unable to smash enviroments.
 * Used as a minor threat in abandoned places, such as areas in maintenance or a ruin.
 */
/mob/living/basic/spider/giant/hunter/scrawny
	name = "scrawny spider"
	health = 60
	maxHealth = 60
	melee_damage_lower = 5
	melee_damage_upper = 10
	desc = "Furry and black, it makes you shudder to look at it. This one has sparkling purple eyes, and looks abnormally thin and frail."
	menu_description = "Fast spider variant specializing in catching running prey and toxin injection, but has less damage than a normal hunter spider at the cost of a little more health."
	ai_controller = /datum/ai_controller/basic_controller/giant_spider/weak

/**
 * ### Scrawny Tarantula
 *
 * A weaker version of the Tarantula, unable to smash enviroments.
 * Used as a moderately strong but slow threat in abandoned places, such as areas in maintenance or a ruin.
 */
/mob/living/basic/spider/giant/tarantula/scrawny
	name = "scrawny tarantula"
	health = 150
	maxHealth = 150
	melee_damage_lower = 20
	melee_damage_upper = 25
	desc = "Furry and black, it makes you shudder to look at it. This one has abyssal red eyes, and looks abnormally thin and frail."
	menu_description = "A weaker variant of the tarantula with reduced amount of health and damage, very slow when not on webbing. It also has a charge ability to close distance with a target after a small windup."
	ai_controller = /datum/ai_controller/basic_controller/giant_spider/weak

/**
 * ### Scrawny Nurse Spider
 *
 * A weaker version of the nurse spider with reduced health, unable to smash enviroments.
 * Mainly used as a weak threat in abandoned places, such as areas in maintenance or a ruin.
 * In the future we should give this AI so that it actually heals its teammates.
 */
/mob/living/basic/spider/giant/nurse/scrawny
	name = "scrawny nurse spider"
	health = 30
	maxHealth = 30
	desc = "Furry and black, it makes you shudder to look at it. This one has brilliant green eyes, and looks abnormally thin and frail."
	menu_description = "Weaker version of the nurse spider, specializing in healing their brethren and placing webbings very swiftly, but has very low amount of health and deals low damage."
	ai_controller = /datum/ai_controller/basic_controller/giant_spider/weak

/**
 * ### Viper Spider (Wizard)
 *
 * A spider form for wizards. Has the viper spider's extreme speed and strong venom, with additional health and vent crawling abilities.
 */
/mob/living/basic/spider/giant/viper/wizard
	name = "water spider"
	desc = "Furry and black, it makes you shudder to look at it. This one has effervescent orange eyes."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "water"
	icon_living = "water"
	icon_dead = "water_dead"
	web_speed = 0.4
	maxHealth = 80
	health = 80
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 1, OXY = 1)
	unsuitable_cold_damage = 1
	unsuitable_heat_damage = 1
	menu_description = "Stronger assassin spider variant with an unmatched speed, high amount of health and very deadly poison, but deals very low amount of damage. It also has ability to ventcrawl."
	apply_spider_antag = FALSE
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/lay_web/sticky_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_spikes,
	)

/mob/living/basic/spider/giant/viper/wizard/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/**
 * ### Sergeant Araneus
 *
 * This friendly arachnid hangs out in the HoS office on some space stations. Better trained than an average officer and does not attack except in self-defence.
 */
/mob/living/basic/spider/giant/sgt_araneus
	name = "Sergeant Araneus"
	real_name = "Sergeant Araneus"
	desc = "A fierce companion of the Head of Security, this spider has been carefully trained by Nanotrasen specialists. Its beady, staring eyes send shivers down your spine."
	faction = list(FACTION_SPIDER)
	gold_core_spawnable = NO_SPAWN
	maxHealth = 250
	health = 250
	melee_damage_lower = 15
	melee_damage_upper = 20
	armour_penetration = 20
	ai_controller = /datum/ai_controller/basic_controller/giant_spider/retaliate
	apply_spider_antag = FALSE
	regeneration_per_tick = -2

/mob/living/basic/spider/giant/sgt_araneus/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "chitter")
	AddElement(/datum/element/ai_retaliate)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
