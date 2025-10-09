
/obj/item/ammo_box/magazine/cm15_12g
	name = "CM-15 magazine (12g buckshot)"
	desc = "An almost straight, 8-round magazine designed for the CM-15 shotgun."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm15_mag-1"
	base_icon_state = "cm15_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 8

/obj/item/ammo_box/magazine/cm15_12g/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm15_12g/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/cm15_12g/incendiary
	name = "CM-15 magazine (12g incendiary)"
	desc = "An almost straight, 8-round magazine designed for the CM-15 shotgun. This one was loaded with incendiary slugs. Be careful!"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary



/obj/item/ammo_box/magazine/m12g_bulldog
	name = "shotgun box magazine (12g buckshot)"
	desc = "A single-stack, 8-round box magazine for the Bulldog shotgun and it's derivatives."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "bulldog_mag"
	base_icon_state = "bulldog_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 8

/obj/item/ammo_box/magazine/m12g_bulldog/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m12g_bulldog/slug
	name = "shotgun box magazine (12g Slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/m12g_bulldog/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m12g_bulldog/drum
	name = "shotgun drum magazine (12g buckshot)"
	desc = "A bulky 12-round drum designed for the Bulldog shotgun and it's derivatives."
	icon_state = "bulldog_drum"
	base_icon_state = "bulldog_drum"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 12
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/m12g_bulldog/drum/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m12g_bulldog/drum/stun
	name = "shotgun drum magazine (12g taser slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/magazine/m12g_bulldog/drum/slug
	name = "shotgun drum magazine (12g slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/m12g_bulldog/drum/dragon
	name = "shotgun drum magazine (12g dragon's breath)"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/ammo_box/magazine/m12g_bulldog/drum/bioterror
	name = "shotgun drum magazine (12g bioterror)"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/bioterror

/obj/item/ammo_box/magazine/m12g_bulldog/drum/meteor
	name = "shotgun drum magazine (12g meteor slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun/meteorslug



//INTERNAL

/obj/item/ammo_box/magazine/internal/shot/dual/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/internal/shot/dual/lethal/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/internal/shot/lethal/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/internal/shot/winchester/conflagration
	name = "conflagration internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 5

/obj/item/ammo_box/magazine/internal/shot/twobore
	name = "two-bore shotgun internal magazine"
	max_ammo = 2
	caliber = CALIBER_SHOTGUN

/obj/item/ammo_box/magazine/internal/shot/buckmaster
	name = "Buckmaster internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 6
	caliber = CALIBER_SHOTGUN

/obj/item/ammo_box/magazine/internal/shot/underbarrel
	name = "underbarrel shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 2
	caliber = CALIBER_SHOTGUN
