//Gold Midnight - Extreme area white and pale damage, breaching
/mob/living/simple_animal/hostile/ordeal/tso_corrosion
	name = "Da Capo Al Fine"
	desc = "Improper use of E.G.O. can have serious consequences."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64.dmi'
	icon_state = "al_fine"
	icon_living = "al_fine"
	icon_dead = "al_fine_dead"
	faction = list("gold_ordeal")
	maxHealth = 3000 //it's a boss, more or less
	health = 3000
	death_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/limbus_death.ogg'
	damage_coeff = list(BURN = 0.2, BRAIN = 0.2, BRUTE = 0.2, TOX = 0.2)
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

/mob/living/simple_animal/hostile/ordeal/tso_corrosion/Initialize(mapload)
	show_global_blurb(5 SECONDS, "Выступление начинается в [get_area_name(src)]", 3 SECONDS)
	return ..()

/mob/living/simple_animal/hostile/ordeal/tso_corrosion/Move()
	return FALSE

/mob/living/simple_animal/hostile/ordeal/tso_corrosion/Life()
	. = ..()
	if(!.) // Dead
		return FALSE
	if(!(HAS_TRAIT(src, TRAIT_GODMODE)))
		DamagePulse()

/mob/living/simple_animal/hostile/ordeal/tso_corrosion/death(gibbed)
	for(var/obj/effect/silent_orchestra_singer/O in performers)
		O.fade_out()
	performers.Cut()
	return ..()

/mob/living/simple_animal/hostile/ordeal/tso_corrosion/Destroy() // in case it somehow gets deleted
	for(var/obj/effect/silent_orchestra_singer/O in performers)
		O.fade_out()
	performers.Cut()
	return ..()

/mob/living/simple_animal/hostile/ordeal/tso_corrosion/CanAttack(atom/the_target)
	return FALSE

/mob/living/simple_animal/hostile/ordeal/tso_corrosion/proc/DamagePulse()
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
				ChangeResistances(list(BRUTE = 1))
				spawn_performer(2, WEST)
			if(3)
				next_movement_time = world.time + 11.5 SECONDS
				ChangeResistances(list(BRUTE = 1))
				symphony_damage = 18
				spawn_performer(1, EAST)
			if(4)
				next_movement_time = world.time + 23 SECONDS
				ChangeResistances(list(BRUTE = 1, BRUTE = 0))
				symphony_damage = 12
				spawn_performer(2, EAST)
			if(5)
				next_movement_time = world.time + 80 SECONDS
				ChangeResistances(list(BURN = 0, BRAIN = 0, BRUTE = 0, TOX = 0))
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
				ChangeResistances(list(BURN = 0.2, BRAIN = 0.2, BRUTE = 0.2, TOX = 0.2))
				addtimer(CALLBACK(src, PROC_REF(DamagePulse_second)), 60 SECONDS)

/mob/living/simple_animal/hostile/ordeal/tso_corrosion/proc/DamagePulse_second()
	current_movement_num = -1
	for(var/obj/effect/silent_orchestra_singer/O in performers)
		O.fade_out()
	performers.Cut()
	animate(src, alpha = 0, time = 2 SECONDS)
	QDEL_IN(src, 2 SECONDS)

/mob/living/simple_animal/hostile/ordeal/tso_corrosion/proc/spawn_performer(distance = 1, direction = EAST)
	var/turf/T = get_turf(src)
	for(var/i = 1 to distance)
		T = get_step(T, direction)
	var/obj/effect/silent_orchestra_singer/O = new(T)
	var/performer_icon_num = clamp(current_movement_num, 1, 4)
	O.icon_state = "silent_[performer_icon_num]"
	O.update_icon()
	performers += O
	return
