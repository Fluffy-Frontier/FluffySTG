/*
	The Execution Extension
*/
/datum/component/execution/infector
	execution_name = "Parasite Leap"
	cooldown = 60 SECONDS
	require_grab = FALSE
	reward_biomass = 0
	reward_energy = 80
	reward_heal = 0
	range = 1
	all_stages = list(/datum/execution_stage/wingwrap,
	/datum/execution_stage/infector_headstab,
	/datum/execution_stage/finisher/skullbore,
	/datum/execution_stage/convert)

	weapon_check = /datum/component/execution/proc/weapon_check_organ


/datum/component/execution/proc/weapon_check_organ()
	.=EXECUTION_CONTINUE

	if (!weapon)
		return EXECUTION_CANCEL

	var/obj/item/organ/E = weapon
	if (!E)
		return EXECUTION_CANCEL

	if (E.owner != user || E.loc != user)
		return EXECUTION_CANCEL

/datum/component/execution/infector/can_start()
	.=..()
	//Core first
	if (. == EXECUTION_CANCEL)
		return

	//Now in addition

	var/cd_time_left = get_cooldown_time()
	if(cd_time_left > 0)
		return EXECUTION_CANCEL

	//Can't target necros
	if (isnecromorph(victim))
		return EXECUTION_CANCEL

	//The target must have a head for us to penetrate
	if (!victim.get_bodypart(BODY_ZONE_HEAD))
		return EXECUTION_CANCEL

	//The target must be standing
	if (victim.body_position == LYING_DOWN)
		return EXECUTION_CANCEL


	//To prevent stacking, there must be no other infectors in the victim's turf
	for (var/mob/living/carbon/human/H in get_turf(victim))
		if (H == victim || H == user)
			continue

		if (istype(H.dna.species, /datum/species/necromorph/infector))
			return EXECUTION_CANCEL


/datum/component/execution/infector/safety_check()

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

/datum/component/execution/infector/stop()
	user.forceMove(get_turf(user))
	.=..()

/*
	Stages
*/
/datum/execution_stage/wingwrap
	duration = 3 SECONDS

/datum/execution_stage/wingwrap/enter()
	. = ..()

	host.victim.losebreath += 4
	host.user.visible_message(span_danger("[host.user] wraps their wings around [host.victim]'s head!"))
	var/mob/living/carbon/human/necromorph/necro = host.user
	necro.play_necro_sound(SOUND_ATTACK, VOLUME_MID, TRUE, 3)

/datum/execution_stage/infector_headstab
	duration = 0.5 SECONDS

/datum/execution_stage/infector_headstab/enter()
	host.user.Immobilize(1+(duration*0.1))
	host.victim.Immobilize(1+(duration*0.1))
	.=..()
	//If we've already won, skip this and just return
	if (host.success)
		duration = 0 SECONDS //Setting duration to 0 will prevent any waiting after this proc
		return

	var/obj/item/organ/tongue/necro/proboscis/proby = host.user.get_organ_slot(ORGAN_SLOT_TONGUE)
	if (proby)
		proby.hide()

	var/done = FALSE
	while (!done)
		//First of all, safety check
		var/safety_result = host.safety_check()

		//This only happens if we are grappled, we skip this tick and try again in a second
		if (safety_result == EXECUTION_RETRY)
			sleep(duration)
			continue
		else if (safety_result != EXECUTION_CONTINUE)
			//If we've either failed or won, we quit this
			if (safety_result == EXECUTION_SUCCESS)
				duration = 0 SECONDS //Setting duration to 0 will prevent any waiting after this proc
			done = TRUE
			continue

		//Okay now lets check the victim's health. We know they still have a head
		var/obj/item/bodypart/head/heady = host.victim.get_bodypart(BODY_ZONE_HEAD)
		var/total_damage = heady.brute_dam + heady.burn_dam
		if (total_damage >= heady.max_damage)
			done = TRUE
			continue

		//They are being strangled, can't breathe. Even if they had an eva suit, the air supply hose is constricted
		host.victim.losebreath++

		//Do the actual damage.
		host.victim.attack_necromorph(host.user, zone_attacked = BODY_ZONE_HEAD, dealt_damage = 30, sharpness = NONE)
		host.user.play_necro_sound(SOUND_ATTACK, VOLUME_MID, TRUE, 3)

		//The victim and their camera shake wildly as they struggle
		shake_camera(host.victim, 2, 3)
		host.victim.shake_animation()
		host.user.shake_animation()

		//We repeat the safety check now, since that damage might have just removed the head
		safety_result = host.safety_check()
		if (safety_result != EXECUTION_CONTINUE)
			//If we've either failed or won, we quit this
			if (safety_result == EXECUTION_SUCCESS)
				duration = 0 SECONDS //Setting duration to 0 will prevent any waiting after this proc
			done = TRUE
			continue

		//Make sure the user stays stunned during this process

/datum/execution_stage/finisher/skullbore/enter()
	. = ..()
	if(host.safety_check() == EXECUTION_CANCEL)
		return

	host.user.visible_message(span_danger("[host.user] drives the [host.weapon] into [host.victim]'s forehead, with a sickening crunch."))

	playsound(host.victim, "fracture", VOLUME_MID, TRUE)

	shake_camera(host.victim, 2, 3)
	host.victim.shake_animation()
	host.user.shake_animation()
	host.user.play_necro_sound(SOUND_SHOUT, VOLUME_MID, TRUE, 3)

	var/obj/item/bodypart/head/H = host.victim.get_bodypart(BODY_ZONE_HEAD)

	//Deal heavy non-dismembering external damage to the head, this is mostly for the sake of blood graphics
	H.receive_damage(9999, 0, damage_source = host.weapon)//, allow_dismemberment = FALSE

	//Destroy the brain. This kills the man
	var/obj/item/organ/brain/brainy = host.victim.get_organ_slot(ORGAN_SLOT_BRAIN)
	if (brainy)
		brainy.apply_organ_damage(9999)	//Victim is now ded

	//Lets just be sure because braindeath doesnt seem to kill instantly
	host.victim.death()

/datum/execution_stage/convert
	duration = 3 SECONDS

/datum/execution_stage/convert/enter()
	. = ..()
	//We are done
	host.victim.start_necromorph_conversion(duration * 0.1)

/datum/execution_stage/convert/exit()
	host.user.forceMove(get_turf(host.user))
