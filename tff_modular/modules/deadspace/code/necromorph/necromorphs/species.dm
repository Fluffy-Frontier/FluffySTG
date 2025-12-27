//It exists just for compability. Don't add any vars or special behaviours
/datum/species/necromorph
	name = "Necromorph"
	id = SPECIES_NECROMORPH
	//There is no way to become it. Period.
	changesource_flags = MIRROR_BADMIN
	//For blood please go to necro_defines
	sexes = FALSE
	hair_alpha = 0
	facial_hair_alpha = 0
	max_bodypart_count = 6
	meat = /obj/item/food/meat/slab/human/mutant/necro
	//Heat and cold does not traditionally affect necros, but fire can still hurt them
	bodytemp_heat_damage_limit = INFINITY
	bodytemp_cold_damage_limit = -(INFINITY)
	///We don't process reagents
	reagent_flags = NONE
	no_equip_flags = list(
		ITEM_SLOT_OCLOTHING,
		ITEM_SLOT_ICLOTHING ,
		ITEM_SLOT_GLOVES,
		ITEM_SLOT_EYES,
		ITEM_SLOT_EARS,
		ITEM_SLOT_MASK,
		ITEM_SLOT_HEAD,
		ITEM_SLOT_FEET,
		ITEM_SLOT_ID,
		ITEM_SLOT_BELT,
		ITEM_SLOT_BACK,
		ITEM_SLOT_DEX_STORAGE,
		ITEM_SLOT_NECK,
		ITEM_SLOT_HANDS,
		ITEM_SLOT_BACK,
		ITEM_SLOT_SUITSTORE,
		ITEM_SLOT_LPOCKET,
		ITEM_SLOT_RPOCKET,
		ITEM_SLOT_HANDCUFFED,
		ITEM_SLOT_LEGCUFFED ,
		ITEM_SLOT_BELT,
	)

	inherent_traits = list(
		TRAIT_IGNORESLOWDOWN,
		TRAIT_DEFIB_BLACKLISTED,
		TRAIT_BADDNA,
		TRAIT_GENELESS,
		TRAIT_VIRUSIMMUNE,
		TRAIT_TOXIMMUNE,
		TRAIT_EASYDISMEMBER,
		TRAIT_NOBREATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_FEARLESS,
		TRAIT_NO_SOUL,
		TRAIT_CANT_RIDE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RESISTCOLD,
		TRAIT_DISCOORDINATED_TOOL_USER,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOSOFTCRIT,
		TRAIT_NOHUNGER,
		TRAIT_FAKEDEATH,
		TRAIT_NOBLOOD,
		TRAIT_NO_ZOMBIFY,
		TRAIT_NO_UNDERWEAR,
		TRAIT_NO_DNA_COPY,
		TRAIT_AGENDER,
		TRAIT_NO_AUGMENTS,
		TRAIT_NO_BLOOD_OVERLAY,
		TRAIT_NO_UNDERWEAR,
		TRAIT_HARD_SOLES,
		TRAIT_NO_SLIP_WATER,
		TRAIT_NOHARDCRIT,
		TRAIT_ANALGESIA,
		TRAIT_SIGHT_BYPASS,
	)
	species_language_holder = /datum/language_holder/necro_talk

	mutanttongue = /obj/item/organ/tongue/necro
	mutanteyes = /obj/item/organ/eyes/necro
	mutantbrain = /obj/item/organ/brain/necro
	mutantheart = /obj/item/organ/heart/necro
	mutantlungs = /obj/item/organ/lungs/necro

	//Necros are mostly just biomass, little to no guts

	inherent_biotypes = MOB_ORGANIC|MOB_UNDEAD|MOB_HUMANOID
	inherent_factions = list(FACTION_NECROMORPH)
	fire_overlay = "generic_burning"

/datum/species/necromorph/check_roundstart_eligible()
	return FALSE

//Does animations for regenerating a limb
/datum/species/necromorph/proc/regenerate_limb(mob/living/carbon/human/necromorph/H, limb, duration)
	var/obj/item/bodypart/part = H.get_bodypart(limb)
	var/image/LR = image(initial(part.icon), H, "[limb]_regen")
	LR.plane = H.plane
	LR.layer = H.layer - 0.1 //Slightly below the layer of the mob, so that the healthy limb will draw over it
	H.flick_overlay(LR, GLOB.clients, duration)

//The natural healing of the necromorph
/datum/species/necromorph/spec_life(mob/living/carbon/human/necromorph/necro, delta_time, times_fired)
	if(necro.stat == DEAD) //Dead necros don't heal
		return
	var/turf/my_turf = get_turf(necro)
	if(my_turf.necro_corrupted) //Not standing on corruption? No heals
		necro.heal_overall_damage(0.2 * delta_time, 0 * delta_time, BODYTYPE_ORGANIC)
	return ..()

