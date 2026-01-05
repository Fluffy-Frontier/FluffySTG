//родной - modular_nova/modules/shotgunrebalance/code/shotgun.dm
/obj/projectile/bullet/shotgun_slug
	damage = 50
	wound_bonus = 5
	exposed_wound_bonus = 10

/obj/projectile/bullet/shotgun_slug/milspec
	damage = 60
	wound_bonus = 10
	exposed_wound_bonus = 10

/obj/item/ammo_casing/shotgun/buckshot
	pellets = 12 // 5 * 12 for 60 damage if every pellet hits

/obj/item/ammo_casing/shotgun/magnum
	pellets = 6 // Half as many pellets for twice the damage each pellet, same overall damage as buckshot


/obj/projectile/bullet/pellet/shotgun_buckshot/magnum
	exposed_wound_bonus = 10

/obj/item/ammo_casing/shotgun/express
	pellets = 15 // 4 * 15 for 60 damage, with less spread then buckshot.

/obj/projectile/bullet/pellet/shotgun_buckshot/express
	damage = 4
