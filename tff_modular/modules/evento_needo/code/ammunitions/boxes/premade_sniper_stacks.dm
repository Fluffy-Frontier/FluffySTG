//7.5x64mm CLIP

/obj/item/ammo_box/magazine/a75clip_box
	name = "a75 ammunition box"
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	icon_state = "generic-ammo"
	ammo_type = /obj/item/ammo_casing/a75clip
	max_ammo = 20

/obj/item/ammo_box/magazine/a308_box
	name = "a308 ammunition box"
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	icon_state = "generic-ammo"
	ammo_type = /obj/item/ammo_casing/a308
	max_ammo = 20

// 8x58mm caseless (SG-669)

/obj/projectile/bullet/a858
	name = "8x58mm caseless bullet"
	damage = 45
	stamina = 10
	armour_penetration = 50
	speed = BULLET_SPEED_SNIPER

/obj/projectile/bullet/a858/trac
	name = "8x58mm tracker"
	damage = 12
	armour_penetration = 0
