#define food_ng_ICON 'tff_modular/modules/new_year_foods_and_drinks/icons/food_ng.dmi'
#define mandarin_ICON 'tff_modular/modules/new_year_foods_and_drinks/icons/mandarin.dmi'

/obj/item/seeds/orange
	mutatelist = list(/obj/item/seeds/lime, /obj/item/seeds/orange_3d, /obj/item/seeds/mandarin)

/obj/item/seeds/mandarin
	name = "mandarin seed pack"
	desc = "These seeds grow into sweet mandarins packed with fragrant oils."
	icon_state = "mandarin_seed"
	icon = mandarin_ICON
	species = "mandarin"
	plantname = "Mandarin Tree"
	product = /obj/item/food/grown/citrus/mandarin
	lifespan = 60
	endurance = 55
	yield = 5
	potency = 25
	growing_icon = mandarin_ICON
	icon_grow = "mandarin-grow"
	icon_dead = "mandarin-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(
	    /datum/reagent/consumable/nutriment/vitamin = 0.05,
	    /datum/reagent/consumable/nutriment = 0.05,
	)

/datum/reagent/consumable/mandarin_juice
	name = "Mandarin Juice"
	description = "Bright, sweet mandarin juice with lingering winter spices."
	color = "#ff9b3a"
	taste_description = "sweet mandarin oil and cloves"
	quality = DRINK_GOOD
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

#undef food_ng_ICON
#undef mandarin_ICON
