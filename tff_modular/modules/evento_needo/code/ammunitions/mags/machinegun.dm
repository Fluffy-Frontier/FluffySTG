/obj/item/ammo_box/magazine/cm40_762_40_box
	name = "CM-40 box magazine (7.62x40mm CLIP)"
	desc = "An 80 round box magazine for CM-40 light machine gun. These rounds do good damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "cm40_mag"
	icon_state = "cm40_mag-1"
	ammo_type = /obj/item/ammo_casing/a762_40
	caliber = CALIBER_762X40MM
	max_ammo = 80
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/cm40_762_40_box/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm40_762_40_box/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/rottweiler_308_box
	name = "Rottweiler box magazine (.308)"
	desc = "A 50 round box magazine for Rottweiler machine gun. These rounds do good damage with significant armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "rottweiler_mag"
	icon_state = "rottweiler_mag-1"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = CALIBER_308
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/rottweiler_308_box/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/rottweiler_308_box/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/m12_shredder
	name = "belt box (12g)"
	desc = "A 40-round belt box for the Shredder heavy machine gun."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "shredder_mag-1"
	base_icon_state = "shredder_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/m12_shredder/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"


/obj/item/ammo_box/magazine/m12_shredder/slug
	name = "belt box (12g slug)"
	desc = "A 40-round belt box for the Shredder heavy machine gun."
	icon_state = "shredder_mag_slug-1"
	base_icon_state = "shredder_mag_slug"
	ammo_type = /obj/item/ammo_casing/shotgun
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL
