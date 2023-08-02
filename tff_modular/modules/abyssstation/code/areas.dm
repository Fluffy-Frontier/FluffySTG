/area/abyss_station
	icon = 'tff_modular/modules/abyssstation/icons/areas.dmi'
	icon_state = "unknown"

/area/abyss_station/exterior/ocean
	name = "Ocean"
	icon_state = "ocean"
	static_lighting = FALSE
	base_lighting_alpha = 255
	base_lighting_color = "#FFFFCC"
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	ambientsounds = list('sound/ambience/shore.ogg', 'sound/ambience/seag1.ogg','sound/ambience/seag2.ogg','sound/ambience/seag2.ogg','sound/ambience/ambiodd.ogg','sound/ambience/ambinice.ogg')

/area/abyss_station/exterior/ocean/shore
	name = "Shore"
	icon_state = "shore"
