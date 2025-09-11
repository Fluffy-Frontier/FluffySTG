/mob/living/simple_animal/hostile/abnormality/space_lady
	name = "Lady out of Space"
	desc = "A humanoid abnormality. It looks extremely pale."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "space"
	icon_living = "space"
	del_on_death = TRUE
	maxHealth = 3200
	health = 3200
	damage_coeff = list(BURN = 0.7, BRAIN = 0, BRUTE = 0, TOX = 1)
	faction = list("hostile")
	can_breach = TRUE
	fear_level = ALEPH_LEVEL
	retreat_distance = 3
	minimum_distance = 3
	ego_list = list(
		/datum/ego_datum/weapon/space,
		/datum/ego_datum/armor/space,
	)
	gift_type =  /datum/ego_gifts/space
	ranged = TRUE
	minimum_distance = 3
	retreat_distance = 3
	ranged_cooldown_time = 3 SECONDS

	observation_prompt = "What touched this place cannot be quantified or understood by human science. <br>It was just a color out of space. <br>\
		It exists on the border of our waking minds, where darkness and light are one, and time and space do not intersect. <br>She has a message, from another place, another time."


	var/explosion_timer = 2 SECONDS
	var/explosion_state = 3
	var/explosion_damage = 100
	var/can_act = TRUE
	var/negative_range = 10
	update_qliphoth = 0
	neutral_chance = 30

//She can't move or attack.
/mob/living/simple_animal/hostile/abnormality/space_lady/Move()
	if(!can_act)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/space_lady/AttackingTarget(atom/attacked_target)
	if(!target)
		GiveTarget(attacked_target)
	OpenFire()
	return

/mob/living/simple_animal/hostile/abnormality/space_lady/OpenFire()
	if(!can_act)
		return

	switch(rand(1, 100))
		if(1 to 10)
			SpellBinder()

		if(10 to 20)
			addtimer(CALLBACK(src, PROC_REF(ExplodeTimer)), explosion_timer*2)
			can_act = FALSE

		if(20 to 30)
			NegativeField()

		if(30 to 40)
			Timestop()

		if(40 to 50)
			BulletTime()

		else
			if(prob(50))
				projectiletype = /obj/projectile/white_hole
			else
				projectiletype = /obj/projectile/black_hole
	..()

//Teleporting and exploding
/mob/living/simple_animal/hostile/abnormality/space_lady/proc/ExplodeTimer()
	say("[explosion_state]...")
	explosion_state -=1

	if (explosion_state == 0)
		explosion_state = initial(explosion_state)
		icon_state = "space_attack"
		addtimer(CALLBACK(src, PROC_REF(Explode)), 15)
	else
		addtimer(CALLBACK(src, PROC_REF(ExplodeTimer)), explosion_timer)

/mob/living/simple_animal/hostile/abnormality/space_lady/proc/Explode()
	//Black hole effect
	goonchem_vortex(get_turf(src), 0, 13)
	for(var/turf/T in view(14, src))
		if(T.density)
			continue
		new /obj/effect/temp_visual/revenant(T)
		for(var/mob/living/carbon/human/L in T)
			L.apply_damage(explosion_damage, BRUTE)
	SLEEP_CHECK_DEATH(10, src)	//I kinda want it to be a bit of a delay but not too much

	//White Hole effect
	for(var/mob/living/carbon/human/L in view(14, src))
		L.apply_damage(explosion_damage, BRUTE)
	goonchem_vortex(get_turf(src), 1, 13)
	can_act = TRUE
	Teleport()

/mob/living/simple_animal/hostile/abnormality/space_lady/proc/Teleport()
	icon_state = "space_teleport"
	var/turf/T = get_turf(pick(GLOB.generic_event_spawns))
	forceMove(T)
	var/area/A = get_area(T)
	show_global_blurb(6 SECONDS, "Аномальная активность обнаружена в [A.name]", 2 SECONDS, "white", "black", "left", around_player)

//Inverts Sanity, kills the insane
/mob/living/simple_animal/hostile/abnormality/space_lady/proc/NegativeField()
	say("Ashes to ashes...")
	can_act = FALSE
	SLEEP_CHECK_DEATH(25, src)
	var/turf/orgin = get_turf(src)
	var/list/all_turfs = RANGE_TURFS(negative_range, orgin)
	for(var/i = 0 to negative_range)
		playsound(src, 'sound/items/weapons/guillotine.ogg', 75, FALSE, 4)
		for(var/turf/T in all_turfs)
			if(get_dist(orgin, T) > i)
				continue
			new /obj/effect/temp_visual/negativelook(T)
			for(var/mob/living/carbon/human/L in T)
				if(L.sanity_lost)					//DIE FOOL. LADY BLAST
					L.death()
				var/sanity_holder = L.sanityhealth	//Hold your current sanity
				L.adjustSanityLoss(-20000) 			//bring you back to full sanity
				L.adjustSanityLoss(sanity_holder)	//and then deal damage equal to your sanity before this attack

			all_turfs -= T
		SLEEP_CHECK_DEATH(3, src)
	can_act = TRUE

//Time stop
/mob/living/simple_animal/hostile/abnormality/space_lady/proc/Timestop()
	say("Stop...")
	can_act = FALSE
	SLEEP_CHECK_DEATH(12, src)
	new /obj/effect/timestop(get_turf(src), 3, 40, list(src))
	can_act = TRUE

//Bouncing bullets
/mob/living/simple_animal/hostile/abnormality/space_lady/proc/BulletTime()
	say("Hold it...")
	can_act = FALSE
	SLEEP_CHECK_DEATH(6, src)

	//Will look into giving it a unique attack
	var/turf/startloc = get_turf(targets_from)
	for(var/i = 1 to 15)
		var/obj/projectile/loos_bullet/black/P = new(get_turf(src))
		P.starting = startloc
		P.firer = src
		P.fired_from = src
		P.yo = target.y - startloc.y
		P.xo = target.x - startloc.x
		P.original = target
		P.set_angle(get_angle(src, target))
		P.fire()

	SLEEP_CHECK_DEATH(10, src)
	can_act = TRUE

//based off a touhou attack of the same name, I need to actually finish it.
/mob/living/simple_animal/hostile/abnormality/space_lady/proc/SpellBinder()
	say("Spellbinding circle...")
	can_act = FALSE
	var/turf/orgin = get_turf(src)
	var/list/all_turfs = RANGE_TURFS(negative_range, orgin)
	playsound(src, 'sound/items/weapons/guillotine.ogg', 75, FALSE, 4)
	for(var/turf/T in all_turfs)
		if(get_dist(orgin, T) != 6)
			continue
		new /obj/effect/temp_visual/negativelook/spellbinder(T)
		all_turfs -= T
	SLEEP_CHECK_DEATH(3, src)

	//Will look into giving it a unique attack
	var/turf/startloc = get_turf(targets_from)
	for(var/i = 1 to 15)
		var/obj/projectile/loos_bullet/P = new(get_turf(src))
		P.starting = startloc
		P.firer = src
		P.fired_from = src
		P.yo = target.y - startloc.y
		P.xo = target.x - startloc.x
		P.original = target
		P.set_angle(get_angle(src, target))
		P.fire()

	SLEEP_CHECK_DEATH(10, src)

	for(var/turf/T in all_turfs)
		if(get_dist(orgin, T) != 3)
			continue
		new /obj/effect/temp_visual/negativelook/spellbinder(T)

	SLEEP_CHECK_DEATH(20, src)

	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/space_lady/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_clothing_class_level(user.get_major_clothing_class()) < 5)
		qliphoth_change(-1)
	if(user.get_clothing_class_level(user.get_major_clothing_class()) < 4)
		qliphoth_change(-1)
	return ..()

/mob/living/simple_animal/hostile/abnormality/space_lady/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if(user.get_clothing_class_level(user.get_major_clothing_class()) < 3)
		qliphoth_change(-1)
		animate(user, transform = user.transform*0.01, time = 5)
		QDEL_IN(user, 5)
	return TRUE

/mob/living/simple_animal/hostile/abnormality/space_lady/FailureEffect(mob/living/carbon/human/user)
	//two chances to lower by 1
	if(prob(50))
		qliphoth_change(-1)
	if(prob(50))
		qliphoth_change(-1)

	return

/mob/living/simple_animal/hostile/abnormality/space_lady/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/space_lady/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	Teleport()


//Bullets
/obj/projectile/white_hole
	name = "miniature white hole"
	icon_state = "antimagic"
	desc = "A mini white hole."
	nodamage = TRUE
	hitsound = "sound/effects/footstep/slime1.ogg"
	speed = 3

/obj/projectile/white_hole/on_hit(target, blocked, pierce_hit)
	goonchem_vortex(get_turf(src), 1, 5)
	for(var/turf/T in view(3, src))
		if(T.density)
			continue
		new /obj/effect/temp_visual/revenant(T)
		for(var/mob/living/carbon/human/L in T)
			L.apply_damage(100, BRUTE)
	return ..()

/obj/projectile/black_hole
	name = "miniature black hole"
	icon_state = "antimagic"
	desc = "A mini black hole."
	nodamage = TRUE
	hitsound = "sound/effects/footstep/slime1.ogg"
	color = COLOR_PURPLE
	speed = 3

/obj/projectile/black_hole/on_hit(target, blocked = FALSE, pierce_hit)
	goonchem_vortex(get_turf(src), 0, 5)
	for(var/turf/T in view(3, src))
		if(T.density)
			continue
		new /obj/effect/temp_visual/revenant(T)
		for(var/mob/living/carbon/human/L in T)
			L.apply_damage(100, BRUTE)
	return ..()

/obj/projectile/loos_bullet
	name = "white beam"
	icon_state = "whitelaser"
	desc = "A beam of white light."
	hitsound = "sound/effects/footstep/slime1.ogg"
	speed = 5		//very slow bullets
	damage = 40		//She fires a lot of them
	damage_type = BRUTE
	spread = 360	//Fires in a 360 Degree radius

	//Grabbed from Harmony, I do want it to act the same
	projectile_piercing  = ALL
	ricochets_max = 3
	ricochet_chance = 100 // JUST FUCKING DO IT
	ricochet_decay_chance = 1
	ricochet_decay_damage = 1.5 // Does MORE per bounce
	ricochet_auto_aim_range = 3
	ricochet_incidence_leeway = 0

/obj/projectile/loos_bullet/check_ricochet_flag(atom/A)
	if(istype(A, /obj/effect/temp_visual/negativelook/spellbinder))
		return TRUE
	return FALSE


/obj/projectile/loos_bullet/black
	name = "black beam"
	icon_state = "purplelaser"
	desc = "A beam of black light."
	damage_type = BRUTE

//Visual effects
/obj/effect/temp_visual/negativelook
	icon = 'icons/effects/atmospherics.dmi'
	icon_state = "antinoblium"
	duration = 6

/obj/effect/temp_visual/negativelook/spellbinder
	density = TRUE
	icon_state = "halon"
	duration = 20
