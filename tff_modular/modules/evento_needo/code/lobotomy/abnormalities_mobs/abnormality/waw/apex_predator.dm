/mob/living/simple_animal/hostile/abnormality/apex_predator
	name = "Apex Predator"
	desc = "An abnormality resembling a beaten up crash dummy."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "apex"
	icon_living = "apex"
	pixel_x = -16
	base_pixel_x = -16


	maxHealth = 1600
	health = 1600
	density = FALSE
	damage_coeff = list(BURN = 1, BRAIN = 0.2, BRUTE = 1, TOX = 1, BRUTE = 1)
	ranged = TRUE
	melee_damage_lower = 30
	melee_damage_upper = 40
	move_to_delay = 3

	melee_damage_type = BRUTE
	stat_attack = HARD_CRIT

	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fragment/attack.ogg'
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	faction = list("hostile")
	can_breach = TRUE
	fear_level = WAW_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/animalism,
		/datum/ego_datum/armor/animalism,
	)
	gift_type =  /datum/ego_gifts/animalism

	observation_prompt = "The crash test dummy stands at the corner of the room. <br>It swings its arms around with twitching, swaying motions. <br>\
		You're not sure if it's even able to understand you. <br>Despite being shaped like a human, there's no face to relate to. <br>No eyes to look at. <br>\
		Just the rough outline of a human. <br>\
		Is there even anything you can say to it?"


	var/revealed = TRUE
	var/can_act = TRUE
	var/backstab_damage = 200
	var/agent_status //Used for insanity

	var/jumping	//Used so it can only start one jump at once
	var/busy	//Can we move now?

	var/jump_cooldown
	var/jump_cooldown_time = 5 SECONDS
	var/jump_damage = 60

	var/recloak_time = 0
	var/recloak_time_cooldown = 30 SECONDS

	update_qliphoth_chance = 40

/mob/living/simple_animal/hostile/abnormality/apex_predator/Move()
	if(busy)
		return FALSE
	..()

/mob/living/simple_animal/hostile/abnormality/apex_predator/Life()
	. = ..()
	if(. && !(HAS_TRAIT(src, TRAIT_GODMODE)) && revealed && recloak_time < world.time)
		Cloak()

/mob/living/simple_animal/hostile/abnormality/apex_predator/try_working(mob/living/carbon/human/user)
	if(user.health == user.maxHealth)
		return FALSE
	. = ..()
	if(!.)
		return
	if(user.health < 0)
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/apex_predator/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	Cloak()
	GiveTarget(user)

/mob/living/simple_animal/hostile/abnormality/apex_predator/AttackingTarget(atom/attacked_target)
	if(!can_act)
		return
	if(!revealed)
		//Will want this to be crazy
		say("Behind you.")

		SLEEP_CHECK_DEATH(7, src)
		Decloak()
		SLEEP_CHECK_DEATH(3, src)
		//Backstab
		if(attacked_target in range(1, src))
			if(isliving(attacked_target))
				var/mob/living/V = attacked_target
				visible_message(span_danger("The [src] rips out [attacked_target]'s guts!"))
				new /obj/effect/gibspawner/generic(get_turf(V))
				V.apply_damage(backstab_damage, BRUTE)
			//Backstab succeeds from any one of 3 tiles behind a mecha, backstab from directly behind gets boosted by mecha directional armor weakness
			else if(ismecha(attacked_target))
				var/relative_angle = abs(dir2angle(attacked_target.dir) - dir2angle(get_dir(attacked_target, src)))
				relative_angle = relative_angle > 180 ? 360 - relative_angle : relative_angle
				if(relative_angle >= 135)
					visible_message(span_danger("The [src] shreds [attacked_target]'s armor!"))
					var/obj/vehicle/sealed/mecha/M = attacked_target
					M.take_damage(backstab_damage, BRUTE, attack_dir = get_dir(M, src))
					new /obj/effect/temp_visual/kinetic_blast(get_turf(M))
				else
					visible_message(span_danger("The [src]'s attack misses [attacked_target]'s weakspots!"))
					..()
			else
				..()
			SLEEP_CHECK_DEATH(20, src)
			Cloak()
			//Remove target
			FindTarget()
		else
			if(!jumping)
				if(!target)
					GiveTarget(attacked_target)
				Jump()
		return
	..()


//Getting hit decloaks
/mob/living/simple_animal/hostile/abnormality/apex_predator/attackby(obj/item/I, mob/living/user, params)
	..()
	Decloak()

/mob/living/simple_animal/hostile/abnormality/apex_predator/bullet_act(obj/projectile/P)
	..()
	Decloak()

/mob/living/simple_animal/hostile/abnormality/apex_predator/proc/Cloak()
	alpha = 10
	revealed = FALSE
	density = FALSE

/mob/living/simple_animal/hostile/abnormality/apex_predator/proc/Decloak()
	recloak_time = world.time + recloak_time_cooldown
	alpha = 255
	revealed = TRUE
	density = TRUE

/mob/living/simple_animal/hostile/abnormality/apex_predator/OpenFire()
	if(!revealed)
		return

	//For readability
	if(!jumping && (jump_cooldown < world.time) && !(HAS_TRAIT(src, TRAIT_GODMODE)))
		Jump()

/mob/living/simple_animal/hostile/abnormality/apex_predator/proc/Jump()
	jumping = TRUE
	busy = TRUE
	icon_state = "apex_crouch"
	addtimer(CALLBACK(src, PROC_REF(Leap)), 5)

/mob/living/simple_animal/hostile/abnormality/apex_predator/proc/Leap()
	density = FALSE
	var/turf/target_turf = get_turf(target)
	playsound(src, 'sound/items/weapons/fwoosh.ogg', 300, FALSE, 9)
	throw_at(target_turf, 7, 1, src, FALSE, callback = CALLBACK(src, PROC_REF(Slam)))
	icon_state = "apex_leap"

	addtimer(CALLBACK(src, PROC_REF(Slam)), 10)

/mob/living/simple_animal/hostile/abnormality/apex_predator/proc/Slam()
	icon_state = "apex_crouch"
	playsound(src, 'sound/effects/meteorimpact.ogg', 300, FALSE, 9)
	for(var/turf/T in range(1, src))
		HurtInTurf(T, list(), jump_damage, BRUTE, null, TRUE, FALSE, TRUE)
		new /obj/effect/temp_visual/kinetic_blast(T)
	addtimer(CALLBACK(src, PROC_REF(Reset)), 12)

/mob/living/simple_animal/hostile/abnormality/apex_predator/proc/Reset()
	density = TRUE
	busy = FALSE
	jumping = FALSE
	icon_state = "apex"
	jump_cooldown = world.time + jump_cooldown_time
