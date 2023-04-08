/obj/item/storage/box/gunset/blueshield_advanced
	name = "Blueshield's gunset"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gunset/blueshield_advanced/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/alt/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)
	new /obj/item/gun/energy/e_gun(src)
