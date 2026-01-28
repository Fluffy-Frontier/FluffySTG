/obj/item/organ/taur_body/serpentine
	/// The constrict ability we have given our owner. Nullable, if we have no owner.
	var/datum/action/innate/constrict/constrict_ability

/obj/item/organ/taur_body/serpentine/Destroy()
	QDEL_NULL(constrict_ability) // handled in remove, but lets be safe
	return ..()

/obj/item/organ/taur_body/serpentine/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	constrict_ability = new /datum/action/innate/constrict(organ_owner)
	constrict_ability.Grant(organ_owner)

	// FLUFFY FRONTIER ADDITION START - PR: 4936
	var/obj/item/bodypart/leg/right_leg = organ_owner.get_bodypart(BODY_ZONE_R_LEG)
	var/obj/item/bodypart/leg/left_leg = organ_owner.get_bodypart(BODY_ZONE_L_LEG)
	right_leg.footprint_sprite = FOOTPRINT_SPRITE_TAIL
	left_leg.footprint_sprite = FOOTPRINT_SPRITE_TAIL
	// FLUFFY FRONTIER ADDITION END

/// Adds TRAIT_HARD_SOLES to our owner.
/obj/item/organ/taur_body/proc/add_hardened_soles(mob/living/carbon/organ_owner = owner)
	ADD_TRAIT(organ_owner, TRAIT_HARD_SOLES, ORGAN_TRAIT)

/obj/item/organ/taur_body/serpentine/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	QDEL_NULL(constrict_ability)
