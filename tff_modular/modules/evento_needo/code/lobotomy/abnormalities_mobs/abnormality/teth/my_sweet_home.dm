//Brain go brrrr.
/mob/living/simple_animal/hostile/abnormality/my_sweet_home
	name = "My Sweet Home"
	desc = "This cozy little house is a safe nest built only for you. Everything is here for you..."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x64.dmi'
	icon_state = "sweet_home"
	icon_living = "sweet_home"
	icon_dead = "sweet_home_death"
	var/can_act = TRUE
	fear_level = TETH_LEVEL
	can_breach = TRUE
	del_on_death = FALSE
	maxHealth = 600
	health = 600
	move_to_delay = 5
	damage_coeff = list(BURN = 0.9, BRAIN = 0.9, BRUTE = 1.2, TOX = 2)
	melee_damage_lower = 15
	melee_damage_upper = 20
	melee_damage_type = BRUTE
	melee_queue_distance = 1
	retreat_distance = 0
	minimum_distance = 0
	stat_attack = CONSCIOUS
	attack_verb_continuous = "stomps"
	attack_verb_simple = "stomp"
	death_message = "crumbles."
	faction = list("hostile")
	ego_list = list(
		/datum/ego_datum/weapon/hearth,
		/datum/ego_datum/armor/hearth,
	)
	gift_type =  /datum/ego_gifts/hearth
	observation_prompt = "\"I am a home.\" <br>\
		A happy little home, just for you. <br>\
		A perfect, safe place away from this scary room. <br>\
		Everything for you. <br>\
		Won't you come inside?"


	var/ranged_damage = 15
	var/damage_dealt = 0
	var/list/counter1 = list() //from FAN, although changed
	var/list/counter2 = list()
	var/slam_cooldown = 10 SECONDS
	var/slam_cooldown_time
	work_types = null

/mob/living/simple_animal/hostile/abnormality/my_sweet_home/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	if(!(HAS_TRAIT(src, TRAIT_GODMODE))) // This thing's big, it should make some noise.
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/sweethome/walk.ogg', 50, 1)

/mob/living/simple_animal/hostile/abnormality/my_sweet_home/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(!.)
		return
	if(prob(50))
		if(user in counter2)
			to_chat(user, span_danger("You grip the key and approach."))
			user.Stun(10 SECONDS)
			SLEEP_CHECK_DEATH(3, src)
			user.gib()
			qliphoth_change(-1)
			BreachEffect(user)
		else if(user in counter1)
			counter2+=user
			to_chat(user, span_danger("It speaks in your mind, reassuring you, you feel safe."))
		else
			counter1+=user
	else
		to_chat(user, span_danger("It whispers in your mind..."))
		if(prob(50))
			to_chat(user, span_danger("...and you accept."))
			SLEEP_CHECK_DEATH(3, src)
			user.Stun(10 SECONDS)
			qliphoth_change(-1)
			user.gib()
			BreachEffect(user)
		else
			to_chat(user, span_danger("...and you almost agree but refuse at the last moment."))

/mob/living/simple_animal/hostile/abnormality/my_sweet_home/proc/AoeAttack()
	damage_dealt = 0
	var/list/hit_turfs = list()
	var/turf/target_turf = get_turf(src)
	for(var/turf/open/T in view(target_turf, 3))
		hit_turfs |= T
		for(var/mob/living/L in HurtInTurf(T, list(), ranged_damage, BRUTE, hurt_mechs = TRUE))
			if((L.stat < DEAD) && !(HAS_TRAIT(L, TRAIT_GODMODE)))
				damage_dealt += ranged_damage
	if(damage_dealt > 0)
		slam_cooldown_time = world.time + slam_cooldown
		for(var/turf/T in hit_turfs)
			new /obj/effect/temp_visual/smash_effect(T)
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/sweethome/smash.ogg', 50, 1)

/mob/living/simple_animal/hostile/abnormality/my_sweet_home/Move()
	if(slam_cooldown_time < world.time)
		AoeAttack()
	return ..()

/obj/effect/temp_visual/smash1
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi'
	icon_state = "smash1"
	duration = 3

/mob/living/simple_animal/hostile/abnormality/my_sweet_home/BreachEffect(user)//code grabbed from scorched_girl
	. = ..()
	update_icon_state()

/mob/living/simple_animal/hostile/abnormality/my_sweet_home/update_icon_state() //code grabbed from forsaken_murderer and smile
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		icon_state = initial(icon)
	else if(health<1)
		icon_state = icon_dead
	else
		pixel_x = -16
		base_pixel_x = -16
		icon_state = "sweet_home_breach"
	return ..()

/mob/living/simple_animal/hostile/abnormality/my_sweet_home/death(gibbed)
	density = FALSE
	animate(src, alpha = 0, time = 10 SECONDS)
	QDEL_IN(src, 10 SECONDS)
	..()
