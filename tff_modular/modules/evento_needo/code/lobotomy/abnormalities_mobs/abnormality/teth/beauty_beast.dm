/mob/living/simple_animal/hostile/abnormality/beauty
	name = "Beauty and the Beast"
	desc = "A quadruped monster covered in brown fur. The amount of the eyes it has is impossible to count."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "beauty"
	icon_living = "beauty"
	icon_dead = "beauty_dead"
	pixel_x = -8
	base_pixel_x = -8

	maxHealth = 650
	health = 650
	del_on_death = FALSE
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/horn,
		/datum/ego_datum/armor/horn,
	)
	gift_type =  /datum/ego_gifts/horn
	observation_prompt = "I see blood puddle here and there in the room. \
		This is not the blood of employees. I hear the monster roaring. It wants to die. Every single day. \
		These puddles are evidence of monster's futile struggle to end its life. \
		\"Kill me. Stab me with that knife you have.\" The monster cannot talk. However, the soul trapped in it can talk and I can hear it. \
		\"Why are you not helping me when you can hear me?\" The monster asks reproachfully."


	var/injured = FALSE

//it needs to use PostSpawn or we can't get the datum of beauty
/mob/living/simple_animal/hostile/abnormality/beauty/PostSpawn()
	. = ..()
	//var/cursed = RememberVar("cursed")
	//if(!cursed)
	//	return
	for(var/mob/dead/observer/O in GLOB.player_list) //we grab the last person that died to beauty and yeet them in there
		if(O.ckey == cursed)
			O.mind.transfer_to(src)
			src.ckey = cursed
			to_chat(src, span_userdanger("You begin to have hundreds of eyes burst from your mouth, while a pair of horns expel from your eye sockets, adorning themselves with flowers. Now the Beast, you forever search for someone to lift your curse."))
			to_chat(src, span_notice("(If you wish to leave this body you can simply ghost with the ooc tab > ghost, there is no consequence for doing so.)"))
			//TransferVar("cursed", null) //we reset the cursed just in case
			return

/mob/living/simple_animal/hostile/abnormality/beauty/death(gibbed)
	density = FALSE
	animate(src, alpha = 0, time = 10 SECONDS)
	QDEL_IN(src, 10 SECONDS)
	..()

/mob/living/simple_animal/hostile/abnormality/beauty/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == CLOTHING_ARMORED)
		if(!injured)
			injured = TRUE
			icon_state = "beauty_injured"

		else if (!(HAS_TRAIT(user, TRAIT_GODMODE)))//If you already did repression, die.
			//TransferVar("cursed", user.ckey)
			user.gib()
			death()

	else
		injured = FALSE
		icon_state = icon_living
	return


