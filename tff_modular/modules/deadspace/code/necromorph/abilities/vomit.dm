/datum/action/cooldown/necro/vomit
	name = "Vomit"
	desc = "A close range attack that covers a large area for area denial."
	cooldown_time = 15 SECONDS
	click_to_activate = TRUE

//We want a custom one that doesn't move you and checks for tails
/datum/action/cooldown/necro/vomit/Activate(atom/target)
	StartCooldown()
	target = get_turf(target)
	owner.face_atom(target)

	var/range = 4

	var/mob/living/carbon/human/necromorph/puker = owner
	if(!puker.get_bodypart(BODY_ZONE_HEAD))
		range = 2

	SEND_SIGNAL(puker, COMSIG_CARBON_VOMITED, range, 1)

	puker.play_necro_sound(SOUND_ATTACK, VOLUME_MID, 1, 3)
	puker.shake_animation(30)

	puker.visible_message(span_warning("[puker] dry heaves!"))
	puker.Stun(1 SECONDS)

	var/starting_dir = puker.dir
	var/turf/location = get_turf(puker)
	for(var/i = 0 to range)
		if(location)
			location.add_vomit_floor(puker, /obj/effect/decal/cleanable/vomit/necro, VOMIT_CATEGORY_DEFAULT, 0.1)

		location = get_step(location, starting_dir)
		if (location?.is_blocked_turf())
			break

	return TRUE
