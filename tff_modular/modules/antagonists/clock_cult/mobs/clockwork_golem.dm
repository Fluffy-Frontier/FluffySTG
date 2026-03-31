//not technically a mob but ehh, close enough
/datum/species/clockwork_golem
	name = "Clockwork Golem"
	id = SPECIES_GOLEM_CLOCKWORK
	meat = /obj/item/stack/sheet/bronze
	fixed_mut_color = rgb(190, 135, 0)
	examine_limb_id = SPECIES_GOLEM
	///ref to our turf_healing component, used for deletion on_species_loss()
	var/datum/component/turf_healing/mob_turf_healing
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/clockwork,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/clockwork,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/clockwork,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/clockwork,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/clockwork,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/clockwork,
	)

/datum/species/golem/clockwork/on_species_gain(mob/living/carbon/our_mob, datum/species/old_species, pref_load)
	. = ..()
	ADD_TRAIT(our_mob, TRAIT_FASTER_SLAB_INVOKE, SPECIES_TRAIT)
	mob_turf_healing = our_mob.AddComponent(/datum/component/turf_healing, healing_types = list(TOX = 1, BRUTE = 1, BURN = 1), \
											healing_turfs = list(/turf/open/floor/bronze, /turf/open/indestructible/reebe_flooring))

/datum/species/golem/clockwork/on_species_loss(mob/living/carbon/human/our_mob, datum/species/new_species, pref_load)
	REMOVE_TRAIT(our_mob, TRAIT_FASTER_SLAB_INVOKE, SPECIES_TRAIT)
	QDEL_NULL(mob_turf_healing)
	. = ..()

//GOLEM
/obj/item/bodypart/head/clockwork
	icon = 'icons/mob/human/bodyparts.dmi'
	icon_static = 'icons/mob/human/bodyparts.dmi'
	icon_state = "clockgolem_head"
	biological_state = BIO_BONE
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	head_flags = NONE
	teeth_count = 0
	burn_modifier = 0.7
	brute_modifier = 0.7

/obj/item/bodypart/chest/clockwork
	icon = 'icons/mob/human/bodyparts.dmi'
	icon_static = 'icons/mob/human/bodyparts.dmi'
	icon_state = "clockgolem_chest"
	biological_state = BIO_BONE
	acceptable_bodytype = BODYTYPE_GOLEM
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	bodypart_traits = list(TRAIT_NO_JUMPSUIT)
	wing_types = null
	burn_modifier = 0.7
	brute_modifier = 0.7

/obj/item/bodypart/arm/left/clockwork
	icon = 'icons/mob/human/bodyparts.dmi'
	icon_static = 'icons/mob/human/bodyparts.dmi'
	icon_state = "clockgolem_l_arm"
	biological_state = (BIO_BONE|BIO_JOINTED)
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	bodypart_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_FIST_MINING, TRAIT_BOULDER_BREAKER)
	unarmed_damage_low = 5
	unarmed_damage_high = 14
	unarmed_effectiveness = 20
	burn_modifier = 0.7
	brute_modifier = 0.7

/obj/item/bodypart/arm/left/clockwork/clear_ownership(mob/living/carbon/old_owner)
	. = ..()

	old_owner.RemoveComponentSource(REF(src), /datum/component/shovel_hands)

/obj/item/bodypart/arm/left/clockwork/apply_ownership(mob/living/carbon/new_owner)
	. = ..()

	new_owner.AddComponentFrom(REF(src), /datum/component/shovel_hands)

/obj/item/bodypart/arm/right/clockwork
	icon = 'icons/mob/human/bodyparts.dmi'
	icon_static = 'icons/mob/human/bodyparts.dmi'
	icon_state = "clockgolem_r_arm"
	biological_state = (BIO_BONE|BIO_JOINTED)
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	bodypart_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_FIST_MINING, TRAIT_BOULDER_BREAKER)
	unarmed_damage_low = 5
	unarmed_damage_high = 14
	unarmed_effectiveness = 20
	burn_modifier = 0.7
	brute_modifier = 0.7

/obj/item/bodypart/arm/right/clockwork/clear_ownership(mob/living/carbon/old_owner)
	. = ..()

	old_owner.RemoveComponentSource(REF(src), /datum/component/shovel_hands)

/obj/item/bodypart/arm/right/clockwork/apply_ownership(mob/living/carbon/new_owner)
	. = ..()

	new_owner.AddComponentFrom(REF(src), /datum/component/shovel_hands)

/obj/item/bodypart/leg/left/clockwork
	icon = 'icons/mob/human/bodyparts.dmi'
	icon_static = 'icons/mob/human/bodyparts.dmi'
	icon_state = "clockgolem_l_leg"
	biological_state = (BIO_BONE|BIO_JOINTED)
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	unarmed_damage_low = 7
	unarmed_damage_high = 21
	unarmed_effectiveness = 25
	burn_modifier = 0.7
	brute_modifier = 0.7

/obj/item/bodypart/leg/right/clockwork
	icon = 'icons/mob/human/bodyparts.dmi'
	icon_static = 'icons/mob/human/bodyparts.dmi'
	icon_state = "clockgolem_r_leg"
	biological_state = (BIO_BONE|BIO_JOINTED)
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	unarmed_damage_low = 7
	unarmed_damage_high = 21
	unarmed_effectiveness = 25
	burn_modifier = 0.7
	brute_modifier = 0.7
