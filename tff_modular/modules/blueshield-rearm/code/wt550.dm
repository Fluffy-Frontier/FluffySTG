/obj/item/storage/toolbox/guncase/nova/wt550
	name = "wt-550 gun case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/wt550
	extra_to_spawn = /obj/item/ammo_box/magazine/wt550m9

/obj/item/storage/toolbox/guncase/nova/wt550/PopulateContents()
	new weapon_to_spawn()

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/wt550m9 = 2,
	), src)
