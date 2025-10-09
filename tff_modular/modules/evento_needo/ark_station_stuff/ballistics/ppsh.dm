/obj/item/gun/ballistic/automatic/ppsh // Dont Use in GunCargo
	name = "\improper SSG-41"
	desc = "A reproduction of a simple Soviet SMG chambered in 7.62x25 Tokarev rounds. Its heavy wooden stock and leather breech buffer help absorb the bolt’s heavy recoil, making it great for spraying and praying. Uraaaa!"
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "ppsh"
	lefthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "ppsh"
	worn_icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "ppsh"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/ppsh
	can_suppress = FALSE
	spread = 20
	fire_delay = 0.5
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/fire/ppsh_fire.ogg'
	fire_sound_volume = 80
	burst_size = 1
	rack_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/smg_cock.ogg'
	load_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/smg_magin.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/smg_magin.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/smg_magout.ogg'

/obj/item/gun/ballistic/automatic/ppsh/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/ppsh
	name = "SSG-56 magazine (7.62x25mm)"
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_items.dmi'
	icon_state = "ppsh"
	ammo_type = /obj/item/ammo_casing/realistic/a762x25
	caliber = "a762x25"
	max_ammo = 71
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/ppsh/modern
	name = "\improper SSG-56"
	desc = "The old rifle of the Old Empire. It was used during the Civil War. The blueprints were transferred to InteQ mercenaries, and they began to use this weapons as a cheap replacement for new products."
	icon_state = "ppsh_modern"
	worn_icon_state = "ppsh"
	inhand_icon_state = "ppsh"
	spread = 15
	burst_size = 1
