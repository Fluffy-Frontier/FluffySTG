#define food_ng_ICON 'tff_modular/modules/new_year_foods_and_drinks/icons/food_ng.dmi'

/datum/reagent/consumable/ethanol/mandarin_martini
	name = "Mandarin Martini"
	description = "A festive martini that marries citrus oils, gin, and vermouth."
	color = "#f7c271"
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "sweet, silky mandarin zest with clove strings"

/datum/glass_style/drinking_glass/mandarin_martini
	required_drink_type = /datum/reagent/consumable/ethanol/mandarin_martini
	icon = food_ng_ICON
	icon_state = "manda_martini"
	name = "Mandarin Martini"
	desc = "Shaken by holiday cheer, not stirred."

/datum/reagent/consumable/ethanol/bluespace_tango
	name = "Bluespace Tango"
	description = "Two shimmering halves of a cocktail locked in quantum step."
	color = "#00d0ff"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "an entangled dance of digital citrus souls"

/datum/glass_style/drinking_glass/bluespace_tango
	required_drink_type = /datum/reagent/consumable/ethanol/bluespace_tango
	icon = food_ng_ICON
	icon_state = "tango"
	name = "Bluespace Tango"
	desc = "For partners separated by lightyears, but connected by flavor."

/datum/reagent/consumable/ethanol/mandarin_telepad
	name = "Mandarin Telepad"
	description = "A synth-friendly riff on the screwdriver that disappears down the hatch."
	color = "#f6ab33"
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "a blinking pulse of relief and ozone"

/datum/glass_style/drinking_glass/mandarin_telepad
	required_drink_type = /datum/reagent/consumable/ethanol/mandarin_telepad
	icon = food_ng_ICON
	icon_state = "manda_telepad"
	name = "Mandarin Telepad"
	desc = "Screwdrivers are for carbons; this one is for tired machines."

/datum/reagent/consumable/mandarinade
	name = "Mandarinade"
	description = "Sparkling mandarin soda best shared during long winter nights."
	color = "#ffb45e"
	quality = DRINK_GOOD
	taste_description = "sweet mandarin bubbles and childhood sugar"

/datum/glass_style/drinking_glass/mandarinade
	required_drink_type = /datum/reagent/consumable/mandarinade
	icon = food_ng_ICON
	icon_state = "mandarinade"
	name = "Mandarinade"
	desc = "Fizzing citrus memories of snow crunching underfoot."

/datum/reagent/consumable/ethanol/mandarin_spritz
	name = "Mandarin Spritz"
	description = "Fresh mandarin juice brightened with tequila, lime, menthol, and soda."
	color = "#ff9c45"
	boozepwr = 40
	quality = DRINK_VERYGOOD
	taste_description = "romantic winter sourness with menthol breath"

/datum/glass_style/drinking_glass/mandarin_spritz
	required_drink_type = /datum/reagent/consumable/ethanol/mandarin_spritz
	icon = food_ng_ICON
	icon_state = "manda_spritz"
	name = "Mandarin Spritz"
	desc = "A sunset gradient crowned with frosty breath."

/datum/reagent/consumable/mandarin_garibaldi
	name = "Mandarin Garibaldi"
	description = "A creamy, non-alcoholic sour layered with soy milk and ginger soda."
	color = "#ffb16f"
	quality = DRINK_GOOD
	taste_description = "sweet-and-sour mandarin with creamy soda"

/datum/glass_style/drinking_glass/mandarin_garibaldi
	required_drink_type = /datum/reagent/consumable/mandarin_garibaldi
	icon = food_ng_ICON
	icon_state = "garibaldi"
	name = "Mandarin Garibaldi"
	desc = "Foamy citrus for the designated reveler."

/datum/chemical_reaction/drink/mandarin_martini
	results = list(/datum/reagent/consumable/ethanol/mandarin_martini = 10)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/martini = 5
		/datum/reagent/consumable/mandarinjuice = 5,
	)
	mix_message = "The shaker fills the air with citrus perfume."

/datum/chemical_reaction/drink/bluespace_tango
	results = list(/datum/reagent/consumable/ethanol/bluespace_tango = 5)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/duplex = 3,
		/datum/reagent/consumable/mandarinjuice = 1,
		/datum/reagent/consumable/ethanol/synthanol = 1,
	)
	mix_message = "Two luminous halves orbit each other before merging."

/datum/chemical_reaction/drink/mandarin_telepad
	results = list(/datum/reagent/consumable/ethanol/mandarin_telepad = 3)
	required_reagents = list(
		/datum/reagent/consumable/mandarinjuice = 1,
		/datum/reagent/consumable/ethanol/synthanol = 1,
		/datum/reagent/iron = 1,
	)
	mix_message = "Static runs along the glass, then blinks out."

/datum/chemical_reaction/drink/mandarinade
	results = list(/datum/reagent/consumable/mandarinade = 3)
	required_reagents = list(
		/datum/reagent/consumable/mandarinjuice = 1,
		/datum/reagent/consumable/lemon_lime = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	mix_message = "It fizzes with sparkling holiday energy."

/datum/chemical_reaction/drink/mandarin_spritz
	results = list(/datum/reagent/consumable/ethanol/mandarin_spritz = 10)
	required_reagents = list(
		/datum/reagent/consumable/mandarinjuice = 4,
		/datum/reagent/consumable/ethanol/tequila = 3,
		/datum/reagent/consumable/limejuice = 1,
		/datum/reagent/consumable/menthol = 1,
		/datum/reagent/consumable/sodawater = 1,
	)
	mix_message = "Menthol mist swirls above the bright orange drink."

/datum/chemical_reaction/drink/mandarin_garibaldi
	results = list(/datum/reagent/consumable/mandarin_garibaldi = 10)
	required_reagents = list(
		/datum/reagent/consumable/mandarinjuice = 5,
		/datum/reagent/consumable/lemonjuice = 2,
		/datum/reagent/consumable/soymilk = 2,
		/datum/reagent/consumable/sol_dry = 1,
	)
	mix_message = "Foam rises as soy milk and ginger soda meet citrus."

#undef food_ng_ICON

