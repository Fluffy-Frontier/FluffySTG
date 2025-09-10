/mob/living/simple_animal/hostile/abnormality/bill
	name = "Bill"
	desc = "That's Bill from accounting. He agreed to do this job for us. He gets paid extra for it."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "bill"
	icon_living = "bill"
	maxHealth = 40
	health = 40
	melee_damage_lower = 4
	melee_damage_upper = 6
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 0.5, BRAIN = 1.5, BRUTE = 1, TOX = 1)
	can_breach = TRUE
	can_spawn = FALSE // Normally doesn't appear

/mob/living/simple_animal/hostile/abnormality/bill/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(!.)
		return
	if(prob(50))
		qliphoth_change(-1)

/mob/living/simple_animal/hostile/abnormality/bill/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	GiveTarget(user)
	addtimer(CALLBACK(src, PROC_REF(die)), 60 SECONDS)

/mob/living/simple_animal/hostile/abnormality/bill/proc/die()
	QDEL_NULL(src)

