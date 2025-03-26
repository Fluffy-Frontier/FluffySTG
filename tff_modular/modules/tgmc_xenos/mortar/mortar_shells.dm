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
	if(isnull(T))
		T = get_turf(src)
	explosion_effect(T)
	qdel(src)

/obj/item/mortar_shell/proc/explosion_effect(turf/T)
	forceMove(T)


/obj/item/mortar_shell/he
	name = "\improper 80mm high explosive mortar shell"
	desc = "An 80mm mortar shell, loaded with a high explosive charge."
	icon_state = "mortar_ammo_he"

/obj/item/mortar_shell/he/explosion_effect(turf/T)
	explosion(T, 0, 0, 5, 7)


/obj/item/mortar_shell/he/high
	desc = "An 80mm mortar shell, loaded with a super high explosive charge."

/obj/item/mortar_shell/he/high/explosion_effect(turf/T)
	explosion(T, 0, 3, 5, 7)


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
	sleep(4)
	explosion(T, 0, 0, 5, 2)


/obj/item/mortar_shell/incendiary
	name = "\improper 80mm incendiary mortar shell"
	desc = "An 80mm mortar shell, loaded with a Type B napalm charge. Perfect for long-range area denial."
	icon_state = "mortar_ammo_inc"
	var/range = 5
	var/fire_type = /datum/effect_system/fluid_spread/smoke/fire

/obj/item/mortar_shell/incendiary/explosion_effect(turf/T)
	explosion(T, 0, 0, 4, 2)
	var/datum/effect_system/fluid_spread/smoke/fire/smoke = new fire_type(T)
	smoke.set_up(range, holder = T, location = T)
	smoke.start()
	playsound(T, 'tff_modular/modules/tgmc_xenos/mortar/sound/gun_flamethrower2.ogg', 35, 1, 4)


/obj/item/mortar_shell/flashbang
	name = "\improper 80mm flashbang mortar shell"
	desc = "An 80mm mortar shell, loaded with a large clasterbang grenade."
	icon_state = "mortar_ammo_flashbang"

	var/range = 4

/obj/item/mortar_shell/flashbang/explosion_effect(turf/T)
	explosion(T, 0, 0, 1, 0)
	var/obj/item/grenade/clusterbuster/flashbang = new /obj/item/grenade/clusterbuster/mortar(T)
	flashbang.arm_grenade(sender, 1 SECONDS)

/obj/item/grenade/clusterbuster/mortar
	min_spawned = 6
	max_spawned = 12


/obj/item/mortar_shell/smoke
	name = "\improper 80mm smoke mortar shell"
	desc = "An 80mm mortar shell, loaded with smoke dispersal agents. Can be fired at marines more-or-less safely. Way slimmer than your typical 80mm."
	icon_state = "mortar_ammo_smoke"

	var/range = 5

/obj/item/mortar_shell/smoke/explosion_effect(turf/T)
	explosion(T, 0, 0, 1, 0)
	var/datum/effect_system/fluid_spread/smoke/bad/smoke = new(T)
	smoke.set_up(range, holder = T, location = T)
	smoke.start()
	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE, -3)
