//Coded by Coxswain
/mob/living/simple_animal/hostile/abnormality/falada
	name = "Spirit of Falada"
	desc = "A horse's severed head."
	pixel_y = 64
	base_pixel_y = 64
	density = FALSE
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "falada"
	icon_living = "falada"
	faction = list("neutral")
	speak_emote = list("neighs")
	fear_level = TETH_LEVEL
	maxHealth = 55
	health = 55
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 1, TOX = 1, BRUTE = 2) //goose stats
	ego_list = list(
		/datum/ego_datum/weapon/zauberhorn,
		/datum/ego_datum/armor/zauberhorn,
	)
	gift_type =  /datum/ego_gifts/zauberhorn

	observation_prompt = "A severed horse-like creature's head hangs high on the wall, sobbing. <br>\
		You can't help but feel some pity for the thing."


	var/liked
	var/happy = TRUE
	var/hint_cooldown
	var/hint_cooldown_time = 30 SECONDS
	var/list/cooldown = list("It is not the time now, not yet.")

	var/list/instinct = list("I should have trusted my instincts, I should have stopped that vile maidservant before it was too late. Look at what happened to me!")

	var/list/insight = list("The late princess was a woman of incredible insight, it may do you well to do the same.")

	var/list/attachment = list("Poor Anidori, her attachment to that woman was too great. She could not see the jealousy harbored within her.")

	var/list/repression = list("The things that they did to me, the things they did to her, all for the want of justice in the world.")

	work_types = null

// Work Mechanics
/mob/living/simple_animal/hostile/abnormality/falada/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/falada/ZeroQliphoth(mob/living/carbon/human/user)
	pissed()
	if(user)
		say("O, Anidori, if only your mother knew the fate to befall you, how her heart would break in two.")
	qliphoth_change(1)
	return

/mob/living/simple_animal/hostile/abnormality/falada/BreachEffect(mob/living/carbon/human/user, breach_type)
	if(breach_type == BREACH_MINING)
		pissed()
		qdel(src)

/mob/living/simple_animal/hostile/abnormality/falada/try_working(mob/living/carbon/human/user)
	liked = pick(
		CLOTHING_ARMORED,
		CLOTHING_ENGINEERING,
		CLOTHING_SCIENCE,
		CLOTHING_SERVICE,
	)
	if(user.get_major_clothing_class() == liked || !liked)
		happy = TRUE
	else
		happy = FALSE
	. = ..()
	if(!.)
		return
	if(hint_cooldown > world.time)
		say(pick(cooldown))
		return
	hint_cooldown = world.time + hint_cooldown_time
	switch(liked)
		if(CLOTHING_ENGINEERING)
			say(pick(instinct))
		if(CLOTHING_SCIENCE)
			say(pick(insight))
		if(CLOTHING_SERVICE)
			say(pick(attachment))
		if(CLOTHING_ARMORED)
			say(pick(attachment))

/mob/living/simple_animal/hostile/abnormality/falada/PostWorkEffect(mob/living/carbon/human/user)
	switch(liked)
		if(CLOTHING_ENGINEERING)
			say(pick(instinct))
		if(CLOTHING_SCIENCE)
			say(pick(insight))
		if(CLOTHING_SERVICE)
			say(pick(attachment))
		if(CLOTHING_ARMORED)
			say(pick(repression))

// Breach
/mob/living/simple_animal/hostile/abnormality/falada/proc/pissed()
	var/turf/W = get_turf(pick(GLOB.start_landmarks_list))
	for(var/turf/T in orange(1, W))
		new /obj/effect/temp_visual/dir_setting/cult/phase
		new /mob/living/simple_animal/hostile/retaliate/goose/falada(T)

// Spawned Mob
/mob/living/simple_animal/hostile/retaliate/goose/falada
	maxHealth = 55
	health = 55
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 1, TOX = 1, BRUTE = 2)
	faction = list("goose") //geese are demons
	attack_same = FALSE
	wander = TRUE

/mob/living/simple_animal/hostile/retaliate/goose/falada/handle_automated_action()
	if(AIStatus == AI_OFF)
		return FALSE
	var/list/possible_targets = ListTargets() //we look around for potential targets and make it a list for later use.
	if(environment_smash)
		EscapeConfinement()
	if(AICanContinue(possible_targets))
		var/atom/target = locate(targets_from)
		if(!QDELETED(target) && !target.Adjacent(target))
			DestroyPathToTarget()
		if(!MoveToTarget(possible_targets))     //if we lose our target
			if(AIShouldSleep(possible_targets))	// we try to acquire a new one
				toggle_ai(AI_IDLE)			// otherwise we go idle
	return 1

/mob/living/simple_animal/hostile/retaliate/goose/falada/Found(atom/A)//This is here as a potential override to pick a specific target if available
	return
