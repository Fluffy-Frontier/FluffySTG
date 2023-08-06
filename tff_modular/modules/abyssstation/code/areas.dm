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
