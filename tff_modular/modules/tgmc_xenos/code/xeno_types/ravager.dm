/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/ravager
	name = "alien ravager"
	desc = "An alien with angry red chitin, with equally intimidating looking blade-like claws in place of normal hands. That sharp tail looks like it'd probably hurt."
	icon_state = "alienravager"
	caste = "ravager"
	maxHealth = 200
	health = 200
	mob_size = MOB_SIZE_LARGE
	melee_damage_lower = 30
	melee_damage_upper = 35
	alien_speed = 0.5

	armor_type = /datum/armor/tgmc_xeno/ravager

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc/no_weeds
	)

	mecha_armor_penetration = 35
	resist_heavy_hits = TRUE

/mob/living/carbon/alien/adult/tgmc/ravager/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/spell/aoe/repulse/xeno/tgmc_tailsweep/slicing,
		/datum/action/cooldown/alien/tgmc/literally_too_angry_to_die,
	)
	grant_actions_by_list(innate_actions)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	AddComponent(/datum/component/tackler, stamina_cost = 0, base_knockdown = 0, range = 8, speed = 2, skill_mod = 9, min_distance = 0)

/datum/armor/tgmc_xeno/ravager
	bomb = 10
	bullet = 50
	energy = 50
	laser = 50
	fire = 30
	melee = 50
