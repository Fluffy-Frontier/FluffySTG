// Nova cargo item price adjustments
// Double prices for items costing less than 1000 credits

// From goodies.dm
/obj/item/storage/lockbox/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_TINY
	atom_storage.max_total_storage = WEIGHT_CLASS_BULKY*35
	atom_storage.max_slots = 35
	atom_storage.set_holdable(list(
		/obj/item/paper,
	))

/datum/supply_pack/goody/shuttle_construction_kit/New()
	. = ..()
	access_view = FALSE
	contains += /obj/item/stack/rods/shuttle/fifty

/datum/supply_pack/goody/xenoarch_intern
	cost = PAYCHECK_CREW * 30 // Doubled from PAYCHECK_CREW * 15

// Carpet packs
/datum/supply_pack/goody/carpet
	cost = PAYCHECK_CREW * 6 // Doubled from PAYCHECK_CREW * 3

/datum/supply_pack/goody/carpet/black
	cost = PAYCHECK_CREW * 6

/datum/supply_pack/goody/carpet/premium
	cost = PAYCHECK_CREW * 7 // Doubled from PAYCHECK_CREW * 3.5

/datum/supply_pack/goody/carpet/premium/royalblue
	cost = PAYCHECK_CREW * 7

/datum/supply_pack/goody/carpet/premium/red
	cost = PAYCHECK_CREW * 7

/datum/supply_pack/goody/carpet/premium/purple
	cost = PAYCHECK_CREW * 7

/datum/supply_pack/goody/carpet/premium/orange
	cost = PAYCHECK_CREW * 7

/datum/supply_pack/goody/carpet/premium/green
	cost = PAYCHECK_CREW * 7

/datum/supply_pack/goody/carpet/premium/cyan
	cost = PAYCHECK_CREW * 7

/datum/supply_pack/goody/carpet/premium/blue
	cost = PAYCHECK_CREW * 7

// Money sense NIFSoft
/datum/supply_pack/goody/money_sense_nifsoft
	cost = CARGO_CRATE_VALUE * 3 // Doubled from CARGO_CRATE_VALUE * 1.5

// Shapeshifter NIFSoft
/datum/supply_pack/goody/shapeshifter_nifsoft
	cost = CARGO_CRATE_VALUE * 3 // Doubled from CARGO_CRATE_VALUE * 1.5

// Hivemind NIFSoft
/datum/supply_pack/goody/hivemind_nifsoft
	cost = CARGO_CRATE_VALUE * 3 // Doubled from CARGO_CRATE_VALUE * 1.5

// Summoner NIFSoft
/datum/supply_pack/goody/summoner_nifsoft
	cost = CARGO_CRATE_VALUE * 1.5 // Doubled from CARGO_CRATE_VALUE * 0.75

// First aid pouches
/datum/supply_pack/goody/firstaid_pouch
	cost = PAYCHECK_CREW * 12 // Doubled from PAYCHECK_CREW * 6

/datum/supply_pack/goody/stabilizer_pouch
	cost = PAYCHECK_CREW * 12 // Doubled from PAYCHECK_CREW * 6

// Wetmaker
/datum/supply_pack/goody/wetmaker
	cost = PAYCHECK_CREW * 2 // Doubled from PAYCHECK_CREW

// Neuroware chips
/datum/supply_pack/goody/brass_neuroware
	cost = PAYCHECK_CREW * 4 // Doubled from PAYCHECK_CREW * 2

/datum/supply_pack/goody/guitar_neuroware
	cost = PAYCHECK_CREW * 4 // Doubled from PAYCHECK_CREW * 2

/datum/supply_pack/goody/percussion_neuroware
	cost = PAYCHECK_CREW * 4 // Doubled from PAYCHECK_CREW * 2

/datum/supply_pack/goody/piano_neuroware
	cost = PAYCHECK_CREW * 4 // Doubled from PAYCHECK_CREW * 2

// From packs.dm

// Critters
/datum/supply_pack/critter/mouse
	cost = CARGO_CRATE_VALUE * 12 // Doubled from CARGO_CRATE_VALUE * 6

/datum/supply_pack/critter/chinchilla
	cost = CARGO_CRATE_VALUE * 14 // Doubled from CARGO_CRATE_VALUE * 7

/datum/supply_pack/critter/fennec
	cost = CARGO_CRATE_VALUE * 14 // Doubled from CARGO_CRATE_VALUE * 7
