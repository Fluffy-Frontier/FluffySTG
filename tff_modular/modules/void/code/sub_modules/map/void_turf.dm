/turf/open/floor/void_turf
	name = "Void"
	icon = 'tff_modular/modules/void/icons/turf.dmi'
	icon_state = "void_turf"
	gender = PLURAL
	var/destroy_on_enter = TRUE

/turf/open/floor/void_turf/ex_act()
	return FALSE

/turf/open/floor/void_turf/acid_act()
	return FALSE

/turf/open/floor/void_turf/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/void_turf/Entered(atom/movable/arrived)
	. = ..()
	if(arrived.movement_type == FLYING)
		return
	convert_to_void(arrived)

/turf/open/floor/void_turf/attack_hand_secondary(mob/user)
	. = ..()
	convert_to_void(user)

/turf/open/floor/void_turf/attack_hand(mob/user)
	. = ..()
	convert_to_void(user)

/turf/open/floor/void_turf/rcd_act(mob/user, obj/item/construction/rcd/the_rcd)
	if(issilicon(user))
		convert_to_void(user)
		return
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.apply_damage(15, BRUTE, BODY_ZONE_CHEST)
		to_chat(C, span_warning("It's surely a bad idea."))
	user.balloon_alert(user, "RCD's gone!")
	convert_to_void(the_rcd)

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

/proc/convert_to_void(atom/target, do_animation = FALSE, message = FALSE, puddle = FALSE)

	#if defined(UNIT_TESTS)
		// Не выполняем аннигиляции, если запущены юнит тесты. Во избеждание ошибок.
		return
	#endif
	if(isobserver(target))
		return FALSE
	if(istype(target, /mob/camera))
		return FALSE
	if(istype(target, /mob/living/basic/void_creture))
		return FALSE

	//Если это моб - окуратно убираем его..
	if(ismob(target))
		var/mob/del_mob = target

		if(del_mob.client)
			del_mob.ghostize(FALSE)
			message_admins("[del_mob.name]/[key_name(del_mob)], Was consumed by void at [ADMIN_JMP(del_mob.loc)]")

		if(isliving(del_mob))
			message = TRUE
			del_mob.notransform = TRUE
			if(issilicon(del_mob))
				var/mob/living/silicon/silicon_mob = del_mob
				silicon_mob.death(TRUE)

			else if(iscarbon(del_mob))
				var/mob/living/carbon/carbon_mob = del_mob
				carbon_mob.death(TRUE)

			else
				var/mob/living/living_mob = del_mob
				living_mob.death(TRUE)
	if(iseffect(target))
		return FALSE
	if(isturf(target))
		return FALSE

	if(message)
		target.visible_message(span_black("[target.name] WAS CONSUMED BY VOID!"))
	if(do_animation)
		var/matrix/pre_matrix = matrix()
		pre_matrix.Scale(1, 0.25)
		animate(target, 6 SECONDS, color = COLOR_ALMOST_BLACK, transform = pre_matrix.Multiply(target), easing = SINE_EASING|EASE_OUT)
		sleep(6 SECONDS)
	if(puddle)
		new /obj/structure/void_puddle(target.loc, TRUE)
	qdel(target)
	return TRUE
