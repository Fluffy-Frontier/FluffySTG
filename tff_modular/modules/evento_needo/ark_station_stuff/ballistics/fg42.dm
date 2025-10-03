/obj/item/gun/ballistic/automatic/fg42
	name = "\improper FG-42 rifle"
	desc = "A long-barreled rifle designed for long range shooting in 7.92x57mm caliber."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "fg42"
	lefthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "fg42"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/fg42
	can_suppress = FALSE
	burst_size = 1
	spread = 0
	fire_delay = 3
	worn_icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "fg42"
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/fire/fg42_fire.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/batrifle_cock.ogg'
	load_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/batrifle_magin.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/batrifle_magin.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/batrifle_magout.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/batrifle_magout.ogg'

/obj/item/gun/ballistic/automatic/fg42/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 1)
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/fg42
	name = "FG-42 magazine (7.92x57mm)"
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_items.dmi'
	icon_state = "fg42"
	ammo_type = /obj/item/ammo_casing/realistic/a792x57
	caliber = "a792x57"
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY
