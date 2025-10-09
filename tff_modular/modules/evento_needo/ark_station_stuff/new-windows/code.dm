// New Icons (Shiptest Style)

/obj/structure/window/fulltile/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/shiptest/window.dmi'

/obj/structure/window/reinforced/fulltile/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/shiptest/reinforced_window.dmi'

/obj/structure/window/reinforced/plasma/plastitanium/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/shiptest/plastitanium_window.dmi'

/obj/structure/window/reinforced/tinted/fulltile/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/shiptest/reinforced_window.dmi'
	color = "#7a7a7a"
	icon_state = "reinforced_window-0"
	base_icon_state = "reinforced_window"

/obj/structure/window/plasma/fulltile/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/shiptest/plasma_window.dmi'
	icon_state = "plasma_window-0"
	base_icon_state = "plasma_window"

/obj/structure/window/reinforced/plasma/fulltile/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/shiptest/rplasma_window.dmi'
	icon_state = "rplasma_window-0"
	base_icon_state = "rplasma_window"

/turf/closed/indestructible/opsglass/shiptest
	name = "window"
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/shiptest/plastitanium_window.dmi'

/obj/structure/window/reinforced/shuttle/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/shiptest/shuttle_window.dmi'

/obj/structure/window/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/shiptest/structures.dmi'

// New-Old Icons (Ark Style)
/obj/structure/window/fulltile/old/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/window.dmi'

/obj/structure/window/reinforced/fulltile/old/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/r_window.dmi'

/obj/structure/window/reinforced/tinted/fulltile/old/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/r_window_tined.dmi'
	icon_state = "reinforced_window-0"
	base_icon_state = "reinforced_window"

/obj/structure/window/plasma/fulltile/old/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/window_plasma.dmi'
	icon_state = "window-0"
	base_icon_state = "window"

/obj/structure/window/reinforced/plasma/fulltile/old/shiptest
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/new-windows/r_window_plasma.dmi'
	icon_state = "reinforced_window-0"
	base_icon_state = "reinforced_window"

// Spawners
/obj/effect/spawner/structure/window/shiptest/old/shiptest
	spawn_list = list(/obj/structure/grille, /obj/structure/window/fulltile/old/shiptest)

/obj/effect/spawner/structure/window/shiptest/reinforced/old/shiptest
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile/old/shiptest)

/obj/effect/spawner/structure/window/shiptest/reinforced/tinted/old/shiptest
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/tinted/fulltile/old/shiptest)

/obj/effect/spawner/structure/window/shiptest/plasma/old/shiptest
	spawn_list = list(/obj/structure/grille, /obj/structure/window/plasma/fulltile/old/shiptest)

/obj/effect/spawner/structure/window/shiptest/reinforced/plasma/old/shiptest
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/plasma/fulltile/old/shiptest)
