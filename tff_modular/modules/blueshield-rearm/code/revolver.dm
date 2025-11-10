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

/obj/item/gun/energy/blueshield/click_alt(mob/user)
	select_fire(user)
	playsound(usr, SFX_REVOLVER_SPIN, 30, FALSE)
	return CLICK_ACTION_SUCCESS

/obj/item/gun/energy/blueshield/attack_self(mob/living/user)
	if(has_empty_cell())
		balloon_alert(user, "there is no cell!")
		return FALSE
	eject_cell(user)

/*
*	(Почти) пустая батарейка.
*	Её цель - встать на место извлечённой, чтобы не ломать неожиданным null'ом ничего.
*/
/obj/item/stock_parts/power_store/cell/zerocell
	maxcharge = 1
