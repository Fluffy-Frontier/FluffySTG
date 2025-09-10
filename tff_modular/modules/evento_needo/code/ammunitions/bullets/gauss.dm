// Ferromagnetic Pellet (Prototype Gauss Rifle & Claris)

/obj/projectile/bullet/gauss
	name = "ferromagnetic pellet"
	icon = 'tff_modular/modules/evento_needo/icons/projectiles.dmi'
	icon_state = "gauss-pellet"
	damage = 25
	range = 35
	light_system = 2
	light_range = 3

/obj/projectile/bullet/gauss/hc
	name = "ferromagnetic pellet"
	damage = 15
	armour_penetration = 60
	range = 50
	hitscan = TRUE
	light_system = 0
	light_range = 0
	muzzle_type = /obj/effect/projectile/muzzle/gauss
	tracer_type = /obj/effect/projectile/tracer/gauss
	impact_type = /obj/effect/projectile/impact/gauss

// Ferromagnetic Lance (GAR AR)

/obj/projectile/bullet/gauss/lance
	name = "ferromagnetic lance"
	icon = 'tff_modular/modules/evento_needo/icons/projectiles.dmi'
	icon_state = "redtrac"
	damage = 30
	armour_penetration = 20

/obj/projectile/bullet/gauss/lance/hc
	name = "ferromagnetic lance"
	damage = 20
	armour_penetration = 80
	range = 50
	hitscan = TRUE
	light_system = 0
	light_range = 0
	muzzle_type = /obj/effect/projectile/muzzle/gauss
	tracer_type = /obj/effect/projectile/tracer/gauss
	impact_type = /obj/effect/projectile/impact/gauss

// Ferromagnetic Slug (Model H)

/obj/projectile/bullet/gauss/slug
	name = "ferromagnetic slug"
	icon = 'tff_modular/modules/evento_needo/icons/projectiles.dmi'
	icon_state = "gauss-slug"
	damage = 50
	armour_penetration = -60
	speed = 0.8

/obj/projectile/bullet/gauss/slug/hc
	name = "ferromagnetic lance"
	damage = 25
	armour_penetration = 0
	range = 50
	hitscan = TRUE
	light_system = 0
	light_range = 0
	muzzle_type = /obj/effect/projectile/muzzle/gauss
	tracer_type = /obj/effect/projectile/tracer/gauss
	impact_type = /obj/effect/projectile/impact/gauss
