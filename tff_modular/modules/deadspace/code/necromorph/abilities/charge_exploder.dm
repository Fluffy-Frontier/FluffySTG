/datum/action/cooldown/mob_cooldown/charge/necro/exploder
	cooldown_time = 10 SECONDS
	charge_delay = 1.8 SECONDS
	charge_speed = 0.15 SECONDS

//Totally not ripped from exploder explode
/datum/action/cooldown/mob_cooldown/charge/necro/exploder/Activate(atom/target)
	var/mob/living/carbon/human/necromorph/exploder/user = owner
	var/obj/item/bodypart/arm/left/pustle = user.get_bodypart(BODY_ZONE_L_ARM)
	if(!pustle)
		to_chat(user, span_warning("You have no pustule, KILL!"))
	var/initial_transform = matrix(user.transform)
	var/initial_x = user.pixel_x
	var/initial_y = user.pixel_y
	var/shake_dir
	user.play_necro_sound(SOUND_SHOUT, VOLUME_MID, TRUE, 3)
	//Lots of shaking with increasing frequency and violence

	shake_dir = pick(-1, 1)
	animate(user, transform = turn(user.transform, 4*shake_dir), pixel_x = 5 * shake_dir, pixel_y = (5 * pick(-1, 1)) + 5*shake_dir, time=1)
	animate(transform = initial_transform, pixel_x = initial_x, pixel_y = initial_y, time=2, easing=ELASTIC_EASING)
	PLAY_SHAKING_ANIMATION(user, 7, 5, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 10, 6, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 12, 7, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 14, 8, shake_dir, initial_x, initial_y, initial_transform)
	. = ..()

/datum/action/cooldown/mob_cooldown/charge/necro/exploder/hit_target(mob/living/carbon/human/necromorph/source, mob/living/target)
	if(isliving(target))
		var/mob/living/carbon/human/necromorph/exploder/user = owner
		var/obj/item/bodypart/arm/left/pustle = user.get_bodypart(BODY_ZONE_L_ARM)
		if(!pustle)
			return ..() //You can still charge with no pustule, it will just be a normal attack instead
		GLOB.move_manager.stop_looping(source)
		qdel(pustle) //Sanity check to prevent double explosion
		if(is_enhanced(source))
			explosion(get_turf(source), 0, 3, 4, 5, 7, TRUE, FALSE, FALSE, TRUE, explosion_cause = src) //Big explosion with alot of fire
		else if(!is_enhanced(source))
			explosion(get_turf(source), 0, 2, 3, 2, 5, TRUE, FALSE, FALSE, TRUE, explosion_cause = src) //Deadly proximity, light area
		source.death()
	else
		source.visible_message(span_danger("[source] smashes into [target]!"))
		shake_camera(source, 4, 3)
		source.Knockdown(20)
		source.drop_all_held_items()
