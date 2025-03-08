/datum/action/cooldown/mob_cooldown/charge/necro/execution/infector
	cooldown_time = 10 SECONDS
	charge_delay = 1.8 SECONDS
	var/cached_pass_flags

//Totally not ripped from exploder explode
/datum/action/cooldown/mob_cooldown/charge/necro/execution/infector/Activate(atom/target)
	//The infector can't flap if its missing too many wings. Specifically, it must have at least one, though there are penalties for not having both
	var/mob/living/carbon/human/necromorph/necro = owner
	var/wings = necro.num_hands

	if(wings == 2)
		charge_speed = 1
	else if (wings == 1)
		charge_speed = 2
	else if (wings < 1)
		to_chat(necro, span_danger("You need at least one wing to leap!"))
		return
	/*
	//Do a chargeup animation. Pulls back and down, and then launches forwards
	//The time is equal to the windup time of the attack, plus 0.5 seconds to prevent a brief stop and ensure launching is a fluid motion
	var/vector2/pixel_offset = get_new_vector(0, -6)
	var/vector2/cached_pixels = get_new_vector(src.pixel_x, src.pixel_y)
	animate(src, pixel_x = src.pixel_x + pixel_offset.x, pixel_y = src.pixel_y + pixel_offset.y, time = 0.2 SECONDS, easing = EASE_OUT|CUBIC_EASING, flags = ANIMATION_PARALLEL)
	animate(pixel_x = cached_pixels.x, pixel_y = cached_pixels.y, easing = EASE_IN|CUBIC_EASING, time = 0.2 SECONDS)
	release_vector(pixel_offset)
	release_vector(cached_pixels)
*/
	//Long shout when targeting mobs
	necro.play_necro_sound(SOUND_SHOUT_LONG, VOLUME_MID, TRUE, 3)

	return ..()

/datum/action/cooldown/mob_cooldown/charge/necro/execution/infector/do_charge_indicator(atom/charge_target)
	var/mob/living/carbon/human/necromorph/source = owner
	cached_pass_flags = source.pass_flags

	var/real_dist = max(1, get_dist_euclidean(source, charge_target))
	animate(source, pixel_x = ((charge_target.x - source.x)/real_dist), pixel_y = ((charge_target.y - source.y)/real_dist), time = 1.5 SECONDS, easing = BACK_EASING, flags = ANIMATION_PARALLEL|ANIMATION_RELATIVE)
	animate(pixel_x = source.base_pixel_x, pixel_y = source.base_pixel_y, time = 0.3 SECONDS)

	//The sprite moves up into the air and a bit closer to the camera
	source.pass_flags |= PASSTABLE

/datum/action/cooldown/mob_cooldown/charge/necro/execution/infector/hit_target(mob/living/carbon/human/necromorph/source, mob/living/target)
	if(iscarbon(target))
		var/mob/living/carbon/human/human_target = target
		infector_execution(human_target)
		shake_camera(target, 4, 3)
		shake_camera(source, 2, 3)
		target.visible_message(
			span_danger("[source] slams into [target]!"),
			span_userdanger("[source] starts his execution!")
			)
		target.drop_all_held_items()
		GLOB.move_manager.stop_looping(source)
	else
		return ..()

/*
	Parasite Leap:

	The infector attempts to leap onto a targeted human. If successful, it latches onto them.

	Once attached, it begins probing the skull with its proboscis through repeated light attacks.
	These are affected by armor, a helmet makes it much harder.

	If it manages to deal enough total damage to max out the head's damage capacity, the operation is successful.
	The victim will be converted where they stand into a necromorph, with a higher compatibilty value used

	If the infector is grappled, the attacks are paused.  If it is thrown away or otherwise pulled off the victim, it is cancelled
	Execution will end in failure if the victim loses their head, but succeed if they die during the process from any other means
*/

//Entrypoint
//This calls charge impact on hit, which mounts to the victim, and then starts the execution
/datum/action/cooldown/mob_cooldown/charge/necro/execution/infector/proc/infector_execution(var/atom/target)
	//Leap autotargets enemies within one tile of the clickpoint
	if (!isliving(target))
		target = autotarget_enemy_mob()

	var/mob/living/human = target
	if (!istype(human) || human.body_position == LYING_DOWN || isnecromorph(human))
		to_chat(owner, span_danger("This must target a living, standing human."), MESSAGE_TYPE_LOCALCHAT)
		return

	var/mob/living/carbon/human/necromorph/necro = owner

	var/obj/item/organ/proboscis/proboscis  = necro.get_organ_slot(ORGAN_SLOT_PROBOSCIS)
	if (!proboscis)
		to_chat(necro, span_danger("You need your proboscis to perform this move!"))
		return
	var/datum/component/execution/infector/execute = necro.GetComponent(/datum/component/execution/infector)
	necro.perform_execution(execute, human, necro)
