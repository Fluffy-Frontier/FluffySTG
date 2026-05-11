/datum/component/riding/creature/chokobo
	require_minigame = FALSE
	uses_native_speed = TRUE
	ride_check_flags = RIDER_NEEDS_ARM | UNBUCKLE_DISABLED_RIDER

/datum/component/riding/creature/chokobo/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	return list(
		TEXT_NORTH = list(-1, 7),
		TEXT_SOUTH = list(0, 10),
		TEXT_EAST =  list(0, 7),
		TEXT_WEST =  list(0, 7),
	)

/datum/component/riding/creature/chokobo/get_parent_offsets_and_layers()
	return list(
		TEXT_NORTH = list(0, 0, MOB_ABOVE_PIGGYBACK_LAYER),
		TEXT_SOUTH = list(0, 0, MOB_ABOVE_PIGGYBACK_LAYER),
		TEXT_EAST =  list(0, 0, MOB_BELOW_PIGGYBACK_LAYER),
		TEXT_WEST =  list(0, 0, MOB_BELOW_PIGGYBACK_LAYER),
	)
