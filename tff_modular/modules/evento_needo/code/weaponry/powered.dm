/obj/item/gun/ballistic/automatic/powered
	accepted_magazine_type = /obj/item/ammo_box/magazine/gauss
	charge_sections = 3

/obj/item/gun/ballistic/automatic/powered/Initialize()
	. = ..()
	if(cell_type)
		cell = new cell_type(src)
	else
		cell = new(src)
	cell.give(cell.maxcharge)
	update_appearance()

/obj/item/gun/ballistic/automatic/powered/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("[src]'s cell is [round(cell.charge / cell.maxcharge, 0.1) * 100]% full.")
	else
		. += span_notice("[src] doesn't seem to have a cell!")

/obj/item/gun/ballistic/automatic/powered/can_shoot()
	if(QDELETED(cell))
		return FALSE

	var/obj/item/ammo_casing/caseless/gauss/shot = chambered
	if(!shot)
		return FALSE
	if(cell.charge < shot.energy_cost * burst_size)
		return FALSE
	return ..()

/obj/item/gun/ballistic/automatic/powered/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	var/obj/item/ammo_casing/caseless/gauss/shot = chambered
	if(shot?.energy_cost)
		cell.use(shot.energy_cost)
	return ..()

/obj/item/gun/ballistic/automatic/powered/get_cell(atom/movable/interface, mob/user)
	return cell

//the things below were taken from energy gun code. blame whoever coded this, not me
/obj/item/gun/ballistic/automatic/powered/attackby(obj/item/A, mob/user, params)
	if(..())
		return FALSE
	if (!internal_cell && istype(A, /obj/item/stock_parts/power_store/cell))
		var/obj/item/stock_parts/power_store/cell/C = A
		if (!cell)
			insert_cell(user, C)

/obj/item/gun/ballistic/automatic/powered/proc/insert_cell(mob/user, obj/item/stock_parts/power_store/cell/C)
	if(user.transferItemToLoc(C, src))
		cell = C
		to_chat(user, span_notice("You load the [C] into \the [src]."))
		playsound(src, load_sound, load_sound_volume, load_sound_vary)
		update_appearance()
		return TRUE
	else
		to_chat(user, span_warning("You cannot seem to get \the [src] out of your hands!"))
		return FALSE

/obj/item/gun/ballistic/automatic/powered/proc/eject_cell(mob/user, obj/item/stock_parts/power_store/cell/tac_load = null)
	playsound(src, load_sound, load_sound_volume, load_sound_vary)
	cell.forceMove(drop_location())
	var/obj/item/stock_parts/power_store/cell/old_cell = cell
	cell = null
	user.put_in_hands(old_cell)
	old_cell.update_appearance()
	to_chat(user, span_notice("You pull the cell out of \the [src]."))
	update_appearance()

/obj/item/gun/ballistic/automatic/powered/screwdriver_act(mob/living/user, obj/item/I)
	if(cell && !internal_cell)
		to_chat(user, span_notice("You begin unscrewing and pulling out the cell..."))
		if(I.use_tool(src, user, 1 SECONDS, volume=100))
			to_chat(user, span_notice("You remove the power cell."))
			eject_cell(user)
	return ..()

/obj/item/gun/ballistic/automatic/powered/update_overlays()
	. = ..()
	if(!automatic_charge_overlays)
		return
	var/overlay_icon_state = "[icon_state]_charge"
	var/charge_ratio = get_charge_ratio()
	if(cell)
		. += "[icon_state]_cell"
	if(charge_ratio == 0)
		. += "[icon_state]_cellempty"
	else
		if(!shaded_charge)
			var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)
			for(var/i in 1 to charge_ratio)
				charge_overlay.pixel_x = ammo_x_offset * (i - 1)
				charge_overlay.pixel_y = ammo_y_offset * (i - 1)
				. += new /mutable_appearance(charge_overlay)
		else
			. += "[icon_state]_charge[charge_ratio]"

/obj/item/gun/ballistic/automatic/powered/proc/get_charge_ratio()
	if(!cell)
		return FALSE
	return CEILING(clamp(cell.charge / cell.maxcharge, 0, 1) * charge_sections, 1)// Sets the ratio to 0 if the gun doesn't have enough charge to fire, or if its power cell is removed.
