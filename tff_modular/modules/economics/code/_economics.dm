// Economics balance adjustments

/obj/machinery/bouldertech/Initialize(mapload)
	. = ..()
	refining_efficiency = 0.8 // Decrease resource yield to 0.8
