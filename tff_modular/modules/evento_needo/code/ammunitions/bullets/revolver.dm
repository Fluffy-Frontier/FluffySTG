// 44 Short (Roumain & Shadow)

/obj/projectile/bullet/a44roum
	name = ".44 roumain bullet"
	damage =  25
	speed = BULLET_SPEED_REVOLVER

/obj/projectile/bullet/a44roum/rubber
	name = ".44 roumain rubber bullet"
	damage =  7
	stamina = 40
	armour_penetration = -10

/obj/projectile/bullet/a44roum/hp
	name = ".44 roumain hollow point bullet"
	damage =  40
	armour_penetration = -10
	ricochet_chance = 0

// .45-70 Gov't (Hunting Revolver)

/obj/projectile/bullet/a4570
	name = ".45-70 bullet"
	damage = 30
	speed = BULLET_SPEED_REVOLVER

/obj/projectile/bullet/a4570/match
	name = ".45-70 match bullet"
	armour_penetration = 10
	ricochets_max = 5
	ricochet_chance = 140
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80
	ricochet_decay_chance = 1

/obj/projectile/bullet/a4570/hp
	name = ".45-70 hollow point bullet"
	damage = 45
	armour_penetration = -10

/obj/projectile/bullet/a4570/explosive //for extra oof
	name = ".45-70 explosive bullet"
	dismemberment = 50 //literally blow limbs off

/obj/projectile/bullet/a4570/explosive/on_hit(atom/target, blocked = FALSE, pierce_hit)
	..()
	explosion(target, -1, 0, 1)
	return BULLET_ACT_HIT
