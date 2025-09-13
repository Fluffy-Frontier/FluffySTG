/mob/living/simple_animal/hostile/abnormality/bluestar
	name = "Blue Star"
	desc = "Floating heart-shaped object. It's alive, and soon you will become one with it."
	health = 4000
	maxHealth = 4000
	pixel_x = -32
	base_pixel_x = -32
	pixel_y = -16
	base_pixel_y = -16
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96.dmi'
	icon_state = "blue_star"
	icon_living = "blue_star"
	icon_dead = "blue_star_dead"
	damage_coeff = list(BURN = 0.4, BRAIN = 0.2, BRUTE = 0.8, TOX = 1.2)
	del_on_death = FALSE
	can_breach = TRUE
	fear_level = ALEPH_LEVEL
	wander = FALSE

	wander = FALSE
	light_color = COLOR_BLUE_LIGHT
	light_range = 36
	light_power = 20

	del_on_death = FALSE

	ego_list = list(
		/datum/ego_datum/weapon/star_sound,
		/datum/ego_datum/armor/star_sound,
	)
	gift_type =  /datum/ego_gifts/star
	observation_prompt = "A group of employees worship this abnormality, despite the fact nothing can be sacred in this place. <br>\
		You recall how you pulled away one employee away from it in the past, even as she screamed and wailed that you were keeping her chained to this world. <br>You thought you were saving her. <br>\
		You can hear a distant howl emanating from the centre of the blue-coloured heart. <br>It's the sound of stars. <br>They're welcoming you, asking you to join them as a star."


	var/pulse_cooldown
	var/pulse_cooldown_time = 12 SECONDS
	var/pulse_damage = 120 // Scales with distance; Ideally, you shouldn't be able to outheal it with white V armor or less

	var/datum/looping_sound/bluestar/soundloop

/mob/living/simple_animal/hostile/abnormality/bluestar/Initialize()
	. = ..()
	soundloop = new(list(src), FALSE)

/mob/living/simple_animal/hostile/abnormality/bluestar/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/mob/living/simple_animal/hostile/abnormality/bluestar/death(gibbed)
	QDEL_NULL(soundloop)
	animate(src, alpha = 0, time = 5 SECONDS)
	QDEL_IN(src, 5 SECONDS)
	..()

/mob/living/simple_animal/hostile/abnormality/bluestar/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/bluestar/Life()
	. = ..()
	if(!.) // Dead
		return FALSE
	if((pulse_cooldown < world.time) && !(HAS_TRAIT(src, TRAIT_GODMODE)))
		BluePulse()

/mob/living/simple_animal/hostile/abnormality/bluestar/CanAttack(atom/the_target)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/bluestar/proc/BluePulse()
	pulse_cooldown = world.time + pulse_cooldown_time
	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bluestar/pulse.ogg', 100, FALSE, 40, falloff_distance = 10)
	var/matrix/init_transform = transform
	animate(src, transform = transform*1.5, time = 3, easing = BACK_EASING|EASE_OUT)
	for(var/mob/living/L in view(48, src))
		if(L.z != z)
			continue
		if(faction_check_atom(L))
			continue
		L.apply_damage((pulse_damage - get_dist(src, L)), BRUTE)
		flash_color(L, flash_color = COLOR_BLUE_LIGHT, flash_time = 70)
		if(!ishuman(L))
			continue
		var/mob/living/carbon/human/H = L
		if(H.sanity_lost) // TODO: TEMPORARY AS HELL
			H.death()
			animate(H, transform = H.transform*0.01, time = 5)
			QDEL_IN(H, 5)
	addtimer(CALLBACK(src, PROC_REF(BluePulse_end), init_transform), 3)

/mob/living/simple_animal/hostile/abnormality/bluestar/proc/BluePulse_end(init_transform)
	animate(src, transform = init_transform, time = 5)

/mob/living/simple_animal/hostile/abnormality/bluestar/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	qliphoth_change(-1)
	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bluestar/pulse.ogg', 25, FALSE, 28)
	user.death()
	animate(user, transform = user.transform*0.01, time = 5)
	QDEL_IN(user, 5)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/bluestar/PostWorkEffect(mob/living/carbon/human/user)
	if(user.sanity_lost)
		qliphoth_change(-1)
	qliphoth_change(-2)
	playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bluestar/pulse.ogg', 25, FALSE, 28)
	user.death()
	animate(user, transform = user.transform*0.01, time = 5)
	QDEL_IN(user, 5)
	return

/mob/living/simple_animal/hostile/abnormality/bluestar/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	var/turf/T = get_turf(pick(GLOB.generic_event_spawns))
	soundloop.start()
	forceMove(T)
	var/area/A = get_area(T)
	show_global_blurb(6 SECONDS, "Аномальная активность обнаружена в [A.name]", 2 SECONDS, "white", "black", "left", around_player)
	BluePulse()
	return
