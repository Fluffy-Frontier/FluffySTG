/obj/item/gun/energy/plasmacutter/necro
	name = "experimental plasma cutter"
	desc = "A high power plasma cutter designed to cut through tungsten reinforced bulkheads during engineering works. Also a rather hazardous improvised weapon, capable of severing limbs in a few shots."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/weapons.dmi'
	lefthand_file = 'tff_modular/modules/deadspace/icons/event/mob/weapons_left_hand.dmi'
	righthand_file = 'tff_modular/modules/deadspace/icons/event/mob/weapons_right_hand.dmi'
	icon_state = "plasma_cutter"
	inhand_icon_state = "plasma_cutter"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/necro)


/obj/item/ammo_casing/energy/plasma/necro
	projectile_type = /obj/projectile/plasma/necro

/obj/projectile/plasma/necro
	range = 8
