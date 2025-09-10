// 10x22mm (Stechkin)

/obj/item/ammo_box/magazine/c10mm_box
	name = "box of 10x22mm ammo"
	desc = "A box of standard 10x22mm ammo."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 45
	caliber = CALIBER_10MM

/obj/item/ammo_box/magazine/c10mm_box/ap
	name = "box of AP 10x22mm ammo"
	desc = "A box of 10x22mm armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "10mmbox-ap"
	ammo_type = /obj/item/ammo_casing/c10mm/ap

/obj/item/ammo_box/magazine/c10mm_box/hp
	name = "box of HP 10x22mm ammo"
	desc = "A box of 10x22mm hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "10mmbox-hp"
	ammo_type = /obj/item/ammo_casing/c10mm/hp

// 9x18mm (Commander + SABR)

/obj/item/ammo_box/magazine/c9mm_box
	name = "box of 9x18mm ammo"
	desc = "A box of standard 9x18mm ammo."
	icon_state = "9mmbox"
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 45
	caliber = CALIBER_9MM

/obj/item/ammo_box/magazine/c9mm_box/ap
	name = "box of AP 9x18mm ammo"
	desc = "A box of 9x18mm armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "9mmbox-ap"
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/magazine/c9mm_box/hp
	name = "box of HP 9x18mm ammo"
	desc = "A box of 9x18mm hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "9mmbox-hp"
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/magazine/c9mm_box/rubber
	name = "box of rubber 9x18mm ammo"
	desc = "A box of 9x18mm rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "9mmbox-rubbershot"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

// .45 (Candor + C20R)

/obj/item/ammo_box/magazine/c45_box
	name = "box of .45 ammo"
	desc = "A box of standard .45 ammo."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	icon_state = "45box"
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 72
	caliber = CALIBER_45

/obj/item/ammo_box/magazine/c45_box/ap
	name = "box of AP .45 ammo"
	desc = "A box of .45 armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "45box-ap"
	ammo_type = /obj/item/ammo_casing/c45/ap

/obj/item/ammo_box/magazine/c45_box/hp
	name = "box of HP .45 ammo"
	desc = "A box of .45 hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "45box-hp"
	ammo_type = /obj/item/ammo_casing/c45/hp

// .22 LR (Himehabu, Pounder)

/obj/item/ammo_box/magazine/c22lr_box
	name = "box of .22 LR ammo"
	desc = "A box of standard .22 LR ammo."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	icon_state = "22lrbox"
	ammo_type = /obj/item/ammo_casing/c22lr
	max_ammo = 30
	caliber = CALIBER_22LR

/obj/item/ammo_box/magazine/c22lr_box/ap
	name = "box of .22 LR AP ammo"
	desc = "A box of standard .22 LR AP ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "22lrbox-ap"
	ammo_type = /obj/item/ammo_casing/c22lr/ap

/obj/item/ammo_box/magazine/c22lr_box/hp
	name = "box of .22 LR HP ammo"
	desc = "A box of standard .22 LR HP ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "22lrbox-hp"
	ammo_type = /obj/item/ammo_casing/c22lr/hp

/obj/item/ammo_box/magazine/c22lr_box/rubber
	name = "box of .22 LR rubber ammo"
	desc = "A box of standard .22 LR rubber ammo."
	icon_state = "22lrbox-rubbershot"
	ammo_type = /obj/item/ammo_casing/c22lr/rubber

// .357

/obj/item/ammo_box/magazine/c357_box
	name = "box of .357 ammo"
	desc = "A box of standard .357 ammo."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	icon_state = "357box"
	ammo_type = /obj/item/ammo_casing/c357
	max_ammo = 18
	caliber = CALIBER_357

/obj/item/ammo_box/magazine/c357_box/match
	name = "box of match .357 ammo"
	desc = "A box of match .357 ammo."
	icon_state = "357box-match"
	ammo_type = /obj/item/ammo_casing/c357/match

// 44 Roumain

/obj/item/ammo_box/magazine/a44roum_box
	name = "box of .44 roumain ammo"
	desc = "A box of standard .44 roumain ammo."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	icon_state = "a44roum"
	ammo_type = /obj/item/ammo_casing/a44roum
	max_ammo = 18
	caliber = CALIBER_44ROUMAIN

/obj/item/ammo_box/magazine/a44roum_box/rubber
	name = "box of rubber .44 roumain ammo"
	desc = "A box of .44 roumain rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "a44roum-rubber"
	ammo_type = /obj/item/ammo_casing/a44roum/rubber

/obj/item/ammo_box/magazine/a44roum_box/hp
	name = "box of HP .44 roumain ammo"
	desc = "A box of .44 roumain hollowpoint ammo, designed to disable targets without causing serious damage."
	icon_state = "a44roum-hp"
	ammo_type = /obj/item/ammo_casing/a44roum/hp
