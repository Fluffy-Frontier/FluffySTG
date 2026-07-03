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
	base_lighting_color = "#5d5d5d"

/area/event/sublocation/fun
	static_lighting = FALSE
	base_lighting_color = "#edff94"

/area/event/sublocation/ozero
	static_lighting = FALSE
	base_lighting_color = "#727152"

/area/event/sublocation/ozero/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	if(ishuman(arrived))
		var/mob/living/carbon/human/player = arrived
		ADD_TRAIT(player, TRAIT_MUTE, TRAUMA_TRAIT)

/area/event/sublocation/ozero/Exited(atom/movable/gone, direction)
	. = ..()
	if(ishuman(gone))
		var/mob/living/carbon/human/player = gone
		REMOVE_TRAIT(player, TRAIT_MUTE, TRAUMA_TRAIT)


/area/event/sublocation/parking

/area/event/sublocation/waiting
	static_lighting = FALSE

/area/event/sublocation/island
	static_lighting = FALSE

/area/event/sublocation/archive
	var/passO = FALSE
	var/passT = FALSE
	base_lighting_color = "#BBBBBB"

/area/event/sublocation/hospital
	base_lighting_color = "#94efff"



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

/area/event/office/can_talk

/area/event/hotel
	base_lighting_alpha = 235
	sound_environment = SOUND_ENVIRONMENT_ROOM
	ambientsounds = list('tff_modular/modules/asdasvasdqwe/sounds/hotel1.mp3', 'tff_modular/modules/asdasvasdqwe/sounds/hotel2.mp3')

/area/event/hotel/darker
	base_lighting_alpha = 170

/area/event/run
	static_lighting = TRUE
	requires_power = FALSE
	//base_lighting_color = COLOR_RED_LIGHT
//ТРЯСКА ЭКРАНА И ТЕМНЕЕ ЛОКАЦИЮ,


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
	base_lighting_color = "#fffd90"
	sound_environment = SOUND_ENVIRONMENT_PLAIN
	min_ambience_cooldown = 6 SECONDS
	max_ambience_cooldown = 7 SECONDS
	ambientsounds = list('tff_modular/modules/asdasvasdqwe/sounds/wind.mp3', 'tff_modular/modules/asdasvasdqwe/sounds/field.mp3')

/area/event/field/hangar
	base_lighting_color = "#523c27"

/area/event/field/bees
	base_lighting_color = "#ffee6f"

/area/event/field/village
	base_lighting_color = "#BC9E82"

/area/event/library
	var/key = FALSE
	var/pass = FALSE
	var/statues_broken = 0

/area/event/library/proc/end()
	for(var/mob/living/carbon/human/player in src)
		to_chat(world, "[player.name]")

		//player.forceMove(pick(SSjob.library_exit))

/area/event/library/finall

/area/event/library/finall/proc/finalize()
	for(var/mob/living/carbon/human/player in GLOB.alive_player_list)
		shake_camera(player, 30 SECONDS, 1)
	addtimer(CALLBACK(src, PROC_REF(end_finalize)), 30 SECONDS)

/area/event/library/finall/proc/sec_finalize()
	for(var/mob/living/carbon/human/player in GLOB.alive_player_list)
		shake_camera(player, 20 SECONDS, 2)
	addtimer(CALLBACK(src, PROC_REF(end_finalize)), 20 SECONDS)

/area/event/library/finall/proc/third_finalize()
	for(var/mob/living/carbon/human/player in GLOB.alive_player_list)
		shake_camera(player, 12 SECONDS, 3)
	addtimer(CALLBACK(src, PROC_REF(end_finalize)), 12 SECONDS)

/area/event/library/finall/proc/end_finalize()
	for(var/mob/living/carbon/human/player in GLOB.alive_player_list)
		player.addmrak()
		player.forceMove(pick(SSjob.library_exit))
		addtimer(CALLBACK(player, TYPE_PROC_REF(/mob/living/carbon/human, removemrak)), 1.5 SECONDS)

/area/event/laboratory_entrance

/area/event/laboratory_final
