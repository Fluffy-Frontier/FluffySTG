/obj/item/binoculars/rangefinder
	name = "rangefinder"
	desc = "A pair of binoculars with a rangefinding function. Ctrl + Click turf to acquire it's coordinates. Ctrl + Click rangefinder to stop lasing."
	icon = 'tff_modular/modules/mortar/icons/items.dmi'
	icon_state = "rangefinder"
	inhand_icon_state = "rangefinder"
	lefthand_file = 'tff_modular/modules/mortar/icons/shells_lefthand.dmi'
	righthand_file = 'tff_modular/modules/mortar/icons/shells_righthand.dmi'

	var/last_x = "UNKNOWN"
	var/last_y = "UNKNOWN"
	var/next_time_use = 0
	var/use_cooldown = 3 SECONDS

	var/debug = FALSE

/obj/item/binoculars/rangefinder/examine(mob/user)
	. = ..()
	. += span_boldnotice("The rangefinder reads: LONGITUDE [last_x], LATITUDE [last_y].")

/obj/item/binoculars/rangefinder/on_wield(obj/item/source, mob/user)
	. = ..()
	inhand_icon_state = "rangefinder_wielded"

/obj/item/binoculars/rangefinder/on_unwield(obj/item/source, mob/user)
	. = ..()
	inhand_icon_state = "rangefinder"

/obj/item/binoculars/rangefinder/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(user.stat != CONSCIOUS)
		to_chat(user, span_warning("You cannot use [src] while incapacitated."))
		return FALSE
	if(world.time < next_time_use)
		to_chat(user, span_warning("[src]'s laser battery is recharging."))
		return FALSE
	var/atom/target_atom
	if(istype(interacting_with, /atom/movable/screen/fullscreen/cursor_catcher))
		var/atom/movable/screen/fullscreen/cursor_catcher/cursor_catcher = interacting_with
		target_atom = cursor_catcher.given_turf
	else
		target_atom = interacting_with

	if(user.z != target_atom.z)
		to_chat(user, span_warning("You cannot get a direct laser from where you are."))
		return FALSE
	if(!is_in_sight(user, target_atom))
		to_chat(user, span_warning("There is something in the way of the laser!"))
		return FALSE

	acquire_target(target_atom, user)
	next_time_use = world.time + use_cooldown
	return TRUE

/obj/item/binoculars/rangefinder/proc/acquire_target(atom/targeted_atom, mob/user)
	var/turf/TU = get_turf(targeted_atom)
	var/distance = get_dist(TU, get_turf(user))
	if(TU.z != user.z || distance == -1)
		to_chat(user, span_warning("You can't focus properly through \the [src] while looking through something else."))
		return

	playsound(src, 'sound/items/night_vision_on.ogg', 35)
	new /obj/effect/temp_visual/laser_target(TU)
	acquire_coordinates(targeted_atom, user)

/obj/item/binoculars/rangefinder/proc/acquire_coordinates(atom/A, mob/user)
	var/turf/TU = get_turf(A)
	last_x = obfuscate_x(TU.x)
	last_y = obfuscate_y(TU.y)
	to_chat(user, span_boldnotice("COORDINATES: LONGITUDE [last_x]. LATITUDE [last_y]."))
	if(debug)
		var/turf/current_turf = get_turf(src)
		to_chat(user, span_notice("([deobfuscate_x(last_x)]:[deobfuscate_y(last_y)])	{([current_turf.x]:[current_turf.y])"))


/obj/effect/temp_visual/laser_target
	name = "laser"
	icon = 'tff_modular/modules/mortar/icons/items.dmi'
	icon_state = "laser_target_coordinate"
	duration = 50
