/obj/item/ammo_casing/energy/disabler/hitscan
	projectile_type = /obj/projectile/beam/hitscan/disabler
	e_cost = LASER_SHOTS(18, STANDARD_CELL_CHARGE)
	delay = 0.7 SECONDS

/obj/item/ammo_casing/energy/laser/eoehoma
	projectile_type = /obj/projectile/beam/laser/eoehoma
	fire_sound = 'tff_modular/modules/evento_needo/sounds/laser/e-fire.ogg'

/obj/projectile/beam/laser/eoehoma/hermit // Used for the Hermits with E-11 because apparently you can only set it on projectile for simple mobs? That's fun!
	spread = 30

/obj/item/ammo_casing/energy/laser/assault
	projectile_type = /obj/projectile/beam/laser/assault
	fire_sound = 'tff_modular/modules/evento_needo/sounds/laser/e40_las.ogg'
	delay = 0.3 SECONDS
	e_cost = LASER_SHOTS(21, STANDARD_CELL_CHARGE) //30 per upgraded cell

/obj/item/ammo_casing/energy/laser/assault/sharplite
	projectile_type = /obj/projectile/beam/laser/assault/sharplite
	fire_sound = 'tff_modular/modules/evento_needo/sounds/laser/e40_las.ogg'

/obj/item/ammo_casing/energy/laser/eoehoma/e50
	projectile_type = /obj/projectile/beam/emitter/hitscan/e50
	fire_sound = 'tff_modular/modules/evento_needo/sounds/laser/heavy_laser.ogg'
	e_cost = LASER_SHOTS(5, STANDARD_CELL_CHARGE)
	delay = 1 SECONDS

/obj/item/ammo_casing/energy/lasergun
	projectile_type = /obj/projectile/beam/laser
	e_cost = LASER_SHOTS(15, STANDARD_CELL_CHARGE)
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun/sharplite
	projectile_type = /obj/projectile/beam/laser/sharplite
	e_cost = LASER_SHOTS(15, STANDARD_CELL_CHARGE)
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun/eoehoma
	projectile_type = /obj/projectile/beam/laser/eoehoma
	fire_sound = 'tff_modular/modules/evento_needo/sounds/laser/e40_las.ogg'
	e_cost = LASER_SHOTS(25, STANDARD_CELL_CHARGE)
	delay = 0.45 SECONDS

/obj/item/ammo_casing/energy/lasergun/eoehoma/heavy
	projectile_type = /obj/projectile/beam/laser/eoehoma/heavy
	fire_sound = 'tff_modular/modules/evento_needo/sounds/laser/heavy_laser.ogg'
	e_cost = LASER_SHOTS(2, STANDARD_CELL_CHARGE)
	select_name = "overcharge"
	delay = 10 SECONDS

/obj/item/ammo_casing/energy/laser/smg
	projectile_type = /obj/projectile/beam/laser/weak
	e_cost = LASER_SHOTS(18, STANDARD_CELL_CHARGE) //12 shots with a normal power cell, 25 with an upgraded
	select_name = "kill"
	delay = 0.25 SECONDS

/obj/item/ammo_casing/energy/laser/sharplite/smg
	projectile_type = /obj/projectile/beam/weak/sharplite
	e_cost = LASER_SHOTS(18, STANDARD_CELL_CHARGE) //12 shots with a normal power cell, 25 with an upgraded
	select_name = "kill"
	delay = 0.2 SECONDS

/obj/item/ammo_casing/energy/laser/sharplite/hos
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)


/obj/item/ammo_casing/energy/laser/practice/sharplite
	projectile_type = /obj/projectile/beam/practice/sharplite
	select_name = "practice"
	harmful = FALSE


/obj/item/ammo_casing/energy/laser/ultima
	delay = 0.75 SECONDS
	projectile_type = /obj/projectile/beam/weak
	pellets = 4
	variance = 25
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE)
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/ultima/alt
	select_name = "scatter"

/obj/item/ammo_casing/energy/disabler/sharplite
	projectile_type = /obj/projectile/beam/disabler/sharplite
	select_name  = "disable"
	e_cost = LASER_SHOTS(25, STANDARD_CELL_CHARGE)
	fire_sound = 'sound/items/weapons/taser2.ogg'
	delay = 0.25 SECONDS
	harmful = FALSE

/obj/item/ammo_casing/energy/disabler/sharplite/hos
	e_cost = LASER_SHOTS(25, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/disabler/sharplite/smg
	projectile_type = /obj/projectile/beam/disabler/weak/negative_ap/sharplite
	e_cost = LASER_SHOTS(25, STANDARD_CELL_CHARGE)
	delay = 0.25 SECONDS

/obj/item/ammo_casing/energy/electrode/old
	e_cost = LASER_SHOTS(3, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/electrode/hos
	e_cost = LASER_SHOTS(5, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/ion/hos
	projectile_type = /obj/projectile/ion/weak
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/ion/cheap
	e_cost = LASER_SHOTS(14, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/disabler/scatter/ultima
	delay = 0.75 SECONDS
	projectile_type = /obj/projectile/beam/disabler/weak/negative_ap
	pellets = 4
	variance = 25
	e_cost = LASER_SHOTS(15, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/disabler/scatter/ultima/alt
	select_name = "blast"

/obj/item/ammo_casing/energy/trap
	projectile_type = /obj/projectile/energy/trap
	select_name = "snare"
	e_cost = LASER_SHOTS(3, STANDARD_CELL_CHARGE)
	delay = 2 SECONDS
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/underbarrel
	projectile_type = /obj/projectile/beam/laser
	e_cost =  LASER_SHOTS(14, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/disabler/underbarrel
	e_cost = LASER_SHOTS(18, STANDARD_CELL_CHARGE)
