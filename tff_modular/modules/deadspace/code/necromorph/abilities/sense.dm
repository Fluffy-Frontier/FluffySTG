/*
/datum/action/innate/sense
	name = "Sense the Unwhole"
	desc = "They cannot stop what is coming. Use to sense those who are not Whole."
	button_icon = 'icons/mob/actions/actions_cult.dmi' //TODO : Get our own sense button sprites
	background_icon_state = "bg_demon"
	buttontooltipstyle = "cult"
	button_icon_state = "cult_mark"

//This is rewritten cultist harvester code kitbashed into the original sense code
//It works well enough for our purposes
/datum/action/innate/sense/Activate()
	var/mob/living/carbon/human/necromorph/sensor = owner
	var/thelist = sensor.marker.unwhole
	if(sensor.marker == null)
		return
	if(sensor.searching)
		desc = "They cannot stop what is coming. Use to sense those who are not Whole."
		button_icon_state = "cult_mark"
		sensor.searching = FALSE
		sensor.sense_target = null
		to_chat(sensor, "<span class='cult italic'>You are no longer sensing.</span>", MESSAGE_TYPE_LOCALCHAT)
		sensor.clear_alert("necrosense")
		return
	else
		for(var/mob/living/found in thelist)
			found = pick(thelist)
			if(QDELETED(found))
				LAZYREMOVE(found, thelist) //He's dead, remove him from the list
				continue
			if(found.stat == DEAD)
				LAZYREMOVE(found, thelist) //He's dead, remove him from the list
				continue
			if(found.z != owner.z)
				continue //If we're not on the same floor ignore it
			sensor.sense_target = found
			to_chat(sensor, span_cult_italic("You are now tracking your prey, [found.real_name] - find [found.p_them()]!"), MESSAGE_TYPE_LOCALCHAT)
		if(!sensor.sense_target)
			to_chat(sensor, span_cult_italic("There is nobody on this floor."), MESSAGE_TYPE_LOCALCHAT)
			return
		desc = "Activate to stop sensing."
		button_icon_state = "sintouch"
		sensor.searching = TRUE
		sensor.throw_alert("necrosense", /atom/movable/screen/alert/necrosense)
		sensor.play_necro_sound(SOUND_SPEECH, VOLUME_MID, TRUE, 3)
		play_effects()

/datum/action/innate/sense/proc/play_effects()
	set waitfor = FALSE

	var/obj/effect/temp_visual/circle = new /obj/effect/temp_visual/expanding_circle(owner.loc, 2 SECONDS, 2)
	circle.pixel_y += 40 //Offset it so it appears to be at our mob's head
	sleep(7)
	circle = new /obj/effect/temp_visual/expanding_circle(owner.loc, 2 SECONDS, 2)
	circle.pixel_y += 40
	sleep(7)
	circle = new /obj/effect/temp_visual/expanding_circle(owner.loc, 2 SECONDS, 2)
	circle.pixel_y += 40




/atom/movable/screen/alert/necrosense
	name = "Necro Sense"
	desc = "Allows you to find those who are not whole."
	icon_state = "cult_sense" //TODO : get our own sprites
	alerttooltipstyle = "cult"
	var/angle = 0
	var/mob/living/carbon/human/necromorph/Cviewer = null

/atom/movable/screen/alert/necrosense/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSprocessing, src)

/atom/movable/screen/alert/necrosense/Destroy()
	Cviewer = null
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/atom/movable/screen/alert/necrosense/process()
	var/mob/living/carbon/human/necromorph/sensor = owner
	var/mob/target = sensor.sense_target

	if(!sensor.mind)
		return
	if(!sensor.sense_target)
		return
	if(target.stat == DEAD)
		to_chat(sensor, span_cult_italic("Your target has died."), MESSAGE_TYPE_LOCALCHAT)
		sensor.searching = FALSE
		sensor.sense_target = null
		sensor.clear_alert("necrosense")

	var/turf/P = get_turf(target)
	var/turf/Q = get_turf(sensor)
	if(!P || !Q || (P.z != Q.z)) //The target is on a different Z level, we cannot sense that far.
		icon_state = "runed_sense2"
		desc = "You can no longer sense your target's presence."
		sensor.searching = FALSE
		sensor.sense_target = null
		return
	if(isliving(target))
		var/mob/living/real_target = target
		desc = "You are currently tracking [real_target.real_name] in [get_area_name(target)]."
	else
		desc = "You are currently tracking [target] in [get_area_name(target)]."
	var/target_angle = get_angle(Q, P)
	var/target_dist = get_dist(P, Q)
	cut_overlays()
	switch(target_dist)
		if(0 to 1)
			icon_state = "runed_sense2"
		if(2 to 8)
			icon_state = "arrow8"
		if(9 to 15)
			icon_state = "arrow7"
		if(16 to 22)
			icon_state = "arrow6"
		if(23 to 29)
			icon_state = "arrow5"
		if(30 to 36)
			icon_state = "arrow4"
		if(37 to 43)
			icon_state = "arrow3"
		if(44 to 50)
			icon_state = "arrow2"
		if(51 to 57)
			icon_state = "arrow1"
		if(58 to 64)
			icon_state = "arrow0"
		if(65 to 400)
			icon_state = "arrow"
	var/difference = target_angle - angle
	angle = target_angle
	if(!difference)
		return
	var/matrix/final = matrix(transform)
	final.Turn(difference)
	animate(src, transform = final, time = 5, loop = 0)
*/
