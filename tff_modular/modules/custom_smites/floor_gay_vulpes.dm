/proc/gay_vulpes_gib(mob/living/carbon/sweet_sweet_boy)
	if(isobserver(sweet_sweet_boy))
		return

	ADD_TRAIT(sweet_sweet_boy, TRAIT_NO_TELEPORT, SMITE_TRAIT)
	sweet_sweet_boy.Stun(200 SECONDS, ignore_canstun = TRUE) // Cant move by themself
	sweet_sweet_boy.mobility_flags = NONE // Cant rest to break animation
	GLOB.move_manager.stop_looping(sweet_sweet_boy) // Cant be grabbed
	sweet_sweet_boy.density = 0 // Cant be moved by walking into them
	sweet_sweet_boy.layer = 0
	sweet_sweet_boy.move_resist = MOVE_RESIST_DEFAULT * 1000
	var/turf/open/the_turf = pick(RANGE_TURFS(1, get_turf(sweet_sweet_boy)))

	while(the_turf == get_turf(sweet_sweet_boy))
		the_turf = pick(RANGE_TURFS(1, get_turf(sweet_sweet_boy)))


	if(!the_turf)
		sweet_sweet_boy.gib()
		return
	sweet_sweet_boy.visible_message(
		span_danger("[sweet_sweet_boy]'s leg is stuck in the floor crack. Wait... Is it opening?."),
		span_bolddanger("Your leg gets stuck in the floor crack below, but something isn't right. The tile begins to move..."),
		blind_message = span_hear("You hear someone's horny laughs."),
	)
	playsound(the_turf, 'tff_modular/modules/custom_smites/sounds/floor_clown_ambience.ogg', 70, TRUE)

	var/mob/living/carbon/human/species/vulpkanin/gib_vulp/horny1 = new /mob/living/carbon/human/species/vulpkanin/gib_vulp(the_turf)
	horny1.pixel_x = -12
	horny1.pixel_y = -5
	var/mob/living/carbon/human/species/vulpkanin/gib_vulp/horny2 = new /mob/living/carbon/human/species/vulpkanin/gib_vulp(the_turf)
	horny2.pixel_y = -10
	var/mob/living/carbon/human/species/vulpkanin/gib_vulp/horny3 = new /mob/living/carbon/human/species/vulpkanin/gib_vulp(the_turf)
	horny3.pixel_x = 12
	horny3.pixel_y = -5

	animate_slide(the_turf, 0, -24, 5 SECONDS)
	sleep(5 SECONDS)
	if(!horny1 || !horny2 || !horny3)
		animate_slide(the_turf, 0, 0, 5 SECONDS)
		sweet_sweet_boy.gib()
		return
	horny1.say("Мальчики, что то я совсем заскучал.")
	sleep(3 SECONDS)
	horny2.say("И вправду, тяжело найти хорошеньких сейчас. Рассядутся по отделам и...")
	sleep(2 SECONDS)
	horny3.say("Тихо проказники! Смотрите какая конфетка!")
	sleep(2 SECONDS)
	horny3.point_at(sweet_sweet_boy)
	sleep(1 SECONDS)
	horny1.say("*look")
	horny2.say("*look")
	horny3.say("*look")
	sleep(4 SECONDS)
	for(var/i = 1 to 3)
		var/replica = ((sweet_sweet_boy.gender == "male") ? "Мальчик!" : (sweet_sweet_boy.gender == "female") ? "Девочка!" : "Лапочка!")
		horny1.say(replica)
		horny2.say(replica)
		horny3.say(replica)
		sleep(2 SECONDS)
	horny2.say("Я хочу расцеловать [(sweet_sweet_boy.gender == "male") ? "его" : (sweet_sweet_boy.gender == "female") ? "её" : "эту красотульку"] сейчас же! Тащим!")
	sleep(1 SECONDS)
	horny1.say("ОБНИМАШКИ!!")
	sleep(1 SECONDS)
	horny3.say("ЦЕЛОВАШКИ!!")
	sleep(1 SECONDS)
	if(!horny1 || !horny2 || !horny3)
		animate_slide(the_turf, 0, 0, 5 SECONDS)
		sweet_sweet_boy.gib()
		return
	sweet_sweet_boy.visible_message(
		span_bolddanger("[horny1] drags [sweet_sweet_boy] beneath [the_turf]!"),
		span_bolddanger("[horny1] drag you beneath [the_turf]!"),
		blind_message = span_hear("You hear nails scraping on the floor!")
	)
	sweet_sweet_boy.Move(the_turf)
	sweet_sweet_boy.layer = 0
	sweet_sweet_boy.plane = -7
	sweet_sweet_boy.Stun(200 SECONDS, ignore_canstun = TRUE) // Move resets all of this
	sweet_sweet_boy.mobility_flags = NONE
	GLOB.move_manager.stop_looping(sweet_sweet_boy)
	sweet_sweet_boy.density = 0
	sweet_sweet_boy.layer = 0
	sweet_sweet_boy.move_resist = MOVE_RESIST_DEFAULT * 1000

	animate_slide(the_turf, 0, 0, 5 SECONDS)
	// The show begins
	playsound(the_turf, 'tff_modular/modules/custom_smites/sounds/dont_leave_me_here.ogg', 60, FALSE)
	sleep(1 SECONDS)
	playsound(the_turf, 'sound/effects/emotes/kiss.ogg', 40, TRUE)
	sleep(0.5 SECONDS)
	playsound(the_turf, 'sound/effects/emotes/kiss.ogg', 40, TRUE)
	sleep(0.25 SECONDS)
	playsound(the_turf, 'sound/effects/emotes/assslap.ogg', 40, TRUE)
	playsound(the_turf, 'sound/effects/emotes/kiss.ogg', 40, TRUE)
	sleep(0.25 SECONDS)
	playsound(the_turf, 'sound/effects/emotes/kiss.ogg', 40, TRUE)
	playsound(the_turf, 'sound/effects/emotes/assslap.ogg', 40, TRUE)
	sleep(0.5 SECONDS)
	playsound(the_turf, 'sound/effects/emotes/kiss.ogg', 40, TRUE)
	for(var/i = 1 to 12)
		sleep(0.25 SECONDS)
		playsound(the_turf, 'sound/effects/emotes/kiss.ogg', 40, TRUE)
		if (prob(50))
			playsound(the_turf, 'sound/effects/emotes/assslap.ogg', 40, TRUE)
	the_turf.Shake(1, 1, 2.5 SECONDS)
	sleep(1 SECONDS)
	playsound(the_turf, 'sound/effects/cartoon_sfx/cartoon_splat.ogg', 80, TRUE)
	sleep(2 SECONDS)
	playsound(the_turf, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 80, TRUE)
	sweet_sweet_boy.ghostize()
	qdel(sweet_sweet_boy)
	qdel(horny1)
	qdel(horny2)
	qdel(horny3)

/mob/living/carbon/human/species/vulpkanin/gib_vulp
	gender = "male"
	plane = -7
	layer = 0
	move_resist = MOVE_RESIST_DEFAULT * 1000

/mob/living/carbon/human/species/vulpkanin/gib_vulp/Initialize()
	. = ..()
	mobility_flags = NONE
	GLOB.move_manager.stop_looping(src)
	density = 0
	src.add_traits(list(TRAIT_GODMODE, TRAIT_NO_TELEPORT), SMITE_TRAIT)
	set_active_language(/datum/language/common)
	equipOutfit(/datum/outfit/job/assistant)

/datum/smite/floor_gay_vulpes
	name = "Send to three floor gay vulpes(GIB)"

/datum/smite/floor_gay_vulpes/effect(client/user, mob/living/target)
	if (!isliving(target))
		return // This doesn't work on ghosts
	if(!iscarbon(target))
		to_chat(user, span_warning("This must be used on a sweet sweet carbon mob."), confidential = TRUE)
		return
	. = ..()

	gay_vulpes_gib(target)
