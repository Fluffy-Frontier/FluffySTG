/obj/item/gun/energy/kalix
	name = "Etherbor BG-12"
	desc = "Etherbor Industries's current civilian energy weapon model. The BG-12 energy beam gun is identical to the military model, minus the removal of the full auto mode. Otherwise, it's no different from older hunting beams from Kalixcis's history."
	icon_state = "kalixgun"
	inhand_icon_state = "kalixgun"
	icon = 'tff_modular/modules/evento_needo/icons/etherbor/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/etherbor/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/etherbor/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/etherbor/onmob.dmi'
	w_class = WEIGHT_CLASS_BULKY

	modifystate = TRUE

	wield_slowdown = LASER_SMG_SLOWDOWN
	ammo_type = list(/obj/item/ammo_casing/energy/kalix, /obj/item/ammo_casing/energy/disabler/hitscan)

	load_sound = 'tff_modular/modules/evento_needo/sounds/gauss/pistol_reload.ogg'

/obj/item/ammo_casing/energy/kalix
	projectile_type = /obj/projectile/beam/hitscan/kalix
	fire_sound = 'tff_modular/modules/evento_needo/sounds/energy/kalixsmg.ogg'
	e_cost = LASER_SHOTS(16, STANDARD_CELL_CHARGE) //30 shots per cell
	delay = 0.55 SECONDS

/obj/projectile/beam/hitscan/kalix
	name = "concentrated energy"
	tracer_type = /obj/effect/projectile/tracer/kalix
	muzzle_type = /obj/effect/projectile/muzzle/kalix
	impact_type = /obj/effect/projectile/impact/kalix
	hitscan_light_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	muzzle_flash_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	impact_light_color_override = LIGHT_COLOR_ELECTRIC_CYAN
	range = 12
	damage_constant = 0.8
	damage = 14
	armour_penetration = -10

/obj/item/gun/energy/kalix/pgf
	name = "Etherbor BG-16"
	desc = "The BG-16 is the military-grade beam gun designed and manufactured by Etherbor Industries as the standard-issue close-range weapon of the PGF."
	icon_state = "pgfgun"
	inhand_icon_state = "pgfgun"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO
	wield_slowdown = LASER_SMG_SLOWDOWN
	ammo_type = list(/obj/item/ammo_casing/energy/kalix/pgf , /obj/item/ammo_casing/energy/disabler/hitscan)

/obj/projectile/beam/hitscan/kalix/pgf
	name = "concentrated energy"
	tracer_type = /obj/effect/projectile/tracer/pgf
	muzzle_type = /obj/effect/projectile/muzzle/pgf
	impact_type = /obj/effect/projectile/impact/pgf
	hitscan_light_color_override = LIGHT_COLOR_ELECTRIC_GREEN
	muzzle_flash_color_override = LIGHT_COLOR_ELECTRIC_GREEN
	impact_light_color_override = LIGHT_COLOR_ELECTRIC_GREEN

/obj/item/ammo_casing/energy/kalix/pgf
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf
	fire_sound = 'tff_modular/modules/evento_needo/sounds/energy/kalixsmg.ogg'
	e_cost = LASER_SHOTS(16, STANDARD_CELL_CHARGE)
	delay = 0.75 SECONDS

/obj/item/gun/energy/kalix/pistol //blue
	name = "Etherbor SG-8"
	desc = "Etherbor's current and sidearm offering. While marketed for the military, it's also available for civillians as an upgrade over older and obsolete beam pistols."
	icon_state = "kalixpistol"
	inhand_icon_state = "kalixpistol"
	w_class = WEIGHT_CLASS_NORMAL
	modifystate = FALSE
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	spread = 2
	spread_unwielded = 5
	ammo_type = list(/obj/item/ammo_casing/energy/kalix/pistol)


	load_sound = 'tff_modular/modules/evento_needo/sounds/gauss/pistol_reload.ogg'

	refused_attachments = list(
		/obj/item/attachment/gun,
		/obj/item/attachment/sling
		)

/obj/item/ammo_casing/energy/kalix/pistol
	fire_sound = 'tff_modular/modules/evento_needo/sounds/energy/kalixpistol.ogg'
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE) //10 shots per cell
	delay = 0.35 SECONDS

/obj/item/gun/energy/kalix/pgf/medium
	name = "Etherbor BGC-10"
	desc = "Etherbor's answer to the PGFMC's request for a carbine style weapon; the BGC-10 offers greater accuracy and power than the BG-16, while being less cumbersome than the DMR mode equipped HBG series rifles."
	icon_state = "pgfmedium"
	inhand_icon_state = "pgfmedium"
	slot_flags = ITEM_SLOT_BACK

	modifystate = TRUE

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	wield_slowdown = LASER_RIFLE_SLOWDOWN

	spread = 0.5
	spread_unwielded = 15

	ammo_type = list(/obj/item/ammo_casing/energy/pgf/assault , /obj/item/ammo_casing/energy/disabler/hitscan)

/obj/item/gun/energy/kalix/pgf/heavy
	name = "Etherbor HBG-7"
	desc = "The HBG-7 is the standard-issue rifle weapon of the PGF. It comes with a special DMR mode that has greater armor piercing for dealing with armored targets."
	icon_state = "pgfheavy"
	inhand_icon_state = "pgfheavy"
	slot_flags = ITEM_SLOT_BACK

	modifystate = FALSE

	wield_slowdown = HEAVY_LASER_RIFLE_SLOWDOWN

	spread = 0
	spread_unwielded = 20

	ammo_type = list(/obj/item/ammo_casing/energy/pgf/assault, /obj/item/ammo_casing/energy/pgf/sniper)

/obj/item/ammo_casing/energy/pgf/assault
	select_name  = "AR"
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf/assault
	fire_sound = 'tff_modular/modules/evento_needo/sounds/energy/kalixrifle.ogg'
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)
	delay = 0.65 SECONDS

/obj/projectile/beam/hitscan/kalix/pgf/assault
	tracer_type = /obj/effect/projectile/tracer/pgf/rifle
	muzzle_type = /obj/effect/projectile/muzzle/pgf/rifle
	impact_type = /obj/effect/projectile/impact/pgf/rifle
	damage = 25 //bar
	armour_penetration = 20
	range = 14
	damage_constant = 0.9

/obj/item/ammo_casing/energy/pgf/sniper
	select_name  = "DMR"
	projectile_type = /obj/projectile/beam/hitscan/kalix/pgf/sniper
	fire_sound = 'tff_modular/modules/evento_needo/sounds/laser/heavy_laser.ogg'
	e_cost = 2000 //20 shots per cell
	delay = 1.8 SECONDS

/obj/projectile/beam/hitscan/kalix/pgf/sniper
	tracer_type = /obj/effect/projectile/tracer/laser/emitter
	muzzle_type = /obj/effect/projectile/muzzle/laser/emitter
	impact_type = /obj/effect/projectile/impact/laser/emitter

	damage = 40
	armour_penetration = 40
	range = 20
	damage_constant = 1

/obj/item/gun/energy/kalix/pgf/heavy/sniper
	name = "Etherbor HBG-7L"
	desc = "HBG-7 with a longer barrel and scope. Intended to get the best use out of the DMR mode, it suffers from longer wield times and slowdown, but it's longer barrel makes it ideal for accuracy."
	icon_state = "pgfheavy_sniper"
	inhand_icon_state = "pgfheavy_sniper"

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	spread = -5
	spread_unwielded = 40

	wield_slowdown = LASER_SNIPER_SLOWDOWN
