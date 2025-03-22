/datum/action/cooldown/mob_cooldown/charge/necro
	name = "Charge"
	desc = "Allows you to charge at a chosen position."
	cooldown_time = 10 SECONDS
	click_to_activate = TRUE
	charge_delay = 2 SECONDS
	charge_speed = 0.1 SECONDS
	charge_distance = 14
	charge_damage = 0
	var/atom/target_atom

/datum/action/cooldown/mob_cooldown/charge/necro/PreActivate(atom/target)
	var/mob/living/carbon/human/necromorph/charger = owner
	var/turf/T = get_turf(target)
	if(!T)
		return FALSE
	if(charger.resting)
		to_chat(charger, span_notice("You cannot charge while on the floor!"))
		return FALSE
	if(!ishuman(target))
		for(var/mob/living/carbon/human/hummie in view(1, T))
			if(!isnecromorph(hummie))
				target = hummie
				break
	if(target == owner || isnecromorph(target))
		return FALSE

	target_atom = target

	return ..()

/datum/action/cooldown/mob_cooldown/charge/necro/Activate(atom/target)
	var/mob/living/carbon/human/necromorph/user = owner
	var/initial_transform = matrix(user.transform)
	var/initial_x = user.pixel_x
	var/initial_y = user.pixel_y
	var/shake_dir
	shake_dir = pick(-1, 1)
	user.play_necro_sound(SOUND_SHOUT, VOLUME_MID, TRUE, 3)
	animate(
		user,
		pixel_x = (3 * shake_dir),
		pixel_y = (2 * shake_dir),
		time = 1
	)
	animate(
		pixel_x = initial_x,
		pixel_y = initial_y,
		time = 2,
		easing = ELASTIC_EASING
	)
	PLAY_SHAKING_ANIMATION(user, 7, 5, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 10, 6, shake_dir, initial_x, initial_y, initial_transform)
	return ..()
/*
/datum/action/cooldown/mob_cooldown/charge/necro/proc/do_charge()
	var/mob/living/carbon/human/necromorph/charger = owner

	actively_moving = FALSE
	charger.charging = TRUE
	RegisterSignal(charger, COMSIG_MOVABLE_BUMP, PROC_REF(on_bump))
	RegisterSignal(charger, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_move))
	RegisterSignal(charger, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	charger.setDir(get_dir(charger, target_atom))
	do_charge_indicator(target_atom)

	var/datum/move_loop/new_loop = GLOB.move_manager.move_towards(charger, target_atom, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)
	if(!new_loop)
		UnregisterSignal(charger, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED))
		return
	RegisterSignal(new_loop, COMSIG_MOVELOOP_PREPROCESS_CHECK, PROC_REF(pre_move))
	RegisterSignal(new_loop, COMSIG_MOVELOOP_POSTPROCESS, PROC_REF(post_move))
	RegisterSignal(new_loop, COMSIG_MOVELOOP_STOP, PROC_REF(charge_end))
	RegisterSignal(charger, COMSIG_MOB_STATCHANGE, PROC_REF(stat_changed))
	RegisterSignal(charger, COMSIG_LIVING_UPDATED_RESTING, PROC_REF(update_resting))

	SEND_SIGNAL(charger, COMSIG_STARTED_CHARGE)
*/

/datum/action/cooldown/mob_cooldown/charge/necro/do_charge_indicator(atom/charge_target)
	return

/datum/action/cooldown/mob_cooldown/charge/necro/on_move(atom/source, atom/new_loc)
	if(!actively_moving)
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/action/cooldown/mob_cooldown/charge/necro/on_moved(atom/source)
	//Light shake with each step
	shake_camera(source, 1.5, 0.5)

/datum/action/cooldown/mob_cooldown/charge/necro/on_bump(atom/movable/source, atom/target)
	if(target)
		if(ismob(target) || target.uses_integrity)
			hit_target(source, target)

/datum/action/cooldown/mob_cooldown/charge/necro/hit_target(mob/living/carbon/human/necromorph/source, mob/living/target, damage_dealt)
	target.attack_necromorph(source)
	if(iscarbon(target))
		var/mob/living/carbon/human/human_target = target
		if(human_target.check_block(source, 0, "the [source.name]", attack_type = LEAP_ATTACK))
			source.Stun(6)
			shake_camera(source, 4, 3)
			shake_camera(target, 2, 1)
			return
		shake_camera(target, 4, 3)
		shake_camera(source, 2, 3)
		target.visible_message(
			span_danger("[source] slams into [target]!"),
			span_userdanger("[source] tramples you onto the ground!")
			)
		target.Knockdown(6)
		target.drop_all_held_items()
		GLOB.move_manager.stop_looping(source)
	else
		source.visible_message(span_danger("[source] smashes into [target]!"))
		shake_camera(source, 4, 3)
		source.Stun(6)
