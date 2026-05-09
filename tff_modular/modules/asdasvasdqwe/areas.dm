/area/event
	static_lighting = TRUE
	base_lighting_alpha = 255
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	//area_flags = BLOCK_SUICIDE

/area/event/start_zone
	static_lighting = FALSE
	base_lighting_alpha = 220
	base_lighting_color = "#fff9ce"
	name = "Laboratory"
	sound_environment = SOUND_ENVIRONMENT_ROOM
	ambientsounds = list('tff_modular/modules/asdasvasdqwe/sounds/office.mp3')

/area/event/sublocation
	name = "subloc"
	sound_environment = SOUND_ENVIRONMENT_ROOM

/area/event/sublocation/corridor

/area/event/sublocation/fun
	static_lighting = FALSE

/area/event/sublocation/ozero
	static_lighting = FALSE

/area/event/sublocation/parking

/area/event/sublocation/waiting
	static_lighting = FALSE

/area/event/sublocation/island
	static_lighting = FALSE

/area/event/sublocation/archive

/area/event/sublocation/hospital


/area/event/levelo
	name = "levelo"
	static_lighting = FALSE
	sound_environment = SOUND_ENVIRONMENT_ROOM
	min_ambience_cooldown = 1 SECONDS
	base_lighting_color = "#f2f76b"
	ambientsounds = list('tff_modular/modules/asdasvasdqwe/sounds/rooms.mp3')

/area/event/levelo/darker
	sound_environment = SOUND_ENVIRONMENT_STONEROOM
	base_lighting_alpha = 145

/area/event/office
	base_lighting_alpha = 180
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	ambientsounds = list('tff_modular/modules/asdasvasdqwe/sounds/office.mp3')

/area/event/office/darker
	base_lighting_alpha = 140
	sound_environment = SOUND_ENVIRONMENT_STONEROOM

/area/event/office/generators
	sound_environment = SOUND_ENVIRONMENT_ROOM
	base_lighting_alpha = 85

	var/generator_on = FALSE

/area/event/hotel
	base_lighting_alpha = 235
	sound_environment = SOUND_ENVIRONMENT_ROOM
	ambientsounds = list('tff_modular/modules/asdasvasdqwe/sounds/hotel1.mp3', 'tff_modular/modules/asdasvasdqwe/sounds/hotel2.mp3')

/area/event/hotel/darker
	base_lighting_alpha = 170

/area/event/run
	static_lighting = TRUE
	//base_lighting_color = COLOR_RED_LIGHT

/area/event/generators
	base_lighting_alpha = 155
	base_lighting_color = COLOR_ORANGE_BROWN
	sound_environment = SOUND_ENVIRONMENT_ROOM
	ambientsounds = list('tff_modular/modules/asdasvasdqwe/sounds/boiler.mp3')

/area/event/sea
	static_lighting = FALSE
	base_lighting_alpha = 215
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	ambientsounds = list('tff_modular/modules/asdasvasdqwe/sounds/tallos1.mp3', 'tff_modular/modules/asdasvasdqwe/sounds/tallos2.mp3')

/area/event/sea/b
	base_lighting_alpha = 155

/area/event/sea/c
	base_lighting_alpha = 130

/area/event/sea/house
	sound_environment = SOUND_ENVIRONMENT_BATHROOM

/area/event/sea/island
	base_lighting_alpha = 145

/area/event/sea/city
	base_lighting_alpha = 140

/area/event/sea/cave
	static_lighting = TRUE
	base_lighting_alpha = 110
	sound_environment = SOUND_ENVIRONMENT_CAVE
	ambientsounds = list('tff_modular/modules/asdasvasdqwe/sounds/water.mp3')

/area/event/sea/cave/deep
	base_lighting_alpha = 85

/area/event/sea/cave/office
	sound_environment = SOUND_ENVIRONMENT_ROOM

/area/event/field
	sound_environment = SOUND_ENVIRONMENT_PLAIN
	min_ambience_cooldown = 6 SECONDS
	max_ambience_cooldown = 7 SECONDS
	ambientsounds = list('tff_modular/modules/asdasvasdqwe/sounds/wind.mp3', 'tff_modular/modules/asdasvasdqwe/sounds/field.mp3')

/area/event/library
