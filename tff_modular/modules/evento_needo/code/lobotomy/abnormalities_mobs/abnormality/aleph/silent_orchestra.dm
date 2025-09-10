/mob/living/simple_animal/hostile/abnormality/silentorchestra
	name = "The Silent Orchestra"
	desc = "From break and ruin, the most beautiful performance begins."
	health = 4000
	maxHealth = 4000
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "silent"
	icon_living = "silent"
	damage_coeff = list(BURN = 0, BRAIN = 0, BRUTE = 0, TOX = 0)
	can_breach = TRUE
	fear_level = ALEPH_LEVEL
	good_hater = TRUE
	wander = FALSE

	wander = FALSE
	light_color = COLOR_VERY_LIGHT_GRAY
	light_range = 7
	light_power = 2

	ego_list = list(
		/datum/ego_datum/weapon/da_capo,
		/datum/ego_datum/armor/da_capo,
	)
	gift_type =  /datum/ego_gifts/dacapo
	observation_prompt = "I was the conductor of Lobotomy Corporation, I put my everything into it. <br>\
		Now, I conduct the song of apocalypse to make everything right. <br>As if he is about to start the performance, he stretches his arm. <br>\
		The conductor, who thought he is the freest soul, was not free at all. <br>The performance ended. <br>I......."


	/// Range of the damage
	var/symphony_range = 20
	/// Amount of white damage every tick
	var/symphony_damage = 10
	/// When to perform next movement
	var/next_movement_time
	/// Current movement
	var/current_movement_num = -1
	/// List of effects currently spawned
	var/list/performers = list()

/mob/living/simple_animal/hostile/abnormality/silentorchestra/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/silentorchestra/Life()
	. = ..()
	if(!.) // Dead
		return FALSE
	if(!(HAS_TRAIT(src, TRAIT_GODMODE)))
		DamagePulse()

/mob/living/simple_animal/hostile/abnormality/silentorchestra/Destroy()
	for(var/obj/effect/silent_orchestra_singer/O in performers)
		O.fade_out()
	performers.Cut()
	return ..()

/mob/living/simple_animal/hostile/abnormality/silentorchestra/CanAttack(atom/the_target)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/silentorchestra/proc/DamagePulse()
	if(current_movement_num < 5)
		for(var/mob/living/L in view(symphony_range, get_turf(src)))
			if(L.z != z)
				continue
			if(faction_check_atom(L))
				continue
			var/dealt_damage = max(6, symphony_damage - round(get_dist(src, L) * 0.1))
			L.apply_damage(dealt_damage, BRUTE)

	if(world.time >= next_movement_time) // Next movement
		current_movement_num += 1
		symphony_range += 5
		switch(current_movement_num)
			if(0)
				next_movement_time = world.time + 4 SECONDS
			if(1)
				next_movement_time = world.time + 22 SECONDS
				ChangeResistances(list(BRUTE = 1))
				spawn_performer(1, WEST)
			if(2)
				next_movement_time = world.time + 14.5 SECONDS
				ChangeResistances(list(BRUTE = 1, BRUTE = 0))
				spawn_performer(2, WEST)
			if(3)
				next_movement_time = world.time + 11.5 SECONDS
				ChangeResistances(list(BRUTE = 1, BRUTE = 0))
				symphony_damage = 18
				spawn_performer(1, EAST)
			if(4)
				next_movement_time = world.time + 23 SECONDS
				ChangeResistances(list(BRUTE = 1, BRUTE = 0))
				symphony_damage = 12
				spawn_performer(2, EAST)
			if(5)
				next_movement_time = world.time + 999 SECONDS // Never
				ChangeResistances(list(BRUTE = 0))
		if(current_movement_num < 6)
			sound_to_playing_players(sound("tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/silentorchestra/movement[current_movement_num].ogg"))
			if(current_movement_num == 5)
				for(var/mob/living/carbon/human/H in view(symphony_range, get_turf(src)))
					if(H.sanity_lost || (H.sanityhealth < H.maxSanity * 0.5))
						var/obj/item/bodypart/head/head = H.get_bodypart("head")
						if(QDELETED(head))
							continue
						head.dismember()
						QDEL_NULL(head)
						H.regenerate_icons()
						H.visible_message(span_danger("[H]'s head explodes!"))
						new /obj/effect/gibspawner/generic/silent(get_turf(H))
						playsound(get_turf(H), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/silentorchestra/headbomb.ogg', 50, 1)
				addtimer(CALLBACK(src, PROC_REF(DamagePulse_end)), 4 SECONDS)
/mob/living/simple_animal/hostile/abnormality/silentorchestra/proc/DamagePulse_end()
	animate(src, alpha = 0, time = 2 SECONDS)
	QDEL_IN(src, 2 SECONDS)

/mob/living/simple_animal/hostile/abnormality/silentorchestra/proc/spawn_performer(distance = 1, direction = EAST)
	var/turf/T = get_turf(src)
	for(var/i = 1 to distance)
		T = get_step(T, direction)
	var/obj/effect/silent_orchestra_singer/O = new(T)
	var/performer_icon_num = clamp(current_movement_num, 1, 4)
	O.icon_state = "silent_[performer_icon_num]"
	O.update_icon()
	performers += O
	return

/mob/living/simple_animal/hostile/abnormality/silentorchestra/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	var/turf/T = get_turf(pick(GLOB.start_landmarks_list))
	forceMove(T)
	DamagePulse()
	return

