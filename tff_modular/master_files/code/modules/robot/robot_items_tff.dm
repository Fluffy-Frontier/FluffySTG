/**
 * Электрическая сварка
 */

/obj/item/weldingtool/borg_electrical
	name = "electrical welding tool"
	desc = "An experimental welding tool capable of welding functionality through the use of electricity. The flame seems almost cold."
	icon = 'modular_skyrat/modules/aesthetics/tools/tools.dmi'
	icon_state = "elwelder"
	light_power = 1
	light_color = LIGHT_COLOR_HALOGEN
	tool_behaviour = NONE
	toolspeed = 0.2
	power_use_amount = POWER_CELL_USE_LOW
	// We don't use fuel
	change_icons = FALSE
	var/datum/weakref/borg_ref
	var/powered = FALSE
	max_fuel = 20

/obj/item/weldingtool/borg_electrical/Initialize(mapload, mob/living/silicon/robot/connected_robot)
	. = ..()
	if(!connected_robot)
		return INITIALIZE_HINT_QDEL
	borg_ref = REF(connected_robot)

/obj/item/weldingtool/borg_electrical/attack_self(mob/user)
	. = ..()
	if(!powered)
		if(!draw_borg_power(power_use_amount))
			return
	powered = !powered
	playsound(src, 'sound/effects/sparks4.ogg', 100, TRUE)
	if(powered)
		to_chat(user, span_notice("You turn [src] on."))
		switched_on()
		return
	to_chat(user, span_notice("You turn [src] off."))
	switched_off()

/obj/item/weldingtool/borg_electrical/switched_on(mob/user)
	welding = TRUE
	tool_behaviour = TOOL_WELDER
	light_on = TRUE
	force = 15
	damtype = BURN
	hitsound = 'sound/items/welder.ogg'
	set_light_on(powered)
	update_appearance()
	START_PROCESSING(SSobj, src)

/obj/item/weldingtool/borg_electrical/switched_off(mob/user)
	powered = FALSE
	welding = FALSE
	light_on = FALSE
	force = initial(force)
	damtype = BRUTE
	set_light_on(powered)
	tool_behaviour = NONE
	update_appearance()
	STOP_PROCESSING(SSobj, src)

/obj/item/weldingtool/borg_electrical/process(seconds_per_tick)
	if(!powered)
		switched_off()
		return
	if(!draw_borg_power(power_use_amount))
		switched_off()
		return

/obj/item/weldingtool/borg_electrical/proc/draw_borg_power(draw_amount)
	var/mob/living/silicon/robot/our_borg = borg_ref.resolve()
	if(!our_borg)
		qdel(src)
	var/obj/item/stock_parts/cell/borg_cell = our_borg.cell
	if(!borg_cell)
		return FALSE
	if(!borg_cell.use(draw_amount))
		return FALSE
	return TRUE
