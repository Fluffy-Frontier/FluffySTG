/obj/projectile/energy/christmas_present
	name = "christmas present"
	icon = 'icons/obj/holiday/christmas.dmi'
	icon_state = "gift1"
	damage = 0
	speed = 1
	impact_effect_type = null
	damage_type = BRUTE
	armor_flag = MELEE
	reflectable = FALSE

/obj/projectile/energy/christmas_present/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(!isliving(target))
		return FALSE
	var/turf/victim_loc = target.loc
	new /obj/item/gift/anything(victim_loc)

/obj/item/ammo_casing/energy/christmas_present
	projectile_type = /obj/projectile/energy/christmas_present
	e_cost = 0

/obj/item/gun/energy/christmas_gun
	name = "christmas present launcher"
	desc = "A weapon that launches christmas presents."
	icon_state = "meteor_gun"
	ammo_type = list(/obj/item/ammo_casing/energy/christmas_present)
	cell_type = /obj/item/stock_parts/power_store/cell/infinite
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	inhand_icon_state = "c20r"
