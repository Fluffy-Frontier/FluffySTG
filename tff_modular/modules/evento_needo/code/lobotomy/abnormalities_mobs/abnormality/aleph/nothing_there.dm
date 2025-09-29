#define NT_GOODBYE_COOLDOWN (20 SECONDS)

/mob/living/simple_animal/hostile/abnormality/nothing_there
	name = "Nothing There"
	desc = "A wicked creature that consists of various human body parts and organs."
	health = 4000
	maxHealth = 4000
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "nothing"
	icon_living = "nothing"
	icon_dead = "nothing_dead"
	melee_damage_type = BRUTE
	damage_coeff = list(BURN = 0.3, BRAIN = 0.8, BRUTE = 0.8, TOX = 1.2)
	melee_damage_lower = 55
	melee_damage_upper = 65
	move_to_delay = 3
	ranged = TRUE
	pixel_x = -8
	base_pixel_x = -8
	del_on_death = FALSE
	stat_attack = HARD_CRIT
	can_breach = TRUE
	fear_level = ALEPH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/mimicry,
		/datum/ego_datum/armor/mimicry,
	)
	gift_type =  /datum/ego_gifts/mimicry
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/kqe = 1.5,
		/mob/living/simple_animal/hostile/abnormality/nobody_is = 1.5,
	)

	observation_prompt = "*Teeth grinding* <br>Incomprehensible sounds can be heard. <br>\
		Its body was already broken long time ago. <br>\
		The twisted mouth opens, the crushed down tongue undulates. <br>\"M-ma......man-ag......r.......\" <br>It's calling for the manager."


	var/shelled
	var/mob/living/disguise_ref
	var/saved_appearance
	var/can_act = TRUE
	var/current_stage = 1
	var/next_transform = null

	var/hello_cooldown
	var/hello_cooldown_time = 6 SECONDS
	var/hello_damage = 120
	var/goodbye_cooldown
	var/goodbye_cooldown_time = 20 SECONDS
	var/goodbye_damage = 500

	var/last_heal_time = 0
	var/heal_percent_per_second = 0.0085
	var/regen_on = TRUE
	var/r_corp_regen_start = 1

	var/datum/looping_sound/nothingthere_ambience/soundloop
	var/datum/looping_sound/nothingthere_heartbeat/heartbeat
	var/datum/looping_sound/nothingthere_disguise/disguiseloop
	var/datum/looping_sound/nothingthere_breach/breachloop

	//Speaking Variables, not sure if I want to use the automated speach at the moment.
	var/heard_words = list()
	var/listen_chance = 10 // 20 for testing, 10 for base
	var/utterance = 5 // 10 for testing, 5 for base
	var/worker = null

	//PLAYABLES ATTACKS
	attack_action_types = list(
		/datum/action/cooldown/nt_goodbye,
		/datum/action/innate/abnormality_attack/toggle/nt_hello_toggle,
	)
	update_qliphoth = 0

/datum/action/cooldown/nt_goodbye
	name = "Goodbye"
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	button_icon_state = "nt_goodbye"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = NT_GOODBYE_COOLDOWN //20 seconds

/datum/action/cooldown/nt_goodbye/Trigger(trigger_flags, atom/target)
	if(!..())
		return FALSE
	if(!istype(owner, /mob/living/simple_animal/hostile/abnormality/nothing_there))
		return FALSE
	var/mob/living/simple_animal/hostile/abnormality/nothing_there/nothing_there = owner
	if(nothing_there.current_stage != 3)
		return FALSE
	StartCooldown()
	nothing_there.Goodbye()
	return TRUE

/datum/action/innate/abnormality_attack/toggle/nt_hello_toggle
	name = "Toggle Hello"
	button_icon_state = "nt_toggle0"
	chosen_attack_num = 2
	chosen_message = span_colossus("You won't shoot anymore.")
	button_icon_toggle_activated = "nt_toggle1"
	toggle_attack_num = 1
	toggle_message = span_colossus("You will now shoot a welcoming sonic wave.")
	button_icon_toggle_deactivated = "nt_toggle0"


/mob/living/simple_animal/hostile/abnormality/nothing_there/Initialize()
	. = ..()
	saved_appearance = appearance
	soundloop = new(list(src), FALSE)
	heartbeat = new(list(src), FALSE)
	disguiseloop = new(list(src), FALSE)
	breachloop = new(list(src), FALSE)

/mob/living/simple_animal/hostile/abnormality/nothing_there/Destroy()
	//TransferVar("mimicry", heard_words)
	QDEL_NULL(soundloop)
	QDEL_NULL(heartbeat)
	QDEL_NULL(disguiseloop)
	QDEL_NULL(breachloop)
	return ..()

/mob/living/simple_animal/hostile/abnormality/nothing_there/PostSpawn()
	. = ..()
	//var/list/old_heard = RememberVar("mimicry")
	//if(islist(old_heard) && LAZYLEN(old_heard))
	//	heard_words = old_heard
	soundloop.start() // We only play the ambience if we're spawned in containment
	return

/mob/living/simple_animal/hostile/abnormality/nothing_there/Move()
	if(!can_act)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/nothing_there/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	if(current_stage == 3)
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nothingthere/walk.ogg', 50, 0, 3)
	return ..()

/mob/living/simple_animal/hostile/abnormality/nothing_there/AttackingTarget(atom/attacked_target)
	if(!can_act)
		return FALSE
	if(!client)
		if((current_stage == 3) && (goodbye_cooldown <= world.time) && prob(35))
			return Goodbye()
		if((current_stage == 3) && (hello_cooldown <= world.time) && prob(35))
			var/turf/target_turf = get_turf(attacked_target)
			for(var/i = 1 to 3)
				target_turf = get_step(target_turf, get_dir(get_turf(src), target_turf))
			return Hello(target_turf)
	return ..()

/mob/living/simple_animal/hostile/abnormality/nothing_there/OpenFire()
	if(!can_act)
		return
	if(current_stage == 3)

		if(client)
			switch(chosen_attack)
				if(1)
					Hello(target)
			return

		if(hello_cooldown <= world.time)
			Hello(target)
		if((goodbye_cooldown <= world.time) && (get_dist(src, target) < 3))
			Goodbye()

	return

/mob/living/simple_animal/hostile/abnormality/nothing_there/ListTargets()
	if(shelled)
		return list()
	return ..()

/mob/living/simple_animal/hostile/abnormality/nothing_there/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if((shelled) && (health < maxHealth * 0.95))
		drop_disguise()

/mob/living/simple_animal/hostile/abnormality/nothing_there/Life()
	. = ..()
	var/speak_list = list()
	if(HAS_TRAIT(src, TRAIT_GODMODE)) // Contained
		if(prob(utterance) && LAZYLEN(heard_words))
			speak_list = pick(heard_words)
			speak_list = heard_words[speak_list]
			//say(pick(speak_list))
		return
	if(.)
		if((shelled) && LAZYLEN(heard_words[disguise_ref]) && prob(utterance*2))
			speak_list = heard_words[disguise_ref]
			//say(pick(speak_list))
		else
			if(LAZYLEN(heard_words) && prob(utterance))
				var/mob/living/carbon/human/speaker = pick(heard_words)
				speak_list = heard_words[speaker]
				var/line = pick(speak_list)
				if((findtext(line, "uwu") || findtext(line, "owo") || findtext(line, "daddy") || findtext(line, "what the dog doin")) && !isnull(speaker) && speaker.stat != DEAD)
					forceMove(get_turf(speaker))
					GiveTarget(speaker)
				//say(line)
		if((last_heal_time + 1 SECONDS) < world.time) // One Second between heals guaranteed
			regen_on = TRUE
			if(health > maxHealth * r_corp_regen_start)
				regen_on = FALSE
			if(regen_on == TRUE)
				var/heal_amount = ((world.time - last_heal_time)/10)*heal_percent_per_second*maxHealth
				if(health <= maxHealth*0.3)
					heal_amount *= 2
				adjustBruteLoss(-heal_amount)
			last_heal_time = world.time
		if(next_transform && (world.time > next_transform))
			next_stage()
		if(current_stage == 2) // Egg
			var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(get_turf(src), src)
			animate(D, alpha = 0, transform = matrix()*1.2, time = 7)

/mob/living/simple_animal/hostile/abnormality/nothing_there/death(gibbed)
	animate(src, alpha = 0, time = 10 SECONDS)
	QDEL_IN(src, 10 SECONDS)
	..()

/mob/living/simple_animal/hostile/abnormality/nothing_there/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods, message_range)
	. = ..()
	if(speaker == worker) // More likely to pick things up from those working on it
		listen_chance *= 2
	if(prob(listen_chance) && istype(speaker, /mob/living/carbon/human))
		if(!(speaker in heard_words)) // No words stored yet
			heard_words[speaker] = list()
		if(!(raw_message in heard_words[speaker]))
			heard_words[speaker] += raw_message
	listen_chance = initial(listen_chance)

/mob/living/simple_animal/hostile/abnormality/nothing_there/apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, attack_direction, attacking_item, exposed_wound_bonus)
	. = ..()
	if(damagetype == BRUTE || damage < 10)
		return
	last_heal_time = world.time + 10 SECONDS // Heal delayed when taking damage; Doubled because it was a little too quick.

/mob/living/simple_animal/hostile/abnormality/nothing_there/proc/disguise_as(mob/living/M)
	if(!(HAS_TRAIT(src, TRAIT_GODMODE))) // Already breaching
		return
	if(!istype(M))
		return
	for(var/turf/open/T in view(4, src))
		new /obj/effect/temp_visual/flesh(T)
	soundloop.stop()
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nothingthere/disguise.ogg', 75, 0, 5)
	new /obj/effect/gibspawner/generic(get_turf(M))
	to_chat(M, span_userdanger("Oh no..."))
	shelled = TRUE
	CopyHumanAppearance(M) // This is the same proc used by Nobody Is for stealing skin. Should be less buggy than copying appearance var.
	disguise_ref = M // We keep a reference to the "shell" for utterances and the like, but it's not absolutely necessary in case they gib somehow
	M.death()
	M.forceMove(src) // Hide them
	disguiseloop.start()
	addtimer(CALLBACK(src, PROC_REF(ZeroQliphoth)), rand(20 SECONDS, 50 SECONDS))

/mob/living/simple_animal/hostile/abnormality/nothing_there/proc/drop_disguise()
	if(!shelled)
		return
	next_transform = world.time + rand(30 SECONDS, 40 SECONDS)
	move_to_delay = 1.5
	appearance = saved_appearance
	if(disguise_ref)
		disguise_ref.forceMove(get_turf(src))
		disguise_ref.gib(DROP_ALL_REMAINS)
		disguise_ref = null
	fear_level = ALEPH_LEVEL
	FearEffect()
	disguiseloop.stop()

/mob/living/simple_animal/hostile/abnormality/nothing_there/proc/next_stage()
	next_transform = null
	switch(current_stage)
		if(1)
			icon_state = "nothing_egg"
			ChangeResistances(list(BURN = 0, BRAIN = 0.6, BRUTE = 0.6, TOX = 1))
			can_act = FALSE
			next_transform = world.time + rand(10 SECONDS, 25 SECONDS)
			heartbeat.start()
		if(2)
			breach_affected = list() // Too spooky
			FearEffect()
			attack_verb_continuous = "strikes"
			attack_verb_simple = "strike"
			attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nothingthere/attack.ogg'
			icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x96.dmi'
			icon_state = icon_living
			pixel_x = -16
			base_pixel_x = -16
			ChangeResistances(list(BRUTE = 0.4, BRUTE = 0.4, BRUTE = 0.8))
			can_act = TRUE
			melee_damage_lower = 65
			melee_damage_upper = 75
			move_to_delay = 1.5
			heartbeat.stop()
			breachloop.start()
	adjustBruteLoss(-maxHealth, forced = TRUE)
	current_stage = clamp(current_stage + 1, 1, 3)

/mob/living/simple_animal/hostile/abnormality/nothing_there/proc/Hello(target)
	if(hello_cooldown > world.time)
		return
	hello_cooldown = world.time + hello_cooldown_time
	can_act = FALSE
	face_atom(target)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nothingthere/hello_cast.ogg', 75, 0, 3)
	icon_state = "nothing_ranged"
	var/turf/target_turf = get_turf(target)
	for(var/i = 1 to 3)
		target_turf = get_step(target_turf, get_dir(get_turf(src), target_turf))
	// Close range gives you more time to dodge
	var/hello_delay = (get_dist(src, target) <= 2) ? (1 SECONDS) : (0.5 SECONDS)
	SLEEP_CHECK_DEATH(hello_delay, src)
	var/list/been_hit = list()
	var/broken = FALSE
	for(var/turf/T in get_line(get_turf(src), target_turf))
		if(T.density)
			if(broken)
				break
			broken = TRUE
		for(var/turf/TF in range(1, T)) // AAAAAAAAAAAAAAAAAAAAAAA
			if(TF.density)
				continue
			new /obj/effect/temp_visual/smash_effect(TF)
			been_hit = HurtInTurf(TF, been_hit, hello_damage, BRUTE, null, TRUE, FALSE, TRUE, hurt_structure = TRUE)
	for(var/mob/living/L in been_hit)
		if(L.health < 0)
			L.gib(DROP_ALL_REMAINS)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nothingthere/hello_bam.ogg', 100, 0, 7)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nothingthere/hello_clash.ogg', 75, 0, 3)
	icon_state = icon_living
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/nothing_there/proc/Goodbye()
	if(goodbye_cooldown > world.time)
		return
	goodbye_cooldown = world.time + goodbye_cooldown_time
	can_act = FALSE
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nothingthere/goodbye_cast.ogg', 75, 0, 5)
	icon_state = "nothing_blade"
	SLEEP_CHECK_DEATH(8, src)
	for(var/turf/T in view(2, src))
		new /obj/effect/temp_visual/nt_goodbye(T)
		for(var/mob/living/L in HurtInTurf(T, list(), goodbye_damage, BRUTE, null, TRUE, FALSE, TRUE, hurt_hidden = TRUE, hurt_structure = TRUE))
			if(L.health < 0)
				L.gib(DROP_ALL_REMAINS)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nothingthere/goodbye_attack.ogg', 75, 0, 7)
	SLEEP_CHECK_DEATH(3, src)
	icon_state = icon_living
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/nothing_there/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if(shelled)
		return FALSE

	if(user.get_clothing_class_level(CLOTHING_ENGINEERING) < 5)
		neutral_chance = 20
		negative_chance = 50
	else
		neutral_chance = 40
		negative_chance = 30


	worker = user
	var/growl_prob = (user.get_major_clothing_class() == CLOTHING_ARMORED || user.get_major_clothing_class() == CLOTHING_SCIENCE) ? 100 : 25
	if(prob(growl_prob)) // Spooky
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nothingthere/growl.ogg', 25, 0)
	return TRUE

/mob/living/simple_animal/hostile/abnormality/nothing_there/PostWorkEffect(mob/living/carbon/human/user)
	worker = null
	if(user.get_clothing_class_level(CLOTHING_ARMORED) < 4)
		if(!shelled) // Not work failure
			qliphoth_change(-1)
	return ..()

/mob/living/simple_animal/hostile/abnormality/nothing_there/FailureEffect(mob/living/carbon/human/user)
	if(HAS_TRAIT(user, TRAIT_GODMODE))
		return
	disguise_as(user)
	return

/mob/living/simple_animal/hostile/abnormality/nothing_there/BreachEffect(mob/living/carbon/human/user)
	if(!(HAS_TRAIT(src, TRAIT_GODMODE))) // Already breaching
		return
	. = ..()
	soundloop.stop()
	if(!shelled)
		next_transform = world.time + rand(30 SECONDS, 40 SECONDS)
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nothingthere/breach.ogg', 50, 0, 5)
		return
	// Teleport us somewhere where nobody will see us at first
	disguiseloop.stop()
	fear_level = ZAYIN_LEVEL // So it doesn't inflict fear to those around them
	move_to_delay = 0.5 // This will make them move at a speed similar to normal players
	var/list/priority_list = list()
	for(var/turf/T in GLOB.generic_event_spawns)
		var/people_in_range = 0
		for(var/mob/living/L in view(9, T))
			if(L.client && L.stat < UNCONSCIOUS)
				people_in_range += 1
				break
		if(people_in_range > 0)
			continue
		priority_list += T
	var/turf/target_turf = get_turf(pick(GLOB.generic_event_spawns))
	if(LAZYLEN(priority_list))
		target_turf = pick(priority_list)
	for(var/turf/open/T in view(3, src))
		new /obj/effect/temp_visual/flesh(T)
	forceMove(target_turf)
	addtimer(CALLBACK(src, PROC_REF(drop_disguise)), rand(40 SECONDS, 90 SECONDS))

#undef NT_GOODBYE_COOLDOWN
