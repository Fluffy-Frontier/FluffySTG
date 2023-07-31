#define DEFAULT_IN_HAND_OFFSET_X 3
#define DEFAULT_IN_HAND_OFFSET_Y 0

/datum/component/riding/creature/human
	//Рука в которой будет находится взятый моб
	var/obj/item/bodypart/used_hand

// Расширяем инициализацию.
/datum/component/riding/creature/human/Initialize(mob/living/riding_mob, force, ride_check_flags, potion_boost)
	. = ..()
	var/mob/living/carbon/human/human_parent = parent
	if(ride_check_flags & CARRIER_NEEDS_ARM && HAS_TRAIT(riding_mob, TRAIT_CAN_BUCKLED_TO_HAND))
		human_parent.buckle_lying = 0
		used_hand = human_parent.get_active_hand()
		ADD_TRAIT(riding_mob, TRAIT_UNDENSE, VEHICLE_TRAIT)


/datum/component/riding/creature/human/vehicle_mob_unbuckle(datum/source, mob/living/former_rider, force = FALSE)
	. = ..()
	if((ride_check_flags & CARRIER_NEEDS_ARM) && HAS_TRAIT(former_rider, TRAIT_CAN_BUCKLED_TO_HAND))
		former_rider.set_density(TRUE)
		REMOVE_TRAIT(former_rider, TRAIT_UNDENSE, VEHICLE_TRAIT)

//Хэндлинг положения в руке
/datum/component/riding/creature/human/handle_vehicle_offsets(dir)
	. = ..()
	var/mob/living/carbon/human/human_parent = parent

	for(var/mob/living/rider in human_parent.buckled_mobs)
		if(!HAS_TRAIT(rider, TRAIT_CAN_BUCKLED_TO_HAND))
			continue

		var/target_pixel_y = DEFAULT_IN_HAND_OFFSET_X
		var/target_pixel_x = DEFAULT_IN_HAND_OFFSET_Y
		var/offset_hand = used_hand.body_zone

		if(dir == NORTH && offset_hand == BODY_ZONE_L_ARM)
			target_pixel_x += -6
		else if(dir == NORTH && offset_hand == BODY_ZONE_R_ARM)
			target_pixel_x += 6
		else if(dir == SOUTH && offset_hand == BODY_ZONE_L_ARM)
			target_pixel_x += 6
		else if(dir == SOUTH && offset_hand == BODY_ZONE_R_ARM)
			target_pixel_x += -6
		else if(dir == EAST)
			target_pixel_x += 3
		else
			target_pixel_x += -3

		rider.pixel_y = target_pixel_y
		rider.pixel_x = target_pixel_x

/datum/component/riding/creature/human/handle_vehicle_layer(dir)
	. = ..()
	var/mob/living/carbon/human/human_parent = parent

	for(var/mob/living/rider in human_parent.buckled_mobs)
		if(!HAS_TRAIT(rider, TRAIT_CAN_BUCKLED_TO_HAND))
			continue
		var/target_layer = MOB_ABOVE_PIGGYBACK_LAYER + 0.10
		if(dir == NORTH)
			target_layer -= 0.30
		rider.layer = target_layer
