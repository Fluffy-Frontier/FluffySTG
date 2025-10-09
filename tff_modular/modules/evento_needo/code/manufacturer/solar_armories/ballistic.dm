#define SOLAR_ATTACHMENTS list(/obj/item/attachment/laser_sight,/obj/item/attachment/rail_light,/obj/item/attachment/bayonet,/obj/item/attachment/energy_bayonet,/obj/item/attachment/scope,/obj/item/attachment/long_scope, /obj/item/attachment/gun, /obj/item/attachment/sling)
#define SOLAR_ATTACH_SLOTS list(ATTACHMENT_SLOT_MUZZLE = 1, ATTACHMENT_SLOT_SCOPE = 1, ATTACHMENT_SLOT_RAIL = 1)

///SOLAR ARMORIES
//fuck you im not typing the full name out
//solarwaffledesuckenmydickengeschutzenweaponmanufacturinglocation

///Pistols
/obj/item/gun/ballistic/automatic/powered/gauss/modelh
	name = "Model H"
	desc = "A standard-issue pistol exported from the Solarian Confederation. It fires slow flesh-rending ferromagnetic slugs at a high energy cost, however they are ineffective on any armor."

	icon = 'tff_modular/modules/evento_needo/icons/solararmories/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/solararmories/onmob.dmi'
	icon_state = "model-h"
	inhand_icon_state = "model-h"
	worn_icon_state = null
	fire_sound = 'tff_modular/modules/evento_needo/sounds/gauss/modelh.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/gauss/pistol_reload.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/modelh

	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	fire_delay = 0.6 SECONDS //pistol, but heavy caliber.
	empty_indicator = FALSE
	recoil = 2
	recoil_unwielded = 4
	spread = 6
	spread_unwielded = 12
	fire_select_icon_state_prefix = "slug_"

	//gauss doesn't explode so there's not light.
	light_range = 0

	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
	)

/obj/item/gun/ballistic/automatic/powered/gauss/modelh/suns
	desc = "A standard-issue pistol exported from the Solarian Confederation. It fires slow flesh-rending ferromagnetic slugs at a high energy cost, however they are ineffective on any armor. It is painted in the colors of SUNS."
	accepted_magazine_type = /obj/item/ammo_box/magazine/modelh
	icon_state = "model-h_suns"
	inhand_icon_state = "model-h_suns"

//not gauss pistol
/obj/item/gun/ballistic/automatic/pistol/solgov
	name = "\improper Pistole C"
	desc = "A favorite of the Terran Regency that is despised by the Solarian bureaucracy. Shifted out of military service centuries ago, though still popular among civilians. Chambered in 5.56mm caseless."
	icon_state = "pistole-c"
	inhand_icon_state = "model-h"
	worn_icon_state = null
	icon = 'tff_modular/modules/evento_needo/icons/solararmories/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/solararmories/onmob.dmi'

	weapon_weight = WEAPON_LIGHT
	accepted_magazine_type = /obj/item/ammo_box/magazine/pistol556mm
	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/pistolec.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/rack_small.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/lock_small.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/drop_small.ogg'

	fire_select_icon_state_prefix = "caseless_"

	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/ballistic/automatic/pistol/solgov/old
	icon_state = "pistole-c-old"

///Rifles

/obj/item/gun/ballistic/automatic/powered/gauss/claris
	name = "Claris"
	desc = "An antiquated Solarian rifle. Chambered in ferromagnetic pellets, just as the founding Solarians intended."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/claris
	icon = 'tff_modular/modules/evento_needo/icons/solararmories/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/solararmories/onmob.dmi'
	icon_state = "claris"
	inhand_icon_state = "claris"
	worn_icon_state = "claris"
	fire_sound = 'tff_modular/modules/evento_needo/sounds/gauss/claris.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/gauss/sniper_reload.ogg'
	fire_delay = 0.4 SECONDS
	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	empty_indicator = FALSE
	fire_select_icon_state_prefix = "pellet_"

	slot_flags = ITEM_SLOT_BACK

	valid_attachments = SOLAR_ATTACHMENTS
	slot_available = SOLAR_ATTACH_SLOTS
	//gauss doesn't explode so there's not light.
	light_range = 0


/obj/item/gun/ballistic/automatic/powered/gauss/claris/suns
	desc = "An antiquated Solarian rifle. Chambered in ferromagnetic pellets, just as the founding Solarians intended. Evidently, SUNS' founders echo the sentiment, as it appears to be painted in their colors."
	icon_state = "claris_suns"
	inhand_icon_state = "claris_suns"
	worn_icon_state = "claris_suns"

/obj/item/gun/ballistic/automatic/powered/gauss/gar
	name = "Solar 'GAR' Carbine"
	desc = "A Solarian carbine, unusually modern for its producers. Launches ferromagnetic lances at alarming speeds."
	accepted_magazine_type = /obj/item/ammo_box/magazine/gar
	icon = 'tff_modular/modules/evento_needo/icons/solararmories/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/solararmories/onmob.dmi'
	icon_state = "gar"
	inhand_icon_state = "gar"
	worn_icon_state = "gar"
	fire_sound = 'tff_modular/modules/evento_needo/sounds/gauss/gar.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/gauss/rifle_reload.ogg'
	burst_size = 1

	fire_delay = 0.2 SECONDS

	actions_types = list()
	empty_indicator = FALSE

	slot_flags = ITEM_SLOT_BACK

	valid_attachments = SOLAR_ATTACHMENTS
	slot_available = SOLAR_ATTACH_SLOTS

	//gauss doesn't explode so there's not light.
	light_range = 0

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO
	fire_select_icon_state_prefix = "lance_"

/obj/item/gun/ballistic/automatic/powered/gauss/gar/suns
	desc = "A Solarian carbine, unusually modern for its producers. It's just modern enough for SUNS, however, who have painted the weapon in their colors. Launches ferromagnetic lances at alarming speeds."
	icon_state = "gar_suns"
	inhand_icon_state = "gar_suns"

///Sniper
/obj/item/gun/ballistic/rifle/solgov
	name = "SSG-669C"
	desc = "A bolt-action sniper rifle used by Solarian troops. Beloved for its rotary design and accuracy. Chambered in 8x58mm Caseless."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/solgov
	icon_state = "ssg669c"
	inhand_icon_state = "ssg669c"
	worn_icon_state = "ssg669c"
	icon = 'tff_modular/modules/evento_needo/icons/solararmories/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/solararmories/onmob.dmi'

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ssg669c.ogg'
	can_be_sawn_off = FALSE

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	spread = -5
	spread_unwielded = 20
	recoil = 1
	recoil_unwielded = 8
	wield_slowdown = SNIPER_SLOWDOWN
