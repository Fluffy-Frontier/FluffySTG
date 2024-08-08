#define ABYSS_ENTRY_ELEVATOR_ID "entryElevator"
#define ABYSS_CARGO_ELEVATOR_ID "cargoElevator"
#define ABYSS_ENGINEERING_ELEVATOR_ID "engineeringElevator"
#define ABYSS_DEPARTURE_ELEVATOR_ID "departureElevator"
#define ABYSS_SECURITY_ELEVATOR_ID "securityElevator"
#define ABYSS_MINE_ELEVATOR_ID "mineElevator"
#define ABYSS_CONTRABAND_ELEVATOR_ID "contrabandElevator"

// ENTRY
/obj/effect/landmark/transport/transport_id/abyss_station/entry_elevator
	specific_transport_id = ABYSS_ENTRY_ELEVATOR_ID

/obj/machinery/elevator_control_panel/abyss_station/entry_elevator
	name = "Entry elevator control"
	linked_elevator_id = ABYSS_ENTRY_ELEVATOR_ID
	preset_destination_names = list("3"="First        Floor", "4"="Second        Floor", "5"="Third        Floor")

/obj/machinery/button/elevator/abyss_station/entry_elevator
	id = ABYSS_ENTRY_ELEVATOR_ID
	name = "Entry elevator button"

/obj/machinery/door/window/elevator/left/abyss_station/entry_elevator
	transport_linked_id = ABYSS_ENTRY_ELEVATOR_ID
	elevator_mode = TRUE

/obj/machinery/door/window/elevator/right/abyss_station/entry_elevator
	transport_linked_id = ABYSS_ENTRY_ELEVATOR_ID
	elevator_mode = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/elevator/left/abyss_station/entry_elevator, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/elevator/right/abyss_station/entry_elevator, 0)

// CARGO
/obj/effect/landmark/transport/transport_id/abyss_station/cargo_elevator
	specific_transport_id = ABYSS_CARGO_ELEVATOR_ID

/obj/machinery/elevator_control_panel/abyss_station/cargo_elevator
	name = "Cargo elevator control"
	linked_elevator_id = ABYSS_CARGO_ELEVATOR_ID
	preset_destination_names = list("3"="First        Floor", "4"="Second        Floor")

/obj/machinery/button/elevator/abyss_station/cargo_elevator
	id = ABYSS_CARGO_ELEVATOR_ID
	name = "Cargo elevator button"

// ENGINEERING
/obj/effect/landmark/transport/transport_id/abyss_station/engineering_elevator
	specific_transport_id = ABYSS_ENGINEERING_ELEVATOR_ID

/obj/machinery/elevator_control_panel/abyss_station/engineering_elevator
	name = "Engineering elevator control"
	linked_elevator_id = ABYSS_ENGINEERING_ELEVATOR_ID
	preset_destination_names = list("3"="First        Floor", "4"="Second        Floor", "5"="Third        Floor")

/obj/machinery/button/elevator/abyss_station/engineering_elevator
	id = ABYSS_ENGINEERING_ELEVATOR_ID
	name = "Engineering elevator button"

/obj/machinery/door/window/elevator/left/abyss_station/engineering_elevator
	transport_linked_id = ABYSS_ENGINEERING_ELEVATOR_ID
	elevator_mode = TRUE

/obj/machinery/door/window/elevator/right/abyss_station/engineering_elevator
	transport_linked_id = ABYSS_ENGINEERING_ELEVATOR_ID
	elevator_mode = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/elevator/left/abyss_station/engineering_elevator, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/elevator/right/abyss_station/engineering_elevator, 0)

// DEPARTURE
/obj/effect/landmark/transport/transport_id/abyss_station/departure_elevator
	specific_transport_id = ABYSS_DEPARTURE_ELEVATOR_ID

/obj/machinery/elevator_control_panel/abyss_station/departure_elevator
	name = "Departure elevator control"
	linked_elevator_id = ABYSS_DEPARTURE_ELEVATOR_ID
	preset_destination_names = list("3"="First        Floor", "4"="Second        Floor", "5"="Third        Floor")

/obj/machinery/button/elevator/abyss_station/departure_elevator
	id = ABYSS_DEPARTURE_ELEVATOR_ID
	name = "Departure elevator button"

/obj/machinery/door/window/elevator/left/abyss_station/departure_elevator
	transport_linked_id = ABYSS_DEPARTURE_ELEVATOR_ID
	elevator_mode = TRUE

/obj/machinery/door/window/elevator/right/abyss_station/departure_elevator
	transport_linked_id = ABYSS_DEPARTURE_ELEVATOR_ID
	elevator_mode = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/elevator/left/abyss_station/departure_elevator, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/elevator/right/abyss_station/departure_elevator, 0)

// SECURITY
/obj/effect/landmark/transport/transport_id/abyss_station/security_elevator
	specific_transport_id = ABYSS_SECURITY_ELEVATOR_ID

/obj/machinery/elevator_control_panel/abyss_station/security_elevator
	name = "Security elevator control"
	linked_elevator_id = ABYSS_SECURITY_ELEVATOR_ID
	preset_destination_names = list("3"="First        Floor", "4"="Second        Floor", "5"="Third        Floor")

/obj/machinery/button/elevator/abyss_station/security_elevator
	id = ABYSS_SECURITY_ELEVATOR_ID
	name = "Security elevator button"

/obj/machinery/door/window/elevator/left/abyss_station/security_elevator
	transport_linked_id = ABYSS_SECURITY_ELEVATOR_ID
	elevator_mode = TRUE

/obj/machinery/door/window/elevator/right/abyss_station/security_elevator
	transport_linked_id = ABYSS_SECURITY_ELEVATOR_ID
	elevator_mode = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/elevator/left/abyss_station/security_elevator, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/elevator/right/abyss_station/security_elevator, 0)

// MINE
/obj/effect/landmark/transport/transport_id/abyss_station/mine_elevator
	specific_transport_id = ABYSS_MINE_ELEVATOR_ID

/obj/machinery/elevator_control_panel/abyss_station/mine_elevator
	name = "Mine elevator control"
	linked_elevator_id = ABYSS_MINE_ELEVATOR_ID
	preset_destination_names = list("2"="First        Floor", "3"="Second        Floor")

/obj/machinery/button/elevator/abyss_station/mine_elevator
	id = ABYSS_MINE_ELEVATOR_ID
	name = "Mine elevator button"

// CONTRABAND
/obj/effect/landmark/transport/transport_id/abyss_station/contraband_elevator
	specific_transport_id = ABYSS_CONTRABAND_ELEVATOR_ID

/obj/machinery/elevator_control_panel/abyss_station/contraband_elevator
	name = "Contraband elevator control"
	linked_elevator_id = ABYSS_CONTRABAND_ELEVATOR_ID
	preset_destination_names = list("2"="First        Floor", "3"="Second        Floor")

/obj/machinery/button/elevator/abyss_station/contraband_elevator
	id = ABYSS_CONTRABAND_ELEVATOR_ID
	name = "Contraband elevator button"

#undef ABYSS_ENTRY_ELEVATOR_ID
#undef ABYSS_CARGO_ELEVATOR_ID
#undef ABYSS_ENGINEERING_ELEVATOR_ID
#undef ABYSS_DEPARTURE_ELEVATOR_ID
#undef ABYSS_SECURITY_ELEVATOR_ID
#undef ABYSS_MINE_ELEVATOR_ID
#undef ABYSS_CONTRABAND_ELEVATOR_ID
