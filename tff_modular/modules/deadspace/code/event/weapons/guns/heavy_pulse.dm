/*
	The heavy pulse rifle has infinite ammo, and is cooldown based instead
*/

/obj/item/gun/energy/pulse_heavy
	name = "Heavy Pulse Rifle"
	desc = "A colossal weapon capable of firing infinitely, but requiring a significant cooldown period. "
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ds13guns48x32.dmi'
	icon_state = "heavypulserifle"
	icon_wielded = "heavypulserifle-wielded"
	lefthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/lefthand_guns.dmi'
	righthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/righthand_guns.dmi'
	worn_icon = 'tff_modular/modules/deadspace/icons/event/mob/onmob/back.dmi'
	worn_icon_state = "heavypulserifle"
	inhand_icon_state = "heavypulserifle"
	display_empty = FALSE
	can_select = FALSE
	automatic_charge_overlays = FALSE
	charge_sections = null
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = null
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	spread = 12
	unwielded_spread = 12
	wielded_spread = 2
	ammo_type = list(/obj/item/ammo_casing/energy/pulserifle)
	cell_type = /obj/item/stock_parts/power_store/cell/pulse_heavy
	item_flags = SLOWS_WHILE_IN_HAND
	can_charge = FALSE
	selfcharge = 1
	charge_delay = 1
	recoil = 0.8
	unwielded_recoil = 0.8
	wielded_recoil = 0.4
	fire_sound = 'tff_modular/modules/deadspace/sound/event/pulse_shot.ogg' //Test sound

/obj/item/gun/energy/pulse_heavy/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed_gun, wielded_spread = wielded_spread, wielded_recoil = wielded_recoil, unwielded_spread = unwielded_spread, unwielded_recoil = unwielded_recoil, icon_wielded = icon_wielded)
	AddComponent(/datum/component/automatic_fire, 0.1 SECONDS)

/**
Energy cell
*/

/obj/item/stock_parts/power_store/cell/pulse_heavy
	name = "Heavy Pulse Rifle power cell"
	desc = "A heavy power pack designed for use with the Heavy Pulse Rifle."
	icon_state = "hcell"

/**
Ammo casing
*/

/obj/item/ammo_casing/energy/pulserifle
	name = "pulse round"
	desc = "A ultra-small caliber round designed for the SWS Motorized Pulse Rifle."
	icon_state = "ionshell-live"
	projectile_type = /obj/projectile/bullet/pulse
	caliber = CALIBER_PULSE
	slot_flags = null
	e_cost = LASER_SHOTS(50, STANDARD_CELL_CHARGE) //The amount of energy a cell needs to expend to create this shot.
	fire_sound = 'tff_modular/modules/deadspace/sound/event/pulse_shot.ogg'
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy
	randomspread = 25

/obj/effect/temp_visual/dir_setting/firing_effect/energy
	icon = 'icons/effects/effects.dmi'
	icon_state = "firing_effect_blue"
	duration = 3
