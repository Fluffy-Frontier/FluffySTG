#define FOOD_NG_ICON 'tff_modular/modules/foods/icons/food_NG.dmi'

/obj/item/seeds/orange
	mutatelist += /obj/item/seeds/mandarin

/obj/item/seeds/mandarin
	name = "mandarin seed pack"
	desc = "These seeds grow into sweet mandarins packed with fragrant oils."
	icon_state = "seed-orange"
	species = "mandarin"
	plantname = "Mandarin Tree"
	product = /obj/item/food/grown/citrus/mandarin
	lifespan = 60
	endurance = 55
	yield = 5
	potency = 25
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	icon_grow = "lime-grow"
	icon_dead = "lime-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(
		/datum/reagent/consumable/nutriment/vitamin = 0.05,
		/datum/reagent/consumable/nutriment = 0.05,
	)

/obj/item/food/grown/citrus/mandarin
	seed = /obj/item/seeds/mandarin
	name = "mandarin"
	desc = "A small, vividly orange citrus that smells like winter holidays."
	icon = FOOD_NG_ICON
	icon_state = "mandarin"
	foodtypes = FRUIT | ORANGES
	juice_typepath = /datum/reagent/consumable/mandarinjuice
	wine_power = 55
	tastes = list(
		"sweet mandarin juice" = 2,
		"clove oil" = 1,
	)

/datum/reagent/consumable/mandarinjuice
	name = "Mandarin Juice"
	description = "Bright, sweet mandarin juice with lingering winter spices."
	color = "#ff9b3a"
	taste_description = "sweet mandarin oil and cloves"
	quality = DRINK_GOOD
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

#undef FOOD_NG_ICON

