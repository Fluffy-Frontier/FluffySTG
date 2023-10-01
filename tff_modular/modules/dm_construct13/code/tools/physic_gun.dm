#define TRAIT_PHYSGUN_PAUSE "physgun_pause"

/obj/item/physic_manipulation_tool
	name = "physic gun"
	desc = "A tool for manipulating physics of objects."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver_map"
	inhand_icon_state = "screwdriver"
	worn_icon_state = "screwdriver"
	belt_icon_state = "screwdriver"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 5
	demolition_mod = 0.5
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	drop_sound = 'sound/items/handling/screwdriver_drop.ogg'
	pickup_sound = 'tff_modular/modules/dm_construct13/sound/physgun_pickup.ogg'

	//Обьект, захваченный в данный момент.
	var/atom/movable/handlet_atom
	//Существо, что использует физ ган в данный момент.
	var/mob/living/physgun_user
	//Датум луча, между носителем физ гана и инструмента.
	var/datum/beam/physgun_beam
	//Цвет эффектов физана.
	var/effects_color = COLOR_CARP_BLUE
	//Эффект отслеживающий наш курсор.
	var/atom/movable/screen/fullscreen/cursor_catcher/physgun_catcher

	//Заблокирован ли наш физ ган.
	var/blocked = FALSE
	//Может ли наш физ ган использовать расширенные финкции.
	var/advanced = FALSE

	var/use_cooldown = 3 SECONDS
	COOLDOWN_DECLARE(grab_cooldown)
	var/datum/looping_sound/gravgen/kinesis/phys_gun/loop_sound

/obj/item/physic_manipulation_tool/Initialize(mapload)
	. = ..()
	loop_sound = new(src)

/obj/item/physic_manipulation_tool/Destroy(force)
	. = ..()
	release_atom()
	qdel(loop_sound)

/**
 * Управление захватом.
 */
/obj/item/physic_manipulation_tool/pre_attack(atom/A, mob/living/user, params)
	if(handlet_atom)
		if(A == handlet_atom)
			release_atom(A, user)
			return TRUE
		user.balloon_alert(user, "Busy!")
		return TRUE
	if(istype(A))
		if(!can_catch(A, user))
			playsound(user, 'tff_modular/modules/dm_construct13/sound/physgun_cant_grab.ogg', 100, TRUE)
			return TRUE
		catch_atom(A, user)
		return TRUE

/obj/item/physic_manipulation_tool/pre_attack_secondary(atom/target, mob/living/user, params)
	if(handlet_atom)
		if(advanced)
			pause_atom(target)
			return TRUE
		release_atom()

/obj/item/physic_manipulation_tool/AltClick(mob/user)
	. = ..()
	var/choised_color = input(usr, "Pick new effects color", "Physgun color") as color|null
	effects_color = choised_color

/**
 * Процессинг движения захваченого атома.
 */
/obj/item/physic_manipulation_tool/process(seconds_per_tick)
	if(!physgun_user)
		release_atom()
		return
	if(!range_check(handlet_atom))
		release_atom()
		return
	if(physgun_catcher.mouse_params)
		physgun_catcher.calculate_params()
	if(!physgun_catcher.given_turf)
		return
	physgun_user.setDir(get_dir(physgun_user, handlet_atom))
	if(handlet_atom.loc == physgun_catcher.given_turf)
		if(handlet_atom.pixel_x == physgun_catcher.given_x - world.icon_size/2 && handlet_atom.pixel_y == physgun_catcher.given_y - world.icon_size/2)
			return
		animate(handlet_atom, 0.2 SECONDS, pixel_x = handlet_atom.base_pixel_x + physgun_catcher.given_x - world.icon_size/2, pixel_y = handlet_atom.base_pixel_y + physgun_catcher.given_y - world.icon_size/2)
		physgun_beam.redrawing()
		return
	animate(handlet_atom, 0.2 SECONDS, pixel_x = handlet_atom.base_pixel_x + physgun_catcher.given_x - world.icon_size/2, pixel_y = handlet_atom.base_pixel_y + physgun_catcher.given_y - world.icon_size/2)
	physgun_beam.redrawing()
	var/turf/turf_to_move = get_step_towards(handlet_atom, physgun_catcher.given_turf)
	handlet_atom.Move(turf_to_move, get_dir(handlet_atom, turf_to_move), 8)
	var/pixel_x_change = 0
	var/pixel_y_change = 0
	var/direction = get_dir(handlet_atom, turf_to_move)
	if(direction & NORTH)
		pixel_y_change = world.icon_size/2
	else if(direction & SOUTH)
		pixel_y_change = -world.icon_size/2
	if(direction & EAST)
		pixel_x_change = world.icon_size/2
	else if(direction & WEST)
		pixel_x_change = -world.icon_size/2
	animate(handlet_atom, 0.2 SECONDS, pixel_x = handlet_atom.base_pixel_x + pixel_x_change, pixel_y = handlet_atom.base_pixel_y + pixel_y_change)

/obj/item/physic_manipulation_tool/proc/can_catch(atom/target, mob/user)
	if(target == user)
		return FALSE
	if(!ismovable(target))
		return FALSE
	var/atom/movable/movable_target = target
	if(iseffect(movable_target))
		return FALSE
	if(movable_target.anchored && !HAS_TRAIT(movable_target, TRAIT_PHYSGUN_PAUSE))
		if(!advanced)
			return FALSE
		movable_target.set_anchored(FALSE)
	if(ismob(movable_target))
		if(!isliving(movable_target))
			return FALSE
		var/mob/living/living_target = movable_target
		if(living_target.buckled)
			return FALSE
		if(living_target.client && !advanced)
			return FALSE
	return TRUE

/obj/item/physic_manipulation_tool/proc/range_check(atom/target)
	if(!isturf(physgun_user.loc))
		return FALSE
	if(!can_see(physgun_user, target, 9))
		return FALSE
	return TRUE

/**
 * Захват атома.
 */
/obj/item/physic_manipulation_tool/proc/catch_atom(atom/movable/target, mob/user)
	if(isliving(target))
		target.add_traits(list(TRAIT_HANDS_BLOCKED), REF(src))
	target.movement_type = FLYING
	target.add_filter("physgun", 2, list("type" = "outline", effects_color, "size" = 2))
	physgun_beam = user.Beam(target, "kinesis")
	physgun_beam.beam_color = effects_color
	physgun_catcher = user.overlay_fullscreen("physgun_effect", /atom/movable/screen/fullscreen/cursor_catcher)
	physgun_catcher.assign_to_mob(user)
	handlet_atom = target
	physgun_user = user
	loop_sound.start()
	START_PROCESSING(SSfastprocess, src)

/**
 * Освобождение атома.
 */
/obj/item/physic_manipulation_tool/proc/release_atom()
	if(isliving(handlet_atom))
		handlet_atom.remove_traits(list(TRAIT_HANDS_BLOCKED), REF(src))
	handlet_atom.movement_type = initial(movement_type)
	STOP_PROCESSING(SSfastprocess, src)
	handlet_atom.remove_filter("physgun")
	physgun_catcher = null
	physgun_user.clear_fullscreen("physgun_effect")
	handlet_atom.pixel_x = initial(pixel_x)
	handlet_atom.pixel_y = initial(pixel_y)
	qdel(physgun_beam)
	physgun_user = null
	handlet_atom = null
	loop_sound.stop()

/**
 * Пауза атома.
 * Закрепляет атом в воздухе, блокируя движение и каке либо взаимодействие.
 */

/obj/item/physic_manipulation_tool/proc/pause_atom(atom/movable/target)
	if(isliving(handlet_atom))
		handlet_atom.add_traits(list(TRAIT_IMMOBILIZED), REF(src))
	ADD_TRAIT(handlet_atom, TRAIT_PHYSGUN_PAUSE, REF(src))
	handlet_atom.set_anchored(TRUE)
	STOP_PROCESSING(SSfastprocess, src)
	physgun_catcher = null
	physgun_user.clear_fullscreen("physgun_effect")
	qdel(physgun_beam)
	physgun_user = null
	handlet_atom = null
	loop_sound.stop()

/obj/item/physic_manipulation_tool/proc/repulse(atom/movable/target, mob/user)
	release_atom()
	var/turf/target_turf = get_turf_in_angle(get_angle(user, target), get_turf(user), 10)
	target.throw_at(target_turf, range = 9, speed = target.density ? 3 : 4, thrower = user, spin = isitem(target))
	playsound(user, 'tff_modular/modules/dm_construct13/sound/physgun_repulse.ogg', 100, TRUE)

/datum/looping_sound/gravgen/kinesis/phys_gun
	mid_sounds = list('tff_modular/modules/dm_construct13/sound/physgun_hold_loop.ogg' = 1)
