/datum/action/cooldown/necro/psy/rune
	name = "Bloody Rune"
	desc = "Creates a spooky rune. Has no functional effects, just for decoration. Should be at least 3 tiles away from another bloody rune!"
	button_icon_state = "rune"
	cost = 16

/datum/action/cooldown/necro/psy/rune/Activate(atom/target)
	var/turf/target_turf = get_turf(target)
	if(target_turf)
		if(isgroundlessturf(target_turf) || target_turf.density)
			to_chat(owner, span_warning("There is no space to place a rune!"))
			return
	..()
	new /obj/effect/decal/cleanable/necro_rune(target_turf, null, RUNE_COLOR_MEDIUMRED, TRUE)
	return TRUE

/obj/effect/decal/cleanable/necro_rune
	name = "rune"
	desc = "Graffiti. Damn kids."
	icon = 'tff_modular/modules/deadspace/icons/effects/runes.dmi'
	icon_state = "rune-1"
	gender = NEUTER
	mergeable_decal = FALSE
	color = "#8C000F"

/obj/effect/decal/cleanable/necro_rune/Initialize(mapload, colour, fade_in)
	. = ..()
	icon_state = "rune-[rand(1, 5)]"
	if(colour)
		color = colour
	if(fade_in)
		alpha = 0
		animate(src, alpha = 255, time = 1 SECONDS, flags = ANIMATION_PARALLEL)

//If we don't do this the rune will try to get DNA, bad things happen when this is done
/obj/effect/decal/cleanable/necro_rune/add_blood_DNA(list/blood_dna)
	return FALSE

/obj/effect/decal/cleanable/necro_rune/NeverShouldHaveComeHere(turf/T)
	return T.density || isgroundlessturf(T)

