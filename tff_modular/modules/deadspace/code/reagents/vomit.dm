/obj/effect/decal/cleanable/vomit/necro
	name = "necro vomit"
	decal_reagent = /datum/reagent/toxin/necro_vomit
	icon_state = "vomit_1-old"
	random_icon_states = list("vomit_1-old", "vomit_2-old", "vomit_3-old", "vomit_4-old")
	var/safepasses = 2
	var/deletion_time = 15 SECONDS

/obj/effect/decal/cleanable/vomit/necro/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	QDEL_IN(src, deletion_time)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddComponent(/datum/component/connect_loc_behalf, src, loc_connections)

/obj/effect/decal/cleanable/vomit/necro/proc/on_entered(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(iscarbon(arrived) && !isnecromorph(arrived))
		var/mob/living/carbon/human = arrived
		human.reagents.add_reagent(decal_reagent, 2)
		safepasses--
		new /obj/effect/thing_acid(get_turf(src))
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
