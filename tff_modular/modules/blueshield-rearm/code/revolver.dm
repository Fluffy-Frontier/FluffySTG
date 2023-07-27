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
	fire_delay = 1.90

	can_charge = FALSE
	ammo_type = list(/obj/item/ammo_casing/energy/laser/blueshield, /obj/item/ammo_casing/energy/disabler/blueshield)
	cell_type = /obj/item/stock_parts/cell/super // Батарея с которой спавниться револьвер.
	var/acceptable_cell_type = /obj/item/stock_parts/cell

/obj/item/gun/energy/blueshield/proc/eject_cell(var/mob/user)
	if(!cell)
		return
	user.put_in_hands(cell)
	cell = null
	
	playsound(usr, SFX_REVOLVER_SPIN, 30, FALSE)
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD) // Для СкайРатовского ХУДа.
	

/obj/item/gun/energy/blueshield/proc/try_insert_cell(var/obj/item/stock_parts/cell/new_cell, var/mob/user)
	if(!new_cell)
		return FALSE
	if(cell)
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
	return TRUE
	

/obj/item/gun/energy/blueshield/AltClick(mob/user)
	. = ..()
	if(.)
		select_fire(user)
		playsound(usr, SFX_REVOLVER_SPIN, 30, FALSE)

/obj/item/gun/energy/blueshield/attack_self(mob/living/user)
	if(!cell)
		balloon_alert(user, "there is no cell!")
		return FALSE
	eject_cell(user)

/obj/item/gun/energy/blueshield/attacked_by(obj/item/attacking_item, mob/living/user)
	if(istype(attacking_item, acceptable_cell_type))
		return try_insert_cell(attacking_item, user)
	. = ..()
	
