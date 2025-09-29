// Green dawn
/mob/living/simple_animal/hostile/ordeal/green_bot
	name = "doubt alpha"
	desc = "A slim robot with a spear in place of its hand."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "green_bot"
	icon_living = "green_bot"
	icon_dead = "green_bot_dead"
	faction = list("green_ordeal")
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC
	maxHealth = 400
	health = 400
	speed = 2
	move_to_delay = 3.5
	melee_damage_lower = 22
	melee_damage_upper = 26
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/green/stab.ogg'
	damage_coeff = list(BURN = 0.8, BRAIN = 1.3, BRUTE = 2, TOX = 1)
	death_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/green/dawn_dead.ogg'

	/// Can't move/attack when it's TRUE
	var/finishing = FALSE

/mob/living/simple_animal/hostile/ordeal/green_bot/CanAttack(atom/the_target)
	if(finishing)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/ordeal/green_bot/Move()
	if(finishing)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/ordeal/green_bot/Goto(target, delay, minimum_distance)
	if(finishing)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/ordeal/green_bot/DestroySurroundings()
	if(finishing)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/ordeal/green_bot/AttackingTarget(atom/attacked_target)
	if(finishing)
		return
	. = ..()
	if(.)
		if(!istype(attacked_target, /mob/living/carbon/human))
			return

		var/mob/living/carbon/human/TH = attacked_target
		if(TH.health < 0)
			finishing = TRUE
			TH.Stun(4 SECONDS)
			forceMove(get_turf(TH))
			var/atom/target = locate(targets_from)
			for(var/i = 1 to 5)
				if(!target.Adjacent(TH) || QDELETED(TH) || TH.health > 0) // They can still be saved if you move them away
					finishing = FALSE
					return
				SLEEP_CHECK_DEATH(3, src)
				TH.attack_animal(src)
				for(var/mob/living/carbon/human/H in view(7, get_turf(src)))
					H.apply_damage(7, BRUTE, null, H.run_armor_check(null, BRUTE), spread_damage = TRUE)
			if(!target.Adjacent(TH) || QDELETED(TH) || TH.health > 0)
				finishing = FALSE
				return
			playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/green/final_stab.ogg', 50, 1)
			TH.gib(DROP_ALL_REMAINS)
			finishing = FALSE

/mob/living/simple_animal/hostile/ordeal/green_bot/spawn_dust()
	return

//Green dawn factory spawn
/mob/living/simple_animal/hostile/ordeal/green_bot/factory
	butcher_results = list()
	guaranteed_butcher_results = list()

/mob/living/simple_animal/hostile/ordeal/green_bot/factory/death(gibbed)
	density = FALSE
	animate(src, alpha = 0, time = 5 SECONDS)
	QDEL_IN(src, 5 SECONDS)
	..()


/******************************************************************/
// Subtypes

/mob/living/simple_animal/hostile/ordeal/green_bot/syringe
	name = "doubt beta"
	desc = "A slim robot with a syringe in place of its hand."
	icon_state = "green_bot_b"
	icon_living = "green_bot_b"
	move_to_delay = 3
	melee_damage_lower = 14
	melee_damage_upper = 16

/mob/living/simple_animal/hostile/ordeal/green_bot/syringe/AttackingTarget(atom/attacked_target)
	if(finishing)
		return
	. = ..()
	if(.)
		if(!istype(attacked_target, /mob/living/carbon/human))
			return
		var/mob/living/carbon/human/H = attacked_target
		H.add_movespeed_modifier(/datum/movespeed_modifier/grab_slowdown/aggressive)
		addtimer(CALLBACK(H, TYPE_PROC_REF(/mob, remove_movespeed_modifier), /datum/movespeed_modifier/grab_slowdown/aggressive), 4 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)

/mob/living/simple_animal/hostile/ordeal/green_bot/syringe/factory/death(gibbed)
	density = FALSE
	animate(src, alpha = 0, time = 5 SECONDS)
	QDEL_IN(src, 5 SECONDS)
	..()

/mob/living/simple_animal/hostile/ordeal/green_bot/fast
	name = "doubt gamma"
	desc = "A slim robot with two spears."
	icon_state = "green_bot_c"
	icon_living = "green_bot_c"
	rapid_melee = 5
	move_to_delay = 7
	melee_damage_lower = 9
	melee_damage_upper = 13

/mob/living/simple_animal/hostile/ordeal/green_bot/fast/factory/death(gibbed)
	density = FALSE
	animate(src, alpha = 0, time = 5 SECONDS)
	QDEL_IN(src, 5 SECONDS)
	..()

