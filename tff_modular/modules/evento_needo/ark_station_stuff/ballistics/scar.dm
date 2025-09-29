/obj/item/gun/ballistic/automatic/scar
	name = "SCAR-L"
	desc = "Part of the SCAR family rifles. This one is SCAR-L, which is for 'Light'. Chambered in .277 Aestus."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "scar"
	lefthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "scar"
	worn_icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "scar"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/scar
	can_suppress = FALSE
	fire_delay = 2.4
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/fire/scar_fire.ogg'
	fire_sound_volume = 50
	rack_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/scar_cock.ogg'
	load_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/scar_mag_out.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/scar_mag_in.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/scar_mag_out.ogg'
	burst_size = 1

/obj/item/gun/ballistic/automatic/scar/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/scar
	name = "\improper SCAR-L magazine"
	desc = "A double-stack translucent polymer magazine for use with the M-61 rifles. Holds 30 rounds of .277 Aestus."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_items.dmi'
	icon_state = "stg"
	ammo_type = /obj/item/ammo_casing/a223
	caliber = CALIBER_A223
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY
