/mob/living/simple_animal/hostile/abnormality/fairy_swarm
	name = "Fairy Swarm"
	desc = "A swarm of chittering fairies."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "fairies"
	icon_living = "fairies"
	maxHealth = 50
	health = 50
	fear_level = TETH_LEVEL
	fear_level = 0
	move_to_delay = 5
	melee_damage_lower = 3
	melee_damage_upper = 5
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 1.5, BRAIN = 1, BRUTE = 1, TOX = 0.5)
	can_breach = TRUE
	can_spawn = FALSE // Normally doesn't appear
	update_qliphoth = -1

/mob/living/simple_animal/hostile/abnormality/fairy_swarm/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	GiveTarget(user)
	addtimer(CALLBACK(src, PROC_REF(die)), 60 SECONDS)

/mob/living/simple_animal/hostile/abnormality/fairy_swarm/proc/die()
	QDEL_NULL(src)

