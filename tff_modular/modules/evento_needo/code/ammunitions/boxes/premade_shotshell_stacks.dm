// Shotshells
/obj/item/ammo_box/magazine/shotgun_box
	name = "box of 12ga buckshot"
	icon_state = "12gbox-buckshot"
	desc = "A box of 12-gauge buckshot shells, devastating at close range."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	max_ammo = 24 //make sure these values are consistent across the board with stack_size variable on respective ammo_casing
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/ammo_box/magazine/shotgun_box/slug
	name = "box of 12ga slugs"
	desc = "A box of 12-gauge slugs, for improved accuracy and penetration."
	icon_state = "12gbox-slug"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/shotgun_box/beanbag
	name = "box of 12ga beanbags"
	desc = "A box of 12-gauge beanbag shells, for incapacitating targets."
	icon_state = "12gbox-beanbag"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/magazine/shotgun_box/rubber
	name = "box of 12ga rubbershot"
	desc = "A box of 12-gauge rubbershot shells, designed for riot control."
	icon_state = "12gbox-rubbershot"
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/magazine/shotgun_box/incendiary
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary
