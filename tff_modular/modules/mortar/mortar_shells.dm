/obj/item/mortar_shell
	name = "\improper 80mm mortar shell"
	desc = "An unlabeled 80mm mortar shell, probably a casing."
	icon = 'tff_modular/modules/mortar/icons/mortar.dmi'
	icon_state = "mortar_ammo_cas"
	lefthand_file = 'tff_modular/modules/mortar/icons/shells_lefthand.dmi'
	righthand_file = 'tff_modular/modules/mortar/icons/shells_righthand.dmi'
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
	return


/obj/item/mortar_shell/he
	name = "\improper 80mm high explosive mortar shell"
	desc = "An 80mm mortar shell, loaded with a high explosive charge."
	icon_state = "mortar_ammo_he"

/obj/item/mortar_shell/he/explosion_effect(turf/T)
	explosion(T, 0, 3, 5, 7)


/obj/item/mortar_shell/frag
	name = "\improper 80mm fragmentation mortar shell"
	desc = "An 80mm mortar shell, loaded with a fragmentation charge."
	icon_state = "mortar_ammo_frag"

	var/obj/item/grenade/grenade_type = /obj/item/grenade/mortar_thing

/obj/item/mortar_shell/frag/explosion_effect(turf/T)
	explosion(T, 0, 0, 5, 2)
	sleep(4)
	var/obj/item/grenade/grenade = new grenade_type(T)
	grenade.detonate(sender)

/obj/item/grenade/mortar_thing
	name = "ERROR"
	desc = "You should not have to see this. Tell your nearest maintainer about it!"

	shrapnel_type = /obj/projectile/bullet/shrapnel/mortar
	shrapnel_radius = 4

/obj/item/grenade/mortar_thing/detonate(mob/living/lanced_by)
	. = ..()
	qdel(src)

/obj/projectile/bullet/shrapnel/mortar
	damage = 30
	ricochet_chance = 10
	wound_bonus = 50


/obj/item/mortar_shell/incendiary
	name = "\improper 80mm incendiary mortar shell"
	desc = "An 80mm mortar shell, loaded with a Type B napalm charge. Perfect for long-range area denial."
	icon_state = "mortar_ammo_inc"
	var/range = 4
	var/fire_type = /datum/effect_system/fluid_spread/smoke/fire

/obj/item/mortar_shell/incendiary/explosion_effect(turf/T)
	explosion(T, 0, 0, 4, 2)
	var/datum/effect_system/fluid_spread/smoke/fire/fire = new fire_type(T)
	fire.set_up(range, holder = T, location = T)
	fire.start()
	playsound(T, 'tff_modular/modules/mortar/sound/gun_flamethrower2.ogg', 35, 1, 4)


/obj/item/mortar_shell/flashbang
	name = "\improper 80mm flashbang mortar shell"
	desc = "An 80mm mortar shell, loaded with a large clasterbang grenade."
	icon_state = "mortar_ammo_flashbang"

	var/range = 4
	var/grenade_type = /obj/item/grenade/clusterbuster/mortar

/obj/item/mortar_shell/flashbang/explosion_effect(turf/T)
	explosion(T, 0, 0, 1, 0)
	var/obj/item/grenade/flashbang = new grenade_type(T)
	flashbang.arm_grenade(sender, 1 SECONDS)

/obj/item/grenade/clusterbuster/mortar
	min_spawned = 6
	max_spawned = 10


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
