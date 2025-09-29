//Dream-Devouring Siltcurrent would be a breach that forces you to either try to kill it from it hitting the tubes or using the tubes to make you last longer.
//When out you're on a timer due to everyone on the floor it's on taking oxygen damage.
//Please don't make an Ikea shark alt skin for this-Crabby.
/mob/living/simple_animal/hostile/abnormality/siltcurrent
	name = "\proper Dream-Devouring Siltcurrent"
	desc = "An abnormality resembling a giant black and teal fish. \
	There's teal light tubes embedded in its body,"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96.dmi'
	icon_state = "siltcurrent"
	icon_living = "siltcurrent"
	icon_dead = "siltcurrent_egg"
	death_message = "coalesces into a primordial egg."
	del_on_death = FALSE
	pixel_x = -32
	base_pixel_x = -32
	move_to_delay = 3
	rapid_melee = 2
	melee_damage_lower = 25
	melee_damage_upper = 35
	melee_damage_type = BRUTE
	maxHealth = 2000
	health = 2000
	damage_coeff = list(BURN = 0.5, BRAIN = 0.5, BRUTE = 0.5, TOX = 0.5)
	stat_attack = HARD_CRIT
	death_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/dreamingcurrent/dead.ogg'
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/crimson/noon_bite.ogg'
	attack_verb_continuous = "chomps"
	attack_verb_simple = "chomps"
	light_color = COLOR_TEAL
	light_range = 4
	light_power = 5
	fear_level = WAW_LEVEL
	ranged = 1
	can_breach = TRUE
	wander = TRUE

	ego_list = list(
		/datum/ego_datum/weapon/abyssal_route,
		/datum/ego_datum/weapon/blind_obsession,
		/datum/ego_datum/armor/blind_obsession
		)
	gift_type = /datum/ego_gifts/blind_obsession
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/dreaming_current = 2,//both are heavily related
		/mob/living/simple_animal/hostile/abnormality/pisc_mermaid = 1.5//both are aquatic abormalities, do oxygen damage while breaching, have water turf in their chambers, and both of their themes are the inverse of the other.
	)

	observation_prompt = "\"Yes. The deep sea is a dark place. <br>\
		But at the end of that dark path is a light. <br>\
		Because there are things that shine in the dark there. <br>\
		Let's go there. <br>And we'll shine brighter than anything in that dark place. <br>\
		We were all abandoned, yes. <br>But we all had dreams, too. <br>Remember? <br>\
		Well, let's make our dreams come true. <br>Let's sink together into the depths.\" <br>\
		The dim fluorescent lights impaling the entity's back flicker."


	var/stunned = FALSE
	//Stuff relating to the dive attack
	var/diving = FALSE
	var/dive_cooldown
	var/dive_cooldown_time = 7.5 SECONDS
	var/dive_damage = 100
	//The amount of flotsams that should spawn in the hallways when it breaches
	var/tube_spawn_amount = 6
	var/list/spawned_flotsams = list()
	var/list/water = list()

	//PLAYABLES ATTACKS
	attack_action_types = list(/datum/action/innate/abnormality_attack/toggle/SiltcurrentDive)

// Player-Controlled code
/datum/action/innate/abnormality_attack/toggle/SiltcurrentDive
	name = "Toggle Blind Obsession"
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	button_icon_state = "_WAW"
	chosen_attack_num = 2
	chosen_message = span_colossus("You won't dive anymore.")
	button_icon_toggle_activated = "_WAW"
	toggle_attack_num = 1
	toggle_message = span_colossus("You will now dive while you attack.")
	button_icon_toggle_deactivated = "_WAW"

//Checks if it's stunned or doing the dive attack to prevent it from attacking or moving while in those 2 states since it would be silly.
/mob/living/simple_animal/hostile/abnormality/siltcurrent/Move()
	if(!IsContained())
		for(var/turf/open/T in oview(src, 10))
			if(!isturf(T) || isspaceturf(T))
				continue
			if(locate(/obj/effect/obsessing_water_effect) in T)
				continue
			if(locate(/turf/open/water) in T)//prevents silly situations where it spawns water on water which makes no sense.
				continue
			var/obj/effect/obsessing_water_effect/W = new(T)
			water += W
	if(diving || stunned)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/siltcurrent/Goto(target, delay, minimum_distance)
	if(diving || stunned)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/siltcurrent/CanAttack(atom/the_target)
	if(diving || stunned)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/siltcurrent/OpenFire()
	if(client)
		switch(chosen_attack)
			if(1)
				SiltDive(get_turf(target),TRUE)
		return
	if(!client)
		SiltDive(get_turf(target),TRUE)
		return

/mob/living/simple_animal/hostile/abnormality/siltcurrent/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(!IsContained())//Prevents you from just refilling your oxygen during work. Go heal dibshit.
		Refill(user)


/mob/living/simple_animal/hostile/abnormality/siltcurrent/bullet_act(obj/projectile/P)
	. = ..()
	if(!IsContained())
		Refill(P.firer)

//Less effective than attacking the flotsam but its another option in higher pop maps where flotsams are more farther away from each other.
/mob/living/simple_animal/hostile/abnormality/siltcurrent/proc/Refill(mob/living/attacker)
	attacker.adjustOxyLoss(-25, updating_health=TRUE, forced=TRUE)

/mob/living/simple_animal/hostile/abnormality/siltcurrent/proc/SiltDive(turf/target, damaging)
	if(diving || stunned)
		return
	if(get_dist(target, src) > 1 && dive_cooldown < world.time)
		dive_cooldown = world.time + dive_cooldown_time
		diving = TRUE
		var/hitflotsam = FALSE
		//icon_state = "current_prepare"
		SLEEP_CHECK_DEATH(0.4 SECONDS, src)
		animate(src, alpha = 1,pixel_x = -32, pixel_z = -32, time = 0.2 SECONDS)
		src.pixel_z = -32
		playsound(src, "tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/piscinemermaid/waterjump.ogg", 10, TRUE, 3)
		SLEEP_CHECK_DEATH(0.75 SECONDS, src)
		forceMove(target) //look out, someone is rushing you!
		playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bloodbath/Bloodbath_EyeOn.ogg', 50, FALSE, 4)
		animate(src, alpha = 255,pixel_x = -32, pixel_z = 32, time = 0.1 SECONDS)
		src.pixel_z = 0
		SLEEP_CHECK_DEATH(0.1 SECONDS, src)
		if(damaging)
			for(var/turf/T in view(2, src))
				var/obj/effect/temp_visual/small_smoke/halfsecond/smonk = new(T)
				smonk.color = COLOR_TEAL
				for(var/obj/structure/flotsam/F in T)
					if(F.broken)
						hitflotsam = TRUE
						Stunned()
						src.adjustBruteLoss(750)
						visible_message(span_boldwarning("[src] gets impaled on the Flotsam taking heavy damage!"))
						playsound(F, "sound/effects/hit_on_shattered_glass.ogg", 50, TRUE)
				for(var/mob/living/L in T)
					if (ishuman(L))
						if(hitflotsam)
							continue
						playsound(L, "tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/dreamingcurrent/bite.ogg", 50, TRUE)
						visible_message(span_boldwarning("[src] mauls through [L]!"))
						to_chat(L, span_userdanger("[src] mauls you!"))
						HurtInTurf(T, list(), dive_damage, BRUTE)
						if(L.health < 0 || L.stat == DEAD)
							L.gib(DROP_ALL_REMAINS)
		SLEEP_CHECK_DEATH(0.5 SECONDS, src)
		diving = FALSE

/mob/living/simple_animal/hostile/abnormality/siltcurrent/proc/Stunned()
	set waitfor = FALSE
	stunned = TRUE
	ChangeResistances(list(BURN = 1.5, BRAIN = 1.5, BRUTE = 1.5, TOX = 1.5))//You did it nows your chance to beat the shit out of it!
	SLEEP_CHECK_DEATH(12 SECONDS, src)
	stunned = FALSE
	ChangeResistances(list(BURN = 0.5, BRAIN = 0.5, BRUTE = 0.5, TOX = 0.5))

/mob/living/simple_animal/hostile/abnormality/dreaming_current/PostWorkEffect(mob/living/carbon/human/user)
	user.adjustOxyLoss(25, updating_health=TRUE, forced=TRUE)//haha drown.
	if(user.get_clothing_class_level(CLOTHING_ENGINEERING) < 3)
		user.adjustOxyLoss(25, updating_health=TRUE, forced=TRUE)//haha drown.
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/siltcurrent/FailureEffect(mob/living/carbon/human/user, work_type, pe)
	qliphoth_change(-1)
	user.adjustOxyLoss(25, updating_health=TRUE, forced=TRUE)//haha drown.
	if(user.oxyloss >= 50)//POWER GRINDER SPOTTED! MUST MAUL THE FUCK!
		qliphoth_change(-1)
		GiveTarget(user)
		SiltDive(get_turf(user),TRUE)
	return

/mob/living/simple_animal/hostile/abnormality/siltcurrent/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	icon_living = "current_breach"
	//icon_state = icon_living
	addtimer(CALLBACK(src, PROC_REF(OxygenLoss)), 5 SECONDS, TIMER_LOOP)
	for(var/mob/living/L in GLOB.player_list)//Spawns Flotsams in the halls and notifies people that it's out.
		if(L.z != z || L.stat >= HARD_CRIT)
			continue
		to_chat(L, span_userdanger("You feel water is entering the facility!"))
	var/list/spawn_turfs = GLOB.generic_event_spawns.Copy()
	for(var/i = 1 to (tube_spawn_amount))
		if(!LAZYLEN(spawn_turfs)) //if list empty, recopy xeno spawns
			spawn_turfs = GLOB.generic_event_spawns.Copy()
		var/X = pick_n_take(spawn_turfs)
		var/turf/T = get_turf(X)
		var/list/deployment_area = list()
		var/turf/deploy_spot = T //spot you are being deployed
		if(LAZYLEN(deployment_area)) //if deployment zone is empty just spawn at xeno spawn
			deploy_spot = pick_n_take(deployment_area)
		var/obj/structure/flotsam/F = new get_turf(deploy_spot)
		spawned_flotsams += F
		F.silt = src

/mob/living/simple_animal/hostile/abnormality/siltcurrent/proc/OxygenLoss()//While its alive all humans around it will lose oxygen.
	for(var/mob/living/carbon/human/H in oview(src, 20))//Used to be global but this should prevent it from being asinine when other abormalities are out
		playsound(H, "sound/effects/bubbles.ogg", 50, TRUE, 7)
		new /obj/effect/temp_visual/mermaid_drowning(get_turf(H))
		H.adjustOxyLoss(4, updating_health=TRUE, forced=TRUE)

/mob/living/simple_animal/hostile/abnormality/siltcurrent/death()
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/abno_cores/waw.dmi'
	pixel_x = -16
	base_pixel_x = -16
	density = FALSE
	animate(src, alpha = 0, time = 10 SECONDS)
	QDEL_IN(src, 10 SECONDS)
	for(var/obj/structure/flotsam/F in spawned_flotsams)
		QDEL_IN(F, rand(5) SECONDS)
		spawned_flotsams -= F
	for(var/obj/effect/obsessing_water_effect/W in water)
		QDEL_IN(W, rand(5) SECONDS)
		water -= W
	..()

/mob/living/simple_animal/hostile/abnormality/siltcurrent/PostSpawn()
	..()
	for(var/turf/open/T in range(1, src)) // fill its cell with water
		T.TerraformTurf(/turf/open/water, flags = CHANGETURF_INHERIT_AIR)

/obj/structure/flotsam
	name = "Flotsam"
	desc = "A pile of teal light tubes embedded into the floor."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x32.dmi'
	pixel_x = -16
	base_pixel_x = -16
	icon_state = "flotsam"
	var/icon_broken = "flotsam_dead"
	max_integrity = 750
	density = TRUE
	anchored = TRUE
	light_color = COLOR_TEAL
	light_range = 4
	light_power = 5
	var/mob/living/simple_animal/hostile/abnormality/siltcurrent/silt

/obj/structure/flotsam/attackby(obj/item/W, mob/user, params)
	. = ..()
	Refill(user)

/obj/structure/flotsam/bullet_act(obj/projectile/P)
	. = ..()
	Refill(P.firer)

/obj/structure/flotsam/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	. = ..()
	if(throwingdatum.thrower)
		Refill(throwingdatum.thrower)

/obj/structure/flotsam/proc/Refill(mob/living/attacker)
	attacker.adjustOxyLoss(-100, updating_health=TRUE, forced=TRUE)
	if(!silt.target && !(silt.diving || silt.stunned))
		silt.dive_cooldown = 0
		to_chat(attacker, span_userdanger("Something is approaching  you!"))
		silt.SiltDive(get_turf(attacker),FALSE)

/obj/effect/obsessing_water_effect
	name = "Obsessing water"
	desc = "A strange black and teal water"
	icon = 'icons/effects/water.dmi'
	icon_state = "wet_static"
	layer = 1.9//Prevents it from blocking bitter flora
	anchored = TRUE
	alpha = 100

/obj/effect/obsessing_water_effect/Initialize(mapload)
	QDEL_IN(src, 5 SECONDS)
	return ..()
