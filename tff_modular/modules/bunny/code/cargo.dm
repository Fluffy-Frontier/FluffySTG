/obj/item/storage/backpack/duffelbag/mining_bunny
	name = "Bunny Kit"
	desc = "A mining outfit kit themed around bunnies, they do live in burrows after all..."
	icon_state = "duffel-explorer"
	inhand_icon_state = "duffel-explorer"

/obj/item/storage/backpack/duffelbag/mining_bunny/PopulateContents()
	new /obj/item/clothing/head/playbunny/miner(src)
	new /obj/item/clothing/neck/playbunny/tie/miner(src)
	new /obj/item/clothing/suit/jacket/playbunny/miner(src)
	new /obj/item/clothing/under/costume/playbunny/miner(src)
	new /obj/item/clothing/shoes/workboots/mining/heeled(src)

/datum/orderable_item/mining/bunny
	item_path = /obj/item/storage/backpack/duffelbag/mining_bunny
	desc = "A mining outfit kit themed around bunnies, they do live in burrows after all..."
	cost_per_order = 500

/datum/supply_pack/vending/wardrobes/bunny
	name = "Bunny Wardrobe Supply Crate"
	desc = "BNNUY"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/vending_refill/wardrobe/bunny,
	)
	crate_name = "Bunny Resupply Crate"
