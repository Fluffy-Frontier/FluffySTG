/mob/living/simple_animal/hostile/abnormality/red_queen
	name = "Red Queen"
	desc = "A noble red abnormality sitting in her chair."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x64.dmi'
	icon_state = "redqueen"
	pixel_x = -8
	base_pixel_x = -8
	maxHealth = 650
	health = 650
	fear_level = HE_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/fury,
		/datum/ego_datum/armor/fury,
	)
	gift_type = /datum/ego_gifts/fury
	observation_prompt = "This abnormality has a notorious reputation for being particularly dry to work with. <br>It's hard to tell what it's thinking or what work it prefers. <br>\
		What type of work will you attempt?"
	var/liked

/mob/living/simple_animal/hostile/abnormality/red_queen/Initialize(mapload)
	. = ..()
	//What does she like?
	//Pick it once so people can find out
	liked = pick(CLOTHING_ENGINEERING, CLOTHING_SCIENCE, CLOTHING_SERVICE, CLOTHING_ARMORED)

/mob/living/simple_animal/hostile/abnormality/red_queen/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() != liked)
		if(prob(20))
			//The Red Queen is fickle, if you're unlucky, fuck you.
			user.visible_message(span_warning("An invisible blade slices through [user]'s neck!"))
			user.apply_damage(200, BRUTE)
			new /obj/effect/temp_visual/slice(get_turf(user))

			//Fitting sound, I want something crunchy, and also very loud so everyone knows
			playsound(src, 'sound/items/weapons/guillotine.ogg', 75, FALSE, 4)

			if(user.health < 0)
				var/obj/item/bodypart/head/head = user.get_bodypart("head")
				//OFF WITH HIS HEAD!
				if(!istype(head))
					return FALSE
				head.dismember()
		else
			to_chat(user, "You narrowly dodge the card-guillotine coming for your neck, that was close, let's try something else.")
	else
		to_chat(user, "You are granted an audience with the red queen. <br>Today, you were able to to satisfy her unpredictable whims")
	return
