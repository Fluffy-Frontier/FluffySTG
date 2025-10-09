//Coded by Coxswain, sprite by Mel
/mob/living/simple_animal/hostile/abnormality/beanstalk
	name = "Beanstalk without Jack"
	desc = "A gigantic stem that reaches higher than the eye can see."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x98.dmi'
	icon_state = "beanstalk"
	maxHealth = 500
	health = 500
	fear_level = TETH_LEVEL

	pixel_x = -16
	base_pixel_x = -16
	ego_list = list(
		/datum/ego_datum/weapon/bean,
		/datum/ego_datum/weapon/giant,
		/datum/ego_datum/armor/bean,
	)
	gift_type = /datum/ego_gifts/bean
	observation_prompt = "You remember an employee was obsessed with this abnormality. <br>\"\
		If you reach the top, you'll find what you've been looking for!\", He'd tell every employee. <br>\
		One day he did climb the beanstalk, and never came back down. <br>Perhaps he's doing okay up there."

	var/climbing = FALSE

/mob/living/simple_animal/hostile/abnormality/beanstalk/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/beanstalk/CanAttack(atom/the_target)
	return FALSE

//Performing instinct work at >4 fortitude starts a special work
/mob/living/simple_animal/hostile/abnormality/beanstalk/try_working(mob/living/carbon/human/user)
	if((user.get_clothing_class_level(CLOTHING_ENGINEERING) >= 4) && (user.get_major_clothing_class() == CLOTHING_ENGINEERING))
		climbing = TRUE
	return ..()

//When working at <2 Temperance and Prudence, or when panicking it is an instant death.
/mob/living/simple_animal/hostile/abnormality/beanstalk/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_clothing_class_level(CLOTHING_SERVICE) < 2 && user.get_clothing_class_level(CLOTHING_SCIENCE) < 2 || user.sanity_lost)
		user.Stun(30 SECONDS)
		step_towards(user, src)
		sleep(0.5 SECONDS)
		if(QDELETED(user))
			return
		step_towards(user, src)
		sleep(0.5 SECONDS)
		if(QDELETED(user))
			return
		animate(user, alpha = 0,pixel_x = 0, pixel_z = 16, time = 3 SECONDS)
		to_chat(user, span_userdanger("You will make it to the top, no matter what!"))
		QDEL_IN(user, 3.5 SECONDS)

//The special work, if you survive you get a powerful EGO gift.
	if(climbing)
		if(user.sanity_lost || user.stat >= SOFT_CRIT || user.stat == DEAD)
			climbing = FALSE
			return

		user.Stun(3 SECONDS)
		step_towards(user, src)
		sleep(0.5 SECONDS)
		if(QDELETED(user))
			climbing = FALSE
			return
		step_towards(user, src)
		sleep(0.5 SECONDS)
		if(QDELETED(user))
			climbing = FALSE
			return
		to_chat(user, span_userdanger("You start to climb!"))
		animate(user, alpha = 1,pixel_x = 0, pixel_z = 16, time = 3 SECONDS)
		user.pixel_z = 16
		user.Stun(10 SECONDS)
		sleep(6 SECONDS)
		if(QDELETED(user))
			climbing = FALSE
			return
		var/datum/ego_gifts/giant/BWJEG = new
		BWJEG.datum_reference = datum_reference
		user.Apply_Gift(BWJEG)
		animate(user, alpha = 255,pixel_x = 0, pixel_z = -16, time = 3 SECONDS)
		user.pixel_z = 0
		to_chat(user, span_userdanger("You return with the giant's treasure!"))
	climbing = FALSE

/datum/ego_gifts/giant
	name = "Giant"
	icon_state = "giant"
	slot = LEFTBACK
