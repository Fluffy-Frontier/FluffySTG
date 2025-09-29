/obj/item/gun/ballistic/automatic/m16
	name = "\improper M-61 rifle"
	desc = "A cheap variation of the weapon used in the Civil War. Produced by the mercenary military industry InteQ."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "m16"
	lefthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "m16"
	worn_icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "m16"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/m16
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 2
	projectile_damage_multiplier = 0.57
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/fire/m16_fire.ogg'
	fire_sound_volume = 50
	rack_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/sfrifle_cock.ogg'
	load_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/sfrifle_magin.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/sfrifle_magin.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/sfrifle_magout.ogg'

/obj/item/ammo_box/magazine/m16
	name = "\improper M-61 magazine"
	desc = "A double-stack translucent polymer magazine for use with the M-61 rifles. Holds 30 rounds of .277 Aestus."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_items.dmi'
	icon_state = "m16e"
	ammo_type = /obj/item/ammo_casing/a223
	caliber = CALIBER_A223
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m16/vintage
	name = "outdated .277 magazine"
	desc = "A double-stack solid magazine that looks rather dated. Holds 20 rounds of .277 Aestus."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_items.dmi'
	icon_state = "m16"
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/// SOLFED
/obj/item/gun/ballistic/automatic/m16/modern
	name = "\improper M-61 Solar rifle"
	desc = "A newer version of the standard M-61. Shoots faster, has better flatness and reliability, and is fully automatic. The plans from the Old Empire were transferred to the Solar Federation after its collapse."
	icon_state = "m16_modern"
	inhand_icon_state = "m16"
	worn_icon_state = "m16"
	spread = 0.5
	burst_size = 1
	fire_delay = 1.90

/obj/item/gun/ballistic/automatic/m16/modern/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, CARGO_COMPANY_SOL_DEFENSE)


/obj/item/gun/ballistic/automatic/m16/modern/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/// INTEQ SHORT
/obj/item/gun/ballistic/automatic/m16/modern/v2
	name = "\improper M-61A1 rifle"
	desc = "An expertly modified, super-compact M-61 rifle designed for operating in tight corridors of ships. You're a mercenary, finish your mission!"
	icon_state = "m16_modern2"
	inhand_icon_state = "m16"
	worn_icon_state = "m16"
	accepted_magazine_type = /obj/item/ammo_box/magazine/m16/patriot
	fire_delay = 0.5
	projectile_damage_multiplier = 0.28

/obj/item/ammo_box/magazine/m16/patriot
	name = "\improper M-61A1 drum magazine"
	desc = "A double-stack solid polymer drum made for use with the M-61A1 rifle. Holds 50 rounds of .277 ammo."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_items.dmi'
	icon_state = "m16"
	max_ammo = 50
	multiple_sprites = AMMO_BOX_FULL_EMPTY
