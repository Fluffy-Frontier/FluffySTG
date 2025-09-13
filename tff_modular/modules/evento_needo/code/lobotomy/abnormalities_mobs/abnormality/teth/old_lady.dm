/mob/living/simple_animal/hostile/abnormality/old_lady
	name = "Old Lady"
	desc = "An old, decrepit lady sitting in a worn-out rocking chair"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "old_lady"
	maxHealth = 400
	health = 400
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/solitude,
		/datum/ego_datum/armor/solitude,
	)
	gift_type =  /datum/ego_gifts/solitude
	observation_prompt = "There was some cracking along the floor. \
		Hair-raising screeching of wooden rocking chair filled the air. I did not want to enter this house. \
		Because I don't like to listen to stories. Bugs were buzzing around here and there. \
		Something slimy popped as I set my foot on it. I found her. Every hole on her face was swarming bugs. \
		I don't want to stay here. I want to get out. It's damp, nasty, and awful. I can't stand it anymore."


	var/meltdown_cooldown_time = 120 SECONDS
	var/meltdown_cooldown
//for solitude effects
	var/solitude_cooldown_time = 1 SECONDS
	var/solitude_cooldown
	update_qliphoth = 4

/mob/living/simple_animal/hostile/abnormality/old_lady/Life()
	. = ..()
	if(meltdown_cooldown < world.time) // Doesn't decrease while working but will afterwards
		meltdown_cooldown = world.time + meltdown_cooldown_time
		qliphoth_change(-1)

	if(solitude_cooldown < world.time && datum_reference.qliphoth_meter == 0)
		solitude_cooldown = world.time + solitude_cooldown_time
		for(var/turf/open/T in range(2 , src))
			if(prob(70))
				new /obj/effect/solitude (T)

/mob/living/simple_animal/hostile/abnormality/old_lady/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(!.)
		return
	icon_state = "old_lady"
	return

//The Effect
/obj/effect/solitude
	name = "solitude gas"
	desc = "You can hardly see through this."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi'
	icon_state = "solitude1"
	move_force = INFINITY
	pull_force = INFINITY
	layer = ABOVE_MOB_LAYER

/obj/effect/solitude/Initialize()
	. = ..()
	icon_state = "solitude[pick(1,2,3,4)]"
	animate(src, alpha = 0, time = 3 SECONDS)
	QDEL_IN(src, 3 SECONDS)
