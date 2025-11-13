/datum/component/automatic_fire
	var/enabled = TRUE

/datum/component/automatic_fire/proc/disable_autofire(datum/source)
	enabled = FALSE

/datum/component/automatic_fire/proc/enable_autofire(datum/source)
	enabled = TRUE

/datum/component/automatic_fire/proc/set_autofire_speed(datum/source, newspeed)
	autofire_shot_delay = newspeed
