/*
	The Execution Extension
*/
/datum/component/execution/tripod
	execution_name = "Parasite Leap"
	cooldown = 60 SECONDS
	require_grab = FALSE
	reward_biomass = 0
	reward_energy = 80
	reward_heal = 0
	range = 1
	all_stages = list(/datum/execution_stage/tripod_claw_pin,
		/datum/execution_stage/tripod_scream,
		/datum/execution_stage/tripod_tongue_force,
		/datum/execution_stage/finisher/tripod_tongue_pull,
		/datum/execution_stage/tripod_bisect,
		)


	weapon_check = /datum/component/execution/proc/weapon_check_organ


/datum/component/execution/tripod/weapon_check_organ()
	.=EXECUTION_CONTINUE

	//We need our tongue still attached
	var/obj/item/organ/tongue/necro/tripod/tongue = user.get_organ_slot(ORGAN_SLOT_TONGUE)
	if (!tongue)
		return EXECUTION_CANCEL

	//We require at least one arm intact
	if(user.num_hands < 1)
		return EXECUTION_CANCEL

	. = ..()

/datum/component/execution/tripod/can_start()
	.=..()
	//Core first
	if (. == EXECUTION_CANCEL)
		return

	if(weapon_check == EXECUTION_CANCEL)
		return

	//Lets check that we have what we need

	//The victim must be lying on the floor
	if (victim.body_position != LYING_DOWN)
		return EXECUTION_CANCEL

	//Now in addition

	var/cd_time_left = get_cooldown_time()
	if(cd_time_left > 0)
		return EXECUTION_CANCEL

	//Can't target necros
	if (isnecromorph(victim))
		return EXECUTION_CANCEL


	//To prevent stacking, there must be no other tripods in the victim's turf
	for (var/mob/living/carbon/human/H in get_turf(victim))
		if (H == victim || H == user)
			continue

		if (istype(H.dna.species, /datum/species/necromorph/tripod))
			return EXECUTION_CANCEL

/datum/component/execution/tripod/acquire_target()
	. = ..()
	if(.)
		//We must face sideways to perform this move.
		if (victim.x > user.x)
			user.setDir(EAST)
		else
			user.setDir(WEST)

		//We extend our tongue indefinitely
		var/obj/item/organ/tongue/necro/tripod/tongue = user.get_organ_slot(ORGAN_SLOT_TONGUE)
		if (!istype(tongue))
			return
		tongue.extend()


/datum/component/execution/tripod/safety_check()

	.=..()
	if (. == EXECUTION_CANCEL)
		return

	//The target must have a head for us to penetrate
	if (!victim.get_bodypart(BODY_ZONE_HEAD))
		return EXECUTION_CANCEL


	//If the target is dead but still has their head, mission success!
	if (victim.stat == DEAD)
		return EXECUTION_SUCCESS

	//Being grappled causes us to pause our progress, we can't keep hitting the enemy until they let go
	if (is_grabbed)
		return EXECUTION_RETRY

/datum/component/execution/tripod/stop()
	user.forceMove(get_turf(user))
	.=..()


/datum/component/execution/tripod/interrupt()
	user.play_necro_sound(SOUND_PAIN, VOLUME_MID, 1, 2)
	.=..()


/*
	Stages
*/
/datum/execution_stage/tripod_claw_pin
	duration = 3 SECONDS

/datum/execution_stage/tripod_claw_pin/enter()
	.=..()
	default_transform = host.user.transform
	animate(host.user, pixel_y = host.user.pixel_y + 16, time = duration * 0.7)
	animate(pixel_y = host.user.pixel_y - 18, time = duration * 0.3, easing = BACK_EASING)
	spawn(duration*0.9)

		//After a delay we must redo safety checks
		if (host.safety_check() == EXECUTION_CONTINUE)
			//Okay lets hit 'em
			host.victim.attack_necromorph(host.user, dealt_damage = 40, zone_attacked = BODY_ZONE_CHEST)
			host.victim.Stun(8)
			host.user.visible_message(span_warning("[host.user] impales [host.victim] through the groin with a vast claw, pinning them to the floor!"))
			playsound(host.victim, 'sound/items/weapons/bladeslice.ogg', VOLUME_MID, 1)

/datum/execution_stage/tripod_claw_pin/interrupt()
	host.victim.remove_status_effect(/datum/status_effect/incapacitating/stun)

//Scream: Just calls shout_long, no stun to self
//----------------------------------------------------
/datum/execution_stage/tripod_scream
	duration = 2 SECONDS

/datum/execution_stage/tripod_scream/enter()
	.=..()
	host.user.play_necro_sound(SOUND_SHOUT_LONG, VOLUME_MID, 1, 2)


//Tongue Force: Slowly forces the tongue into the victim's mouth
//Animation makes the user go down and tilt forward
//----------------------------------------------------
/datum/execution_stage/tripod_tongue_force
	duration = 5 SECONDS
	var/tonguesound = list('tff_modular/modules/deadspace/sound/effects/creatures/necromorph/tripod/tripod_tongueforce_1.ogg',
	'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/tripod/tripod_tongueforce_2.ogg',
	'tff_modular/modules/deadspace/sound/effects/creatures/necromorph/tripod/tripod_tongueforce_3.ogg',
	)

/datum/execution_stage/tripod_tongue_force/enter()
	.=..()
	//We will gradually tilt forward
	var/angle = 30
	if (host.user.dir & WEST)
		angle *= -1
	animate(host.user, pixel_y = host.user.pixel_y - 16, transform = turn(default_transform, angle), time = duration)

	//You can't speak with a massive sword-like tongue down your throat
	ADD_TRAIT(host.victim, TRAIT_MUTE, TRAUMA_TRAIT)

	host.user.visible_message(span_warning("[host.user] starts forcing its tongue down [host.victim]'s throat!"))
	spawn(8)
	playsound(host.victim, pick(tonguesound), VOLUME_MID, TRUE)


/datum/execution_stage/tripod_tongue_force/interrupt()
	REMOVE_TRAIT(host.victim, TRAIT_MUTE, TRAUMA_TRAIT)


//Tongue Pull: Rips the tongue out sharply, victim's head is torn off
//Animation makes the user go down and tilt forward
//----------------------------------------------------
/datum/execution_stage/finisher/tripod_tongue_pull
	duration = 2 SECONDS

/datum/execution_stage/finisher/tripod_tongue_pull/enter()
	.=..()
	var/angle = -55
	if (host.user.dir & WEST)
		angle *= -1

	//Swing back and up like a shampoo advert
	animate(host.user, pixel_y = host.user.pixel_y + 12, transform = turn(default_transform, angle*0.3), time = 6, easing = BACK_EASING)
	animate(pixel_y = host.user.pixel_y + 12, transform = turn(default_transform, angle*0.6), time = 6,)

	spawn(4)
		var/obj/item/bodypart/head/head = host.victim.get_bodypart(BODY_ZONE_HEAD)
		if (istype(head))
			head.dismember()
			host.user.visible_message(span_warning("[host.user] whips back, violently tearing [host.victim]'s head off!"))

			playsound(host.victim, 'modular_nova/modules/horrorform/sound/tear.ogg', VOLUME_MID, TRUE)

//Tongue Pull: Rips the tongue out sharply, victim's head is torn off
//Animation makes the user go down and tilt forward
//----------------------------------------------------
/datum/execution_stage/tripod_bisect
	duration = 5 SECONDS

/datum/execution_stage/tripod_bisect/enter()
	.=..()
	var/x_offset = -48
	var/angle = 30
	if (host.user.dir & WEST)
		angle *= -1
		x_offset *= -1

	var/slamtime = 8
	//Slam down one last time
	animate(host.user, pixel_y = host.user.base_pixel_x - 8, transform = turn(default_transform, angle*-0.2), time = slamtime, easing = BACK_EASING)
	animate(host.user, pixel_y = host.user.base_pixel_y - 8, transform = turn(default_transform, angle*1.2), time = slamtime)

	//Pause briefly
	animate(time = 6)
	//And then pull back to tear off the lower body
	animate(pixel_x = host.user.pixel_x, time = 10, easing = CIRCULAR_EASING)

	spawn(slamtime+6)
		if (host.safety_check() == EXECUTION_CONTINUE)
			var/obj/item/bodypart/chest/chest = host.victim.get_bodypart(BODY_ZONE_CHEST)
			if (istype(chest))
				chest.dismember()
				host.user.visible_message(span_warning("[host.user] drags its massive claw backwards, brutally tearing [host.victim] in half!"))
				playsound(host.victim, 'modular_nova/modules/horrorform/sound/tear.ogg', VOLUME_MID, TRUE)
