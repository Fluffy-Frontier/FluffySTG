/*
*	 The SR-8.
*/

/obj/item/gun/energy/blueshield
	name = "\improper SR-8 energy revolver"
	desc = "SR-8 is an experemental energy revolver that utilises universal type of cells."
	icon = 'tff_modular/modules/blueshield-rearm/icons/sr-8.dmi'
	righthand_file = 'tff_modular/modules/blueshield-rearm/icons/righthand.dmi'
	lefthand_file = 'tff_modular/modules/blueshield-rearm/icons/lefthand.dmi'
	icon_state = "sr-8"
	inhand_icon_state = "sr-8"
	fire_sound = 'tff_modular/modules/blueshield-rearm/sounds/sr8_lethal_shot.ogg'
	can_charge = FALSE
	ammo_type = list(
		/obj/item/ammo_casing/energy/disabler/blueshield,
		/obj/item/ammo_casing/energy/laser/blueshield,
	)
	cell_type = /obj/item/stock_parts/power_store/cell/super // Батарея с которой спавнится револьвер.

	var/obj/item/stock_parts/power_store/cell/zerocell/no_cell
	var/acceptable_cell_type = /obj/item/stock_parts/power_store/cell

/obj/item/gun/energy/blueshield/Initialize(mapload)
	. = ..()
	no_cell = new()

/obj/item/gun/energy/blueshield/examine(mob/user)
	. = ..()
	. += span_notice("You can eject cell by <b>\"using\"</b> [src] in hands.")
	. += span_notice("<b>Alt-Click</b> to cycle firing mode.")
	. += "\n"
	if(has_empty_cell())
		. += "[src] has <b>no cell</b> inside its chamber."
	else
		. += "[src] has \a <b>[cell]</b> inside its chamber."
	. += "\n"
	. += "[src] is currently in <b>[ammo_type[select]:select_name]</b> mode."

/obj/item/gun/energy/blueshield/eject_cell(mob/user)
	if(has_empty_cell())
		return
	cell.update_appearance()
	user.put_in_hands(cell)
	cell = no_cell

	playsound(usr, SFX_REVOLVER_SPIN, 30, FALSE)
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD) // Для СкайРатовского ХУДа.

	balloon_alert(user, "cell ejected")


/obj/item/gun/energy/blueshield/proc/try_insert_cell(obj/item/stock_parts/power_store/cell/new_cell, var/mob/user)
	if(!new_cell)
		return FALSE
	if(!has_empty_cell())
		balloon_alert(user, "cell is already loaded!")
		return FALSE
	user.temporarilyRemoveItemFromInventory(new_cell)
	if(!user.transferItemToLoc(new_cell, src))
		qdel(new_cell) // Если что-то пошло не так...
		return FALSE
	cell = new_cell

	playsound(usr, SFX_REVOLVER_SPIN, 30, FALSE)
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD) // Для СкайРатовского ХУДа.
	balloon_alert(user, "cell inserted")
	return TRUE


/obj/item/gun/energy/blueshield/click_alt(mob/user)
	select_fire(user)
	playsound(usr, SFX_REVOLVER_SPIN, 30, FALSE)
	return CLICK_ACTION_SUCCESS

/obj/item/gun/energy/blueshield/attack_self(mob/living/user)
	if(has_empty_cell())
		balloon_alert(user, "there is no cell!")
		return FALSE
	eject_cell(user)

/obj/item/gun/energy/blueshield/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, acceptable_cell_type))
		return try_insert_cell(attacking_item, user)
	. = ..()

/obj/item/gun/energy/blueshield/proc/has_empty_cell()
	if(!cell)
		return TRUE
	if(cell == no_cell)
		return TRUE
	return FALSE

/*
*	(Почти) пустая батарейка.
*	Её цель - встать на место извлечённой, чтобы не ломать неожиданным null'ом ничего.
*/
/obj/item/stock_parts/power_store/cell/zerocell
	maxcharge = 1
