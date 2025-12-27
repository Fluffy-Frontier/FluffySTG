/obj/item/bodypart/chest/necromorph/infector
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_INFECTOR
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_state = "infector_chest"
	max_damage = 200
	px_x = 0
	px_y = 0
	wound_resistance = 10

/obj/item/bodypart/head/necromorph/infector
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_INFECTOR
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_state = "infector_head"
	max_damage = 200
	px_x = 0
	px_y = -8
	wound_resistance = 5

/obj/item/bodypart/head/necromorph/infector/receive_damage(brute, burn, blocked, updating_health, forced, required_bodytype, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, damage_source, wound_clothing)
	var/obj/item/organ/tongue/necro/proboscis/tongue = owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(tongue)
		if(tongue.extended && prob(burn_dam + brute_dam))
			var/atom/drop_loc = drop_location()
			if(tongue.bodypart_remove(src))
				if(drop_loc) //can be null if being deleted
					tongue.forceMove(get_turf(drop_loc))
	return ..()

/obj/item/bodypart/arm/left/necromorph/infector
	name = "left arm"
	limb_id = SPECIES_NECROMORPH_INFECTOR
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_state = "infector_l_arm"
	attack_verb_continuous = list("slashes", "stabs")
	attack_verb_simple = list("slash", "stab")
	max_damage = 50
	px_x = -6
	px_y = 0
	wound_resistance = 0

/obj/item/bodypart/arm/right/necromorph/infector
	name = "right arm"
	limb_id = SPECIES_NECROMORPH_INFECTOR
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_state = "infector_r_arm"
	attack_verb_continuous = list("slashes", "stabs")
	attack_verb_simple = list("slash", "stab")
	max_damage = 50
	px_x = 6
	px_y = 0
	wound_resistance = 0

/obj/item/bodypart/leg/left/necromorph/infector
	name = "left leg"
	limb_id = SPECIES_NECROMORPH_INFECTOR
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_state = "infector_l_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	px_x = -2
	px_y = 12
	wound_resistance = 0

/obj/item/bodypart/leg/right/necromorph/infector
	name = "right leg"
	limb_id = SPECIES_NECROMORPH_INFECTOR
	icon = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_static = 'tff_modular/modules/deadspace/icons/necromorphs/infector.dmi'
	icon_state = "infector_r_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	px_x = 2
	px_y = 12
	wound_resistance = 0
