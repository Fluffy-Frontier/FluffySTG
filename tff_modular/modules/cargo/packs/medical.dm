/datum/supply_pack/medical/advanced_packs
	name = "Advanced Mesh and Sutures Crate"
	desc = "Contains some advanced regenerative mesh and medicated sutures."
	cost = CARGO_CRATE_VALUE * 4
	access = ACCESS_MEDICAL
	contains = list(
		/obj/item/stack/medical/suture/medicated = 3,
		/obj/item/stack/medical/mesh/advanced = 3,
	)
	crate_name = "medical crate"
	crate_type = /obj/structure/closet/crate/deforest
