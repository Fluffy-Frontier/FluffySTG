/mob/living/simple_animal/hostile/abnormality/sunset_traveller
	name = "Sunset Traveller"
	desc = "A yellow creature with orange butterflies floating around it."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "sunset"
	maxHealth = 400
	health = 400
	fear_level = ZAYIN_LEVEL

	light_color = COLOR_ORANGE
	light_range = 1
	light_power = 1
	environment_smash = FALSE

	ego_list = list(
		/datum/ego_datum/weapon/eclipse,
		/datum/ego_datum/armor/eclipse,
	)

	gift_type =  /datum/ego_gifts/eclipse
	var/list/saylines = list(
		"Wasn't it tiring coming all the way here?",
		"Really, check out those butterflies.",
		"Just watching them will warm your heart.",
	)

	light_color = COLOR_ORANGE
	light_range = 5
	light_power = 7
	var/healing = FALSE

/mob/living/simple_animal/hostile/abnormality/sunset_traveller/try_working(mob/living/carbon/human/user)
	if(healing)
		return FALSE
	. = ..()

/mob/living/simple_animal/hostile/abnormality/sunset_traveller/PostWorkEffect(mob/living/carbon/human/user)
	if(prob(20))
		new /mob/living/simple_animal/hostile/scarlet_moths(src)
		new /mob/living/simple_animal/hostile/scarlet_moths(src)
	Heal(user)

/mob/living/simple_animal/hostile/abnormality/sunset_traveller/proc/Heal(mob/living/carbon/human/user)
	set waitfor = FALSE
	healing = TRUE
	say("Look at those butterflies! Aren't they just beautiful?")
	SLEEP_CHECK_DEATH(15, src)
	say("And gander at that sunset, too! Really makes you want to go for a stroll.")
	SLEEP_CHECK_DEATH(15, src)
	say("Why don't you stop for a moment and take a breather here?")
	while (PlayerCheck(user))
		for(var/mob/living/carbon/human/H in view(3, src))
			//Heal 5% for every 1.5 seconds you're here
			H.adjustBruteLoss(-(H.maxHealth*0.05))
			H.adjustSanityLoss(-(H.maxSanity*0.05))
			new /obj/effect/temp_visual/heal(get_turf(H), "#E2ED4A")
		if(prob(5))
			say(pick(saylines))
		SLEEP_CHECK_DEATH(15, src)
	healing = FALSE

/mob/living/simple_animal/hostile/abnormality/sunset_traveller/proc/PlayerCheck(mob/living/carbon/human/user)
	if(user in view(5, src))
		return TRUE
	else
		say("You must be very busy then, another time, I suppose!")
		return FALSE

// Pink Midnight

/mob/living/simple_animal/hostile/abnormality/sunset_traveller/BreachEffect(mob/living/carbon/human/user)
	can_breach = TRUE
	for(var/mob/living/simple_animal/hostile/ordeal/pink_midnight/pm in GLOB.ordeal_list)
		for(var/turf/target_turf in view(4, pm))
			if(prob(10))
				forceMove(target_turf)
				break
		break
	. = ..()
	HealAlt()
	return ..()

/mob/living/simple_animal/hostile/abnormality/sunset_traveller/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/sunset_traveller/CanAttack(atom/the_target)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/sunset_traveller/proc/HealAlt()
	set waitfor = FALSE
	while (stat != DEAD)
		for(var/mob/living/L in view(5, src))
			L.adjustBruteLoss(-L.maxHealth*0.02)
		if(prob(5))
			say(pick(saylines))
		SLEEP_CHECK_DEATH(10, src)

/mob/living/simple_animal/hostile/abnormality/sunset_traveller/examine(mob/user)
	. = ..()
	. += "\"Look at those butterflies! Aren’t they just beautiful? <br>And gander at that sunset, too! Really makes you want to go for a stroll.\" <br>\
		\"Why don’t you stop for a moment and take a breather here?\" <br>\
		Something yellow gestures warmly at you."

//The moths that heal you
/mob/living/simple_animal/hostile/scarlet_moths
	name = "Scarlet Moths"
	desc = "A set of floating moths."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "fireflies"
	icon_living = "fireflies"
	maxHealth = 8
	health = 8
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 1, TOX = 1)
	melee_damage_type = BRUTE
	stat_attack = HARD_CRIT
	melee_damage_lower = 0
	melee_damage_upper = 0
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	del_on_death = TRUE
	faction = list("neutral")
	light_color = COLOR_ORANGE
	light_range = 5
	light_power = 7
	density = FALSE

/mob/living/simple_animal/hostile/scarlet_moths/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(Explode)), 120 SECONDS)

/mob/living/simple_animal/hostile/scarlet_moths/Life()
	..()
	for(var/mob/living/carbon/human/H in view(5, get_turf(src)))
		H.adjustBruteLoss(-(H.maxHealth*0.03))
		H.adjustSanityLoss(-(H.maxSanity*0.03))
		new /obj/effect/temp_visual/heal(get_turf(H), "#E2ED4A")

/mob/living/simple_animal/hostile/scarlet_moths/proc/Explode()
	qdel(src)
