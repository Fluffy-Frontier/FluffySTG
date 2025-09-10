/obj/item/gun/ballistic/automatic/pistol/commander
	name = "VI Commander"
	desc = "A service pistol produced as Vigilitas Interstellar's standard sidearm. Has a reputation for being easy to use, due to its light recoil and high magazine capacity. Chambered in 9x18mm."
	icon_state = "commander"
	inhand_icon_state = "nt_generic"
	icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/nanotrasen_sharplite/onmob.dmi'

	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = list(
		/obj/item/ammo_box/magazine/co9mm,
	)
	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/rattlesnake.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/rack_small.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/lock_small.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/drop_small.ogg'

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 29,
			"y" = 21,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 20,
			"y" = 17,
		)
	)

/obj/item/gun/ballistic/automatic/pistol/commander/inteq
	name = "PS-03 Commissioner"
	desc = "A modified version of the VI Commander, issued as standard to Inteq Risk Management Group personnel. Features the same excellent handling and high magazine capacity as the original. Chambered in 9x18mm."

	icon = 'tff_modular/modules/evento_needo/icons/inteq/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/inteq/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/inteq/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/inteq/onmob.dmi'
	icon_state = "commander_inteq"
	inhand_icon_state = "inteq_generic"
	worn_icon_state = null
