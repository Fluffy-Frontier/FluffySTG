/*
/datum/action/cooldown/necro/psy/sense
	name = "Sense Survivors"
	desc = "Senses for living survivors and sentient creatures in the world. The Marker automatically does this on activation. Recommend to use if the necromorphs cannot find the last survivors."
	button_icon_state = "scry"
	cost = 250
	cooldown_time = 20 MINUTES //You probably only have to use this ability once in a round, so the cooldown will be big
	marker_flags = SIGNAL_ABILITY_POST_ACTIVATION|SIGNAL_ABILITY_MARKER_ONLY

//This just is a roundabout way for the master signal to add to the survivor list mid-round
/datum/action/cooldown/necro/psy/sense/Activate(atom/target)
	var/mob/eye/marker_signal/called = owner
	called.marker.sense_survivors()
*/
