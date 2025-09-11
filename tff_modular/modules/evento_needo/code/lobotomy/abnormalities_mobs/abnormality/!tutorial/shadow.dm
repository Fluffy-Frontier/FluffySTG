/mob/living/simple_animal/hostile/abnormality/shadow
	name = "Shadow Man"
	desc = "A humanoid that reflects no light."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "shadow"
	icon_living = "shadow"
	maxHealth = 75
	health = 75
	fear_level = TETH_LEVEL
	fear_level = 0
	move_to_delay = 5
	melee_damage_lower = 4
	melee_damage_upper = 6
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 0.5, TOX = 1.5)
	can_breach = TRUE
	can_spawn = FALSE // Normally doesn't appear
	update_qliphoth = -1

/mob/living/simple_animal/hostile/abnormality/shadow/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	GiveTarget(user)
	addtimer(CALLBACK(src, PROC_REF(die)), 60 SECONDS)

/mob/living/simple_animal/hostile/abnormality/shadow/proc/die()
	QDEL_NULL(src)

