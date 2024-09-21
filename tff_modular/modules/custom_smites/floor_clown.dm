/proc/cluwnegib(mob/living/clowns_dinner, duration = 30)
	if(isobserver(clowns_dinner))
		return

	ADD_TRAIT(clowns_dinner, TRAIT_NO_TELEPORT, SMITE_TRAIT)
	clowns_dinner.Stun(200 SECONDS, ignore_canstun = TRUE) // Cant move by themself
	clowns_dinner.mobility_flags = NONE // Cant rest to break animation
	GLOB.move_manager.stop_looping(clowns_dinner) // Cant be grabbed
	clowns_dinner.density = 0 // Cant be moved by walking into them
	clowns_dinner.layer = 0
	clowns_dinner.move_resist = MOVE_RESIST_DEFAULT * 1000
	var/turf/open/the_turf = pick(RANGE_TURFS(1, get_turf(clowns_dinner)))

	while(the_turf == get_turf(clowns_dinner))
		the_turf = pick(RANGE_TURFS(1, get_turf(clowns_dinner)))


	if(!the_turf)
		clowns_dinner.gib()
		return
	clowns_dinner.visible_message(
		span_danger("[clowns_dinner] trembles in fear, as he is about to become clown's dinner."),
		span_bolddanger("HE IS COMING FOR YOU. YOU CAN'T ESCAPE."),
		blind_message = span_hear("You hear someone's evil laugh."),
	)
	playsound(the_turf, 'tff_modular/modules/custom_smites/sounds/floor_clown_ambience.ogg', 70, TRUE)

	var/mob/living/carbon/human/floor_clown/floorcluwne = new /mob/living/carbon/human/floor_clown(the_turf)

	animate_slide(the_turf, 0, -24, duration)
	sleep(duration/2)
	if(!floorcluwne)
		animate_slide(the_turf, 0, 0, duration)
		clowns_dinner.gib()
		return
	floorcluwne.say("WHAT A PRETTY SKIN YOU HAVE. MAY I LEND IT?")
	floorcluwne.point_at(clowns_dinner)
	sleep(duration/2)
	if(!floorcluwne)
		animate_slide(the_turf, 0, 0, duration)
		clowns_dinner.gib()
		return
	clowns_dinner.visible_message(
		span_bolddanger("[floorcluwne] drags [clowns_dinner] beneath [the_turf]!"),
		span_bolddanger("[floorcluwne] drag you beneath [the_turf]!"),
		blind_message = span_hear("You hear nails scraping on the floor!")
	)
	playsound(the_turf, 'sound/misc/scary_horn.ogg', 60, 2)
	clowns_dinner.Move(the_turf)
	clowns_dinner.layer = 0
	clowns_dinner.plane = -7
	clowns_dinner.Stun(200 SECONDS, ignore_canstun = TRUE) // Move resets all that shit
	clowns_dinner.mobility_flags = NONE
	GLOB.move_manager.stop_looping(clowns_dinner)
	clowns_dinner.density = 0
	clowns_dinner.layer = 0
	clowns_dinner.move_resist = MOVE_RESIST_DEFAULT * 1000
	clowns_dinner.anchored = TRUE
	clowns_dinner.ghostize()
	animate_slide(the_turf, 0, 0, duration)
	sleep(duration+5)
	qdel(floorcluwne)
	qdel(clowns_dinner)

/proc/animate_slide(var/atom/to_animate, var/px, var/py, var/time_to_sleep = 10, var/ease = SINE_EASING)
	if(!istype(to_animate))
		return

	var/image/underlay
	if (isturf(to_animate))
		underlay = image('tff_modular/modules/custom_smites/icons/floors.dmi', icon_state = "solid_black")
		underlay.appearance_flags |= RESET_TRANSFORM
		underlay.plane = -8
		to_animate.underlays += underlay

	// Sliding turf down
	animate(to_animate, transform = list(1, 0, px, 0, 1, py), time = time_to_sleep, easing = ease, flags=ANIMATION_PARALLEL)

	if (underlay)
		sleep(time_to_sleep)
		to_animate.underlays -= underlay
		qdel(underlay)

/mob/living/carbon/human/floor_clown
	name = "Floor cluwne"
	real_name = "Floor cluwne"
	gender = "male"
	plane = -7
	layer = 0
	move_resist = MOVE_RESIST_DEFAULT * 1000

/mob/living/carbon/human/floor_clown/Initialize()
	. = ..()
	mobility_flags = NONE
	GLOB.move_manager.stop_looping(src)
	density = 0
	src.add_traits(list(TRAIT_GODMODE, TRAIT_NO_TELEPORT), SMITE_TRAIT)
	equipOutfit(/datum/outfit/consumed_clown)
	set_jitter(60 SECONDS)

/datum/smite/floor_clown
	name = "Floor clown gib"

/datum/smite/floor_clown/effect(client/user, mob/living/target)
	if (!isliving(target))
		return // This doesn't work on ghosts
	. = ..()
	cluwnegib(target)
