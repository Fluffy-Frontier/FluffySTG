/mob/living/simple_animal/hostile/abnormality/bloodbath
	name = "Bloodbath"
	desc = "A constantly dripping bath of blood"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x64.dmi'
	icon_state = "bloodbath"
	maxHealth = 2000
	health = 2000
	rapid_melee = 1
	melee_queue_distance = 2
	move_to_delay = 3
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ichthys/slap.ogg'
	attack_verb_continuous = "mauls"
	attack_verb_simple = "maul"
	melee_damage_lower = 20
	melee_damage_upper = 38
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 1.6, BRAIN = 1, BRUTE = 1.4, TOX = 1.5)
	ranged = TRUE
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/wrist,
		/datum/ego_datum/armor/wrist,
	)

	gift_type =  /datum/ego_gifts/wrist
	observation_prompt = "The Enkephalin cure affected not only mind, but also body. <br>\
		The problem is, the supply of cure became tremendously huge to control when we realized the problem. <br>\
		One of problems, one of them was numbing. <br>People believed they could live happy life. <br>\
		People believed they could buy sadness and sell happiness with money. <br>When the first suicide happened, we should have known that these beliefs had been shattered. <br>\
		Many hands float in the bath. <br>Hands that wanted to grab something but could not. <br>You......"


	var/hands = 0
	var/can_act = TRUE
	var/special_attack_cooldown

/mob/living/simple_animal/hostile/abnormality/bloodbath/PostWorkEffect(mob/living/carbon/human/user)
// any work performed with level 1 Fort and Temperance makes you panic and die
	if(user.get_clothing_class_level(CLOTHING_SERVICE) < 2 && user.get_clothing_class_level(CLOTHING_ENGINEERING) < 2 || (hands == 3 && prob(50)))
		icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x64.dmi'
		icon_state = "bloodbath_a[hands]"
		user.Stun(30 SECONDS)
		step_towards(user, src)
		sleep(0.5 SECONDS)
		if(QDELETED(user))
			return
		step_towards(user, src)
		sleep(0.5 SECONDS)
		if(QDELETED(user))
			return
		user.gib(DROP_ALL_REMAINS)
		visible_message(span_warning("[src] drags [user] into itself!"))
		playsound(get_turf(src),'sound/effects/wounds/blood2.ogg')
		playsound(get_turf(src),'sound/effects/footstep/water1.ogg')
		SLEEP_CHECK_DEATH(3 SECONDS, src)
		hands ++
		if(hands < 4)
			icon_state = "bloodbath[hands]"
		else
			hands = 0
			icon_state = "bloodbath"
		return

/mob/living/simple_animal/hostile/abnormality/bloodbath/BreachEffect(mob/living/carbon/human/user)
	..()
	icon_state = "bloodbath_DF"
	pixel_x = -8
	base_pixel_x = -8
	update_icon()

/mob/living/simple_animal/hostile/abnormality/bloodbath/OpenFire()
	if(!can_act)
		return
	if(special_attack_cooldown > world.time)
		return
	BloodBathSlam()

/mob/living/simple_animal/hostile/abnormality/bloodbath/proc/BloodBathSlam()//weaker version of the DF form
	if(!can_act)
		return
	special_attack_cooldown = world.time + 5 SECONDS
	can_act = FALSE
	for(var/turf/L in view(3, src))
		new /obj/effect/temp_visual/cult/sparks(L)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/ichthys/jump.ogg', 100, FALSE, 6)
	icon_state = "bloodbath_slamprepare"
	SLEEP_CHECK_DEATH(20, src)
	for(var/turf/T in view(3, src))
		var/obj/effect/temp_visual/small_smoke/halfsecond/FX =  new(T)
		FX.color = "#b52e19"
		for(var/mob/living/carbon/human/H in HurtInTurf(T, list(), 50, BRUTE, null, null, TRUE, FALSE, TRUE, FALSE, TRUE, TRUE))
			if(H.sanity_lost)
				H.gib()
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bloodbath/Bloodbath_EyeOn.ogg', 125, FALSE, 6)
	icon_state = "bloodbath_slam"
	SLEEP_CHECK_DEATH(3, src)
	icon_state = "bloodbath_DF"
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/bloodbath/Move()
	if(!can_act)
		return FALSE
	..()
