/atom/movable
	/// Amount of biomass we produce when harvester is nearby
	var/biomass_produce = null

/obj/machinery/limbgrower
	biomass_produce = BIOMASS_HARVEST_MEDIUM

/obj/structure/bodycontainer
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/structure/toilet
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/portable_atmospherics
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/portable_atmospherics/scrubber/huge
	biomass_produce = BIOMASS_HARVEST_MEDIUM

/obj/machinery/deepfryer
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/food_cart
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/gibber
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/griddle
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/grill
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/icecream_vat
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/microwave
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/monkey_recycler
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/oven
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/processor
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/hydroponics
	biomass_produce = BIOMASS_HARVEST_MEDIUM

/obj/structure/reagent_dispensers/watertank
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/structure/reagent_dispensers/beerkeg
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/vending/coffee
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/vending/cola
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/vending/hydronutrients
	biomass_produce = BIOMASS_HARVEST_SMALL

/obj/machinery/vending/snack
	biomass_produce = BIOMASS_HARVEST_SMALL
