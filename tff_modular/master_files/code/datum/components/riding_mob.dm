/datum/component/riding/creature/human
	var/is_hand_buckle = FALSE

/datum/component/riding/creature/human/Initialize(mob/living/riding_mob, force, ride_check_flags, potion_boost)
	. = ..()
	var/mob/living/carbon/human/human_parent = parent
	if(ride_check_flags & CARRIER_NEEDS_ARM && (HAS_TRAIT(riding_mob, TRAIT_CAN_BUCKLED_TO_HAND) || HAS_TRAIT(human_parent, TRAIT_OVERSIZED)))
		human_parent.buckle_lying = 0
		riding_mob.set_density(FALSE)
		is_hand_buckle = TRUE
	else
		is_hand_buckle = FALSE


/datum/component/riding/creature/human/handle_vehicle_offsets(dir)
	. = ..()
	if(!is_hand_buckle)
		return

	var/mob/living/carbon/human/human_parent = parent
	var/mob/living/buckled_mob
	for(var/mob/living/r in human_parent.buckled_mobs)
		buckled_mob = r

	var/target_pixel_y = 3
	var/target_pixel_x = 0

	var/i_hand_index = human_parent.get_inactive_hand_index()
	var/offset_hand

	if(i_hand_index == 1)
		offset_hand = HAND_RIGHT
	else
		offset_hand = HAND_LEFT

	if(dir == NORTH && offset_hand == HAND_LEFT)
		target_pixel_x += -6
	else if(dir == NORTH && offset_hand == HAND_RIGHT )
		target_pixel_x += 6
	else if(dir == SOUTH && offset_hand == HAND_LEFT)
		target_pixel_x += 6
	else if(dir == SOUTH && offset_hand == HAND_RIGHT)
		target_pixel_x += -6
	else if(dir == EAST)
		target_pixel_x += 3
	else
		target_pixel_x += -3

	buckled_mob.pixel_y = target_pixel_y
	buckled_mob.pixel_x = target_pixel_x

/datum/component/riding/creature/human/handle_vehicle_layer(dir)
	. = ..()
	if(!is_hand_buckle)
		return

	var/mob/living/carbon/human/human_parent = parent
	var/mob/living/buckled_mob
	for(var/mob/living/r in human_parent.buckled_mobs)
		buckled_mob = r

	var/target_layer = MOB_ABOVE_PIGGYBACK_LAYER + 0.10
	if(dir == NORTH)
		target_layer -= 0.30

	buckled_mob.layer = target_layer


