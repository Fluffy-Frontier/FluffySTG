/obj/item/ammo_box/magazine/cm23
	name = "CM-23 pistol magazine (10x22mm)"
	desc = "An 10-round magazine magazine designed for the CM-23 pistol. These rounds do moderate damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm23_mag-1"
	base_icon_state = "cm23_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 10

/obj/item/ammo_box/magazine/cm23/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm23/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/m9mm_cm70
	name = "CM-70 machine pistol magazine (9x18mm)"
	desc = "A 18-round magazine designed for the CM-70 machine pistol. These rounds do okay damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm70_mag_18"
	base_icon_state = "cm70_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 18

/obj/item/ammo_box/magazine/m9mm_cm70/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

/obj/item/ammo_box/magazine/m9mm_cm70/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/cm357
	name = "CM-357 pistol magazine (.357)"
	desc = "A 7-round magazine designed for the CM-357 pistol. These rounds do good damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm23_mag"
	base_icon_state = "cm23_mag"
	ammo_type = /obj/item/ammo_casing/c357
	caliber = CALIBER_357
	max_ammo = 7

/obj/item/ammo_box/magazine/cm357/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"



/obj/item/ammo_box/magazine/m9mm_mauler
	name = "mauler machine pistol magazine (9x18mm)"
	desc = "A 12-round magazine designed for the Mauler machine pistol."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "mauler_mag-1"
	base_icon_state = "mauler_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 12

/obj/item/ammo_box/magazine/m9mm_mauler/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"



/obj/item/ammo_box/magazine/spitter_9mm
	name = "spitter pistol magazine (9x18mm)"
	desc = "A thin 30-round magazine for the Spitter submachine gun."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "spitter_mag-1"
	base_icon_state = "spitter_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 30

/obj/item/ammo_box/magazine/spitter_9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"



/obj/item/ammo_box/magazine/co9mm
	name = "commander pistol magazine (9x18mm)"
	desc = "A 12-round double-stack magazine for Commander pistols. These rounds do okay damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "commander_mag-12"
	base_icon_state = "commander_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 12
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/co9mm/hp
	name = "pistol magazine (9x18mm HP)"
	desc= "A 12-round double-stack magazine for standard-issue 9x18mm pistols. These hollow point rounds do significant damage against soft targets, but are nearly ineffective against armored ones."
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/magazine/co9mm/ap
	name = "pistol magazine (9x18mm AP)"
	desc= "A 12-round double-stack magazine for standard-issue 9x18mm pistols. These armor-piercing rounds are okay at piercing protective equipment, but lose some stopping power."
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/magazine/co9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() == 1 ? 1 : round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/co9mm/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/m22lr_himehabu
	name = "pistol magazine (.22 LR)"
	desc = "A single-stack handgun magazine designed to chamber .22 LR. It's rather tiny, all things considered."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "himehabu_mag"
	base_icon_state = "himehabu_mag"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = CALIBER_22LR
	max_ammo = 10
	w_class = WEIGHT_CLASS_SMALL
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/m22lr_himehabu/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/m9mm_rattlesnake
	name = "Rattlesnake magazine (9x18mm)"
	desc = "A long, 18-round double-stack magazine designed for the Rattlesnake machine pistol. These rounds do okay damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "rattlesnake_mag_18"
	base_icon_state = "rattlesnake_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 18

/obj/item/ammo_box/magazine/m9mm_rattlesnake/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

/obj/item/ammo_box/magazine/m9mm_rattlesnake/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/m57_39_asp
	name = "Asp magazine (5.7x39mm)"
	desc = "A 12-round, double-stack magazine for the Asp pistol. These rounds do okay damage with average performance against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "asp_mag-12"
	base_icon_state = "asp_mag"
	ammo_type = /obj/item/ammo_casing/c57x39mm
	caliber = CALIBER_57X39MM
	max_ammo = 12

/obj/item/ammo_box/magazine/m57_39_asp/update_icon_state()
	. = ..()
	if(ammo_count() == 12)
		icon_state = "[base_icon_state]-12"
	else if(ammo_count() >= 10)
		icon_state = "[base_icon_state]-10"
	else if(ammo_count() >= 5)
		icon_state = "[base_icon_state]-5"
	else if(ammo_count() >= 1)
		icon_state = "[base_icon_state]-1"
	else
		icon_state = "[base_icon_state]-0"

/obj/item/ammo_box/magazine/m57_39_asp/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/m10mm_ringneck
	name = "Ringneck pistol magazine (10x22mm)"
	desc = "An 8-round magazine for the Ringneck pistol. These rounds do moderate damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "ringneck_mag-1"
	base_icon_state = "ringneck_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 8

/obj/item/ammo_box/magazine/m10mm_ringneck/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"


/obj/item/ammo_box/magazine/m10mm_ringneck/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/m20_auto_elite
	name = "Model 20 magazine (.44 Roumain)"
	desc = "A nine-round magazine designed for the Model 20 pistol. These rounds do good damage, and fare better against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm23_mag-1"
	base_icon_state = "cm23_mag"
	ammo_type = /obj/item/ammo_casing/a44roum
	caliber = CALIBER_44ROUMAIN
	max_ammo = 9

/obj/item/ammo_box/magazine/m20_auto_elite/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m20_auto_elite/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/pistol/m20_auto_elite/inteq
	name = "PO-20 Pinscher"
	desc = "A large handgun chambered .44 Roumain and manufactured by Serene Outdoors. Modified to Inteq Risk Management Group's standards and issued as a heavy sidearm for officers."

	icon = 'tff_modular/modules/evento_needo/icons/inteq/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "m20_inteq"
	inhand_icon_state = "inteq_generic"
	accepted_magazine_type = /obj/item/ammo_box/magazine/m20_auto_elite

/obj/item/ammo_box/magazine/m20_auto_elite/inteq/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/m17
	name = "Model 17 magazine (.22lr)"
	desc = "A 10-round magazine for the Model 17 \"Micro Target\". These rounds do okay damage with awful performance against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "m17_mag"
	base_icon_state = "m17_mag"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = CALIBER_22LR
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m17/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/pistol556mm
	name = "Pistole C magazine (5.56mm HITP caseless)"
	desc = "A 12-round, double-stack magazine for the Pistole C pistol. These rounds do okay damage with average performance against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "pistolec_mag-12" //ok i did it
	base_icon_state = "pistolec_mag"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm
	caliber = CALIBER_556
	max_ammo = 12

/obj/item/ammo_box/magazine/pistol556mm/update_icon_state()
	. = ..()
	if(ammo_count() == 12)
		icon_state = "[base_icon_state]-12"
	else if(ammo_count() >= 10)
		icon_state = "[base_icon_state]-10"
	else if(ammo_count() >= 5)
		icon_state = "[base_icon_state]-5"
	else if(ammo_count() >= 1)
		icon_state = "[base_icon_state]-1"
	else
		icon_state = "[base_icon_state]-0"
