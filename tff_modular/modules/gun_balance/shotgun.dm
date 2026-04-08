//родной - modular_nova/modules/shotgunrebalance/code/shotgun.dm

/obj/projectile/bullet/pellet/shotgun_buckshot/milspec
	damage = 7
	damage_falloff_tile = -0.1
	wound_falloff_tile = -0.25
	speed = 1.5
	armour_penetration = 5

/obj/projectile/bullet/pellet/shotgun_buckshot
	damage = 5
	wound_bonus = 5
	exposed_wound_bonus = 5

/obj/projectile/bullet/shotgun_slug
	damage = 40
	wound_bonus = 5
	exposed_wound_bonus = 10

/obj/item/gun/ballistic/shotgun/automatic/combat
	projectile_damage_multiplier = 1.25

/obj/projectile/bullet/shotgun_slug/milspec
	damage = 50
	wound_bonus = 10
	exposed_wound_bonus = 10

/obj/item/ammo_casing/shotgun/buckshot
	pellets = 12
	variance = 18

/obj/item/ammo_casing/shotgun/magnum
	pellets = 6 // Half as many pellets for twice the damage each pellet, same overall damage as buckshot
	variance = 15

/obj/projectile/bullet/pellet/shotgun_buckshot/magnum
	damage = 4.5
	exposed_wound_bonus = 10

/obj/item/ammo_casing/shotgun/express
	pellets = 15 // 4 * 15 for 60 damage, with less spread then buckshot.
	variance = 22

/obj/projectile/bullet/pellet/shotgun_buckshot/express
	damage = 4

//TFF баф дроби, выпилить бы
/obj/item/ammo_casing/shotgun/rubbershot
	variance = 16

/obj/item/ammo_casing/shotgun/ion
	variance = 10

/obj/item/ammo_casing/shotgun/incapacitate
	variance = 18

/obj/item/ammo_casing/shotgun/flechette
	variance = 18

/obj/item/ammo_casing/shotgun/antitide
	variance = 22

/obj/item/gun/ballistic/shotgun/katyusha
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/ballistic/shotgun/katyusha/shitzu
	slot_flags = ITEM_SLOT_BACK
