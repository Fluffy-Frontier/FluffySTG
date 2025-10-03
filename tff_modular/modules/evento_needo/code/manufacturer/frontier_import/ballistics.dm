/obj/item/gun/ballistic/automatic/pistol/mauler
	name = "Mauler machine pistol"
	desc = "An automatic machine pistol originating from the Shoal. Impressive volume of fire with abysmal accuracy, lackluster armor penetration, and limited magazine size render it mostly useless outside of very close quarters. Chambered in 9x18mm."
	icon = 'tff_modular/modules/evento_needo/icons/frontier_import/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/frontier_import/onmob.dmi'

	icon_state = "mauler"
	inhand_icon_state = "hp_generic"
	worn_icon_state = null
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm_mauler
	fire_delay = 0.3 SECONDS


	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

	spread = 15
	recoil = 0.4
	spread_unwielded = 20
	recoil_unwielded = 3
	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mauler.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_cocked.ogg'

	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/slide_lock.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_cocked.ogg'

	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_unload.ogg'

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 44,
			"y" = 21,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 20,
			"y" = 19,
		)
	)

/obj/item/gun/ballistic/automatic/pistol/spitter
	name = "\improper Spitter"
	desc = "An open-bolt submachine gun favored by the Frontiersmen. This design's origins are unclear, but its simple, robust design has been widely copied throughout the Frontier, and it is stereotypically used by pirates and various criminal groups that value low price and ease of concealment. Chambered in 9x18mm."
	icon = 'tff_modular/modules/evento_needo/icons/frontier_import/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/frontier_import/onmob.dmi'

	icon_state = "spitter"
	inhand_icon_state = "spitter"
	worn_icon_state = null
	accepted_magazine_type = /obj/item/ammo_box/magazine/spitter_9mm
	bolt_type = BOLT_TYPE_OPEN
	weapon_weight = WEAPON_LIGHT
	fire_delay = 0.2 SECONDS
	spread = 25

	spread_unwielded = 35
	dual_wield_spread = 35
	wield_slowdown = SMG_SLOWDOWN
	fire_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter_cocked.ogg'
	rack_sound_vary = FALSE

	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	load_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter_unload.ogg'

	valid_attachments = list(
		/obj/item/attachment/silencer,
		/obj/item/attachment/foldable_stock/spitter
	)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_STOCK = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 32,
			"y" = 23,
		),
		ATTACHMENT_SLOT_STOCK = list(
			"x" = -5,
			"y" = 18,
		)
	)

	default_attachments = list(/obj/item/attachment/foldable_stock/spitter)

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

/obj/item/gun/ballistic/automatic/smg/pounder
	name = "Pounder"
	desc = "An unusual submachine gun of Frontiersman make. A miniscule cartridge lacking both stopping power and armor penetration is compensated for with best-in-class ammunition capacity and cycle rate. Chambered in .22 LR."
	icon = 'tff_modular/modules/evento_needo/icons/frontier_import/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/frontier_import/onmob.dmi'
	w_class = WEIGHT_CLASS_BULKY //this gun is visually larger, so I believe this is good

	icon_state = "pounder"
	inhand_icon_state = "pounder"
	worn_icon_state = "pounder"
	accepted_magazine_type = /obj/item/ammo_box/magazine/c22lr_pounder_pan
	burst_size = 4
	burst_delay = 0.2 SECONDS
	spread = 20
	spread_unwielded = 50

	fire_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder_cocked.ogg'
	rack_sound_vary = FALSE

	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	load_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder_unload.ogg'

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

	wield_slowdown = SMG_SLOWDOWN

	refused_attachments = list(/obj/item/attachment/gun)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 46,
			"y" = 18,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 40,
			"y" = 17,
		)
	)

/obj/item/gun/ballistic/automatic/hmg/shredder
	name = "\improper Shredder"
	desc = "A vastly atypical heavy machine gun, extensively modified by the Frontiersmen. Additional grips have been added to enable firing from the hip, and it has been modified to fire belts of shotgun shells. Chambered in 12g."
	icon = 'tff_modular/modules/evento_needo/icons/frontier_import/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/frontier_import/onmob.dmi'

	icon_state = "shredder"
	inhand_icon_state = "shredder"
	worn_icon_state = "shredder"
	accepted_magazine_type = /obj/item/ammo_box/magazine/m12_shredder
	spread = 15
	recoil = 3
	recoil_unwielded = 7
	fire_delay = 1 SECONDS
	burst_delay = 5
	bolt_type = BOLT_TYPE_STANDARD
	tac_reloads = FALSE
	fire_sound = 'tff_modular/modules/evento_needo/sounds/hmg/shredder.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/hmg/shredder_cocked_alt.ogg'

	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	load_sound = 'tff_modular/modules/evento_needo/sounds/hmg/shredder_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/hmg/shredder_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/hmg/shredder_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/hmg/shredder_unload.ogg'

	has_bipod = FALSE

	refused_attachments = list(/obj/item/attachment)

	slot_available = list()
