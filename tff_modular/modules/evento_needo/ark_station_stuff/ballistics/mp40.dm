/obj/item/gun/ballistic/automatic/mp40 // Dont Use in GunCargo
	name = "\improper MP-40"
	desc = "The instantly recognizable 'kraut gun'. Extremely outdated SMG that has only seen service during Sol-3's second World War. This one's a poor, unlicensed reproduction."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "mp40"
	lefthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "mp40"
	worn_icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "mp40"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/mp40
	weapon_weight = WEAPON_HEAVY
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 1.7
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/fire/mp40_fire.ogg'
	fire_sound_volume = 100
	rack_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/smg_cock.ogg'
	load_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/smg_magin.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/smg_magin.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/smg_magout.ogg'


/obj/item/gun/ballistic/automatic/mp40/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/mp40
	name = "SSG-56 Modern magazine (9mmx19)"
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_items.dmi'
	icon_state = "mp40"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 32
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/mp40/modern
	name = "\improper SSG-56 Modern"
	desc = "An Old Empire gun that was also used in the Civil War. InteQ mercenaries took the old designs and put this old gun into circulation. Thanks to its short barrel, it was used by pilots and tank crews."
	icon_state = "mp40_modern"
	inhand_icon_state = "mp40"
	worn_icon_state = "mp40"
	burst_size = 1
	fire_delay = 1.5
