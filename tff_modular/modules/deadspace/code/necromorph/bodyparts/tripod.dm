/obj/item/bodypart/chest/necromorph/tripod
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_TRIPOD
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_state = "tripod_chest"
	max_damage = 400
	px_x = 0
	px_y = 0
	wound_resistance = 30
	n_biomass = 81
	burn_modifier = 0.75

/obj/item/bodypart/head/necromorph/tripod
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_TRIPOD
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_state = "tripod_head"
	max_damage = 100
	px_x = 0
	px_y = -8
	wound_resistance = 10
	n_biomass = 15 //pea brain, not much n_biomass
	burn_modifier = 0.75

/obj/item/bodypart/head/necromorph/tripod/receive_damage(brute, burn, blocked, updating_health, forced, required_bodytype, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, damage_source, wound_clothing)
	var/obj/item/organ/tongue/necro/tripod/tongue = owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(tongue)
		if(tongue.extended && prob(burn_dam + brute_dam))
			var/atom/drop_loc = drop_location()
			if(tongue.bodypart_remove(src))
				if(drop_loc) //can be null if being deleted
					tongue.forceMove(get_turf(drop_loc))
	return ..()

/obj/item/bodypart/arm/left/necromorph/tripod
	name = "left arm"
	limb_id = SPECIES_NECROMORPH_TRIPOD
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_state = "tripod_l_arm"
	attack_verb_continuous = list("slashes", "stabs")
	attack_verb_simple = list("slash", "stab")
	max_damage = 150
	px_x = -6
	px_y = 0
	wound_resistance = 5
	n_biomass = 21
	burn_modifier = 0.75

/obj/item/bodypart/arm/left/necromorph/tripod/dismember(dam_type, silent, wounding_type)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/dsnecro_much_slower)

/obj/item/bodypart/arm/right/necromorph/tripod
	name = "right arm"
	limb_id = SPECIES_NECROMORPH_TRIPOD
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_state = "tripod_r_arm"
	attack_verb_continuous = list("slashes", "stabs")
	attack_verb_simple = list("slash", "stab")
	max_damage = 150
	px_x = 6
	px_y = 0
	wound_resistance = 5
	n_biomass = 21
	burn_modifier = 0.75

/obj/item/bodypart/arm/right/necromorph/tripod/dismember(dam_type, silent, wounding_type)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/dsnecro_slower)

/obj/item/bodypart/leg/left/necromorph/tripod
	name = "left leg"
	limb_id = SPECIES_NECROMORPH_TRIPOD
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_state = "tripod_l_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 150
	px_x = -2
	px_y = 12
	wound_resistance = 5
	n_biomass = 21
	burn_modifier = 0.75
	special_footstep_sounds = list(list(
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_1.ogg',
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_2.ogg',
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_3.ogg',
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_4.ogg',
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_5.ogg',
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_6.ogg'
	), VOLUME_MID, 0)

/obj/item/bodypart/leg/left/necromorph/tripod/try_dismember(wounding_type, wounding_dmg, wound_bonus, exposed_wound_bonus)
	return FALSE

/obj/item/bodypart/leg/right/necromorph/tripod
	name = "right leg"
	limb_id = SPECIES_NECROMORPH_TRIPOD
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/tripod.dmi'
	icon_state = "tripod_r_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 150
	px_x = 2
	px_y = 12
	wound_resistance = 5
	n_biomass = 21
	burn_modifier = 0.75
	special_footstep_sounds = list(list(
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_1.ogg',
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_2.ogg',
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_3.ogg',
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_4.ogg',
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_5.ogg',
		'tff_modular/modules/deadspace/sound/effects/footstep/brute_step_6.ogg'
	), VOLUME_MID, 0)

/obj/item/bodypart/leg/right/necromorph/tripod/try_dismember(wounding_type, wounding_dmg, wound_bonus, exposed_wound_bonus)
	return FALSE
