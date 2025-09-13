// Coded by Coxswain
/mob/living/simple_animal/hostile/abnormality/missed_reaper
	name = "Missed Reaper"
	desc = "Appears to be a little girl standing next to a looming shadow. Your instincts tell you to avoid her at all costs."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "reaper"
	maxHealth = 400
	health = 400
	melee_damage_lower = 35
	melee_damage_upper = 45
	melee_damage_type = BRUTE
	attack_verb_continuous = "pierces"
	attack_verb_simple = "pierce"
	faction = list("hostile")
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/nail1.ogg'
	fear_level = HE_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/grasp,
		/datum/ego_datum/armor/grasp,
	)
	gift_type = /datum/ego_gifts/grasp
	light_color = "FFFFFFF"
	light_power = 5
	light_range = 2

	observation_prompt = "She was so pale at the end, she looked more like a porcelain doll than the little girl I knew, \
		laughing and smiling that bright colourful smile I loved so much. <br>I sat next to her bed, powerless to do anything."


	var/meltdown_cooldown //no spamming the meltdown effect
	var/meltdown_cooldown_time = 15 SECONDS

// Spooky effects
/mob/living/simple_animal/hostile/abnormality/missed_reaper/PostSpawn()
	..()
	DestroyLights()
	var/list/spooky_zone = range(1, src)
	if((locate(/obj/structure/looming_shadow) in spooky_zone))
		return
	for(var/turf/open/O in spooky_zone)
		new /obj/effect/gloomy_darkness(O)
	new /obj/structure/looming_shadow(get_turf(src))

// Work Stuff
/mob/living/simple_animal/hostile/abnormality/missed_reaper/PostWorkEffect(mob/living/carbon/human/user)
	. = ..()
	DestroyLights()
	if(user.get_clothing_class_level(CLOTHING_ARMORED) >= 4)
		qliphoth_change(-1)
	if(user.get_clothing_class_level(CLOTHING_SCIENCE) < 3)
		KillUser(user)
		return
	if(user.sanity_lost)
		KillUser(user)

/mob/living/simple_animal/hostile/abnormality/missed_reaper/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/missed_reaper/proc/KillUser(mob/living/carbon/human/user, work_type, pe)
	user.Stun(3 SECONDS)
	step_towards(user, src)
	sleep(0.5 SECONDS)
	if(QDELETED(user))
		return
	step_towards(user, src)
	sleep(0.5 SECONDS)
	if(QDELETED(user))
		return
	user.attack_animal(src)
	sleep(0.2 SECONDS)
	if(QDELETED(user))
		return
	user.attack_animal(src)
	sleep(0.5 SECONDS)
	if(QDELETED(user))
		return
	to_chat(user, span_userdanger("[src] stabs you!"))
	user.apply_damage(3000, BRUTE)
	playsound(user, 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/nail1.ogg', 100, FALSE, 4)
	return

// Procs
/mob/living/simple_animal/hostile/abnormality/missed_reaper/proc/DestroyLights()
	for(var/obj/machinery/light/L in range(3, src)) //blows out the lights
		L.on = 1
		L.break_light_tube()

// Breach
/mob/living/simple_animal/hostile/abnormality/missed_reaper/ZeroQliphoth(mob/living/carbon/human/user)
	qliphoth_change(2) //no need for qliphoth to be stuck at 0
	if(meltdown_cooldown > world.time)
		return
	meltdown_cooldown = world.time + meltdown_cooldown_time
	MeltdownEffect()
	return

/mob/living/simple_animal/hostile/abnormality/missed_reaper/proc/MeltdownEffect(mob/living/carbon/human/user) //copied my code from crumbling armor
	var/list/potentialmarked = list()
	var/list/marked = list()
	var/mob/living/carbon/human/Y
	for(var/mob/living/carbon/human/L in GLOB.player_list)
		if(faction_check_atom(L, FALSE) || L.stat >= HARD_CRIT || L.sanity_lost || z != L.z) // Dead or in hard crit, insane, or on a different Z level.
			continue
		potentialmarked += L
	var/numbermarked = 1 + round(LAZYLEN(potentialmarked) / 5, 1) //1 + 1 in 5 potential players, to the nearest whole number
	SLEEP_CHECK_DEATH(3 SECONDS, src)
	while(numbermarked > marked.len && potentialmarked.len > 0)
		Y = pick(potentialmarked)
		potentialmarked -= Y
		if(Y.stat == DEAD)
			continue
		marked+=Y
		playsound(get_turf(Y), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/missed_reaper/shadowcast.ogg', 50, FALSE, -1)
	SLEEP_CHECK_DEATH(1 SECONDS, src)
	for(Y in marked)
		to_chat(Y, span_userdanger("A shadow appears beneath your feet!"))
		new /obj/effect/malicious_shadow(get_turf(Y))

// Decorations
/obj/structure/looming_shadow
	name = "looming shadow"
	desc = "Looks like some sort of ghost or spirit."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64.dmi'
	icon_state = "looming_shadow"
	anchored = TRUE
	density = FALSE
	layer = BELOW_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/effect/gloomy_darkness
	name = "gloomy darkness"
	desc = "The kind of darkness that light doesn't penetrate."
	icon = 'icons/effects/weather_effects.dmi'
	icon_state = "darkness"
	anchored = TRUE
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/gloomy_darkness/Initialize()
	. = ..()
	alpha = 150

/obj/effect/gloomy_darkness/temporary

/obj/effect/gloomy_darkness/temporary/Initialize()
	. = ..()
	QDEL_IN(src, 0.5 SECONDS)

/obj/effect/malicious_shadow
	name = "malicious shadow"
	desc = "A tall, ominous figure"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64.dmi'
	icon_state = "looming_shadow"
	anchored = TRUE
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE
	var/explode_times = 20
	var/range = -1

/obj/effect/malicious_shadow/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(explode)), 0.5 SECONDS)

/obj/effect/malicious_shadow/proc/explode() //repurposed code from artillary bees, a delayed attack
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/missed_reaper/shadowhit.ogg', 50, 0, 8)
	range = clamp(range + 1, 0, 3)
	var/turf/target_turf = get_turf(src)
	for(var/turf/T in view(range, target_turf))
		var/obj/effect/temp_visual/smash_effect/shadowhit =  new(T)
		shadowhit.color = "#231E1B"
		new /obj/effect/gloomy_darkness/temporary(T)
		for(var/obj/machinery/light/B in T)
			B.on = 1
			B.break_light_tube()
		for(var/mob/living/L in T)
			L.apply_damage(10, BRUTE)
			if(ishuman(L) && L.health < 0)
				var/mob/living/carbon/human/H = L
				H.Drain()
	explode_times -= 1
	if(explode_times <= 0)
		qdel(src)
		return
	sleep(0.4 SECONDS)
	explode()
