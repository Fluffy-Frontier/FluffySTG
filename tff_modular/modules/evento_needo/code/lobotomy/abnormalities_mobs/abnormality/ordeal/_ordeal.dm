/mob/living/simple_animal/hostile/ordeal
	mob_size = MOB_SIZE_HUGE
	robust_searching = TRUE
	stat_attack = HARD_CRIT
	see_in_dark = 7
	vision_range = 12
	aggro_vision_range = 20
	var/datum/ordeal/ordeal_reference
	var/ordeal_remove_ondeath = TRUE

/mob/living/simple_animal/hostile/ordeal/add_to_mob_list()
	. = ..()
	GLOB.ordeal_list += src

/mob/living/simple_animal/hostile/ordeal/remove_from_mob_list()
	. = ..()
	GLOB.ordeal_list -= src

/mob/living/simple_animal/hostile/ordeal/death(gibbed)
	mob_size = MOB_SIZE_HUMAN //let body bags carry dead ordeals
	if(ordeal_reference && ordeal_remove_ondeath)
		ordeal_reference.OnMobDeath(src)
		ordeal_reference = null
	return ..()

/mob/living/simple_animal/hostile/ordeal/Destroy()
	if(ordeal_reference)
		ordeal_reference.OnMobDeath(src)
		ordeal_reference = null
	return ..()

/mob/living/simple_animal/hostile/ordeal/apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, attacking_item, wound_clothing)
	if(is_ego_weapon(attacking_item))
		damage *= 1.5
	return ..()

/mob/living/simple_animal/hostile/ordeal/bullet_act(obj/projectile/proj)
	if(istype(proj, /obj/projectile/ego_bullet))
		proj.damage *= 1.5
	return ..()

