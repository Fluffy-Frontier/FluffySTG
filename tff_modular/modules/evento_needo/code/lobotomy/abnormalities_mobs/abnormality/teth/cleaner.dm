/mob/living/simple_animal/hostile/abnormality/cleaner
	name = "All-Around Cleaner"
	desc = "A tiny robot with helpful intentions."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "cleaner"
	icon_living = "cleaner"
	maxHealth = 800
	health = 800
	ranged = TRUE
	attack_verb_continuous = "cleans"
	attack_verb_simple = "cleans"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/helper/attack.ogg'
	stat_attack = HARD_CRIT
	melee_damage_lower = 11
	melee_damage_upper = 12
	damage_coeff = list(BURN = 1, BRAIN = 0.7, BRUTE = 1, TOX = 2, BRUTE = 2)
	speak_emote = list("states")
	speech_span = SPAN_ROBOT
	vision_range = 14
	aggro_vision_range = 20

	can_breach = TRUE
	fear_level = TETH_LEVEL
	faction = list("neutral", "hostile")
	ego_list = list(
		/datum/ego_datum/weapon/sanitizer,
		/datum/ego_datum/armor/sanitizer,
	)
	gift_type =  /datum/ego_gifts/sanitizer
	gift_message = "Contamination scan complete. Initiating cleaning protocol."
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/helper = 1.5,
		/mob/living/simple_animal/hostile/abnormality/we_can_change_anything = 1.5,
	)

	observation_prompt = "I wipe everything. <br>\
		Cleaning is enjoyable. <br>\
		I like to be the same as others. <br>\
		... <br>\
		I am frankly troubled. <br>\
		The model next to mine boasted that it has multiple parts that others don't. <br>\
		Is that what makes one special? <br>\
		Am I special the way I am?"


	var/bumpdamage = 10

/mob/living/simple_animal/hostile/abnormality/cleaner/Move()
	..()
	//Toss meatbags aside
	for(var/mob/living/carbon/human/H in range(1, src))
		if(H.stat >= SOFT_CRIT)
			continue
		visible_message("[src] tosses [H] out of the way!")
		H.apply_damage(bumpdamage, BRUTE)

		var/rand_dir = pick(NORTH, SOUTH, EAST, WEST)
		var/atom/throw_target = get_edge_target_turf(H, rand_dir)
		if(!H.anchored)
			H.throw_at(throw_target, rand(6, 10), 18, H)

		if(H.stat == DEAD)
			H.gib(FALSE, FALSE, FALSE)

	//destroy the unclean
	for(var/turf/tile in view(src, 2))
		tile.wash(CLEAN_SCRUB)
		for(var/A in tile)
			// Clean small items that are lying on the ground
			if(isitem(A))
				var/obj/item/I = A
				if(I.w_class <= WEIGHT_CLASS_SMALL && !ismob(I.loc))
					I.wash(CLEAN_SCRUB)
			// Clean humans that are lying down
			else if(ishuman(A))
				var/mob/living/carbon/human/cleaned_human = A
				if(cleaned_human.body_position == LYING_DOWN)
					cleaned_human.wash(CLEAN_SCRUB)
					cleaned_human.regenerate_icons()
					to_chat(cleaned_human, span_danger("[src] flawlessly cleans you of your features!"))
					ADD_TRAIT(cleaned_human, TRAIT_DISFIGURED, TRAIT_GENERIC) //cleans your face of uneeded features

/mob/living/simple_animal/hostile/abnormality/cleaner/update_icon_state()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		icon = initial(icon)
		pixel_x = initial(pixel_x)
		base_pixel_x = initial(base_pixel_x)
		pixel_y = initial(pixel_y)
		base_pixel_y = initial(base_pixel_y)
	else
		icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
		pixel_x = -8
		base_pixel_x = -8
		pixel_y = -8
		base_pixel_y = -8
	return ..()

/* Work effects */
/mob/living/simple_animal/hostile/abnormality/cleaner/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(prob(40))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/cleaner/FailureEffect(mob/living/carbon/human/user)
	if(prob(80))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/cleaner/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	update_icon()
	GiveTarget(user)
