/// We use 2 different tyoes for the similar ability to ensure locate() works properly
/*
	Shout
*/

/datum/action/cooldown/necro/shout
	name = "Shout"
	desc = "Shout to disorientate your enemies."
	cooldown_time = 8 SECONDS
	click_to_activate = FALSE

/datum/action/cooldown/necro/shout/Activate(atom/target)
	StartCooldown()
	var/mob/living/carbon/human/necromorph/holder = owner
	holder.play_necro_sound(SOUND_SHOUT, VOLUME_MID_HIGH, TRUE, 2)
	var/matrix/new_matrix = matrix(holder.transform)
	var/shake_dir = pick(-1, 1)
	new_matrix.Turn(17*shake_dir)
	animate(holder, transform = new_matrix, pixel_x = holder.pixel_x + 6*shake_dir, time = 1)
	animate(transform = matrix(), pixel_x = holder.pixel_x-6*shake_dir, time = 11, easing = ELASTIC_EASING)
	new /obj/effect/temp_visual/expanding_circle(holder.loc, 3 SECONDS, 2) //Visual effect

	for(var/mob/living/M in get_hearers_in_view(8, holder))
		if(iscarbon(M))
			var/mob/living/carbon/C = M
			if(!istype(M, /mob/living/carbon/human/necromorph))
				C.set_confusion_if_lower(8 SECONDS)

/*
	Scream
*/

/datum/action/cooldown/necro/scream
	name = "Scream"
	desc = "Scream to disorientate your enemies."
	cooldown_time = 8 SECONDS
	click_to_activate = FALSE

/datum/action/cooldown/necro/scream/Activate(atom/target)
	StartCooldown()
	var/mob/living/carbon/human/necromorph/holder = owner
	holder.play_necro_sound(SOUND_SHOUT_LONG, VOLUME_MID_HIGH, TRUE, 2)
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, src)
	var/matrix/new_matrix = matrix(holder.transform)
	var/shake_dir = pick(-1, 1)
	new_matrix.Turn(17*shake_dir)
	animate(holder, transform = new_matrix, pixel_x = holder.pixel_x + 6*shake_dir, time = 1)
	animate(transform = matrix(), pixel_x = holder.pixel_x-6*shake_dir, time = 11, easing = ELASTIC_EASING)
	new /obj/effect/temp_visual/expanding_circle(holder.loc, 2, 3 SECONDS)	//Visual effect
	for(var/mob/living/M in get_hearers_in_view(8, holder))
		if(iscarbon(M))
			var/mob/living/carbon/C = M
			if(!istype(M, /mob/living/carbon/human/necromorph))
				C.set_confusion_if_lower(8 SECONDS)
				C.set_eye_blur_if_lower(8 SECONDS)
	remove_stun(holder)

/datum/action/cooldown/necro/scream/proc/remove_stun()
	set waitfor = FALSE

	sleep(1)
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, src)
