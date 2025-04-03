/datum/station_trait/announcement_meme
	name = "Announcement Anomalies"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 10000000 // Всегда!!!!!
	show_in_report = TRUE
	report_message = "Communication subsystems seems highly unstable today with bits of external interference."
	blacklist = list(/datum/station_trait/announcement_medbot, /datum/station_trait/birthday, /datum/station_trait/announcement_intern)
	force = TRUE // Я СКАЗАЛ ВСЕГДА!!!!

/datum/station_trait/announcement_meme/New()
	. = ..()
	SSstation.announcer = /datum/centcom_announcer/default/interference_from_ntnet

// помечал минусом те, что не менял
// +- для тех, что менял на один и тот же звук тревоги
/datum/centcom_announcer/default/interference_from_ntnet
	welcome_sounds = list('tff_modular/modules/announcement/sounds/welcome.ogg') //
	alert_sounds = list('tff_modular/modules/announcement/sounds/funny_alarm.ogg') //
	command_report_sounds = list('tff_modular/modules/announcement/sounds/commandreport.ogg') //
	event_sounds = list(
		ANNOUNCER_AIMALF = 'tff_modular/modules/announcement/sounds/aimalfl.ogg', //
		ANNOUNCER_ALIENS = 'tff_modular/modules/announcement/sounds/aliens.ogg', //
		ANNOUNCER_ANIMES = 'modular_nova/modules/alerts/sound/alerts/animes.ogg', // -
		ANNOUNCER_INTERCEPT = 'tff_modular/modules/announcement/sounds/funny_alarm.ogg', //
		ANNOUNCER_IONSTORM = 'tff_modular/modules/announcement/sounds/ion.ogg', //
		ANNOUNCER_METEORS = 'tff_modular/modules/announcement/sounds/meteors.ogg', //
		ANNOUNCER_OUTBREAK5 = 'tff_modular/modules/announcement/sounds/second_warn.ogg', //
		ANNOUNCER_OUTBREAK6 = 'tff_modular/modules/announcement/sounds/funny_alarm.ogg', //
		ANNOUNCER_OUTBREAK7 = 'tff_modular/modules/announcement/sounds/funny_alarm.ogg', //
		ANNOUNCER_POWEROFF = 'tff_modular/modules/announcement/sounds/poweroff.ogg', //
		ANNOUNCER_POWERON = 'modular_nova/modules/alerts/sound/alerts/poweron.ogg', // -
		ANNOUNCER_RADIATION = 'tff_modular/modules/announcement/sounds/radiation.ogg', //
		ANNOUNCER_RADIATIONPASSED = 'tff_modular/modules/announcement/sounds/radpassed.ogg', //
		ANNOUNCER_SHUTTLECALLED = 'modular_nova/modules/alerts/sound/alerts/crew_shuttle_called.ogg', // -
		ANNOUNCER_SHUTTLEDOCK = 'modular_nova/modules/alerts/sound/alerts/crew_shuttle_docked.ogg', // -
		ANNOUNCER_SHUTTLERECALLED = 'modular_nova/modules/alerts/sound/alerts/crew_shuttle_recalled.ogg', // -
		ANNOUNCER_SHUTTLELEFT = 'modular_nova/modules/alerts/sound/alerts/crew_shuttle_left.ogg', // -
		ANNOUNCER_ANOMALIES = 'tff_modular/modules/announcement/sounds/funny_alarm.ogg', //
		ANNOUNCER_GRAVANOMALIES= 'tff_modular/modules/announcement/sounds/funny_alarm.ogg', // +-
		ANNOUNCER_SPANOMALIES = 'tff_modular/modules/announcement/sounds/funny_alarm.ogg', // +-
		ANNOUNCER_VORTEXANOMALIES = 'tff_modular/modules/announcement/sounds/funny_alarm.ogg', // +-
		ANNOUNCER_MASSIVEBSPACEANOMALIES = 'tff_modular/modules/announcement/sounds/bluespace.ogg', //
		ANNOUNCER_TRANSLOCATION = 'tff_modular/modules/announcement/sounds/translocation.ogg', //
		ANNOUNCER_FLUXANOMALIES = 'tff_modular/modules/announcement/sounds/flux.ogg', //
		ANNOUNCER_PYROANOMALIES = 'tff_modular/modules/announcement/sounds/pyro.ogg', //
		ANNOUNCER_CARP = 'tff_modular/modules/announcement/sounds/carps.ogg', //
		ANNOUNCER_BLUESPACEARTY = 'tff_modular/modules/announcement/sounds/artillery.ogg', //
		ANNOUNCER_CAPTAIN = 'tff_modular/modules/announcement/sounds/commandreport.ogg', //
		ANNOUNCER_GRAVGENOFF = 'tff_modular/modules/announcement/sounds/gravityoff.ogg', //
		ANNOUNCER_GRAVGENON = 'tff_modular/modules/announcement/sounds/gravityon.ogg', //
		ANNOUNCER_GREYTIDE = 'tff_modular/modules/announcement/sounds/greytide.ogg', //
		ANNOUNCER_COMMSBLACKOUT = 'tff_modular/modules/announcement/sounds/telecom.ogg', //
		ANNOUNCER_ELECTRICALSTORM = 'tff_modular/modules/announcement/sounds/funny_alarm.ogg', // +-
		ANNOUNCER_BRANDINTELLIGENCE = 'tff_modular/modules/announcement/sounds/assblastusa.ogg', //
		ANNOUNCER_SPOOKY = 'modular_nova/modules/alerts/sound/misc/admin_horror_music.ogg', // -
		ANNOUNCER_ERTYES = 'tff_modular/modules/announcement/sounds/yesert.ogg', //
		ANNOUNCER_MUTANTS = 'tff_modular/modules/announcement/sounds/first_warn.ogg', //
		ANNOUNCER_NRI_RAIDERS = 'tff_modular/modules/announcement/sounds/pirate.ogg', //
		ANNOUNCER_DEPARTMENTAL = 'tff_modular/modules/announcement/sounds/funny_alarm.ogg', //
		ANNOUNCER_SHUTTLE = 'tff_modular/modules/announcement/sounds/funny_alarm.ogg', //
		)
