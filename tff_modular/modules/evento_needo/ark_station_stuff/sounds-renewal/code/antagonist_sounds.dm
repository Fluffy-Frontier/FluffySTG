//// Звуки при получении антагониста

/datum/antagonist/pirate/greet()
	. = ..()
	SEND_SOUND(owner.current, sound('tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/antag/pirate.ogg'))

/datum/antagonist/rev
	stinger_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/antag/revolution.ogg'

/datum/antagonist/cop/greet()
	. = ..()
	SEND_SOUND(owner.current, sound('tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/antag/nri_spawn.ogg'))

/datum/antagonist/nukeop
	stinger_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/antag/nuketeam.ogg'

//////////////////// Звуки при появлении ОБР

/datum/ert
	var/ert_sound = 'modular_nova/modules/alerts/sound/alerts/yesert.ogg'

/datum/ert/nri
	ert_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sounds-renewal/sound/ert/nri_send.ogg'
