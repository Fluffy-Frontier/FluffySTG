//Coded by Coxswain sprites by mel and Sky_
/mob/living/simple_animal/hostile/abnormality/ebony_queen
	name = "Ebony Queen’s Apple"
	desc = "An Abnormality taking the form of a tall humanoid with a rotted apple for a head, wearing a regal robe."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x96.dmi'
	icon_state = "ebonyqueen"
	icon_living = "ebonyqueen"
	icon_dead = "ebonyqueen_dead"
	maxHealth = 2000
	health = 2000
	pixel_x = -16
	base_pixel_x = -16
	blood_volume = 0
	melee_damage_type = BRUTE
	melee_damage_lower = 35
	melee_damage_upper = 45
	speed = 6
	move_to_delay = 6
	ranged = TRUE
	ranged_cooldown_time = 1 //fast!
	rapid_melee = 8 // every 1/4 second
	damage_coeff = list(BURN = 1.0, BRAIN = 1.3, BRUTE = 0, TOX = 0.7)
	ranged = TRUE
	stat_attack = HARD_CRIT
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ebonyqueen/attack.ogg'
	attack_verb_continuous = "claws"
	attack_verb_simple = "claws"
	projectilesound = 'sound/mobs/non-humanoids/venus_trap/venus_trap_hit.ogg'
	can_breach = TRUE
	fear_level = WAW_LEVEL
	del_on_death = FALSE
	death_message = "collapses into a pile of plantmatter."
	death_sound = 'sound/mobs/non-humanoids/venus_trap/venus_trap_death.ogg'
	attacked_sound = 'sound/mobs/non-humanoids/venus_trap/venus_trap_hurt.ogg'
	observation_prompt = "(I hear something) <br>\
		The wicked queen is speaking with the magic mirror again and frowns when its answer remains unchanged. <br>\
		(I see something) <br>\
		I see her take an apple from next to me and imbue it with a poison that can kill with but a drop. <br>\
		She takes on the guise of a wizened old hag and places the poisoned apple back next to me and heads out, a small amount of its poison leaves an impression upon me. <br>\
		(I feel something) <br>\
		I feel her cast me aside, taking a bite of my white flesh to prove her genuinity as Snow White bit the poisoned apple's red flesh. <br>\
		Her plan was a success - her behated Snow White has fallen into a death-like state. <br>\
		Is that all I was for? <br>To bring pain to others whilst never experiencing it myself? <br>\
		I'm beginning to rot and feel pests and other lowly creatures make a meal out of me..."


	var/barrier_cooldown
	var/barrier_cooldown_time = 4 SECONDS
	var/barrage_cooldown
	var/barrage_cooldown_time = 8 SECONDS
	var/burst_cooldown
	var/burst_cooldown_time = 10 SECONDS
	var/barrage_range = 10

	var/can_act = TRUE

	ego_list = list(
		/datum/ego_datum/weapon/ebony_stem,
		/datum/ego_datum/armor/ebony_stem,
	)
	gift_type =  /datum/ego_gifts/ebony_stem
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/golden_apple = 1.5,
		///mob/living/simple_animal/hostile/abnormality/snow_whites_apple = 1.5,
	)

	//PLAYABLES ATTACKS
	attack_action_types = list(
		/datum/action/innate/abnormality_attack/ebony_root,
		/datum/action/innate/abnormality_attack/ebony_barrier,
		/datum/action/innate/abnormality_attack/ebony_barrage,
		/datum/action/cooldown/ebony_burst,
	)

	update_qliphoth_chance = 50

/datum/action/innate/abnormality_attack/ebony_root
	name = "Root Spike"
	button_icon_state = "ebony_root"
	chosen_message = span_colossus("You will now shoot your roots from the ground.")
	chosen_attack_num = 1

/datum/action/innate/abnormality_attack/ebony_barrier
	name = "Thorn Barrier"
	button_icon_state = "ebony_barrier"
	chosen_message = span_colossus("You will now create a barrier of thorns.")
	chosen_attack_num = 2

/datum/action/innate/abnormality_attack/ebony_barrage
	name = "Root Barrage"
	button_icon_state = "ebony_barrage"
	chosen_message = span_colossus("You will now shoot a devastating line of roots.")
	chosen_attack_num = 3

/datum/action/cooldown/ebony_burst
	name = "Thorn Burst"
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	button_icon_state = "ebony_burst"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = 10 SECONDS

/datum/action/cooldown/ebony_burst/Trigger(trigger_flags, atom/target)
	if(!..())
		return FALSE
	var/mob/living/simple_animal/hostile/abnormality/ebony_queen/EQ = owner
	if(!istype(EQ))
		return FALSE
	if(EQ.barrier_cooldown > world.time || !EQ.can_act)
		return FALSE
	StartCooldown()
	EQ.thornBurst()
	return TRUE

/mob/living/simple_animal/hostile/abnormality/ebony_queen/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(TryTeleport)), 5)

/mob/living/simple_animal/hostile/abnormality/ebony_queen/Move()
	if(!can_act)
		return
	return ..()

/mob/living/simple_animal/hostile/abnormality/ebony_queen/Goto(target, delay, minimum_distance)
	if(!can_act)
		return
	return ..()

/mob/living/simple_animal/hostile/abnormality/ebony_queen/MoveToTarget(list/possible_targets)
	if(!can_act)
		return TRUE
	return ..()

/mob/living/simple_animal/hostile/abnormality/ebony_queen/DestroySurroundings()
	if(!can_act)
		return
	return ..()

/mob/living/simple_animal/hostile/abnormality/ebony_queen/death(gibbed)
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/abno_cores/waw.dmi'
	density = FALSE
	animate(src, alpha = 0, time = 5 SECONDS)
	QDEL_IN(src, 5 SECONDS)
	..()

	//Simple behaviors
/mob/living/simple_animal/hostile/abnormality/ebony_queen/proc/TryTeleport() //stolen from knight of despair
	if(!can_act)
		return
	var/list/teleport_potential = list()
	for(var/turf/T in GLOB.generic_event_spawns)
		teleport_potential += T
	if(!LAZYLEN(teleport_potential))
		return FALSE
	can_act = FALSE
	var/turf/teleport_target = pick(teleport_potential)
	new /obj/effect/temp_visual/guardian/phase(get_turf(src))
	new /obj/effect/temp_visual/guardian/phase/out(teleport_target)
	animate(src, alpha = 0, time = 5, easing = EASE_OUT)
	SLEEP_CHECK_DEATH(1, src)
	visible_message(span_boldwarning("[src] fades out!"))
	density = FALSE
	SLEEP_CHECK_DEATH(4, src)
	forceMove(teleport_target)
	var/area/A = get_area(teleport_target)
	show_global_blurb(6 SECONDS, "Аномальная активность обнаружена в [A.name]", 2 SECONDS, "white", "black", "left", around_player)
	SLEEP_CHECK_DEATH(1, src)
	animate(src, alpha = 255, time = 5, easing = EASE_IN)
	SLEEP_CHECK_DEATH(1, src)
	density = TRUE
	visible_message(span_boldwarning("[src] fades in!"))
	SLEEP_CHECK_DEATH(4, src)
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/ebony_queen/AttackingTarget(atom/attacked_target)
	if(!can_act)
		return

	if(!target)
		GiveTarget(attacked_target)

	if(client)
		OpenFire()
		return

	if(attacked_target) // You'd think this should be "attacked_target" but no this shit still uses target I hate it. // Now uses attacked_target I love it.
		if(ismecha(attacked_target))
			if(burst_cooldown <= world.time && prob(50))
				thornBurst()
			else
				OpenFire()
			return
		else if(isliving(attacked_target))
			var/mob/living/L = attacked_target
			if(L.stat != DEAD)
				if(burst_cooldown <= world.time && prob(50))
					thornBurst()
				else
					OpenFire()
			return
	return ..()

/mob/living/simple_animal/hostile/abnormality/ebony_queen/OpenFire()
	if(!can_act)
		return

	ranged_cooldown = world.time + ranged_cooldown_time

	if(client)
		switch(chosen_attack)
			if(1)
				rootStab(target)
			if(2)
				thornBarrier(target)
			if(3)
				rootBarrage(target)
		return

	if((barrage_cooldown <= world.time) && get_dist(src, target) >= 2 && prob(50))
		rootBarrage(target)
	else if((barrier_cooldown <= world.time) && prob(50))
		thornBarrier(target)
	else
		rootStab(target)
	return

	//Effects
/obj/effect/temp_visual/thornspike
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects32x48.dmi'
	icon_state = "thornspike"
	duration = 8
	randomdir = TRUE //random spike appearance
	layer = ABOVE_MOB_LAYER

/obj/effect/temp_visual/root
	name = "pale stem"
	desc = "A target warning you of incoming pain"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	icon_state = "vines"
	duration = 6
	layer = RIPPLE_LAYER	//We want this HIGH. SUPER HIGH. We want it so that you can absolutely, guaranteed, see exactly what is about to hit you.
	var/root_damage = 65 //Black Damage
	var/mob/living/caster //who made this, anyway

/obj/effect/temp_visual/root/Initialize(mapload, new_caster)
	. = ..()
	if(new_caster)
		caster = new_caster
	addtimer(CALLBACK(src, PROC_REF(explode)), 0.5 SECONDS)

/obj/effect/temp_visual/root/proc/explode()
	var/turf/target_turf = get_turf(src)
	if(!target_turf)
		return
	if(QDELETED(caster) || caster?.stat == DEAD || !caster)
		return
	playsound(target_turf, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ebonyqueen/attack.ogg', 40, 0, 8)
	new /obj/effect/temp_visual/thornspike(target_turf)
	var/list/hit = caster.HurtInTurf(target_turf, list(), damage = root_damage, damage_type = BRUTE, check_faction = TRUE, hurt_mechs = TRUE, mech_damage = root_damage/2)
	for(var/mob/living/L in hit)
		if(L.stat == DEAD || L.throwing)
			continue
		L.visible_message(span_userdanger("[src] knocks [L] away!"), span_userdanger("[src] knocks you away!"))
		var/turf/thrownat = get_ranged_target_turf(src, pick(GLOB.alldirs), 2)
		L.throw_at(thrownat, 1, 1, spin = TRUE, force = MOVE_FORCE_OVERPOWERING, gentle = TRUE)
	for(var/obj/vehicle/sealed/mecha/M in hit) //also damage mechs.
		for(var/O in M.occupants)
			var/mob/living/occupant = O
			to_chat(occupant, span_userdanger("Your [M.name] is struck by [src]!"))
	qdel(src)

	//Special attacks; there are four of them
/mob/living/simple_animal/hostile/abnormality/ebony_queen/proc/rootStab(atom/attack_target) //single target
	if(!can_act)
		return
	can_act = FALSE
	playsound(get_turf(src), 'sound/mobs/non-humanoids/venus_trap/venus_trap_hurt.ogg', 75, 0, 5)
	icon_state = "ebonyqueen_attack2"
	var/turf/T = get_turf(attack_target)
	SLEEP_CHECK_DEATH(1, src)
	new /obj/effect/temp_visual/root(T, src)
	SLEEP_CHECK_DEATH(4, src)
	icon_state = icon_living
	SLEEP_CHECK_DEATH(2, src)
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/ebony_queen/proc/thornBarrier(atom/attack_target) //barrier of thorns
	if(barrier_cooldown > world.time || !can_act)
		return
	barrier_cooldown = world.time + barrier_cooldown_time
	can_act = FALSE
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ebonyqueen/charge.ogg', 175, 0, 5) //very quiet sound file
	icon_state = "ebonyqueen_attack3"
	SLEEP_CHECK_DEATH(7.75, src)
	//check if target still exists after the sleep and bail if not
	if(QDELETED(attack_target))
		if(!client && FindTarget())
			attack_target = target
		else
			icon_state = icon_living
			SLEEP_CHECK_DEATH(3, src)
			can_act = TRUE
			return
	var/turf/target_turf = get_turf(attack_target)
	SLEEP_CHECK_DEATH(0.25, src) //slight offset
	for(var/turf/T in RANGE_TURFS(1, target_turf))
		new /obj/effect/temp_visual/root(T, src)
	SLEEP_CHECK_DEATH(7, src)
	icon_state = icon_living
	SLEEP_CHECK_DEATH(3, src)
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/ebony_queen/proc/thornBurst() //expanding square in melee
	if(burst_cooldown > world.time || !can_act)
		return
	burst_cooldown = world.time + burst_cooldown_time
	can_act = FALSE
	var/turf/origin = get_turf(src)
	playsound(origin, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ebonyqueen/strongcharge.ogg', 75, 0, 5)
	playsound(origin, 'sound/mobs/non-humanoids/venus_trap/venus_trap_hurt.ogg', 75, 0, 5)
	icon_state = "ebonyqueen_attack4"
	SLEEP_CHECK_DEATH(9, src)
	var/last_dist = 0
	for(var/turf/T in spiral_range_turfs(2, origin))
		if(!T)
			continue
		var/dist = get_dist(origin, T)
		if(dist > last_dist)
			last_dist = dist
			SLEEP_CHECK_DEATH(1 + min(2 - last_dist, 12) * 0.25, src) //gets faster as it gets further out
		new /obj/effect/temp_visual/root(T, src)
	SLEEP_CHECK_DEATH(8, src)
	icon_state = icon_living
	SLEEP_CHECK_DEATH(3, src)
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/ebony_queen/proc/rootBarrage(atom/attack_target) //line attack
	if(barrage_cooldown > world.time || !can_act)
		return
	barrage_cooldown = world.time + barrage_cooldown_time
	can_act = FALSE
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ebonyqueen/strongcharge.ogg', 75, 0, 5)
	icon_state = "ebonyqueen_attack1"
	SLEEP_CHECK_DEATH(7, src)
	//check if target still exists after the sleep and bail if not
	if(QDELETED(attack_target))
		if(!client && FindTarget())
			attack_target = target
		else
			icon_state = icon_living
			SLEEP_CHECK_DEATH(3, src)
			can_act = TRUE
			return

	var/turf/target_turf = get_ranged_target_turf_direct(src, attack_target, barrage_range)
	var/count = 0
	for(var/turf/T in get_line(get_turf(src), target_turf))
		if(T.density)
			break
		count = count + 1
		if(get_dist(src, T) < 2)
			continue
		addtimer(CALLBACK(src, PROC_REF(stabHit), T), (3 * ((count*0.50)+1)) + 0.25 SECONDS)
	SLEEP_CHECK_DEATH(10, src)
	icon_state = icon_living
	SLEEP_CHECK_DEATH(3, src)
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/ebony_queen/proc/stabHit(turf/T)
	if(QDELETED(src) || stat == DEAD)
		return
	new /obj/effect/temp_visual/root(T, src)
