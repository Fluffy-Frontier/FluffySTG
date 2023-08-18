/turf/open/void_turf
	name = "Void"
	icon = 'tff_modular/modules/void/icons/turf.dmi'
	icon_state = "void_turf"
	gender = PLURAL
	var/destroy_on_enter = TRUE

/turf/open/void_turf/ex_act()
	return FALSE

/turf/open/void_turf/acid_act()
	return FALSE

/turf/open/void_turf/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/void_turf/Entered(atom/movable/arrived)
	. = ..()
	if(arrived.movement_type == FLYING)
		return
	convert_to_void(arrived)

/turf/open/void_turf/attack_hand_secondary(mob/user)
	. = ..()
	convert_to_void(user)

/turf/open/void_turf/attack_hand(mob/user)
	. = ..()
	convert_to_void(user)

/turf/open/void_turf/rcd_act(mob/user, obj/item/construction/rcd/the_rcd)
	if(issilicon(user))
		convert_to_void(user)
		return
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.apply_damage(15, BRUTE, BODY_ZONE_CHEST)
		to_chat(C, span_warning("It's surely a bad idea."))
	user.balloon_alert(user, "RCD's gone!")
	convert_to_void(the_rcd)


/turf/open/void_turf/proc/convert_to_void(atom/target)
	if(istype(target, /mob/living/basic/void_creture) || istype(target, /obj/structure/void_puddle))
		return
	target.visible_message(span_userdanger("[target.name] was consumed by void!"))

	if(isliving(target) || issilicon(target))
		var/mob/living/L = target
		to_chat(L, span_userdanger("Void consumes you. You're now one."))
		new /obj/structure/void_puddle(L.loc, TRUE)

		L.death(TRUE)
		if(L.client)
			L.client.admin_follow(get_turf(L))
			L.client = null
			L.ckey = null
		QDEL_IN(L, 5)
		return

	qdel(target)

/obj/structure/void_puddle
	name = "Void puddle"
	icon = 'tff_modular/modules/void/icons/void_effects.dmi'
	icon_state = "void_puddles1"
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	max_integrity = INFINITY
	opacity = FALSE
	density = FALSE
	anchored = TRUE

/obj/structure/void_puddle/Initialize(mapload, instant = TRUE)
	. = ..()
	var/true_icon_state = "void_puddles[rand(1, 4)]"
	icon_state = true_icon_state
	playsound(src, pick('tff_modular/modules/void/sounds/drip1.ogg','tff_modular/modules/void/sounds/drip2.ogg','tff_modular/modules/void/sounds/drip3.ogg'), 90)
	update_appearance(UPDATE_ICON_STATE)
	if(!instant)
		addtimer(CALLBACK(src, PROC_REF(release_void)), 180 SECONDS)

/obj/structure/void_puddle/proc/release_void()
	if(!src)
		return
	visible_message(span_black("[name] is gone."))
	Destroy()
