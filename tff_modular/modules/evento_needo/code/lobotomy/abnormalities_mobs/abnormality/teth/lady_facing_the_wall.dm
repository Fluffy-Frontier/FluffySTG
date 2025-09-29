/mob/living/simple_animal/hostile/abnormality/wall_gazer
	name = "Lady Facing the Wall"
	desc = "An abnormality that is a pale, naked woman with long, black hair that completely obscures her face"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x48.dmi'
	icon_state = "ladyfacingthewall"
	maxHealth = 400
	health = 400
	fear_level = TETH_LEVEL

	pixel_x = -32
	base_pixel_x = -8
	var/scream_range = 10
	var/scream_damage = 45
	ego_list = list(
		/datum/ego_datum/weapon/wedge,
		/datum/ego_datum/armor/wedge,
	)
	gift_type =  /datum/ego_gifts/wedge
	observation_prompt = "A woman is crying. \
		You cannot see her face as you are turned back to her. But you know who she is. \
		Her muttering is unintelligible, and it gives you goosebumps. You don't like being in the same space with her. \
		You want to get out. The woman seems to be sobbing. You feel as though her crying is insisting you to turn towards her. \
		And you also feel, that you should not."


/mob/living/simple_animal/hostile/abnormality/wall_gazer/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(prob(40))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/wall_gazer/FailureEffect(mob/living/carbon/human/user)
	if(prob(70))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/wall_gazer/ZeroQliphoth(mob/living/carbon/human/user)
	scream()
	return

/mob/living/simple_animal/hostile/abnormality/wall_gazer/proc/scream()
	for(var/mob/living/L in view(scream_range, src))
		if(faction_check_atom(L, FALSE))
			continue
		if(L.stat == DEAD)
			continue
		playsound(get_turf(src), 'sound/mobs/humanoids/human/scream/femalescream_2.ogg', 400)
		L.apply_damage(scream_damage, BRUTE)

/mob/living/simple_animal/hostile/abnormality/wall_gazer/PostWorkEffect(mob/living/carbon/human/user)
	// If you do work while having low Temperance, fuck you and you go insane for turning your back to face her
	if(user.get_major_clothing_class() == CLOTHING_SERVICE)
		qliphoth_change(-1)

	if((user.get_clothing_class_level(CLOTHING_SERVICE) < 2) && !(HAS_TRAIT(user, TRAIT_GODMODE)))
		flick("ladyfacingthewall_active", src)
		user.adjustSanityLoss(user.maxSanity)
		user.apply_status_effect(/datum/status_effect/panicked_lvl_4)
	return ..()
