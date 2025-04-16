/mob/living/basic/guardian/standard
	melee_damage_lower = 30
	melee_damage_upper = 30
	armour_penetration = 25

/mob/living/basic/guardian/support
	healing_amount = 10

/datum/action/cooldown/mob_cooldown/guardian_bluespace_beacon
	cooldown_time = 2.5 MINUTES

/obj/projectile/guardian
	damage = 6

/mob/living/basic/guardian/protector
	range = 7
	melee_damage_lower = 25
	melee_damage_upper = 25
	armour_penetration = 25

/mob/living/basic/guardian/lighting
	melee_damage_lower = 10
	melee_damage_upper = 10
	armour_penetration = 100
	damage_coeff = list(BRUTE = 0.7, BURN = 0.6, TOX = 0.7, STAMINA = 0, OXY = 0.7)

/mob/living/basic/guardian/gravitokinetic
	armour_penetration = 25
	melee_damage_lower = 20
	melee_damage_upper = 20
	damage_coeff = list(BRUTE = 0.7, BURN = 0.7, TOX = 0.7, STAMINA = 0, OXY = 0.7)

/mob/living/basic/guardian/gaseous
	armour_penetration = 20
	damage_coeff = list(BRUTE = 0.9, BURN = 0.45, TOX = 0.75, STAMINA = 0, OXY = 0)

/mob/living/basic/guardian/explosive
	armour_penetration = 20
	melee_damage_lower = 20
	melee_damage_upper = 20
	damage_coeff = list(BRUTE = 0.55, BURN = 0.55, TOX = 0.55, STAMINA = 0.55, OXY = 0.55)

/datum/action/cooldown/mob_cooldown/explosive_booby_trap
	decay_time = 2 MINUTES

/mob/living/basic/guardian/dextrous
	range = 30
	damage_coeff = list(BRUTE = 0.7, BURN = 0.7, TOX = 0.7, STAMINA = 0, OXY = 0.7)

/mob/living/basic/guardian/dextrous/Initialize(mapload, datum/guardian_fluff/theme)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/basic/guardian/charger
	melee_damage_lower = 15
	melee_damage_upper = 15
	armour_penetration = 25
	damage_coeff = list(BRUTE = 0.7, BURN = 0.7, TOX = 0.7, STAMINA = 0, OXY = 0.7)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/guardian
	charge_damage = 35
	destroy_objects = TRUE

/mob/living/basic/guardian/assassin
	armour_penetration = 20
	melee_damage_lower = 25
	melee_damage_upper = 25
	wound_bonus = 20
	bare_wound_bonus = 50
	stealth_cooldown_time = 5 SECONDS

