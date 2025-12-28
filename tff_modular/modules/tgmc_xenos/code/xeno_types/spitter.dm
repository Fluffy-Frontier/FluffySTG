/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/spitter
	name = "alien spitter"
	desc = "A fairly heavy looking alien with prominent acid glands, it's mouth dripping with... some kind of toxin or acid."
	icon_state = "alienspitter"
	caste = "spitter"
	maxHealth = 200
	health = 200
	mob_size = MOB_SIZE_LARGE
	melee_damage_lower = 15
	melee_damage_upper = 20
	alien_speed = 1

	armor_type = /datum/armor/tgmc_xeno/spitter

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc,
		ORGAN_SLOT_XENO_ACIDGLAND = /obj/item/organ/alien/acid/tgmc/large,
		ORGAN_SLOT_XENO_NEUROTOXINGLAND = /obj/item/organ/alien/neurotoxin/tgmc/large,
	)

	resist_heavy_hits = TRUE

	can_hold_facehugger = TRUE

/mob/living/carbon/alien/adult/tgmc/spitter/Initialize(mapload)
	. = ..()
	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/datum/armor/tgmc_xeno/spitter
	bomb = 0
	bullet = 35
	energy = 35
	laser = 35
	fire = 35
	melee = 25
