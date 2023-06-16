// MCR

/obj/item/gun/microfusion/insert_cell(mob/user, obj/item/stock_parts/cell/microfusion/inserting_cell, display_message = TRUE)
	var/hotswap = FALSE
	if(cell)
		hotswap = TRUE
	var/obj/item/stock_parts/cell/old_cell = cell
	if(display_message)
		balloon_alert(user, "cell inserted")
	if(hotswap)
		eject_cell(user, FALSE, FALSE)
	if(sound_cell_insert)
		playsound(src, sound_cell_insert, sound_cell_insert_volume, sound_cell_insert_vary)
	cell = inserting_cell
	inserting_cell.forceMove(src)
	inserting_cell.inserted_into_weapon()
	cell.parent_gun = src
	if(old_cell)
		user.put_in_hands(old_cell)
	recharge_newshot()
	update_appearance()
	return TRUE

// MCR CELL

/obj/item/stock_parts/cell/microfusion
	empty = FALSE
	chargerate = 300

/obj/item/stock_parts/cell/microfusion/inserted_into_weapon()
	do_sparks(4, FALSE, src)

/obj/item/stock_parts/cell/microfusion/cell_removal_discharge()
	do_sparks(4, FALSE, src)
	update_appearance()
