// Gold Dawn - Commander that heals its minions
/mob/living/simple_animal/hostile/ordeal/fallen_amurdad_corrosion
	name = "Fallen Nepenthes"
	desc = "A level 1 agent of Lobotomy Corporation that has somehow been corrupted by an abnormality."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "amurdad_corrosion"
	icon_living = "amurdad_corrosion"
	icon_dead = "amurdad_corrosion_dead"
	faction = list("gold_ordeal")
	maxHealth = 400
	health = 400
	melee_damage_type = BRUTE
	melee_damage_lower = 14
	melee_damage_upper = 14
	pixel_x = -8
	base_pixel_x = -8
	attack_verb_continuous = "bashes"
	attack_verb_simple = "bashes"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ebonyqueen/attack.ogg'
	death_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/limbus_death.ogg'
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 0.8, TOX = 2)
	speed = 1 //slow as balls
	move_to_delay = 20
	ranged = TRUE
	rapid = 2
	rapid_fire_delay = 10
	projectiletype = /obj/projectile/ego_bullet/ego_nightshade/healing //no friendly fire, baby!
	projectilesound = 'sound/items/weapons/gun/bow/bow_fire.ogg'

/mob/living/simple_animal/hostile/ordeal/fallen_amurdad_corrosion/Initialize(mapload)
	. = ..()
	var/list/units_to_add = list(
		/mob/living/simple_animal/hostile/ordeal/beanstalk_corrosion = 3
		)
	AddComponent(/datum/component/ai_leadership, units_to_add, 8, TRUE)

/mob/living/simple_animal/hostile/ordeal/beanstalk_corrosion
	name = "Beanstalk Searching for Jack"
	desc = "A Lobotomy Corporation clerk that has been corrupted by an abnormality."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "beanstalk"
	icon_living = "beanstalk"
	icon_dead = "beanstalk_dead"
	faction = list("gold_ordeal")
	maxHealth = 220
	health = 220
	melee_damage_type = BRUTE
	melee_damage_lower = 7
	melee_damage_upper = 10
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/ego/spear1.ogg'
	death_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/limbus_death.ogg'
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	damage_coeff = list(BURN = 0.9, BRAIN = 1.2, BRUTE = 0.7, TOX = 2)
