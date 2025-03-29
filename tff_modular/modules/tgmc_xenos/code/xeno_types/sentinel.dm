/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/sentinel
	name = "alien sentinel"
	desc = "An alien that'd be unremarkable if not for the bright coloring and visible acid glands that cover it."
	caste = "sentinel"
	maxHealth = 200
	health = 200
	icon_state = "aliensentinel"
	melee_damage_lower = 10
	melee_damage_upper = 15
	next_evolution = /mob/living/carbon/alien/adult/tgmc/spitter

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc,
		ORGAN_SLOT_XENO_ACIDGLAND = /obj/item/organ/alien/acid/tgmc,
		ORGAN_SLOT_XENO_NEUROTOXINGLAND = /obj/item/organ/alien/neurotoxin/tgmc,
	)

	hud_offset_y = -16

	melee_vehicle_damage = 15

/mob/living/carbon/alien/adult/tgmc/sentinel/Initialize(mapload)
	. = ..()
	add_movespeed_modifier(/datum/movespeed_modifier/alien_slow)
