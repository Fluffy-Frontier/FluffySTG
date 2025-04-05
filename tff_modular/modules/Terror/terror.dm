/mob/living/basic/spider/giant/terror
	name = "Terror"
	desc = "Furry and brown with an orange top, its massive jaws strike fear in you. This one has bright orange eyes."
	icon = 'modular_nova/modules/spider/icons/spider.dmi'
	icon_state = "pit"
	icon_living = "pit"
	icon_dead = "pit_dead"
	gender = MALE
	maxHealth = 1800
	health = 1800
	armour_penetration = 60
	melee_damage_lower = 40
	melee_damage_upper = 40
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 25
	maximum_survivable_temperature = 1100
	unsuitable_cold_damage = 0
	wound_bonus = 25
	bare_wound_bonus = 50
	sharpness = SHARP_EDGED
	obj_damage = 150
	web_speed = 1
	limb_destroyer = 50
	damage_coeff = list(BRUTE = 0.75, BURN = 1, TOX = 0, STAMINA = 0, OXY = 0.25)
	speed = 6
	player_speed_modifier = -4
	gold_core_spawnable = NO_SPAWN
	sight = SEE_TURFS
	menu_description = "Has the ability to destroy walls and limbs, and to send warnings to the nest, that's he doesnt have..."
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/wrap,
		/datum/action/cooldown/mob_cooldown/command_spiders,
		/datum/action/cooldown/spell/wall_spider,
		/datum/action/cooldown/mob_cooldown/charge/basic_charge,
	)
/mob/living/basic/spider/giant/terror/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/below_average_web)

/mob/living/basic/spider/giant/terror/melee_attack(mob/living/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !isliving(target))
		return
	target.AdjustKnockdown(1 SECONDS)

/mob/living/basic/spider/giant/terror/melee_attack(obj/vehicle/sealed/mecha/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !ismecha(target))
		return
	target.take_damage(obj_damage, BRUTE, MELEE)

	AddComponent(/datum/component/healing_touch,\
		heal_brute = 200,\
		heal_burn = 200,\
		heal_time = 20 SECONDS,\
		interaction_key = DOAFTER_SOURCE_SPIDER,\
		valid_targets_typecache = typecacheof(list(/mob/living/basic/spider/giant)),\
		action_text = "%SOURCE% begins wrapping the wounds of %TARGET%.",\
		complete_text = "%SOURCE% wraps the wounds of %TARGET%.",\
	)
