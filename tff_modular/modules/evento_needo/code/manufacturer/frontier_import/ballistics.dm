/obj/item/gun/ballistic/automatic/pistol/mauler
	name = "Mauler machine pistol"
	desc = "An automatic machine pistol originating from the Shoal. Impressive volume of fire with abysmal accuracy, lackluster armor penetration, and limited magazine size render it mostly useless outside of very close quarters. Chambered in 9x18mm."
	icon = 'tff_modular/modules/evento_needo/icons/frontier_import/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/frontier_import/onmob.dmi'

	icon_state = "mauler"
	inhand_icon_state = "hp_generic"
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm_mauler
	fire_delay = 0.9 SECONDS

	spread = 20
	recoil = 0.4
	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mauler.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_cocked.ogg'

	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/slide_lock.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_cocked.ogg'

	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_unload.ogg'

/obj/item/gun/ballistic/automatic/pistol/mauler/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/m9mm_mauler
	name = "mauler machine pistol magazine (9x18mm)"
	desc = "A 12-round magazine designed for the Mauler machine pistol."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "mauler_mag-1"
	base_icon_state = "mauler_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 12

/obj/item/ammo_box/magazine/m9mm_mauler/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/gun/ballistic/automatic/pistol/spitter
	name = "\improper Spitter"
	desc = "An open-bolt submachine gun favored by the Frontiersmen. This design's origins are unclear, but its simple, robust design has been widely copied throughout the Frontier, and it is stereotypically used by pirates and various criminal groups that value low price and ease of concealment. Chambered in 9x18mm."
	icon = 'tff_modular/modules/evento_needo/icons/frontier_import/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/frontier_import/onmob.dmi'

	icon_state = "spitter"
	inhand_icon_state = "spitter"
	accepted_magazine_type = /obj/item/ammo_box/magazine/spitter_9mm
	bolt_type = BOLT_TYPE_OPEN
	weapon_weight = WEAPON_LIGHT
	fire_delay = 0.7 SECONDS
	spread = 20

	fire_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter_cocked.ogg'
	rack_sound_vary = FALSE

	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	load_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/spitter_unload.ogg'

/obj/item/gun/ballistic/automatic/pistol/spitter/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/spitter_9mm
	name = "spitter pistol magazine (9x18mm)"
	desc = "A thin 30-round magazine for the Spitter submachine gun."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "spitter_mag-1"
	base_icon_state = "spitter_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 30

/obj/item/ammo_box/magazine/spitter_9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

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
	accepted_magazine_type = /obj/item/ammo_box/magazine/c22lr_pounder_pan
	burst_size = 4
	burst_delay = 0.2 SECONDS
	spread = 20

	fire_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder_cocked.ogg'
	rack_sound_vary = FALSE

	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	load_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/pounder_unload.ogg'

/obj/item/ammo_box/magazine/c22lr_pounder_pan
	name = "pan magazine (.22 LR)"
	desc = "A 50-round pan magazine for the Pounder submachine gun."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "firestorm_pan"
	base_icon_state = "firestorm_pan"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = CALIBER_22LR
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/c22lr_pounder_pan/update_icon_state()
	. = ..()
	icon_state = "firestorm_pan"

/obj/item/gun/ballistic/automatic/hmg/shredder
	name = "\improper Shredder"
	desc = "A vastly atypical heavy machine gun, extensively modified by the Frontiersmen. Additional grips have been added to enable firing from the hip, and it has been modified to fire belts of shotgun shells. Chambered in 12g."
	icon = 'tff_modular/modules/evento_needo/icons/frontier_import/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/frontier_import/onmob.dmi'

	icon_state = "shredder"
	inhand_icon_state = "shredder"
	accepted_magazine_type = /obj/item/ammo_box/magazine/m12_shredder
	spread = 15
	recoil = 3
	mag_display_ammo = TRUE
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

/obj/item/ammo_box/magazine/m12_shredder
	name = "belt box (12g)"
	desc = "A 40-round belt box for the Shredder heavy machine gun."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "shredder_mag-1"
	base_icon_state = "shredder_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/m12_shredder/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m12_shredder/slug
	name = "belt box (12g slug)"
	desc = "A 40-round belt box for the Shredder heavy machine gun."
	icon_state = "shredder_mag_slug-1"
	base_icon_state = "shredder_mag_slug"
	ammo_type = /obj/item/ammo_casing/shotgun
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL
