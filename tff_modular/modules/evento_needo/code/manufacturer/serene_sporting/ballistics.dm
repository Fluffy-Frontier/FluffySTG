/* Micro Target */

/obj/item/gun/ballistic/automatic/pistol/m17
	name = "Model 17 \"Micro Target\""
	desc = "A lightweight and very accurate target pistol produced by Serene Outdoors. The barrel can be unscrewed for storage. Chambered in .22 LR."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "m17"
	inhand_icon_state = "so_generic"
	worn_icon_state = null
	show_bolt_icon = FALSE
	mag_display = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m17

	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/himehabu.ogg'

	bolt_type = BOLT_TYPE_LOCKING

	w_class = WEIGHT_CLASS_SMALL

	spread = 15
	recoil = -2

/obj/item/ammo_box/magazine/m17
	name = "Model 17 magazine (.22lr)"
	desc = "A 10-round magazine for the Model 17 \"Micro Target\". These rounds do okay damage with awful performance against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "m17_mag-full"
	base_icon_state = "m17_mag"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = CALIBER_22LR
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m17/empty
	start_empty = TRUE

/* Auto Elite */

/obj/item/gun/ballistic/automatic/pistol/m20_auto_elite
	name = "Model 20 \"Auto Elite\""
	desc = "A large handgun chambered .44 Roumain. Originally developed by Serene Outdoors for the Star City Police Department when their older handguns proved underpowered, the Auto Elite proved heavy and unwieldy in practice. It has nevertheless seen modest success as a sidearm for big game hunters and among customers looking to make an impression."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "m20"
	inhand_icon_state = "so_generic"
	mag_display = FALSE
	worn_icon_state = null
	accepted_magazine_type = /obj/item/ammo_box/magazine/m20_auto_elite

	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/cm23.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_cocked.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/slide_lock.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/slide_drop.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/deagle_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/deagle_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/deagle_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/deagle_unload.ogg'

	recoil = 1

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

/* Sporter */

/obj/item/gun/ballistic/automatic/m12_sporter
	name = "Model 12 \"Sporter\""
	desc = "An extremely popular target shooting rifle produced by Serene Outdoors. Inexpensive, widely available, and produced in massive numbers, the Sporter is also popular for hunting small game and ground birds. Chambered in .22 LR."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "m12"
	inhand_icon_state = "m12"
	worn_icon_state = "m12"
	show_bolt_icon = FALSE

	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/m12_sporter

	fire_delay =  0.4 SECONDS
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	bolt_type = BOLT_TYPE_LOCKING
	burst_fire_selection = FALSE
	fire_sound = 'tff_modular/modules/evento_needo/sounds/gauss/claris.ogg'

	spread = 0
	recoil = 0

/obj/item/ammo_box/magazine/m12_sporter
	name = "Model 12 magazine (.22lr)"
	desc = "A 25-round magazine for the Model 12 \"Sporter\". These rounds do okay damage with awful performance against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "m12_mag-1"
	base_icon_state = "m12_mag"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = CALIBER_22LR
	max_ammo = 25

/obj/item/ammo_box/magazine/m12_sporter/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m12_sporter/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/m12_sporter/mod
	name = "Model 13 \"Larker\""
	desc = "A common after-market modification of the Model 12 \"Sporter\" rifle, keyed to fire a three round burst."
	burst_size = 3
	burst_delay = 0.6
	burst_fire_selection = TRUE

	icon_state = "larker"
	inhand_icon_state = "larker"
	worn_icon_state = "larker"

/* woodsman */

/obj/item/gun/ballistic/automatic/marksman/woodsman
	name = "Model 23 Woodsman"
	desc = "A large semi-automatic hunting rifle manufactured by Serene Outdoors. Its powerful cartridge, excellent ergonomics and ease of use make it highly popular for hunting big game Chambered in 8x50mmR."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "woodsman"
	inhand_icon_state = "woodsman"
	worn_icon_state = "woodsman"
	show_bolt_icon = FALSE
	mag_display = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m23

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ssg669c.ogg'

	bolt_type = BOLT_TYPE_LOCKING
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK

	spread = -4
	recoil = 1.25
	fire_delay = 0.5 SECONDS
	burst_size = 1

/obj/item/gun/ballistic/automatic/marksman/woodsman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/ammo_box/magazine/m23
	name = "Model 23 magazine (8x50mmR)"
	desc = "A 5-round magazine for the Model 23 \"Woodsman\". These rounds do high damage, with excellent armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "woodsman_mag-1"
	base_icon_state = "woodsman_mag"
	ammo_type = /obj/item/ammo_casing/a8_50r
	caliber = CALIBER_8X50MM
	max_ammo = 5

/obj/item/ammo_box/magazine/m23/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m23/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m23/extended
	name = "Model 23 Extended Magazine (8x50mmR)"
	desc = "A 10-round magazine for the Model 23 \"Woodsman\". These rounds do high damage, with excellent armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "woodsman_extended-1"
	base_icon_state = "woodsman_extended"
	max_ammo = 10

/obj/item/ammo_box/magazine/m23/extended/empty
	start_empty = TRUE

/* super soaker */

/obj/item/gun/ballistic/automatic/m15
	name = "Model 15 Super Sporter"
	desc = "A popular semi-automatic hunting rifle produced by Serene Outdoors. Solid all-round performance, high accuracy, and ease of access compared to military rifles makes the Super Sporter a popular choice for hunting medium game and occasionally self-defense. Chambered in 5.56mm."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "m15"
	inhand_icon_state = "m15"
	worn_icon_state = "m15"
	show_bolt_icon = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m15

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/m16.ogg'

	bolt_type = BOLT_TYPE_LOCKING
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK

	spread = 0
	recoil = 0.5

/obj/item/ammo_box/magazine/m15
	name = "Model 15 magazine (5.56x42mm CLIP)"
	desc = "A 20-round magazine for the Model 15 \"Super Sporter\". These rounds do average damage and perform moderately against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm15_mag"
	base_icon_state = "cm15_mag"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = CALIBER_556X42MM
	max_ammo = 20

/obj/item/ammo_box/magazine/m15/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m15/empty
	start_empty = TRUE

/* cuckmaster */

/obj/item/gun/ballistic/shotgun/automatic/m11
	name = "Model 11 \"Buckmaster\""
	desc = "A semi-automatic hunting shotgun produced by Serene Outdoors. Much lighter and handier than military combat shotguns, it offers the same fire rate and magazine capacity, making it an excellent choice for hunting birds and large game or for security forces looking to upgrade from pump action guns. Chambered in 12g."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "buckmaster"
	inhand_icon_state = "buckmaster"
	worn_icon_state = "buckmaster"
	show_bolt_icon = FALSE
	inhand_x_dimension = 32
	inhand_y_dimension = 32

	fire_delay = 0.5 SECONDS
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/buckmaster
	w_class = WEIGHT_CLASS_BULKY
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/bulldog.ogg'
	spread = 3
	recoil = 1

	casing_ejector = TRUE

/obj/item/ammo_box/magazine/internal/shot/buckmaster
	name = "Buckmaster internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 6
