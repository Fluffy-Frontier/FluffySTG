/mob/living/simple_animal/hostile/abnormality/bottle
	name = "Bottle of Tears"
	desc = "A bottle filled with water with a cake on top"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "bottle1"
	icon_living = "bottle1"
	maxHealth = 800
	health = 800
	damage_coeff = list(BURN = 1, BRAIN = 1.5, BRUTE = 0.5, TOX = 2)
	fear_level = ZAYIN_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/little_alice,
		/datum/ego_datum/armor/little_alice,
	)
	gift_type = /datum/ego_gifts/alice
	gift_message = "Welcome to your very own Wonderland~"
	verb_say = "begs"
	move_to_delay = 5

	melee_damage_lower = 4
	melee_damage_upper = 8
	melee_damage_type = BRUTE

	attack_verb_continuous = "begs"
	attack_verb_simple = "beg"

	var/cake = 3 //How many cake charges are there (2)
	var/speak_cooldown_time = 5 SECONDS
	var/speak_damage = 8
	var/eating = FALSE
	var/scooped = FALSE // There can only be one eye scooper
	var/cake_regen = FALSE
	COOLDOWN_DECLARE(speak_damage_aura)
	update_qliphoth = -1
	action_cooldown = 10 SECONDS

/mob/living/simple_animal/hostile/abnormality/bottle/examine(mob/user)
	. = ..()
	. += "It was all very well to say \"Drink me\" but wisdom told you not to do that in a hurry. <br>\
		The bottle had no markings to denote whether it was poisonous but you could not be sure, it was almost certain to disagree with you, sooner or later..."

/mob/living/simple_animal/hostile/abnormality/bottle/attack_hand(mob/living/carbon/human/M)
	. = ..()
	if(!.)
		return
	if(eating)
		to_chat(M, span_notice("Someone else is already drinking from [src], it'd be kinda weird to join them..."))
		return
	eating = TRUE
	to_chat(M, span_notice("You start drinking from the bottle."))

	if(do_after(M, 2 SECONDS, src, IGNORE_HELD_ITEM, interaction_key = src, max_interact_count = 1))
		if(prob(50) && cake)
			cake -= 1 //Eat some cake
			if(cake > 0)
				M.adjustBruteLoss(-500) // It heals you to full if you eat it
				to_chat(M, span_nicegreen("You consume the cake. Delicious!"))
				update_icon_state() //cake looks eaten
				return
			cake_regen = TRUE

			//Drowns you like Wellcheers does, so I mean the code checks out
			for(var/turf/open/T in view(7, src))
				new /obj/effect/temp_visual/water_waves(T)
			playsound(get_turf(M), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/bottle/bottledrown.ogg', 80, 0)
			update_icon_state() //cake all gone

			if(!scooped)
				new /obj/item/ego_weapon/eyeball(get_turf(M)) // We can only ever spawn one eye scooper
				scooped = TRUE
			if(prob(60))
				to_chat(M, span_userdanger("The room is filling with water! Are you going to drown?!"))
				M.adjustBruteLoss(40) // Hurt bad, but never lethally.
				if(prob(20))
					M.adjustBruteLoss(999) // okay, now you've done it
			M.AdjustSleeping(10 SECONDS)
			if(M.stat == DEAD)
				animate(M, alpha = 0, time = 2 SECONDS)
				QDEL_IN(M, 3.5 SECONDS)
				return

			M.adjustBruteLoss(-(M.maxHealth * 0.25)) // If you didn't die instantly, heal up some.
		else
			playsound(get_turf(M), 'sound/machines/synth/synth_yes.ogg', 25, FALSE, -4)
			M.adjustSanityLoss(-(speak_damage*4)) // Heals the mind
			speak_damage = initial(speak_damage)
		to_chat(M, span_nicegreen("Isn't it wonderful? Your very own Wonderland!"))
	else
		to_chat(M, span_notice("You decide against drinking from the bottle..."))
		M.apply_damage(speak_damage, BRUTE)
	eating = FALSE

/mob/living/simple_animal/hostile/abnormality/bottle/update_icon_state()
	if(cake == 3)
		icon_state = "bottle1"
	else if (cake > 1) // Chowin down
		icon_state = "bottle2"
	else if (cake == 1) // This serves as the warning sprite to stop eating the freakin' cake, man!
		icon_state = "bottle3"
	else
		icon_state = "bottle4"
	return ..()

// Pink Midnight Breach
/mob/living/simple_animal/hostile/abnormality/bottle/BreachEffect(mob/living/carbon/human/user, breach_type)
	ADD_TRAIT(src, TRAIT_MOVE_FLYING, INNATE_TRAIT)
	COOLDOWN_START(src, speak_damage_aura, speak_cooldown_time)
	icon_state = "bottle_breach"
	desc = "A floating bottle, leaking tears.\nYou can use an empty hand to drink from it."
	can_breach = TRUE
	return ..()

/mob/living/simple_animal/hostile/abnormality/bottle/ListTargets()
	. = ..()
	for(var/mob/living/carbon/human/H in .)
		if(H.sanity_lost)
			. -= H
			continue

/mob/living/simple_animal/hostile/abnormality/bottle/Move()
	if(!eating)
		return ..()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/bottle/AttackingTarget(atom/attacked_target)
	if(eating)
		return
	if(isliving(attacked_target))
		var/mob/living/L = attacked_target
		if(faction_check_atom(L))
			L.visible_message(span_danger("[src] feeds [L]... [L] seems heartier!"), span_nicegreen("[src] feeds you, you feel heartier!"))
			L.adjustBruteLoss(-speak_damage/2)
			return
	return ..()

/mob/living/simple_animal/hostile/abnormality/bottle/Life()
	. = ..()
	if(!.)
		return
	if(COOLDOWN_FINISHED(src, speak_damage_aura) && !eating)
		COOLDOWN_START(src, speak_damage_aura, speak_cooldown_time)
		for(var/mob/living/L in view(vision_range, src))
			if(L == src)
				continue
			if(faction_check_atom(L, FALSE))
				continue
			L.apply_damage(speak_damage, BRUTE)
		adjustBruteLoss(-speak_damage) // It falls further into desperation
		if(speak_damage < 40)
			speak_damage += 4
