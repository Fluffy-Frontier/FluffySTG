/obj/item/gun/energy/plasmacutter/adv/bloodred
	name = "Bloody plasma cutter"
	icon_state = "bloodred"
	icon = 'tff_modular/modules/antagonism_updates/bloodred_cutter/icons/obj/bloodred_plasmacutter.dmi'
	lefthand_file = 'tff_modular/modules/antagonism_updates/bloodred_cutter/icons/mob/bloodred_l.dmi'
	righthand_file = 'tff_modular/modules/antagonism_updates/bloodred_cutter/icons/mob/bloodred_r.dmi'
	inhand_icon_state = "bloodred"
	force = 20
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/adv/bloodred)
	toolspeed = 0.5

/obj/item/ammo_casing/energy/plasma/adv/bloodred
	projectile_type = /obj/projectile/plasma/adv/bloodred
	delay = 10
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)

/obj/projectile/plasma/adv/bloodred
	damage = 37
	range = 7
	mine_range = 9

/datum/uplink_item/role_restricted/bloodred_plasmacutter
	name = "Bloody plasma cutter"
	desc = "Short range mining weapon that can easily cut limb off humans and others living creatures. Reload with plasma."
	item = /obj/item/gun/energy/plasmacutter/adv/bloodred
	cost = /datum/uplink_item/medium_cost/weaponry::cost //  11 TC
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_SHAFT_MINER)

