//She tells stories, and does sanity damage. What can I say?
/mob/living/simple_animal/hostile/abnormality/drownedsisters
	name = "Drowned Sisters"
	desc = "A pair of girls with masks covering their faces."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x64.dmi'
	icon_state = "sisters"
	maxHealth = 400
	health = 400
	fear_level = TETH_LEVEL
	pixel_x = -32
	base_pixel_x = -32

	ego_list = list(
		/datum/ego_datum/weapon/sorority,
		/datum/ego_datum/armor/sorority,
	)
	gift_type =  /datum/ego_gifts/sorority
	observation_prompt = "You sit cross-legged before the pair, flowers conceal their faces and expression. <br>\
		\"Ahh, woe is us. We have become sinners. Please hear us, hear of our sins that we do not know we've committed, and absolve us of our grief...\""


	var/breaching = FALSE

//Work Mechanics
/mob/living/simple_animal/hostile/abnormality/drownedsisters/try_working(mob/living/carbon/human/user)
	if(breaching)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/drownedsisters/PostWorkEffect(mob/living/carbon/human/user)
// okay so according to the lore you're not really supposed to remember the stories she says so we're going to make it so your sanity goes back up
	if(!user.sanity_lost)
		user.adjustSanityLoss(-user.get_clothing_class_level(CLOTHING_SCIENCE) * 20)
	..()
	switch(user.get_major_clothing_class())
		if(CLOTHING_ENGINEERING)
			qliphoth_change(-1)
		if(CLOTHING_SERVICE)
			if(datum_reference.qliphoth_meter == 3)
				FloodRoom()
			else
				qliphoth_change(1)
	return

//Breaches
/mob/living/simple_animal/hostile/abnormality/drownedsisters/ZeroQliphoth(mob/living/carbon/human/user)
	qliphoth_change(3)
	if(!user)
		return
	to_chat(user, span_userdanger("You are attacked by an invisible assailant!"))
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/jangsan/tigerbite.ogg', 75, 0)
	user.apply_damage(200, BRUTE, null)
	if(user.health < 0 || user.stat == DEAD)
		user.gib(DROP_ALL_REMAINS)
	return ..()

/mob/living/simple_animal/hostile/abnormality/drownedsisters/proc/FloodRoom() //Qliphoth Went over max
	breaching = TRUE
	for(var/turf/open/T in view(7, src))
		new /obj/effect/temp_visual/water_waves(T)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/piscinemermaid/waterjump.ogg', 75, 0)
	var/list/teleport_potential = list()
	for(var/turf/T in GLOB.generic_event_spawns)
		teleport_potential += T
	if(!LAZYLEN(teleport_potential))
		return
	for(var/mob/living/carbon/human/H in view(7, src))
		if(!H.sanity_lost)
			var/turf/teleport_target = pick(teleport_potential)
			TeleportPerson(H, teleport_target)
		else
			QDEL_NULL(H.ai_controller) //If they panicked, they just drown
			H.adjustOxyLoss(200)
	sleep(5 SECONDS)
	qliphoth_change(3)
	breaching = FALSE

/mob/living/simple_animal/hostile/abnormality/drownedsisters/proc/TeleportPerson(mob/living/carbon/human/H, turf/teleport_target)
	set waitfor = FALSE
	to_chat(H, span_userdanger("You can't breathe!"))
	H.AdjustSleeping(10 SECONDS)
	animate(H, alpha = 0, time = 2 SECONDS)
	sleep(2 SECONDS)
	H.forceMove(get_turf(teleport_target)) // See ya!
	animate(H, alpha = 255, time = 0 SECONDS)
