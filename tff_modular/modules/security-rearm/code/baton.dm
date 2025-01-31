/obj/item/melee/baton/security/berdish
	name = "gendarme baton"
	desc = "A long axe for beating criminal scum."
	desc_controls = "Left click to stun, right click to harm."
	icon = 'tff_modular/modules/security-rearm/icons/obj/berdish.dmi'
	worn_icon = 'tff_modular/modules/security-rearm/icons/mob/berdish_back.dmi'
	icon_state = "berdish"
	base_icon_state = "berdish"
	inhand_icon_state = "berdish"
	worn_icon_state = "berdish"
	icon_angle = -90
	lefthand_file = 'tff_modular/modules/security-rearm/icons/mob/berdish_lefthand.dmi'
	righthand_file = 'tff_modular/modules/security-rearm/icons/mob/berdish_righthand.dmi'
	SET_BASE_PIXEL(-8, 0)

/obj/item/melee/baton/security/berdish/loaded //this one starts with a cell pre-installed.
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high
