#define FRAGMENT_SONG_COOLDOWN (14 SECONDS)

/mob/living/simple_animal/hostile/abnormality/fragment
	name = "Fragment of the Universe"
	desc = "An abnormality taking form of a black ball covered by 'hearts' of different colors."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "fragment"
	icon_living = "fragment"
	maxHealth = 800
	health = 800
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 1.5, TOX = 1, BRUTE = 2)
	ranged = TRUE
	melee_damage_lower = 8
	melee_damage_upper = 12
	rapid_melee = 2
	melee_damage_type = BRUTE
	stat_attack = HARD_CRIT
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fragment/attack.ogg'
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	faction = list("hostile")
	can_breach = TRUE
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/fragment,
		/datum/ego_datum/armor/fragment,
	)
	gift_type =  /datum/ego_gifts/fragments
	observation_prompt = "It started singing. You..."


	var/song_cooldown
	var/song_cooldown_time = 10 SECONDS
	var/song_damage = 5 // Dealt 8 times
	var/can_act = TRUE

	//Visual/Animation Vars
	var/obj/effect/fragment_legs/legs
	var/obj/particle_emitter/fragment_note/particle_note
	var/obj/particle_emitter/fragment_song/particle_song

	//PLAYABLES ACTIONS
	attack_action_types = list(/datum/action/cooldown/fragment_song)

/mob/living/simple_animal/hostile/abnormality/fragment/Login()
	. = ..()
	to_chat(src, "<h1>You are Fragment of the Universe, A Combat Role Abnormality.</h1><br>\
		<b>|Echoes of the Stars|: You are able to trigger your “Song” ability using the button on your screen or a hotkey (Spacebar by Default).<br>\
		While you are using your “Song” all humans that you see will start taking WHITE damage over time.<br>\
		This attack goes through the Rhinos mechs, which can cause the user to panic within the mech and become completely helpless.</b>")

/datum/action/cooldown/fragment_song
	name = "Sing"
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	button_icon_state = "fragment"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = FRAGMENT_SONG_COOLDOWN //14 seconds

/datum/action/cooldown/fragment_song/Trigger(trigger_flags, atom/target)
	if(!..())
		return FALSE
	if(!istype(owner, /mob/living/simple_animal/hostile/abnormality/fragment))
		return FALSE
	var/mob/living/simple_animal/hostile/abnormality/fragment/fragment = owner
	if(fragment.IsContained()) // No more using cooldowns while contained
		return FALSE
	StartCooldown()
	fragment.song()
	return TRUE

/mob/living/simple_animal/hostile/abnormality/fragment/Destroy()
	QDEL_NULL(legs)
	if(!particle_note)
		return ..()
	particle_note.fadeout()
	particle_song.fadeout()
	return ..()

/mob/living/simple_animal/hostile/abnormality/fragment/Move()
	if(!can_act)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/fragment/OpenFire()
	if(!can_act || client)
		return

	if(song_cooldown <= world.time)
		song()

/mob/living/simple_animal/hostile/abnormality/fragment/proc/song()
	if(song_cooldown > world.time)
		return
	can_act = FALSE
	flick("fragment_song_transition" , src)
	SLEEP_CHECK_DEATH(5, src)

	legs = new(get_turf(src))
	icon_state = "fragment_song_head"
	pixel_y = 5
	particle_note = new(get_turf(src))
	particle_note.pixel_y = 26
	particle_song = new(get_turf(src))
	particle_song.pixel_y = 26
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/fragment/sing.ogg', 50, 0, 4)
	for(var/i = 1 to 8)
		//Animation for bobbing the head left to right
		switch(i)
			if(1)
				animate(src, transform = turn(matrix(), -30), time = 6, flags = SINE_EASING | EASE_OUT )
			if(3)
				animate(src, transform = turn(matrix(), 0), time = 6, flags = SINE_EASING | EASE_IN | EASE_OUT )
			if(5)
				animate(src, transform = turn(matrix(), 30), time = 6, flags = SINE_EASING | EASE_IN | EASE_OUT )
			if(7)
				animate(src, transform = turn(matrix(), 0), time = 6, flags = SINE_EASING | EASE_IN )
		//Animation -END-

		for(var/mob/living/L in view(8, src))
			if(faction_check_atom(L, FALSE))
				continue
			if(L.stat == DEAD)
				continue
			L.apply_damage(song_damage, BRUTE)
		SLEEP_CHECK_DEATH(3, src)

	animate(src, pixel_y = 0, time = 0)
	QDEL_NULL(legs)
	flick("fragment_song_transition" , src)
	SLEEP_CHECK_DEATH(5, src)
	icon_state = "fragment_breach"
	pixel_y = 0
	can_act = TRUE
	song_cooldown = world.time + song_cooldown_time
	if(!particle_note)
		return
	particle_note.fadeout()
	particle_song.fadeout()

/mob/living/simple_animal/hostile/abnormality/fragment/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(prob(40))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/fragment/FailureEffect(mob/living/carbon/human/user)
	if(prob(80))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/fragment/PostWorkEffect(mob/living/carbon/human/user)
	if(user.sanity_lost)
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/fragment/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	update_icon()
	GiveTarget(user)

/mob/living/simple_animal/hostile/abnormality/fragment/update_icon_state()
	if(HAS_TRAIT(src, TRAIT_GODMODE)) // Not breaching
		icon_state = initial(icon)
	else // Breaching
		icon_state = "fragment_breach"
	icon_living = icon_state
	return ..()

//Exists so the head can be animated separatedly from the legs when it sings
/obj/effect/fragment_legs
	name = "Fragment of the Universe"
	desc = "An abnormality taking form of a black ball covered by 'hearts' of different colors."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "fragment_song_legs"
	move_force = INFINITY
	pull_force = INFINITY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

#undef FRAGMENT_SONG_COOLDOWN


/mob/living/simple_animal/hostile/abnormality/fragment/proc/TriggerSong()
	for(var/datum/action/cooldown/fragment_song/A in actions)
		A.Trigger()

