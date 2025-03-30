/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/runner
	name = "alien runner"
	desc = "A short alien with sleek red chitin, clearly abiding by the 'red ones go faster' theorem and almost always running on all fours."
	caste = "runner"
	maxHealth = 150
	health = 150
	icon_state = "alienrunner"
	melee_damage_lower = 15
	melee_damage_upper = 20
	next_evolution = /mob/living/carbon/alien/adult/tgmc/ravager
	on_fire_pixel_y = 0

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc/small/tiny,
	)

	hud_offset_y = -32

	melee_vehicle_damage = 20

	/// Holds the evade ability to be granted to the runner later
	var/datum/action/cooldown/alien/tgmc/evade/evade_ability

/mob/living/carbon/alien/adult/tgmc/runner/Initialize(mapload)
	. = ..()
	evade_ability = new(src)
	evade_ability.Grant(src)

	add_movespeed_modifier(/datum/movespeed_modifier/alien_quick)
	AddComponent(/datum/component/tackler, stamina_cost = 0, base_knockdown = 2, range = 10, speed = 2, skill_mod = 7, min_distance = 0)

/mob/living/carbon/alien/adult/tgmc/runner/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	if(evade_ability)
		var/evade_result = evade_ability.on_projectile_hit()
		if(!(evade_result == BULLET_ACT_HIT))
			return evade_result
	return ..()
