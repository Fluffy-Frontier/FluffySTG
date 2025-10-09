// 7.12x82mm (L6 SAW)

/obj/projectile/bullet/mm712x82
	name = "7.12x82mm bullet"
	damage = 15
	armour_penetration = 40
	speed = BULLET_SPEED_RIFLE

/obj/projectile/bullet/mm712x82/ap
	name = "7.12x82mm armor-piercing bullet"
	armour_penetration = 75

/obj/projectile/bullet/mm712x82/hp
	name = "7.12x82mm hollow point bullet"
	damage = 30
	armour_penetration = -20

/obj/projectile/bullet/mm712x82/match
	name = "7.12x82mm match bullet"
	armour_penetration = 50
	ricochets_max = 2
	ricochet_chance = 60
	ricochet_auto_aim_range = 4
	ricochet_incidence_leeway = 35
