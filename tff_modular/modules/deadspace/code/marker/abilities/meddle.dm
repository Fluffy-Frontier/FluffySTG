/datum/action/cooldown/necro/psy/meddle
	name = "Meddle"
	desc = "A context sensitive spell which does different things depending on the target. Interfaces with machines, moves items, messes with computers and office appliances."
	button_icon_state = "meddle"
	cost = 10

/datum/action/cooldown/necro/psy/meddle/PreActivate(obj/target)
	if(!isobj(target))
		return TRUE
	return ..()

/datum/action/cooldown/necro/psy/meddle/Activate(obj/target)
	..()
	target.meddle_act(owner)
	return TRUE

/obj/proc/meddle_act(mob/user)
	var/direction = prob(50) ? -1 : 1
	animate(src, pixel_x = pixel_x + SHAKE_ANIMATION_OFFSET * direction, time = 1, easing = QUAD_EASING | EASE_OUT, flags = ANIMATION_PARALLEL)
	animate(pixel_x = pixel_x - (SHAKE_ANIMATION_OFFSET * 2 * direction), time = 1)
	animate(pixel_x = pixel_x + SHAKE_ANIMATION_OFFSET * direction, time = 1, easing = QUAD_EASING | EASE_IN)

/obj/machinery/power/floodlight/meddle_act(mob/user)
	. = ..()
	change_setting(1, user) // 1 == FLOODLIGHT_OFF

/obj/machinery/vending/meddle_act(mob/user)
	. = ..()
	throw_item()

/obj/machinery/computer/arcade/meddle_act(mob/user)
	. = ..()
	prizevend(user)

/obj/machinery/microwave/meddle_act(mob/user)
	. = ..()
	start_cycle(user)

/obj/structure/curtain/meddle_act(mob/user)
	. = ..()
	toggle()

/obj/machinery/shower/meddle_act(mob/user)
	. = ..()
	interact(user)

/obj/structure/window/meddle_act(mob/user)
	playsound(src.loc, 'sound/effects/glass/glassknock.ogg', VOLUME_MID, vary = TRUE)

/obj/structure/closet/meddle_act(mob/user)
	. = ..()
	toggle(user)

/obj/machinery/photocopier/meddle_act(mob/user)
	. = ..()
	playsound(src, 'sound/machines/printer.ogg', 50, vary = FALSE)

/obj/machinery/reagentgrinder/meddle_act(mob/user)
	operate_for(6 SECONDS, TRUE, user)

/obj/machinery/conveyor_switch/meddle_act(mob/user)
	. = ..()
	attack_hand(user)

/obj/machinery/disposal/meddle_act(mob/user)
	. = ..()
	flush()
