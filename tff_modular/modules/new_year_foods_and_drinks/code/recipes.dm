/datum/crafting_recipe/food/olivier_salad
	name = "Olivier salad"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/pickle = 1,
		/obj/item/food/boiledegg = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/grown/carrot = 1,
		/obj/item/food/sausage = 1,
		/datum/reagent/consumable/mayonnaise = 5,
	)
	result = /obj/item/food/salad/olivier
	category = CAT_SALAD

/datum/crafting_recipe/food/vinegret_salad
	name = "Vinegret salad"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/grown/redbeet = 1,
		/obj/item/food/grown/carrot = 1,
		/obj/item/food/onion_slice/red = 2,
		/obj/item/food/grown/peas = 1,
		/datum/reagent/consumable/nutriment/fat/oil/olive = 5,
		/datum/reagent/consumable/vinegar = 1,
	)
	result = /obj/item/food/salad/vinegret
	category = CAT_SALAD

/datum/crafting_recipe/food/kraboviy_salad
	name = "Kraboviy salad"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/fishmeat = 2,
		/obj/item/food/grown/corn = 1,
		/obj/item/food/boiledegg = 1,
		/datum/reagent/consumable/mayonnaise = 5,
	)
	result = /obj/item/food/salad/kraboviy
	category = CAT_SALAD

/datum/crafting_recipe/food/kraboviy_salad/crab
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/meat/slab/rawcrab = 1,
		/obj/item/food/grown/corn = 1,
		/obj/item/food/boiledegg = 1,
		/datum/reagent/consumable/mayonnaise = 5,
	)

/datum/crafting_recipe/food/shuba
	name = "Shuba"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/fishmeat = 2,
		/obj/item/food/boiledegg = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/grown/carrot = 1,
		/obj/item/food/grown/redbeet = 1,
		/obj/item/food/grown/onion = 1,
		/datum/reagent/consumable/mayonnaise = 10,
	)
	result = /obj/item/food/cake/shuba
	category = CAT_SALAD

/datum/crafting_recipe/food/kholodetz
	name = "Kholodetz"
	reqs = list(
		/obj/item/food/headcheese = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/carrot = 1,
		/obj/item/food/grown/herbs = 1,
	)
	result = /obj/item/food/cake/kholodetz
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/christmas_ham
	name = "Raw Christmas ham"
	reqs = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/food/breadslice/plain = 2,
		/obj/item/food/grown/berries = 1,
		/datum/reagent/consumable/bbqsauce = 5,
		/datum/reagent/consumable/blackpepper = 1,
	)
	result = /obj/item/food/christmas_ham/raw
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/caviar_butterbrod
	name = "Caviar butterbrod"
	reqs = list(
		/obj/item/food/breadslice/plain = 1,
		/obj/item/food/butter = 1,
		/obj/item/food/red_caviar = 1,
	)
	result = /obj/item/food/sandwich/caviar_butterbrod
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/caviar_butterbrod/moonfish
	reqs = list(
		/obj/item/food/breadslice/plain = 1,
		/obj/item/food/butter = 1,
		/obj/item/food/moonfish_caviar = 1,
	)

/datum/crafting_recipe/food/candy_cane
	name = "Candy cane"
	reqs = list(
		/datum/reagent/consumable/sugar = 10,
		/datum/reagent/consumable/menthol = 5,
		/datum/reagent/consumable/nutriment/fat/oil/corn = 5,
	)
	result = /obj/item/food/sweets/candy_cane
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/candy_cane/mint
	reqs = list(
		/datum/reagent/consumable/sugar = 8,
		/obj/item/food/mint = 1,
		/datum/reagent/consumable/nutriment/fat/oil/corn = 5,
	)

