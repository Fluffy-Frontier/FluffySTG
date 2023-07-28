// Лазер

/obj/item/ammo_casing/energy/laser/blueshield
	projectile_type = /obj/projectile/beam/laser/hellfire
	e_cost = 2500
	select_name = "burn"
	fire_sound = 'tff_modular/modules/blueshield-rearm/sounds/sr8_laser_shot.ogg'

// Дизейблер

/obj/item/ammo_casing/energy/disabler/blueshield
	e_cost = 1250

// Пуля

/obj/item/ammo_casing/energy/concentrated_blueshield
	projectile_type = /obj/projectile/bullet/concentrated_energy
	e_cost = 5000
	select_name = "pierce"
	fire_sound = 'tff_modular/modules/blueshield-rearm/sounds/sr8_bullet_shot.ogg'

/obj/projectile/bullet/concentrated_energy
	name = "concentrated energy"
	damage = 30 // урон аналогичный M1911
	icon_state = "gaussphase"
