/mob/living/basic/spider/giant/ambush
	obj_damage = 60
	armour_penetration = 25
	melee_damage_lower = 25
	melee_damage_upper = 30
	player_speed_modifier = -4.0
	health = 185
	maxHealth = 185

/mob/living/basic/spider/giant/guard
	armour_penetration = 15
	obj_damage = 60
	player_speed_modifier = -4.2
	speed = 4.5

/mob/living/basic/spider/giant/hunter
	armour_penetration = 15
	poison_per_bite = 2
	poison_type = /datum/reagent/toxin/staminatoxin
	health = 130
	maxHealth = 130

/mob/living/basic/spider/giant/scout
	armour_penetration = 15
	melee_damage_lower = 15
	melee_damage_upper = 20
	melee_attack_cooldown = 0.8 SECONDS
	poison_type = /datum/reagent/mercury
	health = 90
	maxHealth = 90

/mob/living/basic/spider/giant/tangle
	health = 200
	maxHealth = 200
	poison_per_bite = 3
	obj_damage = 80
	player_speed_modifier = -4
	poison_type = /datum/reagent/toxin/chloralhydrate

/mob/living/basic/spider/giant/tank
	melee_damage_lower = 15
	melee_damage_upper = 20
	armour_penetration = 15
	poison_type = /datum/reagent/inverse/lentslurri
	poison_per_bite = 3.5
	obj_damage = 75
	player_speed_modifier = -4.5

/mob/living/basic/spider/giant/breacher
	armour_penetration = 25
	poison_type = /datum/reagent/toxin/heparin
	poison_per_bite = 3
	obj_damage = 80
	player_speed_modifier = -4.5

/mob/living/basic/spider/giant/tarantula
	armour_penetration = 40
	player_speed_modifier = -6.0

/mob/living/basic/spider/giant/midwife
	player_speed_modifier = -3.9
	health = 300
	maxHealth = 300
	obj_damage = 90
	poison_type = /datum/reagent/toxin/leadacetate
	poison_per_bite = 6.5
