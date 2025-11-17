/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/sentinel
	name = "alien sentinel"
	desc = "An alien that'd be unremarkable if not for the bright coloring and visible acid glands that cover it."
	icon_state = "aliensentinel"
	caste = "sentinel"
	maxHealth = 125
	health = 125
	melee_damage_lower = 10
	melee_damage_upper = 15
	alien_speed = 0.5
	next_evolution = /mob/living/carbon/alien/adult/tgmc/spitter

	armor_type = /datum/armor/tgmc_xeno/sentinel

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc,
		ORGAN_SLOT_XENO_ACIDGLAND = /obj/item/organ/alien/acid/tgmc,
		ORGAN_SLOT_XENO_NEUROTOXINGLAND = /obj/item/organ/alien/neurotoxin/tgmc,
	)

	maptext_height = 32
	maptext_width = 32
	hud_offset_y = -16

/mob/living/carbon/alien/adult/tgmc/sentinel/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/mob_cooldown/sneak/alien,
	)
	grant_actions_by_list(innate_actions)

/datum/armor/tgmc_xeno/sentinel
	bomb = 10
	bullet = 30
	energy = 30
	laser = 30
	fire = 30
	melee = 30
