/obj/item/storage/medkit/tactical/blueshield
	name = "blueshield combat medical kit"
	desc = "Blue boy to the rescue!"
	color = "#AAAAFF"

/obj/item/storage/medkit/tactical/blueshield/PopulateContents()
	if(empty)
		return
	// FLUFFY FRONTIER EDIT START - blueshield medicine buff
	/*
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/sensor_device/blueshield(src)
	*/
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/suture/medicated = 1,
		/obj/item/stack/medical/mesh/advanced = 1,
		/obj/item/reagent_containers/medigel/libital = 1,
		/obj/item/reagent_containers/hypospray/medipen/salacid = 1,
		/obj/item/reagent_containers/medigel/aiuri = 1,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone = 1,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 2,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 2,
		/obj/item/reagent_containers/hypospray/medipen = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 2,
		/obj/item/sensor_device/blueshield = 1,
		/obj/item/healthanalyzer/advanced = 1,
	)
	generate_items_inside(items_inside,src)
	// FLUFFY FRONTIER EDIT END
