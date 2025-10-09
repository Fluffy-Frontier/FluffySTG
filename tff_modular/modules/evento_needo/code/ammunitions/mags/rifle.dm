
/obj/item/ammo_box/magazine/p16 //repath to /obj/item/ammo_box/magazine/generic_556 sometime
	name = "assault rifle magazine (5.56x42mm CLIP)"
	desc = "A simple, 30-round magazine for 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "p16_mag"
	base_icon_state = "p16_mag"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = CALIBER_556X42MM
	max_ammo = 30

/obj/item/ammo_box/magazine/p16/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/p16/empty
	start_empty = TRUE



/obj/item/ammo_box/magazine/skm_762_40
	name = "assault rifle magazine (7.62x40mm CLIP)"
	desc = "A slightly curved, 20-round magazine for the 7.62x40mm CLIP variants of the SKM assault rifle family. These rounds do good damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "skm_mag"
	icon_state = "skm_mag"
	ammo_type = /obj/item/ammo_casing/a762_40
	caliber = CALIBER_762X40MM
	max_ammo = 20

/obj/item/ammo_box/magazine/skm_762_40/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/skm_762_40/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/skm_762_40/extended
	name = "extended assault rifle magazine (7.62x40mm CLIP)"
	desc = "A very curved, 40-round magazine for the 7.62x40mm CLIP variants of the SKM assault rifle family. These rounds do good damage with good armor penetration."
	base_icon_state = "skm_extended_mag"
	icon_state = "skm_extended_mag"
	max_ammo = 40

/obj/item/ammo_box/magazine/skm_762_40/extended/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/skm_762_40/drum
	name = "assault rifle drum (7.62x40mm CLIP)"
	desc = "A 75-round drum for the 7.62x40mm CLIP variants of the SKM assault rifle family. These rounds do good damage with good armor penetration."
	base_icon_state = "skm_drum"
	icon_state = "skm_drum"
	max_ammo = 75
	w_class = WEIGHT_CLASS_NORMAL



/obj/item/ammo_box/magazine/e40
	name = "E-40 magazine (.299 Eoehoma caseless)"
	icon_state = "e40_mag-1"
	base_icon_state = "e40_mag"
	ammo_type = /obj/item/ammo_casing/caseless/c299
	caliber = ".299 caseless"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY



/obj/item/ammo_box/magazine/illestren_a850r //this is a magazine codewise do nothing breaks
	name = "en bloc clip (8x50mmR)"
	desc = "A 5-round en bloc clip for the Illestren Hunting Rifle. These rounds do good damage with significant armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "enbloc_858"
	ammo_type = /obj/item/ammo_casing/a8_50r
	caliber = CALIBER_8X50MM
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron = 500)



/obj/item/ammo_box/magazine/swiss
	name = "\improper Swiss Cheese Magazine (5.56x42mm CLIP)"
	desc = "A deft, 30-round magazine for the Swiss Cheese assault rifle. These rounds do moderate damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "swissmag-1"
	base_icon_state = "swissmag"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = CALIBER_556X42MM
	max_ammo = 30

/obj/item/ammo_box/magazine/swiss/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"



/obj/item/ammo_box/magazine/m556_42_hydra
	name = "Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A simple, 30-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "hydra_mag-30"
	base_icon_state = "hydra_mag"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = CALIBER_556X42MM
	max_ammo = 30

/obj/item/ammo_box/magazine/m556_42_hydra/update_icon_state()
	. = ..()
	if(max_ammo > 30)
		icon_state = "[base_icon_state]-[!!ammo_count()]"
	else
		icon_state = "[base_icon_state]-[ammo_count() == 1 ? 1 : round(ammo_count(),5)]"

/obj/item/ammo_box/magazine/m556_42_hydra/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m556_42_hydra/small
	name = "Short Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A short, 20-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles; intended for the DMR variant. These rounds do moderate damage with good armor penetration."
	icon_state = "hydra_small_mag-20"
	base_icon_state = "hydra_small_mag"
	max_ammo = 20

/obj/item/ammo_box/magazine/m556_42_hydra/small/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m556_42_hydra/extended
	name = "extended Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A bulkier, 60-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon_state = "hydra_extended_mag"
	base_icon_state = "hydra_extended_mag"
	max_ammo = 60

/obj/item/ammo_box/magazine/m556_42_hydra/extended/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m556_42_hydra/casket
	name = "casket Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A very long and bulky 100-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon_state = "hydra_casket_mag"
	base_icon_state = "hydra_casket_mag"
	max_ammo = 100
	w_class = WEIGHT_CLASS_NORMAL



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
	icon_state = "woodsman_extended-1"
	base_icon_state = "woodsman_extended"
	max_ammo = 10

/obj/item/ammo_box/magazine/m23/extended/empty
	start_empty = TRUE



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


//INTERNAL

/obj/item/ammo_box/magazine/internal/shot/winchester
	name = "winchester internal magazine"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = CALIBER_38
	max_ammo = 12

/obj/item/ammo_box/magazine/internal/shot/winchester/absolution
	name = "absolution internal magazine"
	ammo_type = /obj/item/ammo_casing/c357
	caliber = CALIBER_357
	max_ammo = 8

/obj/item/ammo_box/magazine/internal/vickland
	name = "Vickland battle rifle internal magazine"
	ammo_type = /obj/item/ammo_casing/a8_50r
	caliber = CALIBER_8X50MM
	max_ammo = 8

/obj/item/ammo_box/magazine/internal/boltaction/smile
	name = "smile internal magazine"
	ammo_type = /obj/item/ammo_casing/a300
	caliber = CALIBER_A300
	max_ammo = 5

/obj/item/ammo_box/magazine/internal/boltaction/solgov
	name = "SSG-669C internal magazine"
	ammo_type = /obj/item/ammo_casing/caseless/a858
	caliber = CALIBER_A858
	max_ammo = 5
