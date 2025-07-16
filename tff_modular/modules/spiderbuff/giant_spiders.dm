#define isvent(A) (istype(A, /obj/machinery/atmospherics/components/unary/vent_pump))

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

/mob/living/basic/spider/giant
	maxHealth = 150
	health = 150
	obj_damage = 40
	wound_bonus = 0
	melee_damage_lower = 20
	melee_damage_upper = 20
	regeneration_per_tick = -3

/mob/living/basic/spider/giant/ambush
	maxHealth = 140
	health = 140
	obj_damage = 50
	armour_penetration = 25
	melee_damage_lower = 15
	melee_damage_upper = 15
	wound_bonus = 0
	speed = 4
	web_speed = 0.25
	menu_description = "medium-speed spider with small damage and medium health, but with good regeneration. When on the web, causes insane damage. Has ability to become invisible."
	regeneration_per_tick = -2.5

/mob/living/basic/spider/giant/ambush/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !isliving(target))
		return
	var/obj/structure/spider/web = locate() in src.loc
	var/mob/living/human = target
	if(web)
		human.apply_damage(17.5, BRUTE, wound_bonus = 0)

/mob/living/basic/spider/giant/guard
	maxHealth = 200
	health = 200
	melee_damage_lower = 15
	melee_damage_upper = 20
	armour_penetration = 25
	wound_bonus = 15
	obj_damage = 60
	speed = 4
	damage_coeff = list(BRUTE = 1, BURN = 1, STAMINA = 1, TOX = 1, OXY = 1)
	menu_description = "Tanky and strong able to shed a carcass for protection. Has rage ability to become a little bit stronger."
	innate_actions = list(/datum/action/cooldown/mob_cooldown/web_effigy, /datum/action/cooldown/guard_rage)
	regeneration_per_tick = -2

/**
 * ### Hunter Spider
 * A subtype of the giant spider which is faster, has toxin injection, but less health and damage.
 * This spider is only slightly slower than a human.
 */
/mob/living/basic/spider/giant/hunter
	maxHealth = 135
	health = 135
	melee_attack_cooldown = 7
	armour_penetration = 20
	wound_bonus = -15
	obj_damage = 60
	speed = 2.8
	sharpness = SHARP_EDGED
	menu_description = "Fast spider with vampirism, has good damage and health, but its passively losing health."
	has_regeneration = FALSE
	var/damage_per_tick = 3 // Thats hurts

/mob/living/basic/spider/giant/hunter/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/fast_web)
	RegisterSignal(src, COMSIG_LIVING_LIFE, PROC_REF(damaging))

/mob/living/basic/spider/giant/hunter/proc/damaging(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	if(!isliving(source) || source.stat == DEAD || !source.mind)
		return

	source.adjustBruteLoss(damage_per_tick)

/mob/living/basic/spider/giant/hunter/melee_attack(mob/living/basic/spider/giant/source, atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !isliving(target) || target == src || iscyborg(target))
		return
	var/mob/living/carbon/who_attack = target
	if(isliving(who_attack))
		who_attack.blood_volume -= 15
	source.adjustBruteLoss(-20)
	return TRUE

/mob/living/basic/spider/giant/hunter/away_caves
	minimum_survivable_temperature = 0
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/spider/giant/scout
	maxHealth = 100
	health = 100
	obj_damage = 50
	melee_damage_upper = 5
	armour_penetration = 25
	wound_bonus = 0
	speed = 3
	poison_type = /datum/reagent/toxin/mutetoxin
	poison_per_bite = 3
	web_speed = 0.75
	sight = SEE_SELF|SEE_MOBS|SEE_TURFS
	menu_description = "Spider that able to see enemies through walls, has ability to travel in vents. Has low amount of health and damage, but on attack, it's injects mutetoxin and deals stamina damage"
	regeneration_per_tick = -2

/mob/living/basic/spider/giant/scout/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if(!isliving(target))
		return
	var/mob/living/mob = target
	mob.apply_damage(15, STAMINA)

/**
 * ### Nurse Spider
 *
 * A subtype of the giant spider which specializes in support skills.
 * Nurses can place down webbing in a quarter of the time that other species can and can wrap other spiders' wounds, healing them.
 * Note that it cannot heal itself.
 */
/mob/living/basic/spider/giant/nurse
	maxHealth = 60
	health = 60
	melee_damage_lower = 5
	melee_damage_upper = 10
	wound_bonus = 0
	speed = 2.8
	web_type = /datum/action/cooldown/mob_cooldown/lay_web/sealer
	menu_description = "Avarage speed spider able to heal other spiders and itself together with a fast web laying capability, has low damage and health."
	///The health HUD applied to the mob.
	innate_actions = list(/datum/action/cooldown/heal_aura_spider)

///Used in the caves away mission.
/mob/living/basic/spider/giant/nurse/away_caves
	minimum_survivable_temperature = 0
	gold_core_spawnable = NO_SPAWN

/**
 * ### Tangle Spider
 *
 * A subtype of the giant spider which specializes in support skills.
 * Tangle spiders can place down webbing in a quarter of the time that other species plus has an expanded arsenal of traps and web structures to place to benefit the nest.
 */
/mob/living/basic/spider/giant/tangle
	maxHealth = 150
	health = 150
	melee_damage_lower = 5
	melee_damage_upper = 10
	wound_bonus = 0
	obj_damage = 80
	web_speed = 0.1
	speed = 3.5
	regeneration_per_tick = -4
	poison_type = /datum/reagent/inverse/lentslurri
	poison_per_bite = 3.5
	web_type = /datum/action/cooldown/mob_cooldown/lay_web/sealer
	sight = SEE_SELF|SEE_TURFS
	menu_description = "Drone spider with multiple web types to reinforce the nest with little damage. Slowdowns on hit. Able to destroy weak walls."
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

/**
 * ### Spider Breacher
 * A subtype of the giant spider, specialized in breaching and invasion.
 * This spider is only slightly slower than a human.
 */
/mob/living/basic/spider/giant/breacher
	maxHealth = 175
	health = 175
	melee_damage_lower = 15
	melee_damage_upper = 15
	armour_penetration = 20
	poison_type = /datum/reagent/toxin/heparin
	poison_per_bite = 3
	obj_damage = 100
	web_speed = 0.5
	speed = 5
	web_type = /datum/action/cooldown/mob_cooldown/lay_web/strong
	menu_description = "Has the ability to destroy walls and limbs, has additional damage against synthetic humans and cyborgs. Can unweld vents by attacking it."
	regeneration_per_tick = -4

/mob/living/basic/spider/giant/breacher/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	var/mob/living/human = target
	if(issynthetic(human) || isandroid(human) || iscyborg(human) || isbot(human))
		human.apply_damage(20, BRUTE)
	var/obj/machinery/atmospherics/components/unary/vent_pump/pump = human
	if(isvent(pump))
		if(!do_after(src, 1.5 SECONDS, pump))
			return
		playsound(pump, 'sound/effects/bang.ogg', 70)
		pump.welded = FALSE
		pump.update_appearance(UPDATE_ICON)

/**
 * ### Tarantula
 *
 * A subtype of the giant spider which specializes in pure strength and staying power.
 * Is slowed down when not on webbing, but can lunge to throw off attackers and possibly to stun them.
 */
/mob/living/basic/spider/giant/tarantula
	wound_bonus = -15
	melee_attack_cooldown = 8.5
	armour_penetration = 35
	obj_damage = 150
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 0, OXY = 1)
	speed = 6
	web_speed = 0.6
	regeneration_per_tick = -5
	pass_flags = PASSTABLE

/mob/living/basic/spider/giant/tarantula/melee_attack(obj/vehicle/sealed/mecha/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !ismecha(target))
		return
	target.take_damage(30, BRUTE, MELEE)

/**
 * ### Spider Viper
 *
 * A subtype of the giant spider which specializes in speed and poison.
 * Injects a deadlier toxin than other spiders, moves extremely fast, but has a limited amount of health.
 */
/mob/living/basic/spider/giant/viper
	maxHealth = 80
	health = 80
	melee_damage_lower = 10
	melee_damage_upper = 15
	armour_penetration = 10
	poison_per_bite = 8
	poison_type = /datum/reagent/toxin/viperspider
	speed = 2.8
	player_speed_modifier = -2.5
	regeneration_per_tick = -2
	menu_description = "Assassin spider variant with an very deadly poison and projectile attack, but has very low amount of health and damage."
	var/lastfired = 0
	var/shot_delay = 15
	var/shoot_sound = 'sound/effects/meatslap.ogg'
	var/projectile = /obj/projectile/toxin/viper

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
	maxHealth = 300
	health = 300
	melee_damage_lower = 20
	melee_damage_upper = 25
	armour_penetration = 25
	regeneration_per_tick = -2
	speed = 3
	obj_damage = 80
	web_speed = 0.2
	web_type = /datum/action/cooldown/mob_cooldown/lay_web/sealer
	menu_description = "Royal spider variant specializing in reproduction and leadership, deals medium damage."
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/lay_eggs,
		/datum/action/cooldown/mob_cooldown/lay_eggs/abnormal,
		/datum/action/cooldown/mob_cooldown/lay_eggs/enriched,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/lay_web/sticky_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		/datum/action/cooldown/mob_cooldown/lay_web/web_spikes,
		/datum/action/cooldown/mob_cooldown/set_spider_directive,
		/datum/action/cooldown/mob_cooldown/wrap,
	)

/**
 * ### Sergeant Araneus
 *
 * This friendly arachnid hangs out in the HoS office on some space stations. Better trained than an average officer and does not attack except in self-defence.
 */
/mob/living/basic/spider/giant/sgt_araneus
	armour_penetration = 20
	regeneration_per_tick = -2

#undef isvent
