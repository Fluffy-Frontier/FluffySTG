//.22lr (Himehabu, Micro Target, Pounder (uwu))

/obj/projectile/bullet/c22lr
	name = ".22LR bullet"
	damage = 17
	armour_penetration = -40
	ricochet_incidence_leeway = 20
	ricochet_chance = 65
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c22lr/hp
	name = ".22LR HP bullet"
	damage = 19
	armour_penetration = -50
	ricochet_chance = 0

/obj/projectile/bullet/c22lr/ap
	name = ".22LR armor piercing bullet"
	damage = 15
	armour_penetration = -20
	ricochet_incidence_leeway = 20
	ricochet_chance = 30

/obj/projectile/bullet/c22lr/rubber
	name = ".22LR rubber bullet"
	damage = 4
	stamina = 15
	armour_penetration = -50
	ricochets_max = 8 //ding ding ding ding
	ricochet_incidence_leeway = 70
	ricochet_chance = 130
	ricochet_decay_damage = 0.8

// 10x22mm (Ringneck)

/obj/projectile/bullet/c10mm
	name = "10x22mm bullet"
	damage = 25
	armour_penetration = -20
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c10mm/surplus
	name = "10x22mm surplus bullet"

/obj/projectile/bullet/c10mm/ap
	name = "10x22mm armor-piercing bullet"
	damage = 23
	armour_penetration = 10

/obj/projectile/bullet/c10mm/hp
	name = "10x22mm hollow point bullet"
	damage = 35
	armour_penetration = -30

/obj/projectile/bullet/c10mm/rubber
	name = "10x22mm rubber bullet"
	damage = 7
	stamina = 35
	armour_penetration = -30

// .45 (Candor, C20r)

/obj/projectile/bullet/c45
	name = ".45 bullet"
	damage = 25
	armour_penetration = -20
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c45/surplus
	name = ".45 surplus bullet"

/obj/projectile/bullet/c45/ap
	name = ".45 armor-piercing bullet"
	damage = 22
	armour_penetration = 10

/obj/projectile/bullet/c45/hp
	name = ".45 hollow point bullet"
	damage = 37
	armour_penetration = -30

/obj/projectile/bullet/c45/rubber
	name = ".45 rubber bullet"
	damage = 7
	stamina = 37
	armour_penetration = -30
