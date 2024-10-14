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
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/reagent_containers/hypospray/medipen/salacid(src)
	new /obj/item/reagent_containers/hypospray/medipen/oxandrolone(src)
	new /obj/item/reagent_containers/hypospray/medipen/salbutamol(src)
	new /obj/item/reagent_containers/hypospray/medipen/salbutamol(src)
	new /obj/item/reagent_containers/hypospray/medipen/penacid(src)
	new /obj/item/reagent_containers/hypospray/medipen/penacid(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)
	new /obj/item/reagent_containers/hypospray/medipen/deforest/coagulants(src)
	new /obj/item/reagent_containers/hypospray/medipen/deforest/coagulants(src)
	new /obj/item/sensor_device/blueshield(src)
	new /obj/item/healthanalyzer/advanced(src)
// FLUFFY FRONTIER EDIT END
