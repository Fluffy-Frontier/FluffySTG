
/obj/item/ammo_box/magazine/f4_308
	name = "\improper F4 Magazine (.308)"
	desc = "A standard 10-round magazine for F4 platform DMRs. These rounds do good damage with significant armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "gal_mag"
	base_icon_state = "gal_mag"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = CALIBER_308
	max_ammo = 10

/obj/item/ammo_box/magazine/f4_308/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/f4_308/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/f90
	name = "\improper CM-F90 Magazine (6.5x57mm CLIP)"
	desc = "A large 5-round box magazine for the CM-F90 sniper rifles. These rounds deal amazing damage and bypass half of their protective equipment, though it isn't a high enough caliber to pierce armored vehicles."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "f90_mag"
	icon_state = "f90_mag-1"
	ammo_type = /obj/item/ammo_casing/a75clip
	caliber = CALIBER_75X64MM
	max_ammo = 5

/obj/item/ammo_box/magazine/f90/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/f90/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/boomslang
	name = "\improper Boomslang Magazine (7.5x64mm CLIP)"
	desc = "A large 10-round box magazine for Boomslang sniper rifles. These rounds deal amazing damage and can pierce protective equipment, excluding armored vehicles."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "boomslang"
	icon_state = "boomslang"
	ammo_type = /obj/item/ammo_casing/a75clip
	caliber = CALIBER_75X64MM
	max_ammo = 10
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/boomslang/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/boomslang/short
	name = "\improper Boomslang Magazine (7.5x64mm CLIP)"
	desc = "A 5-round box magazine for Boomslang sniper rifles. These rounds deal amazing damage and can pierce protective equipment, excluding armored vehicles."
	base_icon_state = "boomslang_short"
	icon_state = "boomslang_short"
	ammo_type = /obj/item/ammo_casing/a75clip
	caliber = CALIBER_75X64MM
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/boomslang/short/empty
	start_empty = TRUE
