/obj/item/storage/pouch/cin_medkit
	var/static/list/pouch_holdables = list(
		/obj/item/pinpointer,
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/hypospray,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/box/bandages,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/reagent_containers/blood,
		/obj/item/stack/sticky_tape,
	)
	var/static/list/pouch_unholdables = list(
		/obj/item/reagent_containers/cup,
		/obj/item/storage/wallet,
	)

/obj/item/storage/pouch/cin_medkit/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 8
	atom_storage.max_slots = 4
	atom_storage.set_holdable(pouch_holdables, pouch_unholdables)

/obj/item/storage/pouch/cin_general
	var/static/list/pouch_holdables = list(

	)
	var/static/list/pouch_unholdables = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/clothing/gloves,
		/obj/item/flashlight/seclite,
		/obj/item/grenade,
		/obj/item/gun,
		/obj/item/holosign_creator/security,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
		/obj/item/radio,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/pinpointer,
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/hypospray,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/box/bandages,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/hemostat,
		/obj/item/reagent_containers/blood,
		/obj/item/stack/sticky_tape,
		/obj/item/reagent_containers/cup,
		/obj/item/storage/wallet,
	)

/obj/item/storage/pouch/cin_general/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = WEIGHT_CLASS_SMALL*3
	atom_storage.max_slots = 3
	atom_storage.cant_hold = typecacheof(pouch_unholdables)

/obj/item/storage/pouch/medical/firstaid
	var/static/list/pouch_holdables = list(
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/hypospray,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/box/bandages,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/reagent_containers/blood,
		/obj/item/stack/sticky_tape,
	)
	var/static/list/pouch_unholdables = list(
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/reagent_containers/cup,
		/obj/item/storage/wallet,
	)

/obj/item/storage/pouch/medical/firstaid/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 5
	atom_storage.max_total_storage = 10
	atom_storage.set_holdable(pouch_holdables, pouch_unholdables)

/obj/item/storage/medkit/combat_surgeon
	var/static/list/pouch_holdables = list(
		/obj/item/pinpointer,
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/hypospray,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/box/bandages,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/hemostat,
		/obj/item/scalpel,
		/obj/item/surgicaldrill,
		/obj/item/retractor,
		/obj/item/circular_saw,
		/obj/item/surgical_drapes,
		/obj/item/reagent_containers/blood,
		/obj/item/stack/sticky_tape,
	)
	var/static/list/pouch_unholdables = list(
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/storage/wallet,
	)

/obj/item/storage/medkit/combat_surgeon/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.set_holdable(pouch_holdables, pouch_unholdables)

/obj/item/clothing/accessory/colonial_webbing
	w_class = WEIGHT_CLASS_NORMAL
