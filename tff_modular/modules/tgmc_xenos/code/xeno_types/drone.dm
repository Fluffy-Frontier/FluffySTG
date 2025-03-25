/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/drone
	name = "alien drone"
	desc = "As plain looking as you could call an alien with armored black chitin and large claws."
	caste = "drone"
	maxHealth = 200
	health = 200
	icon_state = "aliendrone"
	melee_damage_lower = 15
	melee_damage_upper = 20
	next_evolution = /mob/living/carbon/alien/adult/tgmc/praetorian

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc/large,
		ORGAN_SLOT_XENO_RESINSPINNER = /obj/item/organ/alien/resinspinner,
		ORGAN_SLOT_XENO_ACIDGLAND = /obj/item/organ/alien/acid,
	)

	hud_offset_y = -16

	melee_vehicle_damage = 20

/mob/living/carbon/alien/adult/tgmc/drone/Initialize(mapload)
	. = ..()
	GRANT_ACTION(/datum/action/cooldown/alien/tgmc/heal_aura)
