/obj/effect/decal/cleanable/vomit/necro
	name = "necro vomit"
	decal_reagent = /datum/reagent/toxin/necro_vomit
	var/safepasses = 2

/obj/effect/decal/cleanable/vomit/necro/on_entered(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(iscarbon(arrived) && !isnecromorph(arrived))
		var/mob/living/carbon/human = arrived
		human.reagents.add_reagent(decal_reagent, 2)
		safepasses--
		if(safepasses <= 0 && !QDELETED(src))
			qdel(src)


/datum/reagent/toxin/necro_vomit
	name = "Necro Vomit"
	description = "Someone's vomit. Huh."
	color = "#006400"
	taste_description = "disgusting"
	toxpwr = 2.5

/datum/reagent/toxin/necro_vomit/on_mob_metabolize(mob/living/affected_mob)
	if(!iscarbon(affected_mob))
		return

	var/mob/living/carbon/victim = affected_mob

	victim.emote("scream")
	victim.adjust_timed_status_effect(15 SECONDS, /datum/status_effect/bioacid/enhanced, 180 SECONDS)
	victim.set_eye_blur_if_lower(10 SECONDS)
	victim.adjust_temp_blindness(6 SECONDS)
	victim.set_confusion_if_lower(5 SECONDS)
	victim.update_damage_hud()
	victim.reagents.remove_reagent(/datum/reagent/toxin/necro_vomit, 2)
	return ..()
