//not technically a mob but ehh, close enough
/datum/species/clockwork_golem
	name = "Clockwork Golem"
	id = SPECIES_GOLEM_CLOCKWORK
	inherent_traits = list(
		TRAIT_GENELESS,
		TRAIT_LAVA_IMMUNE,
		TRAIT_NEVER_WOUNDED,
		TRAIT_NOBLOOD,
		TRAIT_NOBREATH,
		TRAIT_NODISMEMBER,
		TRAIT_NOFIRE,
		TRAIT_NO_AUGMENTS,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_NO_UNDERWEAR,
		TRAIT_PIERCEIMMUNE,
		TRAIT_RADIMMUNE,
		TRAIT_SNOWSTORM_IMMUNE,
		TRAIT_UNHUSKABLE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RESISTHIGHPRESSURE,
	)
	mutantheart = null
	mutantlungs = null
	inherent_biotypes = MOB_HUMANOID|MOB_MINERAL
	payday_modifier = 1.0
	siemens_coeff = 0
	no_equip_flags = ITEM_SLOT_MASK | ITEM_SLOT_OCLOTHING | ITEM_SLOT_GLOVES | ITEM_SLOT_FEET | ITEM_SLOT_ICLOTHING | ITEM_SLOT_SUITSTORE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC
	sexes = FALSE
	species_language_holder = /datum/language_holder/golem

	bodytemp_heat_damage_limit = BODYTEMP_HEAT_LAVALAND_SAFE
	bodytemp_cold_damage_limit = BODYTEMP_COLD_ICEBOX_SAFE

	mutant_organs = list(/obj/item/organ/adamantine_resonator)
	mutanteyes = /obj/item/organ/eyes/golem
	mutantbrain = /obj/item/organ/brain/golem
	mutanttongue = /obj/item/organ/tongue/golem
	mutantstomach = /obj/item/organ/stomach/golem
	mutantliver = /obj/item/organ/liver/golem
	mutantappendix = /obj/item/organ/appendix/golem
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

/datum/species/clockwork_golem/on_species_gain(mob/living/carbon/our_mob, datum/species/old_species, pref_load)
	. = ..()
	ADD_TRAIT(our_mob, TRAIT_FASTER_SLAB_INVOKE, SPECIES_TRAIT)
	mob_turf_healing = our_mob.AddComponent(/datum/component/turf_healing, healing_types = list(TOX = 1, BRUTE = 1, BURN = 1), healing_turfs = list(/turf/open/floor/bronze, /turf/open/indestructible/reebe_flooring))

/datum/species/clockwork_golem/on_species_loss(mob/living/carbon/human/our_mob, datum/species/new_species, pref_load)
	REMOVE_TRAIT(our_mob, TRAIT_FASTER_SLAB_INVOKE, SPECIES_TRAIT)
	QDEL_NULL(mob_turf_healing)
	. = ..()

//GOLEM
/obj/item/bodypart/head/clockwork
	biological_state = BIO_BONE
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM_CLOCKWORK
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	head_flags = NONE
	teeth_count = 0
	burn_modifier = 0.4
	brute_modifier = 0.4

/obj/item/bodypart/chest/clockwork
	biological_state = BIO_BONE
	acceptable_bodytype = BODYTYPE_GOLEM
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM_CLOCKWORK
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	bodypart_traits = list(TRAIT_NO_JUMPSUIT)
	wing_types = null
	burn_modifier = 0.4
	brute_modifier = 0.4

/obj/item/bodypart/arm/left/clockwork
	biological_state = (BIO_BONE|BIO_JOINTED)
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM_CLOCKWORK
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	bodypart_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_FIST_MINING, TRAIT_BOULDER_BREAKER)
	unarmed_damage_low = 5
	unarmed_damage_high = 14
	unarmed_effectiveness = 20
	burn_modifier = 0.4
	brute_modifier = 0.4

/obj/item/bodypart/arm/left/clockwork/clear_ownership(mob/living/carbon/old_owner)
	. = ..()

	old_owner.RemoveComponentSource(REF(src), /datum/component/shovel_hands)

/obj/item/bodypart/arm/left/clockwork/apply_ownership(mob/living/carbon/new_owner)
	. = ..()

	new_owner.AddComponentFrom(REF(src), /datum/component/shovel_hands)

/obj/item/bodypart/arm/right/clockwork
	biological_state = (BIO_BONE|BIO_JOINTED)
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM_CLOCKWORK
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	bodypart_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_FIST_MINING, TRAIT_BOULDER_BREAKER)
	unarmed_damage_low = 5
	unarmed_damage_high = 14
	unarmed_effectiveness = 20
	burn_modifier = 0.4
	brute_modifier = 0.4

/obj/item/bodypart/arm/right/clockwork/clear_ownership(mob/living/carbon/old_owner)
	. = ..()

	old_owner.RemoveComponentSource(REF(src), /datum/component/shovel_hands)

/obj/item/bodypart/arm/right/clockwork/apply_ownership(mob/living/carbon/new_owner)
	. = ..()

	new_owner.AddComponentFrom(REF(src), /datum/component/shovel_hands)

/obj/item/bodypart/leg/left/clockwork
	biological_state = (BIO_BONE|BIO_JOINTED)
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM_CLOCKWORK
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	unarmed_damage_low = 7
	unarmed_damage_high = 21
	unarmed_effectiveness = 25
	burn_modifier = 0.4
	brute_modifier = 0.4

/obj/item/bodypart/leg/right/clockwork
	biological_state = (BIO_BONE|BIO_JOINTED)
	bodytype = BODYTYPE_GOLEM | BODYTYPE_ORGANIC
	limb_id = SPECIES_GOLEM_CLOCKWORK
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	unarmed_damage_low = 7
	unarmed_damage_high = 21
	unarmed_effectiveness = 25
	burn_modifier = 0.4
	brute_modifier = 0.4
