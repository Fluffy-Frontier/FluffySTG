
/obj/item/ammo_box/magazine/cm5_9mm
	name = "CM-5 magazine (9x18mm)"
	desc = "A 30-round magazine for the CM-5 submachine gun. These rounds do okay damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm5_mag"
	base_icon_state = "cm5_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 30

/obj/item/ammo_box/magazine/cm5_9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm5_9mm/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/cm5_9mm/rubber
	desc = "A 30-round magazine for the CM-5 submachine gun. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	caliber = "9x18mm rubber"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber



/obj/item/ammo_box/magazine/c22lr_pounder_pan
	name = "pan magazine (.22 LR)"
	desc = "A 50-round pan magazine for the Pounder submachine gun."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "firestorm_pan"
	base_icon_state = "firestorm_pan"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = CALIBER_22LR
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/c22lr_pounder_pan/update_icon_state()
	. = ..()
	icon_state = "firestorm_pan"




/obj/item/ammo_box/magazine/c44_firestorm_mag
	name = "stick magazine (.44 Roumain)"
	desc = "A 24-round stick magazine for the toploading Firestorm submachine gun. These rounds do moderate damage, and perform adequately against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "firestorm_mag-1"
	base_icon_state = "firestorm_mag"
	ammo_type = /obj/item/ammo_casing/a44roum
	caliber = CALIBER_44ROUMAIN
	max_ammo = 24

/obj/item/ammo_box/magazine/c44_firestorm_mag/update_icon_state()
	. = ..()
	icon_state = "firestorm_mag-[!!ammo_count()]"

/obj/item/ammo_box/magazine/c44_firestorm_mag/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c44_firestorm_mag/pan
	name = "pan magazine (.44 Roumain)"
	desc = "A bulky, 40-round pan magazine for the toploading Firestorm submachine gun. The rate of fire may be low, but this much ammo can mow through anything."
	icon_state = "firestorm_pan"
	base_icon_state = "firestorm_pan"
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/c44_firestorm_mag/pan/update_icon_state() //Causes the mag to NOT inherit the parent's update_icon oooh the misery
	. = ..()
	icon_state = "firestorm_pan"

/obj/item/ammo_box/magazine/c44_firestorm_mag/pan/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/skm_46_30
	name = "subcaliber assault rifle magazine (4.6x30mm)"
	desc = "A slightly-curved, 30-round magazine for the SKM-24v. These rounds do okay damage with average performance against armor"
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "skmcarbine_mag"
	icon_state = "skmcarbine_mag-1"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = CALIBER_46X30MM
	max_ammo = 30

/obj/item/ammo_box/magazine/skm_46_30/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"



/obj/item/ammo_box/magazine/smgm9mm
	name = "SMG magazine (9x18mm)"
	desc = "A 30-round magazine for 9x18mm submachine guns. These rounds do okay damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "smg9mm-42"
	base_icon_state = "smg9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 30

/obj/item/ammo_box/magazine/smgm9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 42 : 0]"

/obj/item/ammo_box/magazine/smgm9mm/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/smgm9mm/ap
	name = "SMG magazine (9x18mm AP)"
	desc = "A 30-round magazine for 9x18mm submachine guns. These armor-piercing rounds are okay at piercing protective equipment, but lose some stopping power."
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/magazine/smgm10mm
	name = "Mongrel magazine (10x22mm)"
	desc = "A 24-round magazine for the SKM-44v. These rounds do moderate damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "mongrel_mag-24"
	base_icon_state = "mongrel_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 24

/obj/item/ammo_box/magazine/smgm10mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

/obj/item/ammo_box/magazine/smgm10mm/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/m57_39_sidewinder
	name = "Sidewinder magazine (5.7x39mm)"
	desc = "A 30-round magazine for the Sidewinder submachine gun. These rounds do okay damage with average performance against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "sidewinder_mag-1"
	base_icon_state = "sidewinder_mag"
	ammo_type = /obj/item/ammo_casing/c57x39mm
	caliber = CALIBER_57X39MM
	max_ammo = 30

/obj/item/ammo_box/magazine/m57_39_sidewinder/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m57_39_sidewinder/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/m45_cobra
	name = "Cobra magazine (.45)"
	desc = "A 24-round magazine for the Cobra submachine gun. These rounds do moderate damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cobra_mag-24"
	base_icon_state = "cobra_mag"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = CALIBER_45
	max_ammo = 24

/obj/item/ammo_box/magazine/m45_cobra/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/m45_cobra/empty
	start_empty = TRUE
