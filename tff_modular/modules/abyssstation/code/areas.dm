/area/abyss_station
	icon = 'tff_modular/modules/abyssstation/icons/areas.dmi'
	icon_state = "unknown"

/area/abyss_station/exterior
	name = "Exterior"
	static_lighting = FALSE
	base_lighting_alpha = 255
	base_lighting_color = "#FFFFCC"
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY

/area/abyss_station/exterior/abyss
	name = "Abyss"
	icon_state = "abyss"

/area/abyss_station/exterior/one_level
	name = "The first level of the Abyss"
	icon_state = "one_level"

/area/abyss_station/exterior/two_level
	name = "The second level of the Abyss"
	icon_state = "two_level"

/area/abyss_station/exterior/ocean
	name = "Ocean"
	icon_state = "ocean"
	ambientsounds = list('sound/ambience/shore.ogg', 'sound/ambience/seag1.ogg','sound/ambience/seag2.ogg','sound/ambience/seag2.ogg','sound/ambience/ambiodd.ogg','sound/ambience/ambinice.ogg')

/area/abyss_station/exterior/ocean/shore
	name = "Shore"
	icon_state = "shore"

/area/abyss_station/exterior/ocean/beach
	name = "Beach"
	icon_state = "beach"

/area/abyss_station/exterior/spaceport
	name = "Spaceport"
	icon_state = "spaceport"

/area/abyss_station/exterior/park
	name = "Central Park"
	icon_state = "central_park"

/area/abyss_station/exterior/park/dorm
	name = "Dormitory Park"
	icon_state = "dorm_park"

/area/abyss_station/exterior/park/skate
	name = "Skateboard Park"
	icon_state = "skate_park"

/area/abyss_station/exterior/bridge/north
	name = "North Bridge"
	icon_state = "north_bridge"

/area/abyss_station/exterior/bridge/south
	name = "South Bridge"
	icon_state = "south_bridge"

/area/abyss_station/exterior/bridge/east
	name = "East Bridge"
	icon_state = "east_bridge"

/area/abyss_station/exterior/bridge/west
	name = "West Bridge"
	icon_state = "west_bridge"

/area/abyss_station/station/
	name = "station"
	icon = 'tff_modular/modules/abyssstation/icons/areas.dmi'
	icon_state = "station"

/area/abyss_station/station/security
	name = "Barracks"
	icon_state = "securitylockerroom"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/security
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/abyss_station/station/security/camera
	name = "Camera Room"
	icon_state = "camera_room"

/area/abyss_station/station/service
	airlock_wires = /datum/wires/airlock/service

/area/abyss_station/station/service/bar
	name = "Gay Bar"
	icon_state = "bar"

/area/abyss_station/station/service/garden
	name = "Garden"
	icon_state = "garden"
	base_lighting_alpha = 255
	base_lighting_color = "#FFFFCC"

/area/abyss_station/station/service/public_garden
	name = "Garden"
	icon_state = "garden"
	base_lighting_alpha = 255
	base_lighting_color = "#FFFFCC"

/area/abyss_station/station/service/diner
	name = "Diner"
	icon_state = "diner"
	base_lighting_alpha = 255
	base_lighting_color = "#FFFFCC"

/area/abyss_station/station/service/library/lounge
	name = "\improper Library Lounge"
	icon_state = "library_lounge"
	base_lighting_alpha = 255
	base_lighting_color = "#FFFFCC"

/area/abyss_station/station/command
	name = "Command"
	icon_state = "command"
	ambientsounds = list(
		'sound/ambience/signal.ogg',
		)
	airlock_wires = /datum/wires/airlock/command
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/abyss_station/station/command/heads_quarters/captain
	name = "\improper Captain's Office"
	icon_state = "captain"
	sound_environment = SOUND_AREA_WOODFLOOR
