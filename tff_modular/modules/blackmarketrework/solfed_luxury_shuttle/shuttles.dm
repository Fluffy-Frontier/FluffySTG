/datum/map_template/shuttle/ruin/solfed_luxury
	prefix = "_maps/shuttles/nova/"
	suffix = "solfed_luxury"
	description = "A luxurious Solar Federation space exploration vessel."
	name = "'Serenity II'"

/obj/machinery/computer/shuttle/serenity2
	name = "FSC 'Serenity II' Console"
	desc = "Used to control the FSC 'Serenity II'."
	circuit = /obj/item/circuitboard/computer/serenity2
	shuttleId = "serenity2"
	possible_destinations = "serenity2_home;serenity2_custom;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/serenity2
	name = "FSC 'Serenity II' Navigation Computer"
	desc = "Used to designate a precise transit location for the FSC 'Serenity II'."
	shuttleId = "serenity2"
	lock_override = NONE
	shuttlePortId = "serenity2_custom"
	jump_to_ports = list("serenity2_home" = 1, "whiteship_home" = 1)
	view_range = 0
	x_offset = 5
	y_offset = 1

/obj/item/circuitboard/computer/serenity2
	name = "FSC 'Serenity II' Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/serenity2

/area/shuttle/serenity2
	name = "FSC 'Serenity II'"
	requires_power = FALSE
	fire_detect = FALSE
	forced_ambience = TRUE
	ambient_buzz_vol = 15
	ambientsounds = list('modular_nova/modules/encounters/sounds/alarm_radio.ogg',
						'modular_nova/modules/encounters/sounds/alarm_small_09.ogg',
						'modular_nova/modules/encounters/sounds/gear_loop.ogg',
						'modular_nova/modules/encounters/sounds/gear_start.ogg',
						'modular_nova/modules/encounters/sounds/gear_stop.ogg',
						'modular_nova/modules/encounters/sounds/intercom_loop.ogg')

/area/shuttle/serenity2/cockpit
    name = "FSC 'Serenity II' Control Room"

/area/shuttle/serenity2/midship
    name = "FSC 'Serenity II' Midship Compartment"

/area/shuttle/serenity2/kitchen
    name = "FSC 'Serenity II' Kitchen"

/area/shuttle/serenity2/restroom
    name = "FSC 'Serenity II' Restroom"

/obj/docking_port/stationary/serenity2
	name = "SolFed Docking Port"
	shuttle_id = "serenity2_home"
	roundstart_template = /datum/map_template/shuttle/ruin/solfed_luxury
	dir = EAST
	width = 12
	height = 20
	dwidth = 0
	dheight = 0

/obj/docking_port/mobile/serenity2
	callTime = 15 SECONDS
	can_move_docking_ports = TRUE
	shuttle_id = "serenity2"
	launch_status = 0
	movement_force = list("KNOCKDOWN"=0,"THROW"=0)
	name = "FSC 'Serenity II'"
	port_direction = EAST
	preferred_direction = NORTH
	shuttle_areas = list(
		/area/shuttle/serenity2,
		/area/shuttle/serenity2/cockpit,
		/area/shuttle/serenity2/midship,
		/area/shuttle/serenity2/kitchen,
		/area/shuttle/serenity2/restroom
    )

/obj/item/disk/holodisk/ruin/space/solfed_outpost
	name = "sole holotape of the crashlander"
	desc = "A holodisk containing a small memo."
	preset_image_type = /datum/preset_holoimage/engineer
	preset_record_text = {"
		NAME Crashlander
		SOUND PING
		DELAY 20
		SAY ...-O.
		DELAY 50
		SAY Shit, the audio got cut.
		DELAY 30
		SAY Guess that's what you get for using a holotape that survived an EMP blast...
		DELAY 50
		SAY Well, either way...
		DELAY 30
		SAY I, uh-... My station got destroyed. Blasted into a million bits.
		DELAY 40
		SAY Reduced to a mere nebula of itself.
		DELAY 50
		SAY Thankfully, I managed to get to the escape pods just barely in time...
		DELAY 50
		SAY Then... My pod crashed into this asteroid, probably due to its navigation system getting scrambled in the blast.
		DELAY 60
		SAY Thankfully, was already sitting in an emergency spacesuit, so I'm more or less unharmed, though a little traumatized.
		DELAY 60
		SAY And now, after making an escape out of that scrap pile of a pod, I, uh...
		DELAY 50
		SAY Found an entrance inside of this old 'n mothballed outpost in the middle of nowhere.
		DELAY 50
		SAY ...I mean, it looks kind of abandoned - it's all dusty, power's out, nobody's out here to greet me, uh...
		DELAY 50
		SAY Judging by the emblems and flags on the walls, it's probably some old SolFed shuttle depot.
		DELAY 50
		SAY Must've been ages since the last time this whole place had anybody step a foot inside of it.
		DELAY 50
		SAY Now, I still haven't finished taking a look at this wreck of a place, but...
		DELAY 50
		SAY While looking around through windows I think what I saw was an actual SolFed shuttle - got the insignias 'n all.
		DELAY 50
		SAY Granted, it probably requires some repair first before it flies, but there's nothing those gold hands of yours truly can't do, eh?
		DELAY 60
		SAY So-o... Guess things are actually clearing up now - I think it's all up the hill from now on.
		DELAY 50
		SAY Anyways, enough of me blabbering. Back to work, I guess. First time I'm venting to a holotape, sheesh...
		DELAY 50
		SOUND sparks
	"}

