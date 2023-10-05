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

/obj/effect/landmark/lift_id/abyss/main
	specific_lift_id = ABYSS_CENTRAL_TRAM

/obj/effect/landmark/tram/nav/abyss/main
	name = ABYSS_CENTRAL_TRAM
	specific_lift_id = ABYSS_CENTRAL_TRAM_NAV_BEACONS
	dir = WEST

/obj/effect/landmark/tram/platform/abyss/west
	name = "West Wing"
	specific_lift_id = ABYSS_CENTRAL_TRAM
	platform_code = ABYSS_TRAMSTATION_WEST
	tgui_icons = list("Arrival" = "plane-arrival", "Cargo" = "truck-ramp-box", "Service" = "bell-concierge")

/obj/effect/landmark/tram/platform/abyss/cental
	name = "Central Wing"
	specific_lift_id = ABYSS_CENTRAL_TRAM
	platform_code = ABYSS_TRAMSTATION_CENTRAL
	tgui_icons = list("Science" = "book", "Command" = "house")

/obj/effect/landmark/tram/platform/abyss/east
	name = "East Wing"
	specific_lift_id = ABYSS_CENTRAL_TRAM
	platform_code = ABYSS_TRAMSTATION_EAST
	tgui_icons = list("Departures" = "plane-departure", "Dormitories" = "hotel", "Medical" = "hospital")

//---------------------------------------------------------------------
/obj/effect/landmark/lift_id/abyss/north
	specific_lift_id = ABYSS_NORTH_TRAM

/obj/effect/landmark/tram/nav/abyss/north
	name = ABYSS_NORTH_TRAM
	specific_lift_id = ABYSS_NORTH_TRAM_NAV_BEACONS
	dir = NORTH

/obj/effect/landmark/tram/platform/abyss/north
	name = "North Wing"
	specific_lift_id = ABYSS_NORTH_TRAM
	platform_code = ABYSS_TRAMSTATION_NORTH
	tgui_icons = list("Security" = "shield-halved")

/obj/effect/landmark/tram/platform/abyss/north_cental
	name = "Central Wing"
	specific_lift_id = ABYSS_NORTH_TRAM
	platform_code = ABYSS_TRAMSTATION_NORTH_CENTRAL
	tgui_icons = list("Science" = "book", "Command" = "house")

//---------------------------------------------------------------------
/obj/effect/landmark/lift_id/abyss/south
	specific_lift_id = ABYSS_SOUTH_TRAM

/obj/effect/landmark/tram/nav/abyss/south
	name = ABYSS_SOUTH_TRAM
	specific_lift_id = ABYSS_SOUTH_TRAM_NAV_BEACONS
	dir = SOUTH

/obj/effect/landmark/tram/platform/abyss/south
	name = "South Wing"
	specific_lift_id = ABYSS_SOUTH_TRAM
	platform_code = ABYSS_TRAMSTATION_SOUTH
	tgui_icons = list("Engineering" = "screwdriver-wrench")

/obj/effect/landmark/tram/platform/abyss/south_cental
	name = "Central Wing"
	specific_lift_id = ABYSS_SOUTH_TRAM
	platform_code = ABYSS_TRAMSTATION_SOUTH_CENTRAL
	tgui_icons = list("Science" = "book", "Command" = "house")
