
/obj/structure/barricade/sandbags/meatbags
	name = "meat barricade"
	desc = "Bags of meat. Weird, but self explanatory."

	icon = 'tff_modular/modules/deadspace/asdg/sandbags.dmi'
	icon_state = "meatbags-0"
	base_icon_state = "meatbags"

	max_integrity = 300
	proj_pass_rate = 50


//Healing Roses
/obj/effect/decal/spring_healing
	name = "blooming roses"
	desc = ""
	icon = 'tff_modular/modules/deadspace/asdg/ausflora.dmi'
	icon_state = "rdflowers_1"

//Healing Roses
/obj/effect/decal/eve_moss
	name = "moss"
	desc = ""
	icon = 'tff_modular/modules/deadspace/asdg/tiles/lava_moss.dmi'
	icon_state = "moss"



/area/station/crazy
	name = "horror"
	ambience_index = AMBIENCE_HORROR
	sound_environment = SOUND_AREA_SMALL_ENCLOSED
	icon = 'icons/area/areas_station.dmi'
	icon_state = "graveyard"


//floors

/turf/open/indestructible/necropolis/normal
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/indestructible/meat/crimson
	name = "crimson floor"
	icon = 'tff_modular/modules/deadspace/asdg/tiles/floors/crimsongrass.dmi'
	icon_state = "grass-31"
	pixel_x = -19
	pixel_y = -19
	baseturfs = /turf/open/indestructible/meat/crimson

/turf/open/indestructible/meat/flesh
	name = "flesh"
	icon = 'tff_modular/modules/deadspace/asdg/tiles/floors.dmi'
	icon_state = "flesh0"
	baseturfs = /turf/open/indestructible/meat/flesh

/turf/open/indestructible/meat/flesh/a
	icon_state = "flesh1"
	baseturfs = /turf/open/indestructible/meat/flesh/a

/turf/open/indestructible/meat/flesh/b
	icon_state = "flesh2"
	baseturfs = /turf/open/indestructible/meat/flesh/b

/turf/open/indestructible/meat/flesh/c
	icon_state = "flesh3"
	baseturfs = /turf/open/indestructible/meat/flesh/c

/turf/open/indestructible/meat/basalt
	name = "basalt"
	icon = 'tff_modular/modules/deadspace/asdg/tiles/floors/basalt.dmi'
	icon_state = "basalt-255"
	pixel_x = -19
	pixel_y = -19
	baseturfs = /turf/open/indestructible/meat/basalt

/turf/open/indestructible/meat/lavagrass
	name = "flesh"
	icon = 'tff_modular/modules/deadspace/asdg/tiles/floors/lava_grass_red.dmi'
	icon_state = "grass-159"
	pixel_x = -9
	pixel_y = -9
	baseturfs = /turf/open/indestructible/meat/lavagrass

/turf/open/indestructible/meat/dirt
	name = "dirt"
	icon = 'tff_modular/modules/deadspace/asdg/tiles/floors/dirt.dmi'
	icon_state = "dirt"
	pixel_x = -2
	pixel_y = -2
	baseturfs = /turf/open/indestructible/meat/dirt

/turf/open/indestructible/meat/darkdirt
	name = "dark dirt"
	icon = 'tff_modular/modules/deadspace/asdg/tiles/floors/darkdirt.dmi'
	icon_state = "darkdirt"
	pixel_x = -2
	pixel_y = -2
	baseturfs = /turf/open/indestructible/meat/darkdirt

//doors


/obj/machinery/door/airlock
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/public.dmi'

/obj/machinery/door/airlock/command
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/command.dmi'

/obj/machinery/door/airlock/solgov
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/solgov.dmi'

/obj/machinery/door/airlock/security
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/security.dmi'

/obj/machinery/door/airlock/engineering
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/engineering.dmi'

/obj/machinery/door/airlock/medical
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/medical.dmi'

/obj/machinery/door/airlock/maintenance
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/maintenance.dmi'

/obj/machinery/door/airlock/maintenance/external
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/maintenanceexternal.dmi'

/obj/machinery/door/airlock/mining
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/mining.dmi'

/obj/machinery/door/airlock/atmos
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/atmos.dmi'

/obj/machinery/door/airlock/research
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/research.dmi'

/obj/machinery/door/airlock/freezer
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/freezer.dmi'

/obj/machinery/door/airlock/science
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/science.dmi'

/obj/machinery/door/airlock/virology
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station/virology.dmi'


/obj/machinery/door/airlock/public
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station2/glass.dmi'
	overlays_file = 'tff_modular/modules/deadspace/asdg/doors/airlocks/station2/overlays.dmi'


/obj/machinery/door/airlock/external
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/external/external.dmi'
	overlays_file = 'tff_modular/modules/deadspace/asdg/doors/airlocks/external/overlays.dmi'


/obj/machinery/door/airlock/vault
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/vault/vault.dmi'
	overlays_file = 'tff_modular/modules/deadspace/asdg/doors/airlocks/vault/overlays.dmi'


/obj/machinery/door/airlock/hatch
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/hatch/centcom.dmi'
	overlays_file = 'tff_modular/modules/deadspace/asdg/doors/airlocks/hatch/overlays.dmi'

/obj/machinery/door/airlock/maintenance_hatch
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/hatch/maintenance.dmi'
	overlays_file = 'tff_modular/modules/deadspace/asdg/doors/airlocks/hatch/overlays.dmi'


/obj/machinery/door/airlock/highsecurity
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/highsec/highsec.dmi'
	overlays_file = 'tff_modular/modules/deadspace/asdg/doors/airlocks/highsec/overlays.dmi'

/obj/machinery/door/airlock/shuttle
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/shuttle/shuttle.dmi' //WS Edit - Classic Shuttle //I'm leaving this. Your hubris will be remembered.
	overlays_file = 'tff_modular/modules/deadspace/asdg/doors/airlocks/shuttle/old_overlays.dmi'

/obj/machinery/door/airlock/glass_large
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/glass_large/glass_large.dmi'
	overlays_file = 'tff_modular/modules/deadspace/asdg/doors/airlocks/glass_large/overlays.dmi'

/obj/machinery/door/airlock/outpost //secure anti-tiding airlock
	icon = 'tff_modular/modules/deadspace/asdg/doors/airlocks/centcom/centcom.dmi'
	overlays_file = 'tff_modular/modules/deadspace/asdg/doors/airlocks/centcom/overlays.dmi'


/obj/structure/window
	icon = 'tff_modular/modules/deadspace/asdg/structures.dmi'

/obj/structure/window/fulltile
	icon = 'tff_modular/modules/deadspace/asdg/window.dmi'

/obj/structure/window/reinforced/fulltile
	icon = 'tff_modular/modules/deadspace/asdg/reinforced_window.dmi'

/obj/structure/window/plasma/fulltile
	icon_state = "plasma_window-0"
	base_icon_state = "plasma_window"
	icon = 'tff_modular/modules/deadspace/asdg/plasma_window.dmi'

/obj/structure/window/plasma/reinforced/fulltile
	icon = 'tff_modular/modules/deadspace/asdg/rplasma_window.dmi'
	icon_state = "rplasma_window-0"
	base_icon_state = "rplasma_window"

/obj/structure/window/reinforced/tinted/fulltile
	icon_state = "tinted_window-0"
	base_icon_state = "tinted_window"
	icon = 'tff_modular/modules/deadspace/asdg/tinted_window.dmi'


//statue
/obj/structure/statue/horror
	name = "synth leftovers"
	desc = "..."
	icon = 'tff_modular/modules/deadspace/asdg/statuelarge.dmi'
	icon_state = "syndproto"
	density = FALSE
	anchored = TRUE

/obj/structure/chair/sofa/brown
	icon = 'tff_modular/modules/deadspace/asdg/sofa.dmi'

/obj/structure/chair/sofa/brown/middle
	icon_state = "brown_oldsofa_middle"

/obj/structure/chair/sofa/brown/left
	icon_state = "brown_oldsofa_end_left"

/obj/structure/chair/sofa/brown/right
	icon_state = "brown_oldsofa_end_right"

/obj/structure/chair/sofa/brown/corner
	icon_state = "brown_oldsofa_corner"


/obj/structure/chair/sofa/reddy
	icon = 'tff_modular/modules/deadspace/asdg/sofa.dmi'

/obj/structure/chair/sofa/reddy/middle
	icon_state = "red_oldsofa_middle"

/obj/structure/chair/sofa/reddy/left
	icon_state = "red_oldsofa_end_left"

/obj/structure/chair/sofa/reddy/right
	icon_state = "red_oldsofa_end_right"

/obj/structure/chair/sofa/reddy/corner
	icon_state = "red_oldsofa_corner"

