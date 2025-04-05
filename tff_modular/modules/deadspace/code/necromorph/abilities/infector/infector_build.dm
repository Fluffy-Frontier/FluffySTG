/datum/action/cooldown/necro/corruption/infector
	name = "Lesser generic corruption placement ability"
	cooldown_time = 10 SECONDS

/datum/action/cooldown/necro/corruption/infector/PreActivate(atom/target)
	var/turf/location = get_turf(target)
	if(get_dist(location, owner) > 1)
		to_chat(owner, span_notice("Selected target is too far away from you!"), MESSAGE_TYPE_LOCALCHAT)
		return
	var/mob/living/carbon/human/necromorph/infector/necro = owner
	to_chat(owner, span_danger("Current signal biomass: [necro.marker.signal_biomass]!"), MESSAGE_TYPE_LOCALCHAT)
	return ..()
