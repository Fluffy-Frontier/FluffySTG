/obj/item/gun/ballistic/automatic/ff/m221
	name = "\improper M221 Submachine Gun"
	desc = "A compact submachine gun firing .35 Sol. Looks like a captured weapon of the Solar Federation officers."

	icon = 'tff_modular/modules/guns/icons/obj/guns32x.dmi'
	icon_state = "m221"

	lefthand_file = 'tff_modular/modules/guns/icons/mob/guns_lefthand.dmi'
	righthand_file = 'tff_modular/modules/guns/icons/mob/guns_righthand.dmi'
	inhand_icon_state = "m221"

	special_mags = TRUE

	bolt_type = BOLT_TYPE_OPEN

	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/ff/m221
	spawn_magazine_type = /obj/item/ammo_box/magazine/ff/m221

	fire_sound = 'tff_modular/modules/guns/sounds/m221.ogg'
	can_suppress = FALSE

	burst_size = 3
	fire_delay = 0.2 SECONDS

	spread = 7.5

	projectile_damage_multiplier = 0.85

/obj/item/gun/ballistic/automatic/ff/m221/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/automatic/ff/m221/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/ff/m221/examine_more(mob/user)
	. = ..()

	. += "The M221 Submachine Gun was originally produced in the Solar Federation. \
		These weapons were supplied to peacekeeping forces on SolFed frontiers."

	return .


/obj/item/ammo_box/magazine/ff/m221
	name = "\improper Sol pistol magazine"
	desc = "A standard size magazine for SolFed pistols, holds twelve rounds."

	icon = 'tff_modular/modules/guns/icons/obj/ammo.dmi'
	icon_state = "m221_standart"
	base_icon_state = "m221_standart"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_SMALL

	ammo_type = /obj/item/ammo_casing/c35sol
	caliber = CALIBER_SOL35SHORT
	max_ammo = 24

/obj/item/ammo_box/magazine/ff/m221/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 2)]"

/obj/item/ammo_box/magazine/ff/m221/starts_empty
	start_empty = TRUE
