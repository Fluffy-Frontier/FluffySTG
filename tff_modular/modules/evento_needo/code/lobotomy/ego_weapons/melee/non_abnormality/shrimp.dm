// All of these are usably by clerks

/obj/item/ego_weapon/ranged/shrimp/minigun
	name = "soda minigun"
	desc = "A gun used by shrimp corp, apparently."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_weapons.dmi'
	icon_state = "sodaminigun"
	inhand_icon_state = "sodaminigun"
	force = 31
	attack_speed = 5.8
	projectile_path = /obj/projectile/ego_bullet/ego_soda
	weapon_weight = WEAPON_HEAVY
	drag_slowdown = 3
	slowdown = 2
	spread = 40
	item_flags = SLOWS_WHILE_IN_HAND
	projectile_damage_multiplier = 0.60
	fire_sound = 'sound/items/weapons/gun/smg/shot.ogg'
	autofire = 0.04 SECONDS

/obj/item/ego_weapon/ranged/shrimp/assault
	name = "soda assault rifle"
	desc = "A gun used by shrimp corp, apparently."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_weapons.dmi'
	icon_state = "sodaassault"
	inhand_icon_state = "sodaassault"
	force = 11
	projectile_path = /obj/projectile/ego_bullet/ego_soda
	weapon_weight = WEAPON_HEAVY
	burst_size = 3
	fire_delay = 5
	fire_sound = 'sound/items/weapons/gun/rifle/shot.ogg'

/obj/item/ego_weapon/ranged/shrimp/rambominigun
	name = "Shrimp Rambo's Minigun"
	desc = "A gun used by THE shrimp rambo."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_weapons.dmi'
	icon_state = "sodaminigun"
	inhand_icon_state = "sodaminigun"
	force = 105
	attack_speed = 5.7
	projectile_path = /obj/projectile/ego_bullet/ego_soda
	weapon_weight = WEAPON_HEAVY
	drag_slowdown = 2
	slowdown = 1.5
	item_flags = SLOWS_WHILE_IN_HAND
	fire_sound = 'sound/items/weapons/gun/smg/shot.ogg'
	autofire = 0.01 SECONDS
