/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc/crusher
	name = "alien crusher"
	desc = "A huge alien with an enormous armored crest."
	icon_state = "aliencrusher"
	caste = "crusher"
	maxHealth = 700
	health = 700
	mob_size = MOB_SIZE_LARGE
	melee_damage_lower = 30
	melee_damage_upper = 35
	alien_speed = 1.5

	additional_organ_types_by_slot = list(
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/tgmc,
	)

	hud_offset_y = -16

	mecha_armor_penetration = 35
	resist_heavy_hits = TRUE

/mob/living/carbon/alien/adult/tgmc/crusher/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/mob_cooldown/charge/basic_charge/xeno_charge,
	)
	grant_actions_by_list(innate_actions)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
