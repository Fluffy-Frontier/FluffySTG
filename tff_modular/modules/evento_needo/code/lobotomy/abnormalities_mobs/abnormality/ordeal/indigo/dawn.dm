//Indigo dawns.
/mob/living/simple_animal/hostile/ordeal/indigo_dawn
	name = "unknown scout"
	desc = "A tall humanoid with a walking cane. It's wearing indigo armor."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "indigo_dawn"
	icon_living = "indigo_dawn"
	icon_dead = "indigo_dawn_dead"
	faction = list("indigo_ordeal")
	maxHealth = 110
	health = 110
	move_to_delay = 1.3	//Super fast, but squishy and weak.
	stat_attack = DEAD
	melee_damage_type = BRUTE
	melee_damage_lower = 10
	melee_damage_upper = 12
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/indigo/stab_1.ogg'
	damage_coeff = list(BURN = 1, BRAIN = 1.5, BRUTE = 0.5, TOX = 0.8)
	blood_volume = BLOOD_VOLUME_NORMAL


/mob/living/simple_animal/hostile/ordeal/indigo_dawn/AttackingTarget(atom/attacked_target)
	. = ..()
	if(. && isliving(attacked_target))
		var/mob/living/L = attacked_target
		if(L.stat != DEAD)
			if(L.health <= HEALTH_THRESHOLD_DEAD && HAS_TRAIT(L, TRAIT_NODEATH))
				devour(L)
		else
			devour(L)

/mob/living/simple_animal/hostile/ordeal/indigo_dawn/proc/devour(mob/living/L)
	if(!L)
		return FALSE
	visible_message(
		span_danger("[src] devours [L]!"),
		span_userdanger("You feast on [L], restoring your health!"))
	adjustBruteLoss(-(maxHealth/2))
	L.gib(DROP_ALL_REMAINS)
	return TRUE

/mob/living/simple_animal/hostile/ordeal/indigo_dawn/invis
	move_to_delay = 3	//These ones are slower because they're invisible
	alpha = 15

/mob/living/simple_animal/hostile/ordeal/indigo_dawn/skirmisher
	move_to_delay = 2	//These ones are slower because they move a little eratically
	ranged = 1
	retreat_distance = 3
	minimum_distance = 1

/mob/living/simple_animal/hostile/ordeal/indigo_dawn/OpenFire(atom/A)
	visible_message(span_danger("<b>[src]</b> menacingly stares at [A]!"))
	ranged_cooldown = world.time + ranged_cooldown_time
