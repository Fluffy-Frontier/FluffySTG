/datum/supply_pack/organic/canned_caviar
	name = "Red Caviar"
	desc = "A Skrell export tin containing six servings of synthetic red caviar."
	cost = 1200
	contains = list(/obj/item/food/canned_red_caviar = 6)
	crate_type = /obj/structure/closet/crate/freezer/food
	crate_name = "caviar crate"

/datum/orderable_item/milk_eggs/canned_caviar
	name = "canned caviar"
	purchase_path = /obj/item/food/canned_red_caviar
	cost_per_order = 200

/datum/supply_pack/organic/mandarin
	name = "Mandarines"
	desc = "A crate  of mandarines"
	cost = 300
	contains = list(/obj/item/food/grown/citrus/mandarin = 6)
	crate_type = /obj/structure/closet/crate/hydroponics
	crate_name = "mandarines crate"

/datum/orderable_item/veggies/mandarin
	name = "mandarin"
	purchase_path = /obj/item/food/grown/citrus/mandarin
	cost_per_order = 10
