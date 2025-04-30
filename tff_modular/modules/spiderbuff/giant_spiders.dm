/mob/living/basic/spider/giant/ambush
	obj_damage = 60
	armour_penetration = 25
	melee_damage_lower = 25
	melee_damage_upper = 30
	player_speed_modifier = -4.0
	health = 185
	maxHealth = 185
	speed = 4.5
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/sneak/spider,
		)

/mob/living/basic/spider/giant/guard
	health = 250
	maxHealth = 250
	melee_damage_lower = 20
	melee_damage_upper = 20
	armour_penetration = 15
	obj_damage = 90
	player_speed_modifier = -4.2
	damage_coeff = list(BRUTE = 1, BURN = 1, STAMINA = 1, TOX = 1, OXY = 1)
	speed = 3.5
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/web_effigy,
		)

/mob/living/basic/spider/giant/guard/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/basic/spider/giant/hunter
	armour_penetration = 15
	poison_per_bite = 2
	poison_type = /datum/reagent/toxin/staminatoxin
	health = 130
	maxHealth = 130
	speed = 2.5
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		)

/mob/living/basic/spider/giant/hunter/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/basic/spider/giant/scout
	armour_penetration = 15
	melee_damage_lower = 15
	melee_damage_upper = 20
	melee_attack_cooldown = 0.8 SECONDS
	poison_type = /datum/reagent/mercury
	health = 90
	maxHealth = 90
	speed = 2.8

/mob/living/basic/spider/giant/tangle
	health = 200
	maxHealth = 200
	poison_per_bite = 3
	obj_damage = 80
	player_speed_modifier = -4
	speed = 3.5
	poison_type = /datum/reagent/toxin/chloralhydrate
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/lay_web/sticky_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		/datum/action/cooldown/mob_cooldown/lay_web/web_spikes,
		)

/mob/living/basic/spider/giant/tangle/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/basic/spider/giant/tank
	melee_damage_lower = 15
	melee_damage_upper = 20
	armour_penetration = 15
	poison_type = /datum/reagent/inverse/lentslurri
	poison_per_bite = 3.5
	obj_damage = 75
	player_speed_modifier = -4.5
	speed = 3.8
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		)

/mob/living/basic/spider/giant/breacher
	armour_penetration = 25
	poison_type = /datum/reagent/toxin/heparin
	poison_per_bite = 3
	obj_damage = 80
	player_speed_modifier = -4.5
	speed = 4

/mob/living/basic/spider/giant/tarantula
	armour_penetration = 40
	player_speed_modifier = -5
	speed = 5
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/charge/basic_charge,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		)

/mob/living/basic/spider/giant/nurse
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/spell/pointed/projectile/web_restraints,
		/datum/action/cooldown/heal_aura_spider,
		)
	speed = 2.5

/mob/living/basic/spider/giant/nurse/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/basic/spider/giant/viper
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/defensive_mode,
		)
	speed = 2.8
	maxHealth = 110
	health = 110

/mob/living/basic/spider/giant/viper/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/basic/spider/giant/midwife
	player_speed_modifier = -3.9
	health = 300
	maxHealth = 300
	obj_damage = 90
	poison_type = /datum/reagent/toxin/leadacetate
	poison_per_bite = 6.5
	pass_flags = PASSMOB

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
