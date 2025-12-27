/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/runner
	name = "alien runner"
	desc = "A short alien with sleek red chitin, clearly abiding by the 'red ones go faster' theorem and almost always running on all fours."
	icon_state = "alienrunner"
	caste = "runner"
	maxHealth = 100
	health = 100
	melee_damage_lower = 15
	melee_damage_upper = 20
	alien_speed = -0.5
	next_evolution = /mob/living/carbon/alien/adult/tgmc/ravager

	armor_type = /datum/armor/tgmc_xeno/rouny

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc/small/tiny,
	)

	maptext_height = 32
	maptext_width = 32

	/// Holds the evade ability to be granted to the runner later
	var/datum/action/cooldown/alien/tgmc/evade/evade_ability

/mob/living/carbon/alien/adult/tgmc/runner/Initialize(mapload)
	. = ..()
	evade_ability = new(src)
	evade_ability.Grant(src)

	AddComponent(/datum/component/tackler, stamina_cost = 0, base_knockdown = 2, range = 8, speed = 2, skill_mod = 4, min_distance = 0)

/datum/armor/tgmc_xeno/rouny
	bomb = 0
	bullet = 30
	energy = 30
	laser = 30
	fire = 20
	melee = 30
