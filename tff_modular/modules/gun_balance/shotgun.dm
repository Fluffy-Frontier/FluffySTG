//родной - modular_nova/modules/shotgunrebalance/code/shotgun.dm

/obj/projectile/bullet/shotgun_slug
	damage = 25
	wound_bonus = 0
	exposed_wound_bonus = 15

/obj/projectile/bullet/shotgun_slug/milspec
	damage = 50

/obj/item/ammo_casing/shotgun/buckshot
	pellets = 6
	variance = 15

/obj/item/ammo_casing/shotgun/express
	pellets = 10
	variance = 12


/obj/item/ammo_casing/shotgun/rubbershot
	pellets = 6
	variance = 15

/obj/projectile/bullet/pellet/shotgun_buckshot
	damage = 5
	wound_bonus = 5
	exposed_wound_bonus = 5

/obj/projectile/bullet/pellet/shotgun_buckshot/express
	damage = 3

/obj/projectile/bullet/pellet/shotgun_rubbershot
	speed = 0.8

/obj/projectile/bullet/pellet/flechette
	damage = 2
	exposed_wound_bonus = 5
