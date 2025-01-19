/obj/item/gun/ballistic/automatic/wt550/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/toolbox/guncase/nova/wt550
	name = "wt-550 gun case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/wt550/nomag
	extra_to_spawn = /obj/item/ammo_box/magazine/wt550m9

/obj/item/storage/toolbox/guncase/nova/wt550/PopulateContents()
	new weapon_to_spawn(src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/wt550m9/rubber = 1,
		/obj/item/ammo_box/magazine/wt550m9 = 2,
	), src)

/obj/item/ammo_box/magazine/wt550m9/rubber
	name = "\improper WT-550 Rubber magazine"
	ammo_type = /obj/item/ammo_casing/c46x30mm/rubber
