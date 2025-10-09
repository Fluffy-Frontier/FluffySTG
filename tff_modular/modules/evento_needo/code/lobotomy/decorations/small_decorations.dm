/obj/structure/flotsam
	name = "Flotsam"
	desc = "A pile of teal light tubes embedded into the floor."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x32.dmi'
	pixel_x = -16
	base_pixel_x = -16
	icon_state = "flotsam"
	max_integrity = 750
	density = TRUE
	anchored = TRUE
	light_color = COLOR_TEAL
	light_range = 4
	light_power = 5



//REGENERATOR

/obj/machinery/regenerator
	name = "regenerator"
	desc = "A machine responsible for slowly restoring the health and sanity of employees in the area."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "regen"
	density = TRUE
	resistance_flags = INDESTRUCTIBLE
	layer = ABOVE_OBJ_LAYER //So people dont stand ontop of it when above it

//Safety Plant Regenerator
/obj/machinery/regenerator/safety
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64.dmi'
	icon_state = "regen"
	layer = ABOVE_OBJ_LAYER //So people dont stand ontop of it when above it


//SEED EXTRACTOR

/obj/structure/seed_grinder
	name = "seed grinder"
	desc = "A crude grinding machine repurposed from kitchen appliances. Plants go in, seeds come out."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/farming_structures.dmi'
	icon_state = "sextractor_manual"
	density = FALSE
	anchored = TRUE
