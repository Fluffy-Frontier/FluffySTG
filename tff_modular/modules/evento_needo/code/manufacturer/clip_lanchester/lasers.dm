/obj/item/gun/energy/kalix/clip
	name = "ECM-6"
	desc = "A modernized copy of the ECM-1, CLIP's first service weapon. Features a number of improvements to bring the aging design back into the modern age."
	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	icon_state = "cm1"
	inhand_icon_state = "cm1"
	worn_icon_state = "cm1"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO
	wield_slowdown = LASER_SMG_SLOWDOWN
	ammo_type = list(/obj/item/ammo_casing/energy/kalix, /obj/item/ammo_casing/energy/disabler/hitscan)

/obj/item/gun/energy/kalix/clip/old
	name = "ECM-1"
	desc = "This is either a flawless replica, or a genuine example of the colonial-era laser weaponry issued to Free Zohil forces in CLIP's founding years. Over a hundred years old, and especially difficult to source replacement parts for, but still deadly. Kept around for ceremonial use in the CLIP Minutemen, and, rarely, for influential members of all divisions."

	ammo_type = list(/obj/item/ammo_casing/energy/kalix)

/obj/item/gun/energy/laser/e50/clip
	name = "ECM-50"
	desc = "An extensive modification of the Eoehoma E-50 Emitter by Clover Photonics, customized for CLIP-BARD to fight Xenofauna. Sacrifices some of the E-50's raw power for vastly improved energy efficiency, while preserving its incendiary side-effects."

	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	icon_state = "cm50"
	inhand_icon_state = "cm50"
	worn_icon_state = "cm50"
	shaded_charge = TRUE
	charge_sections = 4

	ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/e50/clip)

/obj/item/ammo_casing/energy/laser/eoehoma/e50/clip
	projectile_type = /obj/projectile/beam/emitter/hitscan/clip
	fire_sound = 'tff_modular/modules/evento_needo/sounds/laser/heavy_laser.ogg'
	e_cost = 6250
	delay = 0.6 SECONDS

/obj/projectile/beam/emitter/hitscan/clip
	damage = 35
