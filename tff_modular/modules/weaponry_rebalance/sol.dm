/obj/item/gun/ballistic/shotgun/riot/sol
	fire_delay = 0.8 SECONDS

/obj/item/gun/ballistic/shotgun/riot/sol/super
	fire_delay = 0.75 SECONDS

/obj/item/gun/ballistic/shotgun/doublebarrel
	fire_delay = 1 SECONDS

/obj/item/gun/ballistic/shotgun/doublebarrel
	pb_knockback = 2

/obj/item/gun/ballistic/shotgun/doublebarrel/super/on_booster_toggle(datum/component/source, mob/user, amped)
	if(amped)
		fire_sound = amped_fire_sound
		recoil = amped_recoil
		pb_knockback = 3
		balloon_alert(user, "barrels amped")
	else
		fire_sound = base_fire_sound
		recoil = base_recoil
		pb_knockback = initial(pb_knockback)
		balloon_alert(user, "barrels de-amped")

/datum/supply_pack/companies/ballistics/sol_fed/longarm/outomaties
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle)
	cost = CARGO_CRATE_VALUE * 7

/obj/item/gun/ballistic/shotgun/riot/sol/super/plus
	projectile_damage_multiplier = 1.25

/obj/item/gun/ballistic/automatic/sol_rifle
	projectile_damage_multiplier = 0.8

/obj/item/gun/ballistic/automatic/sol_rifle/marksman
	projectile_damage_multiplier = 1
