/obj/item/binoculars/rangefinder
	name = "rangefinder"
	desc = "A pair of binoculars with a rangefinding function. Ctrl + Click turf to acquire it's coordinates. Ctrl + Click rangefinder to stop lasing."
	icon = 'tff_modular/modules/tgmc_xenos/mortar/icons/items.dmi'
	icon_state = "rangefinder"
	inhand_icon_state = "rangefinder"
	lefthand_file = 'tff_modular/modules/tgmc_xenos/mortar/icons/shells_lefthand.dmi'
	righthand_file = 'tff_modular/modules/tgmc_xenos/mortar/icons/shells_righthand.dmi'

	var/turf/targetturf
	var/last_x = "UNKNOWN"
	var/last_y = "UNKNOWN"

	var/debug = TRUE

/obj/item/binoculars/rangefinder/Destroy(force)
	. = ..()
	targetturf = null

/obj/item/binoculars/rangefinder/examine(mob/user)
	. = ..()
	. += span_notice(span_bold("The rangefinder reads: LONGITUDE [last_x], LATITUDE [last_y]."))

/obj/item/binoculars/rangefinder/on_wield(obj/item/source, mob/user)
	. = ..()
	inhand_icon_state = "rangefinder_wielded"

/obj/item/binoculars/rangefinder/on_unwield(obj/item/source, mob/user)
	. = ..()
	inhand_icon_state = "rangefinder"

/obj/item/binoculars/rangefinder/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		if(user.stat != CONSCIOUS)
			to_chat(user, span_warning("You cannot use [src] while incapacitated."))
			return FALSE
		if(user.z != interacting_with.z)
			to_chat(user, span_warning("You cannot get a direct laser from where you are."))
			return FALSE
		acquire_target(interacting_with, user)
		return TRUE

/obj/item/binoculars/rangefinder/proc/acquire_target(atom/targeted_atom, mob/user)
	var/turf/TU = get_turf(targeted_atom)
	var/distance = get_dist(TU, get_turf(user))
	if(TU.z != user.z || distance == -1)
		to_chat(user, span_warning("You can't focus properly through \the [src] while looking through something else."))
		return

	playsound(src, 'sound/items/night_vision_on.ogg', 35)
	var/obj/effect/temp_visual/laser_target/LT = new(TU)
	acquire_coordinates(targeted_atom, user)

/obj/item/binoculars/rangefinder/proc/acquire_coordinates(atom/A, mob/user)
	var/turf/TU = get_turf(A)
	targetturf = TU
	last_x = targetturf.x
	last_y = targetturf.y
	var/turf/current_turf = get_turf(src)
	to_chat(user, span_notice("COORDINATES: LONGITUDE [last_x]. LATITUDE [last_y]."))
	if(debug)
		to_chat(user, span_notice("([deobfuscate_x(last_x)]:[deobfuscate_y(last_y)])	{([current_turf.x]:[current_turf.y])"))


/obj/effect/temp_visual/laser_target
	name = "laser"
	icon = 'tff_modular/modules/tgmc_xenos/mortar/icons/items.dmi'
	icon_state = "laser_target_coordinate"
	duration = 600
