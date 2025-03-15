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

	puker.play_necro_sound(puker, SOUND_ATTACK, VOLUME_MID, 1, 3)
	puker.shake_animation(30)

	puker.visible_message(span_warning("[puker] dry heaves!"))
	puker.Stun(1 SECONDS)

	playsound(puker, 'sound/effects/splat.ogg', 50, TRUE)

	var/starting_dir = puker.dir
	var/turf/location = get_turf(puker)
	for(var/i = 0 to range)
		if(location)
			location.add_vomit_floor(puker, /obj/effect/decal/cleanable/vomit/necro, VOMIT_CATEGORY_DEFAULT, 0.1)

		location = get_step(location, starting_dir)
		if (location?.is_blocked_turf())
			break

	return TRUE


/obj/effect/decal/cleanable/vomit/necro
	name = "necro vomit"
	decal_reagent = /datum/reagent/toxin/necro
	var/safepasses = 2

/obj/effect/decal/cleanable/vomit/necro/on_entered(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(iscarbon(arrived) && !isnecromorph(arrived))
		var/mob/living/carbon/human = arrived
		human.reagents.add_reagent(decal_reagent, 2)
		safepasses--
		if(safepasses <= 0 && !QDELETED(src))
			qdel(src)
