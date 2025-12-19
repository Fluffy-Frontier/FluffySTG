/datum/reagent/consumable/ethanol/mandarin_martini
	name = "Mandarin Martini"
	description = "A festive martini that marries citrus oils, gin, and vermouth."
	color = "#f7c271"
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "sweet, silky mandarin zest with clove strings"

/datum/glass_style/drinking_glass/mandarin_martini
	required_drink_type = /datum/reagent/consumable/ethanol/mandarin_martini
	icon = TFF_FOOD_NY_ICON
	icon_state = "manda_martini"
	name = "Mandarin Martini"
	desc = "What could be better than a gin-tonic? Of course, only a martini, an aperitif \
			cocktail based on gin and vermouth. What could be better than a martini? Mandarin Martini!"

/datum/reagent/consumable/ethanol/bluespace_tango
	name = "Bluespace Tango"
	description = "Two shimmering halves of a cocktail locked in quantum step."
	color = "#00d0ff"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "an entangled dance of digital citrus souls"

/datum/glass_style/drinking_glass/bluespace_tango
	required_drink_type = /datum/reagent/consumable/ethanol/bluespace_tango
	icon = TFF_FOOD_NY_ICON
	icon_state = "tango"
	name = "Bluespace Tango"
	desc = "For those who want to be together but can't. For those whose life is a continuous tango. And for synthetics."

/datum/reagent/consumable/ethanol/mandarin_telepad
	name = "Mandarin Telepad"
	description = "A synth-friendly riff on the screwdriver that disappears down the hatch."
	color = "#f6ab33"
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "a blinking pulse of relief and ozone"

/datum/glass_style/drinking_glass/mandarin_telepad
	required_drink_type = /datum/reagent/consumable/ethanol/mandarin_telepad
	icon = TFF_FOOD_NY_ICON
	icon_state = "manda_telepad"
	name = "Mandarin Telepad"
	desc = "The analogue of the Screwdriver, but for synthetics. Just what a tired unit needs."

/datum/reagent/consumable/mandarinade
	name = "Mandarinade"
	description = "Sparkling mandarin soda best shared during long winter nights."
	color = "#ffb45e"
	quality = DRINK_GOOD
	taste_description = "sweet mandarin juice, sugar and a long-forgotten childhood"

/datum/glass_style/drinking_glass/mandarinade
	required_drink_type = /datum/reagent/consumable/mandarinade
	icon = TFF_FOOD_NY_ICON
	icon_state = "mandarinade"
	name = "Mandarinade"
	desc = "Sparkling tangerine drink, perfect for a winter evening on Christmas Eve."

/datum/reagent/consumable/ethanol/mandarin_spritz
	name = "Mandarin Spritz"
	description = "Fresh mandarin juice brightened with tequila, lime, menthol, and soda."
	color = "#ff9c45"
	boozepwr = 40
	quality = DRINK_VERYGOOD
	taste_description = "of a romantic winter evening, pleasant sourness on the tongue and menthol breath"

/datum/glass_style/drinking_glass/mandarin_spritz
	required_drink_type = /datum/reagent/consumable/ethanol/mandarin_spritz
	icon = TFF_FOOD_NY_ICON
	icon_state = "manda_spritz"
	name = "Mandarin Spritz"
	desc = "Freshly squeezed mandarin juice, white tequila, dash of lime juice, a drop of menthol and soda. Stir, not shake. Divine."

/datum/reagent/consumable/mandarin_garibaldi
	name = "Mandarin Garibaldi"
	description = "An exquisite non-alcoholic sour."
	color = "#ffb16f"
	quality = DRINK_GOOD
	taste_description = "the sweet and sour soda,  and the creamy aftertaste. Perfectly combined with the pleasant New Year's scent of mandarin"

/datum/glass_style/drinking_glass/mandarin_garibaldi
	required_drink_type = /datum/reagent/consumable/mandarin_garibaldi
	icon = TFF_FOOD_NY_ICON
	icon_state = "garibaldi"
	name = "Mandarin Garibaldi"
	desc = "Foamy citrus for the designated reveler."

/datum/chemical_reaction/drink/mandarin_martini
	results = list(/datum/reagent/consumable/ethanol/mandarin_martini = 10)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/martini = 5,
		/datum/reagent/consumable/mandarin_juice = 5,
	)
	mix_message = "The shaker fills the air with citrus perfume."

/datum/chemical_reaction/drink/bluespace_tango
	results = list(/datum/reagent/consumable/ethanol/bluespace_tango = 5)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/duplex = 3,
		/datum/reagent/consumable/mandarin_juice = 1,
		/datum/reagent/consumable/ethanol/synthanol = 1,
	)
	mix_message = "Two luminous halves orbit each other before merging."

/datum/chemical_reaction/drink/mandarin_telepad
	results = list(/datum/reagent/consumable/ethanol/mandarin_telepad = 3)
	required_reagents = list(
		/datum/reagent/consumable/mandarin_juice = 1,
		/datum/reagent/consumable/ethanol/synthanol = 1,
		/datum/reagent/iron = 1,
	)
	mix_message = "Static runs along the glass, then blinks out."

/datum/chemical_reaction/drink/mandarinade
	results = list(/datum/reagent/consumable/mandarinade = 3)
	required_reagents = list(
		/datum/reagent/consumable/mandarin_juice = 1,
		/datum/reagent/consumable/lemon_lime = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	mix_message = "It fizzes with sparkling holiday energy."

/datum/chemical_reaction/drink/mandarin_spritz
	results = list(/datum/reagent/consumable/ethanol/mandarin_spritz = 10)
	required_reagents = list(
		/datum/reagent/consumable/mandarin_juice = 4,
		/datum/reagent/consumable/ethanol/tequila = 3,
		/datum/reagent/consumable/limejuice = 1,
		/datum/reagent/consumable/menthol = 1,
		/datum/reagent/consumable/sodawater = 1,
	)
	mix_message = "Menthol mist swirls above the bright orange drink."

/datum/chemical_reaction/drink/mandarin_garibaldi
	results = list(/datum/reagent/consumable/mandarin_garibaldi = 10)
	required_reagents = list(
		/datum/reagent/consumable/mandarin_juice = 5,
		/datum/reagent/consumable/lemonjuice = 2,
		/datum/reagent/consumable/soymilk = 2,
		/datum/reagent/consumable/sol_dry = 1,
	)
	mix_message = "Foam rises as soy milk and ginger soda meet citrus."

