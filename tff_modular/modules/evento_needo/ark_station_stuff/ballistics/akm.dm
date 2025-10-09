/obj/item/gun/ballistic/automatic/akm
	name = "\improper KAR-84 carbine"
	desc = "Old developments of the InteQ weapons factories. A copy of one of the Old Empire's machine guns. Has a slightly cheaper price tag, and mercenaries don't need more."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "akm"
	lefthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "akm"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/akm
	can_suppress = FALSE
	fire_delay = 2.5
	actions_types = list()
	worn_icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "akm"
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/fire/akm_fire.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/ltrifle_cock.ogg'
	load_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/ltrifle_magin.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/ltrifle_magin.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/interact/ltrifle_magout.ogg'
	burst_size = 1

/obj/item/gun/ballistic/automatic/akm/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/// VARIETIES ///
/// INTEQ NEW
/obj/item/gun/ballistic/automatic/akm/modern
	name = "\improper KAR-19 carbine"
	desc = "An upgraded version of the KR-Q, InteQ assault rifles. It has a shorter firing delay and better reliability."
	icon_state = "akm_modern"
	inhand_icon_state = "akm"
	worn_icon_state = "akm"
	fire_delay = 1
	fire_sound = 'tff_modular/modules/evento_needo/ark_station_stuff/sound/guns/fire/ak12_fire.ogg'

/// INTEQ CIV
/obj/item/gun/ballistic/automatic/akm/civvie
	name = "\improper Sabel carbine"
	desc = "Civilian version of the KR-Q-12 assault rifles produced by InteQ."
	icon_state = "akm_civ"
	inhand_icon_state = "akm_civ"
	accepted_magazine_type = /obj/item/ammo_box/magazine/akm/civvie
	fire_delay = 5
	dual_wield_spread = 15
	spread = 5
	worn_icon_state = "akm_civ"
	recoil = 0.2
	projectile_damage_multiplier = 0.97

/// NRI
/obj/item/gun/ballistic/automatic/akm/nri
	name = "\improper IKAR-19 carbine"
	desc = "The newest version of the 'KR', a former weapon of the Old Empire, after the collapse the plans were given to the NRI."
	icon_state = "akm_nri"
	inhand_icon_state = "akm_nri"
	worn_icon_state = "akm_nri"
	can_suppress = TRUE

/obj/item/gun/ballistic/automatic/akm/nri/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, CARGO_COMPANY_NRI_SURPLUS)

/// AMMO ///
/obj/item/ammo_box/magazine/akm
	name = "KR-Q magazine"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo."
	icon = 'tff_modular/modules/evento_needo/ark_station_stuff/icons/guns/gunsgalore_items.dmi'
	icon_state = "akm"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39
	caliber = "a762x39"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/akm/ricochet
	name = "KR-Q magazine (MATCH)"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. Contains highly ricocheting ammunition."
	icon_state = "akm_ricochet"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/ricochet

/obj/item/ammo_box/magazine/akm/fire
	name = "KR magazine (INCENDIARY)"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. Contains incendiary ammunition."
	icon_state = "akm_fire"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/fire

/obj/item/ammo_box/magazine/akm/ap
	name = "KR-Q magazine (ARMOR PIERCING)"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. Contains armor-piercing ammunition."
	icon_state = "akm_ap"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/ap

/obj/item/ammo_box/magazine/akm/emp
	name = "KR-Q magazine (EMP)"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. Contains ion ammunition, good for disrupting electronics and wrecking mechas."
	icon_state = "akm_emp"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/emp

/obj/item/ammo_box/magazine/akm/rubber
	name = "KR-Q magazine (RUBBER)"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. Contains less-than-lethal rubber ammunition."
	icon_state = "akm_rubber"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/civilian/rubber

/obj/item/ammo_box/magazine/akm/banana
	name = "KR-Q extended magazine"
	desc = "a banana-shaped double-stack magazine able to hold 45 rounds of 5.6x40mm ammunition. It's meant to be used on a light machine gun, but it's just a longer KR-Q magazine."
	max_ammo = 45

/obj/item/ammo_box/magazine/akm/civvie
	name = "Sabel magazine"
	desc = "a shortened double-stack magazine able to hold 15 rounds of civilian-grade 5.6mm ammo."
	icon_state = "akm_civ"
	max_ammo = 15
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/civilian
	caliber = "a762x39civ"
