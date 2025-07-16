/obj/item/storage/backpack/duffelbag/super_medik
	name = "medical technician kit"
	desc = "A large duffel bag for holding extra medical supplies."
	icon_state = "duffel-medical"
	inhand_icon_state = "duffel-med"

/obj/item/storage/backpack/duffelbag/super_medik/PopulateContents()
	var/static/items_inside = list(
		/obj/item/gun/ballistic/automatic/smg/cobra/indie = 1,
		/obj/item/ammo_box/magazine/m45_cobra = 3,
		/obj/item/storage/medkit/tactical/premium = 2,
		/obj/item/gun/medbeam = 1,
	)
	generate_items_inside(items_inside,src)



/obj/item/storage/backpack/duffelbag/super_shit_s_drobowikom
	name = "armored shotgun kit"
	desc = "A large duffel bag for holding defence items."
	icon_state = "duffel-syndie"
	inhand_icon_state = "duffel-syndie"

/obj/item/storage/backpack/duffelbag/super_shit_s_drobowikom/PopulateContents()
	var/static/items_inside = list(
		/obj/item/gun/ballistic/shotgun/automatic/m11 = 1,
		/obj/item/ammo_box/advanced/s12gauge = 3,
		/obj/item/shield/ballistic = 2,
	)
	generate_items_inside(items_inside,src)



/obj/item/storage/backpack/duffelbag/super_bulldogzer
	name = "tactical annihilation bag"
	desc = "A large duffel bag for holding extra powerful shotgun."
	icon_state = "duffel-syndie"
	inhand_icon_state = "duffel-syndieammo"


/obj/item/storage/backpack/duffelbag/super_bulldogzer/PopulateContents()
	var/static/items_inside = list(
		/obj/item/gun/ballistic/shotgun/automatic/bulldog/drum = 1,
		/obj/item/ammo_box/magazine/m12g_bulldog/drum = 3,
	)
	generate_items_inside(items_inside,src)



/obj/item/storage/backpack/duffelbag/super_machinedozer
	name = "machinegun bag"
	desc = "A large duffel bag for holding machineguns."
	icon_state = "duffel-syndie"
	inhand_icon_state = "duffel-syndieammo"

/obj/item/storage/backpack/duffelbag/super_machinedozer/PopulateContents()
	var/static/items_inside = list(
		/obj/item/gun/ballistic/automatic/hmg/cm40 = 1,
		/obj/item/ammo_box/magazine/cm40_762_40_box = 4,
	)
	generate_items_inside(items_inside,src)



/obj/item/storage/backpack/duffelbag/super_cloaker
	name = "tactical pistol kit"
	desc = "A large duffel bag for holding such a small pistol."
	icon_state = "duffel-security"
	inhand_icon_state = "duffel-sec"

/obj/item/storage/backpack/duffelbag/super_cloaker/PopulateContents()
	var/static/items_inside = list(
		/obj/item/gun/ballistic/automatic/pistol/asp = 1,
		/obj/item/ammo_box/magazine/m57_39_asp = 5,
	)
	generate_items_inside(items_inside,src)
