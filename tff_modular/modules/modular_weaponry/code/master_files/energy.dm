/obj/item/gun/energy

	var/internal_magazine = FALSE
	var/latch_closed = TRUE
	var/latch_toggle_delay = 1.0 SECONDS
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		///obj/item/attachment/scope,
		/obj/item/attachment/sling,
		/obj/item/attachment/ammo_counter,
	)
	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_SCOPE = 1,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 27,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 18,
			"y" = 22,
		)
	)


/obj/item/gun/energy/Initialize(mapload)
	. = ..()
	update_overlays()

/obj/item/gun/energy/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/melee/baton/security))
		return try_charging_with_batton(tool, user)
	if(istype(tool, /obj/item/stock_parts/power_store/cell))
		if(cell)
			eject_cell(user, tool)
		else
			try_insert_cell(user, tool)
	return ..()

/obj/item/gun/energy/examine(mob/user)
	. = ..()
	if(cell)
		. += span_info("It has [cell.name] installed")

/obj/item/gun/energy/update_overlays()
	. = ..()
	if(ismob(loc))
		var/mutable_appearance/latch_overlay
		latch_overlay = mutable_appearance('tff_modular/modules/modular_weaponry/icons/cell_latch.dmi')
		if(latch_closed)
			if(cell)
				latch_overlay.icon_state = "latch-on-full"
			else
				latch_overlay.icon_state = "latch-on-empty"
		else
			if(cell)
				latch_overlay.icon_state = "latch-off-full"
			else
				latch_overlay.icon_state = "latch-off-empty"
		. += latch_overlay

/obj/item/gun/energy/proc/try_insert_cell(mob/user, obj/item/stock_parts/power_store/cell/new_cell, display_message = TRUE)
	if(!new_cell)
		return FALSE
	if(latch_closed)
		to_chat(user, "Unlatch the power cell's retainment clip")
		return FALSE
	//if(!has_empty_cell())
	//	if(eject_cell(user, new_cell))
	//		to_chat(user, span_notice("You perform a tactical reload on \the [src]."))
	//	else
	//		to_chat(user, span_warning("Your reload was interupted!"))
	//		return FALSE
	if(insert_cell(user, new_cell, display_message))
		to_chat(user, span_notice("You insert battery in \the [src]."))

	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD) // Для СкайРатовского ХУДа.
	return TRUE

/obj/item/gun/energy/proc/insert_cell(mob/user, obj/item/stock_parts/power_store/C, display_message)
	if(!C)
		return FALSE
	if(!user.transferItemToLoc(C, src))
		to_chat(user, span_warning("У тебя не получается отцепить батарею от рук!"))
		return FALSE

	cell = C
	var/obj/item/ammo_casing/energy/shot = ammo_type[select] //Necessary to find cost of shot
	shot.e_cost = initial(shot.e_cost) * cell.maxcharge / STANDARD_CELL_CHARGE
	battery_damage_multiplier = max(1 + (cell.maxcharge / (STANDARD_CELL_CHARGE * 200)), 1)

	playsound(src, 'sound/items/weapons/gun/general/magazine_insert_full.ogg', 40, TRUE)
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	if(display_message)
		balloon_alert(user, "cell inserted")
	return TRUE

/obj/item/gun/energy/proc/eject_cell(mob/user, obj/item/stock_parts/power_store/cell/tac_load = null)
	if(latch_closed && user)
		to_chat(user, "Unlatch the power cell's retainment clip")
		return FALSE
	if(!cell && user)
		to_chat(user, "There's no cell inside")
		return FALSE
	playsound(src, 'sound/items/weapons/gun/general/magazine_remove_full.ogg', 40, TRUE)
	cell.update_appearance()
	var/obj/item/stock_parts/power_store/cell/old_cell = cell
	cell.forceMove(drop_location())
	if(tac_load)
		if(try_insert_cell(user, tac_load, FALSE))
			balloon_alert(user, "cell swapped")
		else
			cell = null
	else
		cell = null

	if(user)
		user.put_in_hands(old_cell)
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	return TRUE





//special is_type_in_list method to counteract problem with current method
/obj/item/gun/energy/proc/is_attachment_in_contents_list()
	for(var/content_item in contents)
		if(istype(content_item, /obj/item/attachment/))
			return TRUE
	return FALSE

/obj/item/gun/energy/proc/has_empty_cell()
	if(!cell)
		return TRUE
	return FALSE

///Заряд батарейки включенным станбатоном
/obj/item/gun/energy/proc/try_charging_with_batton(obj/item/melee/baton/security/stunbaton, mob/living/carbon/user)
	//Если батарея пуста или станбатон выключен - обычный удар по стволу
	if(has_empty_cell() || !stunbaton.active)
		stunbaton.attack_atom(src, user)
		return
	//Шанс может быть больше, если в это верить
	if(loc == user && prob(40))
		stunbaton.attack(user, user)
		return
	if(prob(25))
		do_sparks(3, source = src)
		qdel(cell)
		to_chat(user, span_warning("Из разъема для батареи разносится отвратительный горелый запах."))
		stunbaton.attack_atom(src, user)
		return
	//Ну это реально глупо. Кто будет в здравом уме бить электрической дубинкой по энергетическому оружие, чтобы зарядить его.
	if(cell.charge == cell.maxcharge)
		//НА ПУТИ К ФИАСКО
		if(prob(50))
			if(prob(50))
				explosion(src, 0, 0, 1, 2, 1, "[user] попытался зарядить [name] с помощью грубой силы.")
				qdel(cell)
				return
			else
				do_sparks(3, source = src)
				cell.use(cell.charge)
				to_chat(user, span_notice("Батарея издает подозрительный звук."))
				stunbaton.attack_atom(src, user)
				return
	if(prob(55))
		do_sparks(3, source = src)
		electrocute_mob(user, cell, src)
		cell.use(LASER_SHOTS(2, cell.maxcharge))
		stunbaton.attack_atom(src, user)
		return
	else
		//Если игрок прошел через все испытания он получает ААААААААААВТО. 5 патронов.
		cell.give(LASER_SHOTS(5, cell.maxcharge))
		to_chat(user, "Каким то чудесным образом батарея выдерживает твое гениальное действие.")
		stunbaton.attack_atom(src, user)
	return ITEM_INTERACT_SUCCESS



/obj/item/gun/energy/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	. = ..()
	if(!latch_closed && prob(65)) //make the cell slide out if it's fired while the retainment clip is unlatched, with a 65% probability
		to_chat(user, span_warning("The [src]'s cell falls out!"))
		eject_cell()
	return

/obj/item/gun/energy/attack_hand(mob/user, list/modifiers)
	if(!internal_magazine && loc == user && user.is_holding(src) && !has_empty_cell() && !latch_closed)
		eject_cell(user)
		return
	return ..()

/obj/item/gun/energy/attack_self(mob/living/user)
	if(latch_closed)
		unique_action(user)
	else if(!latch_closed)
		if(has_empty_cell())
			balloon_alert(user, "there is no cell!")
			return FALSE
		eject_cell(user)
	return ..()

/obj/item/gun/energy/screwdriver_act(mob/living/user, obj/item/I)
	if(!user.is_holding(src))
		return ..()
	var/choice = isnull(pin) ? FALSE : tgui_input_list(user, "Choose action", "Choice", list("Take pin out", "Cell-slot action"))
	if(choice == "Cell-slot action" || !choice)
		if(latch_closed)
			to_chat(user, span_notice("You start to unlatch the [src]'s power cell retainment clip..."))
			if(do_after(user, latch_toggle_delay, src))
				to_chat(user, span_notice("You unlatch the [src]'s power cell retainment clip " + span_red("OPEN") + "."))
				playsound(src, 'sound/items/taperecorder/taperecorder_play.ogg', 50, FALSE)
				latch_closed = FALSE
				update_appearance()
			return ITEM_INTERACT_SUCCESS
		else if(!latch_closed)
			// if(!cell && is_attachment_in_contents_list())
			// 	return ..() //should bring up the attachment menu if attachments are added. If none are added, it just does leaves the latch open
			to_chat(user, span_warning("You start to latch the [src]'s power cell retainment clip..."))
			if (do_after(user, latch_toggle_delay, src))
				to_chat(user, span_notice("You latch the [src]'s power cell retainment clip " + span_green("CLOSED") + "."))
				playsound(src, 'sound/items/taperecorder/taperecorder_close.ogg', 50, FALSE)
				latch_closed = TRUE
				update_appearance()
				return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/gun/energy/unique_action(mob/living/user)
	if(ammo_type.len > 1)
		select_fire(user)
		update_appearance()

