#define MINIMUM_CLOTHING_STOCK 5

/obj/machinery/vending
	/// Additions to the `products` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/products_ff
	/// Additions to the `product_categories` list of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/product_categories_ff
	/// Additions to the `premium` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/premium_ff
	/// Additions to the `contraband` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/contraband_ff

/obj/machinery/vending/Initialize(mapload)
	if(products_nova)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in products_nova)
			products[item_to_add] = products_nova[item_to_add]

	if(product_categories_nova)
		for(var/category in product_categories_nova)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] += category["products"]
					already_exists = TRUE
					break

			if(!already_exists)
				product_categories += category

	if(premium_nova)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in premium_nova)
			premium[item_to_add] = premium_nova[item_to_add]

	if(contraband_nova)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in contraband_nova)
			contraband[item_to_add] = contraband_nova[item_to_add]

	if(products_ff)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in products_ff)
			products[item_to_add] = products_ff[item_to_add]

	if(product_categories_ff)
		for(var/category in product_categories_ff)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] += category["products"]
					already_exists = TRUE
					break

			if(!already_exists)
				product_categories += category

	if(premium_ff)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in premium_ff)
			premium[item_to_add] = premium_ff[item_to_add]

	if(contraband_ff)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in contraband_ff)
			contraband[item_to_add] = contraband_ff[item_to_add]

	// Time to make clothes amounts consistent!
	for (var/obj/item/clothing/item in products)
		if(products[item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
			products[item] = MINIMUM_CLOTHING_STOCK

	for (var/category in product_categories)
		for(var/obj/item/clothing/item in category["products"])
			if(category["products"][item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
				category["products"][item] = MINIMUM_CLOTHING_STOCK

	for (var/obj/item/clothing/item in premium)
		if(premium[item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
			premium[item] = MINIMUM_CLOTHING_STOCK

	QDEL_NULL(products_nova)
	QDEL_NULL(product_categories_nova)
	QDEL_NULL(premium_nova)
	QDEL_NULL(contraband_nova)
	QDEL_NULL(products_ff)
	QDEL_NULL(product_categories_ff)
	QDEL_NULL(premium_ff)
	QDEL_NULL(contraband_ff)
	return ..()

#undef MINIMUM_CLOTHING_STOCK
