/mob/living/simple_animal/hostile/ordeal/indigo_dusk
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_dead = "sweeper_dead"
	faction = list("indigo_ordeal")
	maxHealth = 1500
	health = 1500
	stat_attack = DEAD
	melee_damage_type = BRUTE
	rapid_melee = 1
	melee_damage_lower = 13
	melee_damage_upper = 17
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/indigo/stab_1.ogg'
	blood_volume = BLOOD_VOLUME_NORMAL
	wander = TRUE

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/white
	name = "\proper Commander Adelheide"
	maxHealth = 2100
	health = 2100
	desc = "A tall humanoid with a white greatsword."
	icon_state = "adelheide"
	icon_living = "adelheide"
	melee_damage_type = BRUTE
	melee_damage_lower = 42
	melee_damage_upper = 55
	damage_coeff = list(BURN = 0.7, BRAIN = 0.5, BRUTE = 1.5, TOX = 0.7)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/white/CanAttack(atom/the_target)
	if(ishuman(the_target))
		var/mob/living/carbon/human/L = the_target
		if(L.sanity_lost && L.stat != DEAD)
			return FALSE
	return ..()

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/black
	name = "\proper Commander Maria"
	desc = "A tall humanoid with a large black hammer."
	icon_state = "maria"
	icon_living = "maria"
	melee_damage_type = BRUTE
	melee_damage_lower = 42
	melee_damage_upper = 55
	damage_coeff = list(BURN = 0.7, BRAIN = 0.7, BRUTE = 0.5, TOX = 1.5)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/red
	name = "\proper Commander Jacques"
	desc = "A tall humanoid with red claws."
	icon_state = "jacques"
	icon_living = "jacques"
	rapid_melee = 4
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 0.5, BRAIN = 1.5, BRUTE = 0.7, TOX = 0.7)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/pale
	name = "\proper Commander Silvina"
	desc = "A tall humanoid with glowing pale fists."
	icon_state = "silvina"
	icon_living = "silvina"
	rapid_melee = 2
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 1.5, BRAIN = 0.7, BRUTE = 0.7, TOX = 0.5)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/Initialize(mapload)
	. = ..()
	var/units_to_add = list(
		/mob/living/simple_animal/hostile/ordeal/indigo_noon = 1,
		)
	AddComponent(/datum/component/ai_leadership, units_to_add)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/AttackingTarget(atom/attacked_target)
	. = ..()
	if(. && isliving(attacked_target))
		var/mob/living/L = attacked_target
		if(L.stat != DEAD)
			if(L.health <= HEALTH_THRESHOLD_DEAD && HAS_TRAIT(L, TRAIT_NODEATH))
				devour(L)
		else
			devour(L)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/proc/devour(mob/living/L)
	if(!L)
		return FALSE
	visible_message(
		span_danger("[src] devours [L]!"),
		span_userdanger("You feast on [L], restoring your health!"))
	adjustBruteLoss(-(maxHealth/2))
	L.gib(DROP_ALL_REMAINS)
	return TRUE


/mob/living/simple_animal/hostile/ordeal/indigo_midnight
	name = "Matriarch"
	desc = "A humanoid creature wearing metallic armor. The Queen of sweepers."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "matriarch"
	icon_living = "matriarch"
	icon_dead = "matriarch_dead"
	faction = list("indigo_ordeal")
	maxHealth = 3000
	health = 3000
	stat_attack = DEAD
	pixel_x = -16
	base_pixel_x = -16
	melee_damage_type = BRUTE
	move_to_delay = 3
	speed = 3
	rapid_melee = 2
	melee_damage_lower = 60
	melee_damage_upper = 60
	ranged = TRUE
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/indigo/stab_1.ogg'
	damage_coeff = list(BURN = 0.3, BRAIN = 0.4, BRUTE = 0.2, TOX = 0.5)
	blood_volume = BLOOD_VOLUME_NORMAL
	move_resist = MOVE_FORCE_OVERPOWERING
	simple_mob_flags = SILENCE_RANGED_MESSAGE
	wander = TRUE
	//How many people has she eaten
	var/belly = 0
	//How mad is she?
	var/phase = 1

	//How often does she slam?
	var/slam_cooldown = 3
	var/slam_current = 3
	var/slam_damage = 100
	var/slamming = FALSE

	var/pulse_cooldown
	var/pulse_cooldown_time = 10 SECONDS
	var/pulse_damage = 10 // More over time

	//Spawning sweepers
	var/pissed_count
	var/pissed_threshold = 16

	//phase speedchange
	var/phasespeedchange = -0.6


/mob/living/simple_animal/hostile/ordeal/indigo_midnight/Move()
	if(slamming) //slammin B)
		return FALSE
	..()

//Prototype Complex Targeting -IP
/mob/living/simple_animal/hostile/ordeal/indigo_midnight/CanAttack(atom/the_target)
	if(isliving(the_target))
		var/mob/living/L = the_target
		if(stat == DEAD && !faction_check_atom(L))
			return TRUE
	return ..()

//Remind me to return to this and make complex targeting a option for all creatures. I may make it a TRUE FALSE var.
/mob/living/simple_animal/hostile/ordeal/indigo_midnight/PickTarget(list/Targets)
	//Higher brain functions have been turned off.
	if(phase >= 3)
		return ..()

	var/list/valued_targets
	for(var/mob/target_thing in Targets)
		if(isliving(target_thing))
			var/mob/living/L = target_thing
			//Hate for corpses since we eats them.
			if(L.stat == DEAD)
				valued_targets[target_thing] += 10
			//Highest possible addition is + 9.9
			if(iscarbon(L))
				if(L.stat != DEAD && L.health <= (L.maxHealth * 0.6))
					var/upper = L.maxHealth - HEALTH_THRESHOLD_DEAD
					var/lower = L.health - HEALTH_THRESHOLD_DEAD
					valued_targets[target_thing] += min( 2 * ( 1 / ( max( lower, 1 ) / upper ) ), 20)
	return max(valued_targets)

	/*
	Priority from greatest to least:
	dead close: 90
	close: 80
	dead far: 40
	far: 30
	*/

/mob/living/simple_animal/hostile/ordeal/indigo_midnight/handle_automated_movement()
	var/list/low_priority_turfs = list() // Oh, you're wounded, how nice.
	var/list/medium_priority_turfs = list() // You're about to die and you are close? Splendid.
	var/list/high_priority_turfs = list() // IS THAT A DEAD BODY?
	for(var/mob/living/carbon/human/H in GLOB.alive_player_list)
		if(H.z != z) // Not on our level
			continue
		if(get_dist(src, H) < 4) // Way too close
			continue
		if(H.stat != DEAD) // Not dead people
			if(H.health < H.maxHealth*0.5)
				if(get_dist(src, H) > 24) // Way too far
					low_priority_turfs += get_turf(H)
					continue
				medium_priority_turfs += get_turf(H)
			continue
		if(get_dist(src, H) > 24) // Those are dead people
			medium_priority_turfs += get_turf(H)
			continue
		high_priority_turfs += get_turf(H)

	var/turf/target_turf
	if(LAZYLEN(high_priority_turfs))
		target_turf = get_closest_atom(/turf/open, high_priority_turfs, src)
	else if(LAZYLEN(medium_priority_turfs))
		target_turf = get_closest_atom(/turf/open, medium_priority_turfs, src)
	else if(LAZYLEN(low_priority_turfs))
		target_turf = get_closest_atom(/turf/open, low_priority_turfs, src)

	if(istype(target_turf))
		Goto(target_turf, move_to_delay, 1)
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/ordeal/indigo_midnight/AttackingTarget(atom/attacked_target)
	. = ..()
	if(. && isliving(attacked_target))
		var/mob/living/L = attacked_target
		if(L.stat != DEAD)
			if(L.health <= HEALTH_THRESHOLD_DEAD && HAS_TRAIT(L, TRAIT_NODEATH))
				devour(L)
		else
			devour(L)

	slam_current-=1
	if(slam_current == 0)
		slamming = TRUE
		slam_current = slam_cooldown
		aoe(2, 1)

/mob/living/simple_animal/hostile/ordeal/indigo_midnight/proc/devour(mob/living/L)
	if(!L)
		return FALSE
	visible_message(
		span_danger("[src] devours [L]!"),
		span_userdanger("You feast on [L], restoring your health!"))
	adjustBruteLoss(-(maxHealth*0.3))
	L.gib(DROP_ALL_REMAINS)
	//Increase the Vore counter by 1
	belly += 1
	pulse_damage += 2
	//She gets faster but not as protected or as strong
	if(belly == 5 && phase == 1)
		phase2()
	if(belly == 10 && phase == 2)
		phase3()
	return TRUE

/mob/living/simple_animal/hostile/ordeal/indigo_midnight/bullet_act(obj/projectile/P)
	..()
	pissed_count += 1
	if(pissed_count >= pissed_threshold)
		pissed_count = 0
		for(var/turf/T in orange(1, src))
			if(T.density)
				continue
			if(prob(20))
				new /obj/effect/sweeperspawn(T)

/mob/living/simple_animal/hostile/ordeal/indigo_midnight/Life()
	. = ..()
	if(!.) // Dead
		return FALSE
	if(pulse_cooldown < world.time)
		BlackPulse()
		//Putting this here so that it doesn't look weird
		if(health == maxHealth/2 && phase == 1)
			phase2()
		if(health == maxHealth/4 && phase == 2)
			phase3()

/mob/living/simple_animal/hostile/ordeal/indigo_midnight/proc/BlackPulse()
	pulse_cooldown = world.time + pulse_cooldown_time
	playsound(src, 'sound/items/weapons/resonator_blast.ogg', 100, FALSE, 90)
	for(var/mob/living/L in urange(90, src))
		if(faction_check_atom(L))
			continue
		//don't kill if you're too close.
		var/distance = round(get_dist(src, L))
		if(distance <= 10)
			continue
		L.apply_damage(((pulse_damage + distance - 10)*0.5), BRUTE, null, L.run_armor_check(null, BRUTE), spread_damage = TRUE)

/mob/living/simple_animal/hostile/ordeal/indigo_midnight/proc/phase2()
	icon_state = "phasechange"
	//SLEEP_CHECK_DEATH(5, src)

	maxHealth = 4000
	ChangeResistances(list(BURN = 0.4, BRAIN = 0.6, BRUTE = 0.25, TOX = 0.8))
	move_to_delay = phasespeedchange
	rapid_melee +=1
	melee_damage_lower -= 10
	melee_damage_upper -= 10

	pulse_cooldown_time = 6 SECONDS
	slam_cooldown = 5
	icon_state = "matriarch_slim"
	icon_living = "matriarch_slim"
	phase = 2


/mob/living/simple_animal/hostile/ordeal/indigo_midnight/proc/phase3()
	icon_state = "sicko_mode"
	//SLEEP_CHECK_DEATH(5, src)

	maxHealth = 3000
	ChangeResistances(list(BURN = 0.5, BRAIN = 0.8, BRUTE = 0.3, TOX = 1))
	move_to_delay = phasespeedchange
	rapid_melee += 2
	melee_damage_lower -= 15
	melee_damage_upper -= 15

	pulse_cooldown_time = 4 SECONDS
	slam_cooldown = 10
	icon_state = "matriarch_fast"
	icon_living = "matriarch_fast"
	phase = 3


/// cannibalized from wendigo
/mob/living/simple_animal/hostile/ordeal/indigo_midnight/proc/aoe(range, delay)
	for(var/turf/W in range(range, src))
		new /obj/effect/temp_visual/guardian/phase(W)
	sleep(10)
	var/turf/orgin = get_turf(src)
	var/list/all_turfs = RANGE_TURFS(range, orgin)
	for(var/i = 0 to range)
		for(var/turf/T in all_turfs)
			if(get_dist(orgin, T) > i)
				continue
			playsound(T,'sound/effects/bamf.ogg', 60, TRUE, 10)
			new /obj/effect/temp_visual/small_smoke/halfsecond(T)
			for(var/mob/living/carbon/human/L in T)
				if(L == src || L.throwing)
					continue
				to_chat(L, span_userdanger("[src]'s ground slam shockwave sends you flying!"))
				var/turf/thrownat = get_ranged_target_turf_direct(src, L, 8, rand(-10, 10))
				L.throw_at(thrownat, 8, 2, src, TRUE, force = MOVE_FORCE_OVERPOWERING, gentle = TRUE)
				L.apply_damage(slam_damage, BRUTE, null, L.run_armor_check(null, BRUTE), spread_damage = TRUE)
				shake_camera(L, 2, 1)
			all_turfs -= T
		sleep(delay)
	slamming = FALSE


/obj/effect/sweeperspawn
	name = "bloodpool"
	desc = "A target warning you of incoming pain"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/cult_effects.dmi'
	icon_state = "bloodin"
	move_force = INFINITY
	pull_force = INFINITY
	generic_canpass = FALSE
	movement_type = PHASING | FLYING
	layer = ABOVE_ALL_MOB_LAYER	//We want this HIGH. SUPER HIGH. We want it so that you can absolutely, guaranteed, see exactly what is about to hit you.

/obj/effect/sweeperspawn/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(spawnscout)), 6)

/obj/effect/sweeperspawn/proc/spawnscout()
	new /mob/living/simple_animal/hostile/ordeal/indigo_spawn(get_turf(src))
	qdel(src)

/mob/living/simple_animal/hostile/ordeal/indigo_spawn
	name = "sweeper scout"
	desc = "A tall humanoid with a walking cane. It's wearing indigo armor."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "indigo_dawn"
	icon_living = "indigo_dawn"
	icon_dead = "indigo_dawn_dead"
	faction = list("indigo_ordeal")
	maxHealth = 110
	health = 110
	move_to_delay = 1.3	//Super fast, but squishy and weak.
	stat_attack = HARD_CRIT
	melee_damage_type = BRUTE
	melee_damage_lower = 21
	melee_damage_upper = 24
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/indigo/stab_1.ogg'
	damage_coeff = list(BURN = 1, BRAIN = 1.5, BRUTE = 0.5, TOX = 0.8)
	blood_volume = BLOOD_VOLUME_NORMAL
