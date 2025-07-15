// 8x50mmR (Illestren Hunting Rifle)

/obj/item/ammo_box/magazine/a8_50r_box
	name = "box of 8x50mm ammo"
	desc = "A box of standard 8x50mm ammo."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	icon_state = "8x50mmbox"
	ammo_type = /obj/item/ammo_casing/a8_50r
	max_ammo = 30
	caliber = CALIBER_8X50MM

/obj/item/ammo_box/magazine/shotgun_box/hp
	name = "box of HP 8x50mm ammo"
	desc = "A box of hollow point 8x50mm ammo, designed to cause massive damage at the cost of armor penetration."
	icon_state = "8x50mmbox-hp"
	ammo_type = /obj/item/ammo_casing/a8_50r/hp
	caliber = CALIBER_SHOTGUN

/obj/item/ammo_box/magazine/shotgun_box/match
	name = "box of 8x50mm match ammo"
	desc = "A box of standard 8x50mm ammo."
	icon_state = "8x50mmbox-match"
	ammo_type = /obj/item/ammo_casing/a8_50r/match
	max_ammo = 10

/obj/item/ammo_box/magazine/shotgun_box/trac
	name = "box of 8x50mm trac ammo"
	desc = "A box of 8x50mm trackers."
	icon_state = "8x50mmbox-trac"
	ammo_type = /obj/item/ammo_casing/a8_50r/trac
	max_ammo = 10

// 5.56x42mm CLIP (CM82, Hydra variants)

/obj/item/ammo_box/magazine/a556_42_box
	name = "box of 5.56x42mm CLIP ammo"
	desc = "A box of standard 5.56x42mm CLIP ammo."
	icon_state = "a556_42box_big"
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	ammo_type = /obj/item/ammo_casing/a556_42
	max_ammo = 45
	caliber = CALIBER_556X42MM

/obj/item/ammo_box/magazine/a556_42_box/hp
	name = "box of 5.56x42mm CLIP HP ammo"
	desc = "A box of standard 5.56x42mm CLIP HP ammo."
	icon_state = "a556_42box_big-hp"
	ammo_type = /obj/item/ammo_casing/a556_42/hp

/obj/item/ammo_box/magazine/a556_42_box/ap
	name = "box of 5.56x42mm CLIP AP ammo"
	desc = "A box of standard 5.56x42mm CLIP AP ammo."
	icon_state = "a556_42box_big-ap"
	ammo_type = /obj/item/ammo_casing/a556_42/ap

// 7.62x40mm CLIP (SKM Rifles)

/obj/item/ammo_box/magazine/a762_40_box
	name = "box of 7.62x40mm CLIP ammo"
	desc = "A box of standard 7.62x40mm CLIP ammo."
	icon_state = "a762_40box_big"
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	ammo_type = /obj/item/ammo_casing/a762_40
	max_ammo = 45
	caliber = CALIBER_762X40MM

/obj/item/ammo_box/magazine/a762_40_box/hp
	name = "box of 7.62x40mm CLIP Hollow Point ammo"
	desc = "A box of standard 7.62x40mm CLIP Hollow Point ammo."
	icon_state = "a762_40box_big-hp"
	ammo_type = /obj/item/ammo_casing/a762_40/hp

/obj/item/ammo_box/magazine/a762_40_box/ap
	name = "box of 7.62x40mm CLIP Armour Piercing ammo"
	desc = "A box of standard 7.62x40mm CLIP Armour Piercing ammo."
	icon_state = "a762_40box_big-ap"
	ammo_type = /obj/item/ammo_casing/a762_40/ap

/obj/item/ammo_box/magazine/a762_40_box/rubber
	name = "box of 7.62x40mm CLIP rubber ammo"
	desc = "A box of standard 7.62x40mm CLIP rubber ammo."
	icon_state = "a762_40box_big-rubbershot"
	ammo_type = /obj/item/ammo_casing/a762_40/rubber

//.308 (M514 EBR & CM-GAL-S)

/obj/item/ammo_box/magazine/a308_box
	name = "box of .308 ammo"
	desc = "A box of standard .308 ammo."
	icon_state = "a308box"
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	ammo_type = /obj/item/ammo_casing/a308
	max_ammo = 30
	caliber = CALIBER_308

/obj/item/ammo_box/magazine/a308_box/hp
	name = "box of .308 HP ammo"
	desc = "A box of standard .308 HP ammo."
	icon_state = "a308box"
	ammo_type = /obj/item/ammo_casing/a308/hp

/obj/item/ammo_box/magazine/a308_box/ap
	name = "box of .308 AP ammo"
	desc = "A box of standard .308 AP ammo."
	icon_state = "a308box"
	ammo_type = /obj/item/ammo_casing/a308/ap

// P16

/obj/item/ammo_box/magazine/p16_box
	name = "box of P16 ammo"
	desc = "A box of standard P16 ammo."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo_boxes.dmi'
	icon_state = "generic-ammo"
	ammo_type = /obj/item/ammo_casing/a308/ap
	caliber = CALIBER_308
