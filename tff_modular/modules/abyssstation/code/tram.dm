#define ABYSS_CENTRAL_TRAM_NAV_BEACONS "abyss_central_tram_nav_beacons"
#define ABYSS_CENTRAL_TRAM "abyss_central_tram"
#define ABYSS_TRAMSTATION_WEST 1
#define ABYSS_TRAMSTATION_CENTRAL 2
#define ABYSS_TRAMSTATION_EAST 3

#define ABYSS_NORTH_TRAM_NAV_BEACONS "abyss_north_tram_nav_beacons"
#define ABYSS_NORTH_TRAM "abyss_north_tram"
#define ABYSS_TRAMSTATION_NORTH 1
#define ABYSS_TRAMSTATION_NORTH_CENTRAL 2

#define ABYSS_SOUTH_TRAM_NAV_BEACONS "abyss_south_tram_nav_beacons"
#define ABYSS_SOUTH_TRAM "abyss_south_tram"
#define ABYSS_TRAMSTATION_SOUTH 1
#define ABYSS_TRAMSTATION_SOUTH_CENTRAL 2

/obj/machinery/computer/tram_controls/abyss_station
	icon = 'tff_modular/modules/abyssstation/icons/computer.dmi'

/obj/effect/landmark/transport/transport_id/abyss_station/tram/main
	specific_transport_id = ABYSS_CENTRAL_TRAM

/obj/effect/landmark/transport/nav_beacon/tram/nav/abyss_station/tram/main
	name = ABYSS_CENTRAL_TRAM
	specific_transport_id = ABYSS_CENTRAL_TRAM_NAV_BEACONS
	dir = WEST

/obj/effect/landmark/transport/nav_beacon/tram/platform/abyss_station/tram/west
	name = "West Wing"
	specific_transport_id = ABYSS_CENTRAL_TRAM
	platform_code = ABYSS_TRAMSTATION_WEST
	tgui_icons = list("Arrival" = "plane-arrival", "Cargo" = "truck-ramp-box", "Service" = "bell-concierge")

/obj/effect/landmark/transport/nav_beacon/tram/platform/abyss_station/tram/central
	name = "Central Wing"
	specific_transport_id = ABYSS_CENTRAL_TRAM
	platform_code = ABYSS_TRAMSTATION_CENTRAL
	tgui_icons = list("Science" = "book", "Command" = "house")

/obj/effect/landmark/transport/nav_beacon/tram/platform/abyss_station/tram/east
	name = "East Wing"
	specific_transport_id = ABYSS_CENTRAL_TRAM
	platform_code = ABYSS_TRAMSTATION_EAST
	tgui_icons = list("Departures" = "plane-departure", "Dormitories" = "hotel", "Medical" = "hospital")

/obj/machinery/transport/tram_controller/abyss_station/main
	configured_transport_id = ABYSS_CENTRAL_TRAM

/obj/machinery/computer/tram_controls/abyss_station/main
	specific_transport_id = ABYSS_CENTRAL_TRAM

//---------------------------------------------------------------------
/obj/effect/landmark/transport/transport_id/abyss_station/tram/north
	specific_transport_id = ABYSS_NORTH_TRAM

/obj/effect/landmark/transport/nav_beacon/tram/nav/abyss_station/tram/north
	name = ABYSS_NORTH_TRAM
	specific_transport_id = ABYSS_NORTH_TRAM_NAV_BEACONS
	dir = NORTH

/obj/effect/landmark/transport/nav_beacon/tram/platform/abyss_station/tram/north
	name = "North Wing"
	specific_transport_id = ABYSS_NORTH_TRAM
	platform_code = ABYSS_TRAMSTATION_NORTH
	tgui_icons = list("Security" = "shield-halved")

/obj/effect/landmark/transport/nav_beacon/tram/platform/abyss_station/tram/north_cental
	name = "Central Wing"
	specific_transport_id = ABYSS_NORTH_TRAM
	platform_code = ABYSS_TRAMSTATION_NORTH_CENTRAL
	tgui_icons = list("Science" = "book", "Command" = "house")

/obj/machinery/transport/tram_controller/abyss_station/north
	configured_transport_id = ABYSS_NORTH_TRAM

/obj/machinery/computer/tram_controls/abyss_station/north
	specific_transport_id = ABYSS_NORTH_TRAM

//---------------------------------------------------------------------
/obj/effect/landmark/transport/transport_id/abyss_station/tram/south
	specific_transport_id = ABYSS_SOUTH_TRAM

/obj/effect/landmark/transport/nav_beacon/tram/nav/abyss_station/tram/south
	name = ABYSS_SOUTH_TRAM
	specific_transport_id = ABYSS_SOUTH_TRAM_NAV_BEACONS
	dir = SOUTH

/obj/effect/landmark/transport/nav_beacon/tram/platform/abyss_station/tram/south
	name = "South Wing"
	specific_transport_id = ABYSS_SOUTH_TRAM
	platform_code = ABYSS_TRAMSTATION_SOUTH
	tgui_icons = list("Engineering" = "screwdriver-wrench")

/obj/effect/landmark/transport/nav_beacon/tram/platform/abyss_station/tram/south_cental
	name = "Central Wing"
	specific_transport_id = ABYSS_SOUTH_TRAM
	platform_code = ABYSS_TRAMSTATION_SOUTH_CENTRAL
	tgui_icons = list("Science" = "book", "Command" = "house")

/obj/machinery/transport/tram_controller/abyss_station/south
	configured_transport_id = ABYSS_SOUTH_TRAM

/obj/machinery/computer/tram_controls/abyss_station/south
	specific_transport_id = ABYSS_SOUTH_TRAM

#undef ABYSS_CENTRAL_TRAM_NAV_BEACONS
#undef ABYSS_CENTRAL_TRAM
#undef ABYSS_TRAMSTATION_WEST
#undef ABYSS_TRAMSTATION_CENTRAL
#undef ABYSS_TRAMSTATION_EAST
#undef ABYSS_NORTH_TRAM_NAV_BEACONS
#undef ABYSS_NORTH_TRAM
#undef ABYSS_TRAMSTATION_NORTH
#undef ABYSS_TRAMSTATION_NORTH_CENTRAL
#undef ABYSS_SOUTH_TRAM_NAV_BEACONS
#undef ABYSS_SOUTH_TRAM
#undef ABYSS_TRAMSTATION_SOUTH
#undef ABYSS_TRAMSTATION_SOUTH_CENTRAL
