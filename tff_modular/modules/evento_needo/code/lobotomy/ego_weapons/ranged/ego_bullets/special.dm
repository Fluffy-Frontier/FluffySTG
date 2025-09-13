/obj/projectile/ego_bullet/ego_soda/rifle
	damage = 17
	speed = 0.25

/obj/projectile/ego_bullet/shrimp_red
	name = "9mm soda bullet R"
	damage = 8
	range = 12
	spread = 20
	damage_type = BURN

/obj/projectile/ego_bullet/shrimp_white
	name = "9mm soda bullet W"
	damage = 70
	speed = 0.1
	damage_type = BRAIN
	projectile_piercing = PASSMOB

/obj/projectile/ego_bullet/shrimp_white/on_hit(atom/target, blocked = FALSE, pierce_hit)
	..()
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	if(H.sanity_lost)
		var/obj/item/bodypart/head/head = H.get_bodypart("head")
		if(istype(head))
			if(QDELETED(head))
				return
			head.dismember()
			QDEL_NULL(head)
			H.regenerate_icons()
			visible_message(span_danger("[H]'s head blew right off!"))

/obj/projectile/ego_bullet/shrimp_pale
	name = "9mm soda bullet P"
	damage = 6
	damage_type = BRUTE

/obj/projectile/ego_bullet/ego_kcorp
	damage = 15

/obj/projectile/ego_bullet/ego_knade
	damage = 15
	speed = 1
	icon_state = "kcorp_nade"

/obj/projectile/ego_bullet/ego_knade/on_hit(atom/target, blocked = FALSE, pierce_hit)
	..()
	for(var/turf/T in view(1, src))
		for(var/mob/living/L in T)
			L.apply_damage(60, BRUTE, null, L.run_armor_check(null, BRUTE), spread_damage = TRUE)
	new /obj/effect/explosion(get_turf(src))
	qdel(src)
	return BULLET_ACT_HIT

/obj/projectile/ego_bullet/flammenwerfer
	name = "flames"
	icon_state = "flamethrower_fire"
	damage = 1
	damage_type = BURN
	speed = 2
	range = 5
	hitsound_wall = 'sound/items/weapons/tap.ogg'
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser

/obj/projectile/ego_bullet/flammenwerfer/on_hit(atom/target, blocked = FALSE, pierce_hit)
	..()
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	H.adjust_fire_stacks(0.1)
	H.ignite_mob()
	return BULLET_ACT_HIT

/obj/projectile/ego_bullet/tendamage
	name = "bullet"
	damage = 10
