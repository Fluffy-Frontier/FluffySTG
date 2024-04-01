// Лазер

/obj/item/ammo_casing/energy/laser/blueshield
	projectile_type = /obj/projectile/beam/laser/hellfire/blueshield
	e_cost = LASER_SHOTS(4, STANDARD_CELL_CHARGE * 10) //8 выстрелов на выданной в комплекте Т2 батарейке
	select_name = "kill"
	fire_sound = 'tff_modular/modules/blueshield-rearm/sounds/sr8_lethal_shot.ogg'

/obj/projectile/beam/laser/hellfire/blueshield
	name = "concentrated energy"
	icon_state = "gaussphase"

// Дизейблер

/obj/item/ammo_casing/energy/disabler/blueshield
	e_cost = LASER_SHOTS(8, STANDARD_CELL_CHARGE * 10)
