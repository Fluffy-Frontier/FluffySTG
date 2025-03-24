/obj/item/mortar_shell
	name = "\improper 80mm mortar shell"
	desc = "An unlabeled 80mm mortar shell, probably a casing."
	icon = 'tff_modular/modules/tgmc_xenos/mortar/icons/mortar.dmi'
	icon_state = "mortar_ammo_cas"
	lefthand_file = 'tff_modular/modules/tgmc_xenos/mortar/icons/shells_lefthand.dmi'
	righthand_file = 'tff_modular/modules/tgmc_xenos/mortar/icons/shells_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY

	/// Who fier that shell
	var/sender
	/// is it currently on fire and about to explode?
	var/burning = FALSE

/obj/item/mortar_shell/proc/detonate(turf/T)
	explosion_effect(T)
	qdel(src)

/obj/item/mortar_shell/proc/explosion_effect(turf/T)
	forceMove(T)


/obj/item/mortar_shell/he
	name = "\improper 80mm high explosive mortar shell"
	desc = "An 80mm mortar shell, loaded with a high explosive charge."
	icon_state = "mortar_ammo_he"

/obj/item/mortar_shell/he/explosion_effect(turf/T)
	explosion(T, 0, 3, 5, 7, explosion_cause = sender)


/obj/item/mortar_shell/frag
	name = "\improper 80mm fragmentation mortar shell"
	desc = "An 80mm mortar shell, loaded with a fragmentation charge."
	icon_state = "mortar_ammo_frag"

	// dealing with creating a [/datum/component/pellet_cloud] on detonate
	/// if set, will spew out projectiles of this type
	var/shrapnel_type = /obj/item/shrapnel
	/// the higher this number, the more projectiles are created as shrapnel
	var/shrapnel_radius = 20

/obj/item/mortar_shell/frag/explosion_effect(turf/T)
	AddComponent(/datum/component/pellet_cloud, projectile_type = shrapnel_type, magnitude = shrapnel_radius)
	sleep(2)
	explosion(T, 0, 1, 3, 4, explosion_cause = sender)


// /obj/item/mortar_shell/incendiary
// 	name = "\improper 80mm incendiary mortar shell"
// 	desc = "An 80mm mortar shell, loaded with a Type B napalm charge. Perfect for long-range area denial."
// 	icon_state = "mortar_ammo_inc"
// 	var/radius = 5
// 	var/flame_level = BURN_TIME_TIER_5 + 5 //Type B standard, 50 base + 5 from chemfire code.
// 	var/burn_level = BURN_LEVEL_TIER_2
// 	var/flameshape = FLAMESHAPE_DEFAULT
// 	var/fire_type = FIRE_VARIANT_TYPE_B //Armor Shredding Greenfire

// /obj/item/mortar_shell/incendiary/detonate(turf/T)
// 	explosion(T, 0, 2, 4, 7, explosion_cause = sender)
// 	flame_radius(cause_data, radius, T, flame_level, burn_level, flameshape, null, fire_type)
// 	playsound(T, 'tff_modular/modules/tgmc_xenos/mortar/sound/gun_flamethrower2.ogg', 35, 1, 4)
