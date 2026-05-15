// Cyto samples (Change if you want, pls, i'm bad at balance)
/datum/supply_pack/science/cytosamples
	name = "Cytology Samples"
	desc = "Contains 3 samples"
	cost = CARGO_CRATE_VALUE * 1.5
	access = ACCESS_SCIENCE
	access_view = ACCESS_SCIENCE
	contains = list(/obj/item/petri_dish/extremerandom = 3)
	crate_name = "cytology samples"
	crate_type = /obj/structure/closet/crate/secure/science

// Adds extreme random petri dishes. They can contain any, ANY sample
/obj/item/petri_dish/extremerandom
	var/static/list/possible_samples = list(
		list(CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5),
		list(CELL_LINE_TABLE_BLOB, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5),
		list(CELL_LINE_TABLE_MOIST, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5),
		list(CELL_LINE_TABLE_SLUDGE, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5),
		list(CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5),
		list(CELL_LINE_TABLE_ALGAE, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5),
		list(CELL_LINE_ORGAN_HEART, CELL_VIRUS_TABLE_GENERIC, 1, 5),
		list(CELL_LINE_ORGAN_HEART_CURSED, CELL_VIRUS_TABLE_GENERIC, 1, 5),
		list(CELL_LINE_ORGAN_LUNGS, CELL_VIRUS_TABLE_GENERIC, 1, 5),
		list(CELL_LINE_ORGAN_LIVER, CELL_VIRUS_TABLE_GENERIC, 1, 5),
		list(CELL_LINE_ORGAN_STOMACH, CELL_VIRUS_TABLE_GENERIC, 1, 5),
	)
	name = "extreme random sample petri dish"

/obj/item/petri_dish/extremerandom/Initialize(mapload)
	. = ..()
	var/list/chosen = pick(possible_samples)
	sample = new
	sample.GenerateSample(chosen[1],chosen[2],chosen[3],chosen[4])
	update_appearance()

// Experi-MENTOR samples
/datum/supply_pack/science/experimentrosamples
	name = "Relics"
	desc = "Contains some relics"
	cost = CARGO_CRATE_VALUE
	access = ACCESS_SCIENCE
	access_view = ACCESS_SCIENCE
	contains = list(
		/obj/item/relic = 5,
		/obj/item/relic/lavaland = 1,
	)
	crate_name = "experimentor relics"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/science/experimentrosamples/fill(obj/structure/closet/crate/relics)
	for(var/i in 1 to 3)
		var/item = pick_weight(contains)
		new item(relics)

