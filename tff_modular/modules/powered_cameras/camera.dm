/obj/machinery/camera
	power_channel = AREA_USAGE_ENVIRON

	///Cell reference
	var/obj/item/stock_parts/power_store/cell
	/// If TRUE, then cell is null, but one is pretending to exist.
	/// This is to defer emergency cell creation unless necessary, as it is very expensive.
	var/has_mock_cell = TRUE


/obj/machinery/camera/Initialize(mapload)
	. = ..()
	if (!mapload)
		has_mock_cell = FALSE

	// Because... why not?
	if (mapload && !camera_enabled && is_station_level(z))
		triggerCameraAlarm()

	RegisterSignal(src, COMSIG_MACHINERY_POWER_RESTORED, PROC_REF(on_power_restore))
	RegisterSignal(src, COMSIG_MACHINERY_POWER_LOST, PROC_REF(on_power_loss))

/obj/machinery/camera/can_use()
	. = ..()
	if(!has_power() && !has_emergency_power(active_power_usage))
		return FALSE

// returns whether this light has power
// true if area has power and lightswitch is on
/obj/machinery/camera/proc/has_power()
	var/area/local_area = get_room_area()
	if(isnull(local_area))
		return FALSE
	return local_area.power_environ

// returns whether this light has emergency power
// can also return if it has access to a certain amount of that power
/obj/machinery/camera/proc/has_emergency_power(power_usage_amount)
	if(!cell && !has_mock_cell)
		return FALSE
	if (has_mock_cell)
		return TRUE
	if(power_usage_amount ? cell.charge >= power_usage_amount : cell.charge)
		return TRUE
	return FALSE

// attempts to use power from the installed emergency cell, returns true if it does and false if it doesn't
/obj/machinery/camera/proc/use_emergency_power(power_usage_amount = active_power_usage)
	if(!has_emergency_power(power_usage_amount))
		return FALSE
	var/obj/item/stock_parts/power_store/real_cell = get_cell()
	real_cell.use(power_usage_amount)
	return TRUE

/obj/machinery/camera/proc/is_full_charge()
	if(cell)
		return cell.charge == cell.maxcharge
	return TRUE

/obj/machinery/camera/get_cell()
	if (has_mock_cell)
		cell = new /obj/item/stock_parts/power_store/cell/emergency_light(src)
		has_mock_cell = FALSE

	return cell

/obj/machinery/camera/process(seconds_per_tick)
	if(has_power())
		if(cell)
			charge_cell(active_power_usage * seconds_per_tick * 10, cell = cell) //Recharge emergency power automatically while not using it
		// If the cell is done mooching station power, stop processing
		if(is_full_charge())
			return PROCESS_KILL

	if(camera_enabled && !use_emergency_power(active_power_usage * seconds_per_tick))
		toggle_cam(null, 0)
		// Instead of copypasting cameranet update code I just imitate wirecutter behavior
		camera_enabled = TRUE
		if (alarm_on)
			cancelCameraAlarm()	// You're dead
		return PROCESS_KILL

/obj/machinery/camera/proc/on_power_restore()
	SIGNAL_HANDLER

	if(camera_enabled)
		if (alarm_on)
			cancelCameraAlarm()

		// That means it was disabled due to lack of power and not cutting wires
		if (!has_emergency_power(active_power_usage))
			camera_enabled = FALSE
			toggle_cam(null, 0)

	// Start processing to recharge the cell
	if(!is_full_charge())
		START_PROCESSING(SSmachines, src)

/obj/machinery/camera/proc/on_power_loss()
	SIGNAL_HANDLER

	triggerCameraAlarm()
	START_PROCESSING(SSmachines, src)

/obj/machinery/camera/drop_upgrade(obj/item/upgrade_dropped)
	. = ..()
	if (cell == upgrade_dropped)
		cell = null

/obj/machinery/camera/Exited(atom/movable/gone, direction)
	. = ..()
	if (gone == cell)
		cell = null

/obj/machinery/camera/examine(mob/user)
	. = ..()
	if(panel_open)
		if (!cell && !has_mock_cell)
			. += span_info("It can be upgraded with a emergency [EXAMINE_HINT("power cell")].")
		else
			. += span_info("It has [has_mock_cell ? "[/obj/item/stock_parts/power_store/cell/emergency_light::name]" : "[cell.name]"] as an emergency power source installed.")
			. += span_info("But you can still swap it with [EXAMINE_HINT("other cell")] or dismantling the camera.")
			. += span_info("It can be removed with [EXAMINE_HINT("crowbar differently")].")
	if (camera_enabled && !has_power() && has_emergency_power(active_power_usage))
		. += span_warning("It's emergency power LED is blinking.")

/obj/machinery/camera/update_icon_state()
	. = ..()
	if (!has_power() && !has_emergency_power(active_power_usage))
		icon_state = "[xray_module][base_icon_state]_off"

/obj/machinery/camera/on_deconstruction(disassembled)
	..()
	if (cell)
		drop_upgrade(cell)

/obj/machinery/camera/crowbar_act_secondary(mob/living/user, obj/item/tool)
	var/obj/item/mycell = get_cell()
	if (mycell)
		to_chat(user, span_notice("You carefully remove [src]'s [mycell.name] with the crowbar."))
		drop_upgrade(mycell)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/machinery/camera/attackby(obj/item/attacking_item, mob/living/user, list/modifiers, list/attack_modifiers)
	if(istype(attacking_item, /obj/item/stock_parts/power_store/cell) && (camera_construction_state != CAMERA_STATE_FINISHED || panel_open))
		if(!user.temporarilyRemoveItemFromInventory(attacking_item, newloc = src))
			return ITEM_INTERACT_BLOCKING

		var/was_active = has_power() || has_emergency_power(active_power_usage)
		if (has_mock_cell || cell)
			// It will handle mock cell creation
			var/obj/item/mycell = get_cell()
			to_chat(user, span_notice("You carefuly removed [src]'s [mycell.name] with other cell. Do not ask me how."))
			drop_upgrade(mycell)

		to_chat(user, span_notice("You attach [attacking_item] into [name]'s inner circuits."))
		attacking_item.forceMove(src)
		cell = attacking_item
		if (!was_active && has_emergency_power(active_power_usage))
			if(camera_enabled)
				if (alarm_on)
					cancelCameraAlarm()

				camera_enabled = FALSE
				toggle_cam(null, 0)

			// Start processing to recharge the cell
			if(!is_full_charge())
				START_PROCESSING(SSmachines, src)
		return ITEM_INTERACT_SUCCESS
	. = ..()

// Please do not have separate cells and processing, guys.
/obj/machinery/camera/silicon
	has_mock_cell = FALSE

/obj/machinery/camera/silicon/on_power_loss()
	return

/obj/machinery/camera/exosuit
	has_mock_cell = FALSE

/obj/machinery/camera/exosuit/on_power_loss()
	return

