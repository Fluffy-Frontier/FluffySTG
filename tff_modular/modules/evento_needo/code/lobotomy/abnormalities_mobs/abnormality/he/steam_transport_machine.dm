/mob/living/simple_animal/hostile/abnormality/steam
	name = "Steam Transport Machine"
	desc = "A bipedal, steam-powered automaton made of a brown, wood-like material with brass edges."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "steam"
	icon_living = "steam"
	icon_dead = "steammachine_egg"
	del_on_death = FALSE
	maxHealth = 1600
	health = 1600
	blood_volume = 0
	ranged = TRUE
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/steam/attack.ogg'
	friendly_verb_continuous = "bonks"
	friendly_verb_simple = "bonk"
	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	damage_coeff = list(BURN = 0.5, BRAIN = 1, BRUTE = 2, TOX = 1.5)
	speak_emote = list("bellows")
	speech_span = SPAN_ROBOT
	pixel_x = -16
	can_breach = TRUE
	rapid_melee = 1
	melee_queue_distance = 2
	move_to_delay = 5
	melee_damage_lower = 20
	melee_damage_upper = 35
	melee_damage_type = BRUTE
	fear_level = HE_LEVEL
	ranged = TRUE
	rapid = 5
	rapid_fire_delay = 1
	ranged_cooldown_time = 50
	projectiletype = /obj/projectile/steam
	projectilesound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/steam/steamfire.ogg'

	ego_list = list(
		/datum/ego_datum/weapon/nixie,
		/datum/ego_datum/armor/nixie,
	)
	gift_type =  /datum/ego_gifts/nixie
	observation_prompt = "It carries heavy objects without a word. <br>\
		As it does its work, the number on the electronic display seems to update. <br>\
		Machines exist for a purpose. <br>\
		You feel like you should give it an order."


	var/gear = 0
	var/steam_damage = 5
	var/steam_venting = FALSE
	var/can_act = TRUE
	var/guntimer
	var/updatetimer

//Gear Shift - Most mechanics are determined by round time
/mob/living/simple_animal/hostile/abnormality/steam/proc/GearUpdate()
	var/new_gear = gear
	var/facility_full_percentage = 0
	if(SSabnormality_queue.spawned_abnos) // dont divide by 0
		facility_full_percentage = 100 * (SSabnormality_queue.spawned_abnos / SSabnormality_queue.rooms_start)
	// how full the facility is, from 0 abnormalities out of 24 cells being 0% and 24/24 cells being 100%
	switch(facility_full_percentage)
		if(0 to 49) // Expecting Hes and Teths still
			new_gear = 1
		if(50 to 69)  // Expecting WAW
			new_gear = 1
		if(70 to 79) // Wowzer, an ALEPH?
			new_gear = 2
		if(80 to 99) // More than one ALEPH
			new_gear = 3
		if(100) // Full facility expected
			new_gear = 4
	if(gear != new_gear)
		gear = new_gear
		ClankSound()
		UpdateStats()
	if(gear < 4)
		updatetimer = addtimer(CALLBACK(src, PROC_REF(GearUpdate)), 1 MINUTES, TIMER_STOPPABLE) //Let's just call this every minute
	return

/mob/living/simple_animal/hostile/abnormality/steam/proc/ClankSound()
	set waitfor = FALSE
	playsound(src.loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clock/clank.ogg', 75, TRUE)
	SLEEP_CHECK_DEATH(10, src)
	playsound(src.loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clock/turn_on.ogg', 75, TRUE)

/mob/living/simple_animal/hostile/abnormality/steam/proc/UpdateStats()
	src.set_light(3, (gear * 2), "D4FAF37")
	ChangeResistances(list(
		BURN  = (0.5 - (gear * 0.1)),
		BRAIN = (1 - (gear * 0.1)),
		BRUTE = (2 - (gear * 0.1)),
		TOX = (1.5 - (gear * 0.1)),
	))
	melee_damage_lower = (20 + (10 * gear))
	melee_damage_upper = (35 + (10 * gear))
	steam_damage = (5 + (3 * gear))
	var/oldhealth = maxHealth
	maxHealth = (1600 + (400 * gear))
	adjustBruteLoss(oldhealth - maxHealth) //Heals 400 health in a gear shift if it's already breached
	ranged_cooldown_time = (40 - (5 * gear))
	if(datum_reference.qliphoth_meter == 4)
		qliphoth_change(-min(gear,3))
	else
		qliphoth_change(-1)

/mob/living/simple_animal/hostile/abnormality/steam/PostSpawn()
	. = ..()
	GearUpdate()

/mob/living/simple_animal/hostile/abnormality/steam/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/steam/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(prob(50))
		qliphoth_change(-1)
	return

//Breach
/mob/living/simple_animal/hostile/abnormality/steam/Life()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return
	if(!steam_venting)
		return
	SpawnSteam() //Periodically spews out damaging fog while breaching

/mob/living/simple_animal/hostile/abnormality/steam/proc/SpawnSteam()
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/steam/exhale.ogg', 75, 0, 8)
	var/turf/target_turf = get_turf(src)
	for(var/turf/T in view(2, target_turf))
		if(prob(30))
			continue
		new /obj/effect/temp_visual/palefog(T)
		for(var/mob/living/H in T)
			if(faction_check_atom(H))
				continue
			H.apply_damage(steam_damage, BRUTE)
	adjustBruteLoss(10) //Take some damage every time steam is vented

/mob/living/simple_animal/hostile/abnormality/steam/apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, attack_direction, attacking_item, exposed_wound_bonus)
	. = ..()
	if(steam_venting)
		return
	if(health <= (maxHealth * 0.3))
		steam_venting = TRUE
		visible_message(span_warning("[src]'s engine explodes!"), span_boldwarning("Your steam engine malfunctions!"))
		new /obj/effect/temp_visual/explosion(get_turf(src))
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/scorchedgirl/explosion.ogg', 50, FALSE, 8)
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/steam/steambreak.ogg', 125, FALSE)
		rapid = 3

/mob/living/simple_animal/hostile/abnormality/steam/Move()
	if(!can_act)
		return FALSE
	..()

/mob/living/simple_animal/hostile/abnormality/steam/AttackingTarget()
	if(!can_act)
		return FALSE
	..()

/mob/living/simple_animal/hostile/abnormality/steam/OpenFire()
	if(get_dist(src, target) > 4)
		return
	. = ..()
	can_act = FALSE
	guntimer = addtimer(CALLBACK(src, PROC_REF(startMoving)), (10), TIMER_STOPPABLE)

/mob/living/simple_animal/hostile/abnormality/steam/proc/startMoving()
	can_act = TRUE
	deltimer(guntimer)

/mob/living/simple_animal/hostile/abnormality/steam/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	if(!(HAS_TRAIT(src, TRAIT_GODMODE))) // Whitaker nerf
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/steam/step.ogg', 50, 1)

/mob/living/simple_animal/hostile/abnormality/steam/death(gibbed)
	. = ..()
	if(guntimer)
		deltimer(guntimer)
	if(updatetimer)
		deltimer(updatetimer)
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/abno_cores/he.dmi'
	pixel_x = -16
	density = FALSE
	animate(src, alpha = 0, time = 10 SECONDS)
	QDEL_IN(src, 10 SECONDS)

/obj/projectile/steam
	name = "steam"
	icon_state = "smoke"
	hitsound = 'sound/machines/clockcult/steam_whoosh.ogg'
	damage = 4
	speed = 0.4
	damage_type = BRUTE
