// Звуки оружия

/obj/item/gun/ballistic/shotgun
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/gunshotshotgunshot.ogg'
	load_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/shotguninsert.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/shotgun_pump.ogg'

/obj/item/gun/ballistic/shotgun/riot/sol
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/gunshotshotgunshot.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/shotgun_pump.ogg'

/obj/item/gun/ballistic/revolver
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/revolvershot.ogg'

/obj/item/gun/ballistic/automatic
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/gunshot_smg_alt.ogg'

/obj/item/gun/ballistic/automatic/sol_smg
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/gunshot_smg_alt.ogg'

/obj/item/gun/ballistic/automatic/l6_saw
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/lmgshot.ogg'

/obj/item/ammo_casing/energy
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/laser.ogg'

/obj/item/ammo_casing/laser
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/laser.ogg'

/obj/item/ammo_casing/energy/lasergun/carbine
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/laser.ogg'

/obj/item/ammo_casing/energy/laser/heavy
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/laser.ogg'

/obj/item/ammo_casing/energy/xray
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/laser.ogg'

/obj/item/ammo_casing/energy/laser/microfusion
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/laser.ogg'

/datum/looping_sound/chainsaw
	start_sound = list('tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/chainsawstart.ogg' = 1)
	start_length = 4 SECONDS

// /obj/item/chainsaw/attack_self(mob/user)
// 	. = ..()
// 	if(on)
// 		playsound(src, 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/chainsawstart.ogg', 65, 1)

// 	if(on)
// 		hitsound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/weapons/chainsawhit.ogg'
// 		chainsaw_loop.start()
// 	else
// 		hitsound = SFX_SWING_HIT
// 		chainsaw_loop.stop()


// Код для добавления/изменения аннонсов и их звучания

/* У Новы так же.
/datum/centcom_announcer/default
	welcome_sounds = list('sound/ai/default/welcome.ogg')
	alert_sounds = list('modular_nova/modules/alerts/sound/alerts/alert2.ogg')
	command_report_sounds = list('modular_nova/modules/alerts/sound/alerts/commandreport.ogg')
	event_sounds = list(
		ANNOUNCER_AIMALF = 'sound/ai/default/aimalf.ogg',
		ANNOUNCER_ALIENS = 'modular_nova/modules/alerts/sound/alerts/lifesigns.ogg',
		ANNOUNCER_ANIMES = 'modular_nova/modules/alerts/sound/alerts/animes.ogg',
		ANNOUNCER_INTERCEPT = 'modular_nova/modules/alerts/sound/alerts/alert2.ogg',
		ANNOUNCER_IONSTORM = 'modular_nova/modules/alerts/sound/alerts/ionstorm.ogg',
		ANNOUNCER_METEORS = 'modular_nova/modules/alerts/sound/alerts/meteors.ogg',
		ANNOUNCER_OUTBREAK5 = 'modular_nova/modules/alerts/sound/alerts/outbreak5.ogg',
		ANNOUNCER_OUTBREAK6 = 'modular_nova/modules/alerts/sound/alerts/alert3.ogg',
		ANNOUNCER_OUTBREAK7 = 'modular_nova/modules/alerts/sound/alerts/outbreak7.ogg',
		ANNOUNCER_POWEROFF = 'modular_nova/modules/alerts/sound/alerts/poweroff.ogg',
		ANNOUNCER_POWERON = 'modular_nova/modules/alerts/sound/alerts/poweron.ogg',
		ANNOUNCER_RADIATION = 'modular_nova/modules/alerts/sound/alerts/radiation.ogg',
		ANNOUNCER_RADIATIONPASSED = 'modular_nova/modules/alerts/sound/alerts/radpassed.ogg',
		ANNOUNCER_SHUTTLECALLED = 'modular_nova/modules/alerts/sound/alerts/crew_shuttle_called.ogg',
		ANNOUNCER_SHUTTLEDOCK = 'modular_nova/modules/alerts/sound/alerts/crew_shuttle_docked.ogg',
		ANNOUNCER_SHUTTLERECALLED = 'modular_nova/modules/alerts/sound/alerts/crew_shuttle_recalled.ogg',
		ANNOUNCER_SHUTTLELEFT = 'modular_nova/modules/alerts/sound/alerts/crew_shuttle_left.ogg',
		ANNOUNCER_ANOMALIES = 'modular_nova/modules/alerts/sound/alerts/alert2.ogg',
		ANNOUNCER_GRAVANOMALIES= 'modular_nova/modules/alerts/sound/alerts/gravanomalies.ogg',
		ANNOUNCER_SPANOMALIES = 'modular_nova/modules/alerts/sound/alerts/wormholes.ogg',
		ANNOUNCER_VORTEXANOMALIES = 'modular_nova/modules/alerts/sound/alerts/vortex.ogg',
		ANNOUNCER_MASSIVEBSPACEANOMALIES = 'modular_nova/modules/alerts/sound/alerts/bluespace_anomalies.ogg',
		ANNOUNCER_TRANSLOCATION = 'modular_nova/modules/alerts/sound/alerts/transolcation.ogg',
		ANNOUNCER_FLUXANOMALIES = 'modular_nova/modules/alerts/sound/alerts/flux.ogg',
		ANNOUNCER_PYROANOMALIES = 'modular_nova/modules/alerts/sound/alerts/pyr_anomalies.ogg',
		ANNOUNCER_CARP = 'modular_nova/modules/alerts/sound/alerts/carps.ogg',
		ANNOUNCER_BLUESPACEARTY = 'modular_nova/modules/alerts/sound/alerts/artillery.ogg',
		ANNOUNCER_CAPTAIN = 'modular_nova/modules/alerts/sound/alerts/announce.ogg',
		ANNOUNCER_GRAVGENOFF = 'modular_nova/modules/alerts/sound/alerts/gravityoff.ogg',
		ANNOUNCER_GRAVGENON = 'modular_nova/modules/alerts/sound/alerts/gravityon.ogg',
		ANNOUNCER_GREYTIDE = 'modular_nova/modules/alerts/sound/alerts/greytide.ogg',
		ANNOUNCER_COMMSBLACKOUT = 'modular_nova/modules/alerts/sound/alerts/commsblackout.ogg',
		ANNOUNCER_ELECTRICALSTORM = 'modular_nova/modules/alerts/sound/alerts/estorm.ogg',
		ANNOUNCER_BRANDINTELLIGENCE = 'modular_nova/modules/alerts/sound/alerts/rampant_brand_int.ogg',
		ANNOUNCER_SPOOKY = 'modular_nova/modules/alerts/sound/misc/admin_horror_music.ogg',
		ANNOUNCER_ERTYES = 'modular_nova/modules/alerts/sound/alerts/yesert.ogg',
		ANNOUNCER_MUTANTS = 'modular_nova/modules/alerts/sound/alerts/hazdet.ogg',
		ANNOUNCER_KLAXON = 'modularz_arkstation/modules/black_mesa/sound/siren1_long.ogg',
		// ANNOUNCER_ICARUS = 'modular_nova/modules/assault_operatives/sound/icarus_alarm.ogg',
		ANNOUNCER_NRI_RAIDERS = 'modular_nova/modules/encounters/sounds/morse.ogg',
		ANNOUNCER_DEPARTMENTAL = 'modular_nova/modules/alerts/sound/alerts/alert3.ogg',
		ANNOUNCER_SHUTTLE = 'modular_nova/modules/alerts/sound/alerts/alert3.ogg',
		)
*/

//////// Шлюзы и прочее

/obj/machinery/door/airlock
	doorDeni = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/machines/deniedbeep.ogg'

//////////////////// Зоны, эмбиенты

// /area
// 	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/shipambience.ogg'

/area/station/maintenance
	ambient_buzz = 'sound/ambience/maintenance/maintambience.ogg'
	ambient_buzz_vol = 20

// SCIENCE
/area/station/science
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/sci.ogg'
	ambient_buzz_vol = 20

/area/station/command/heads_quarters/rd
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/sci.ogg'
	ambient_buzz_vol = 20

// MEDICAL
/area/station/medical
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/med.ogg'
	ambient_buzz_vol = 20

/area/station/command/heads_quarters/cmo
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/med.ogg'
	ambient_buzz_vol = 20

/area/station/medical/surgery
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/med_sur.ogg'
	ambient_buzz_vol = 20

/area/station/medical/psychology
	ambient_buzz = 'sound/ambience/misc/ticking_clock.ogg'
	ambient_buzz_vol = 10
	ambientsounds = null

// CHAPEL
/area/station/service/chapel
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/church.ogg'
	ambient_buzz_vol = 25
	ambientsounds = list('tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/church-bell1.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/church-bell2.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/church-cross1.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/church-cross2.ogg',
						'sound/ambience/holy/ambicha1.ogg',
						'sound/ambience/holy/ambicha2.ogg',
						'sound/ambience/holy/ambicha3.ogg',
						'sound/ambience/holy/ambicha4.ogg',
						'sound/ambience/holy/ambiholy.ogg',
						'sound/ambience/holy/ambiholy2.ogg',
						'sound/ambience/holy/ambiholy3.ogg')
	min_ambience_cooldown = 35 SECONDS
	max_ambience_cooldown = 65 SECONDS

// SECURITY
/area/station/security
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/security.ogg'
	ambient_buzz_vol = 15

/area/station/command/heads_quarters/hos
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/security.ogg'
	ambient_buzz_vol = 15

// ENGINEERING
/area/station/engineering
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/engineering.ogg'
	ambient_buzz_vol = 15

/area/station/construction
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/engineering.ogg'
	ambient_buzz_vol = 15

// ATMOS
/area/station/engineering/atmos
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/atmos.ogg'
	ambient_buzz_vol = 10

// AI and TELECOMMS

/area/station/tcommsat
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/tcommsat.ogg'
	ambient_buzz_vol = 15

GLOBAL_LIST_INIT(space_ambience_ark,list(
	'modular_nova/master_files/sound/ambience/starlight.ogg', //NOVA EDIT ADDITION
	'sound/ambience/engineering/ambiatmos.ogg',
	'sound/ambience/space/ambispace.ogg',
	'sound/ambience/space/ambispace2.ogg',
	'sound/ambience/space/ambispace3.ogg',
	'sound/ambience/space/ambispace4.ogg',
	'sound/ambience/space/ambispace5.ogg',
	'sound/ambience/space/ambispace6.ogg',
	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/space/space1.ogg',
	'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/space/space2.ogg',
))

// MISC
/area/shuttle
	ambient_buzz = 'modular_nova/modules/encounters/sounds/amb_ship_01.ogg'
	ambient_buzz_vol = 15
	ambientsounds = list('modular_nova/modules/encounters/sounds/alarm_radio.ogg',
						'modular_nova/modules/encounters/sounds/alarm_small_09.ogg',
						'modular_nova/modules/encounters/sounds/gear_loop.ogg',
						'modular_nova/modules/encounters/sounds/gear_start.ogg',
						'modular_nova/modules/encounters/sounds/gear_stop.ogg',
						'modular_nova/modules/encounters/sounds/intercom_loop.ogg')
	min_ambience_cooldown = 15 SECONDS
	max_ambience_cooldown = 25 SECONDS

/area/shuttle/pirate/nri
	name = "NRI Starship"
	ambient_buzz = 'modular_nova/modules/encounters/sounds/amb_ship_01.ogg'
	ambient_buzz_vol = 15
	min_ambience_cooldown = 15 SECONDS
	max_ambience_cooldown = 25 SECONDS
	ambientsounds = list('modular_nova/modules/encounters/sounds/alarm_radio.ogg',
						'modular_nova/modules/encounters/sounds/alarm_small_09.ogg',
						'modular_nova/modules/encounters/sounds/gear_loop.ogg',
						'modular_nova/modules/encounters/sounds/gear_start.ogg',
						'modular_nova/modules/encounters/sounds/gear_stop.ogg',
						'modular_nova/modules/encounters/sounds/intercom_loop.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/radio/1.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/radio/2.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/radio/3.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/radio/4.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/radio/5.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/radio/6.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/radio/7.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/radio/8.ogg',
						'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/radio/9.ogg')

/area/awaymission/beach
	forced_ambience = TRUE
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/beach.ogg'
	ambient_buzz_vol = 25

/area/centcom/syndicate_mothership
	ambient_buzz = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ambience/stadium.ogg'
	ambient_buzz_vol = 15
	min_ambience_cooldown = 15 SECONDS
	max_ambience_cooldown = 25 SECONDS
	ambientsounds = list('modular_nova/modules/encounters/sounds/alarm_radio.ogg',
						'modular_nova/modules/encounters/sounds/alarm_small_09.ogg',
						'modular_nova/modules/encounters/sounds/gear_loop.ogg',
						'modular_nova/modules/encounters/sounds/gear_start.ogg',
						'modular_nova/modules/encounters/sounds/gear_stop.ogg',
						'modular_nova/modules/encounters/sounds/intercom_loop.ogg')

