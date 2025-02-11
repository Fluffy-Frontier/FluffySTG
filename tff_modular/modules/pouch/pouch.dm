/obj/item/storage/pouch/cin_medkit
	var/static/list/pouch_holdables = list(
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/pill,
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
	)

/obj/item/storage/pouch/cin_medkit/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 8
	atom_storage.max_slots = 4
	atom_storage.set_holdable(pouch_holdables)
