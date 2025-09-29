#define SERENE_ATTACHMENTS list(/obj/item/attachment/rail_light, /obj/item/attachment/bayonet,/obj/item/attachment/scope,/obj/item/attachment/long_scope, /obj/item/attachment/sling, /obj/item/attachment/gun, /obj/item/attachment/ammo_counter)
#define SERENE_ATTACH_SLOTS list(ATTACHMENT_SLOT_MUZZLE = 1, ATTACHMENT_SLOT_RAIL = 1, ATTACHMENT_SLOT_SCOPE = 1)

/* Micro Target */

/obj/item/gun/ballistic/automatic/pistol/m17
	name = "Model 17 \"Micro Target\""
	desc = "A lightweight and very accurate target pistol produced by Serene Outdoors. The barrel can be unscrewed for storage. Chambered in .22 LR."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "m17"
	inhand_icon_state = "so_generic"
	worn_icon_state = null
	show_bolt_icon = FALSE
	mag_display = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m17

	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/himehabu.ogg'

	bolt_type = BOLT_TYPE_LOCKING

	w_class = WEIGHT_CLASS_SMALL

	spread = 15
	spread_unwielded = 35
	recoil = -2
	recoil_unwielded = -2

	wield_slowdown = PISTOL_SLOWDOWN

	valid_attachments = list(
		/obj/item/attachment/m17_barrel,
	)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 30,
			"y" = 23,
		),
	)

	default_attachments = list(/obj/item/attachment/m17_barrel)

/* Auto Elite */

/obj/item/gun/ballistic/automatic/pistol/m20_auto_elite
	name = "Model 20 \"Auto Elite\""
	desc = "A large handgun chambered .44 Roumain. Originally developed by Serene Outdoors for the Star City Police Department when their older handguns proved underpowered, the Auto Elite proved heavy and unwieldy in practice. It has nevertheless seen modest success as a sidearm for big game hunters and among customers looking to make an impression."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "m20"
	inhand_icon_state = "so_generic"
	mag_display = FALSE
	worn_icon_state = null
	accepted_magazine_type = /obj/item/ammo_box/magazine/m20_auto_elite

	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/cm23.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_cocked.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/slide_lock.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/slide_drop.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/deagle_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/deagle_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/deagle_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/deagle_unload.ogg'

	recoil_unwielded = 4
	recoil = 1

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 33,
			"y" = 22,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 17,
		)
	)

/* Sporter */

/obj/item/gun/ballistic/automatic/m12_sporter
	name = "Model 12 \"Sporter\""
	desc = "An extremely popular target shooting rifle produced by Serene Outdoors. Inexpensive, widely available, and produced in massive numbers, the Sporter is also popular for hunting small game and ground birds. Chambered in .22 LR."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "m12"
	inhand_icon_state = "m12"
	worn_icon_state = "m12"
	show_bolt_icon = FALSE

	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/m12_sporter

	fire_delay =  0.4 SECONDS
	burst_size = 1
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	burst_fire_selection = FALSE
	bolt_type = BOLT_TYPE_LOCKING

	fire_sound = 'tff_modular/modules/evento_needo/sounds/gauss/claris.ogg'

	spread = 0
	spread_unwielded = 15
	recoil = 0
	recoil_unwielded = 2
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	valid_attachments = SERENE_ATTACHMENTS
	slot_available = SERENE_ATTACH_SLOTS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 44,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 17,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 28,
			"y" = 17,
		)
	)

/obj/item/gun/ballistic/automatic/m12_sporter/mod
	name = "Model 13 \"Larker\""
	desc = "A common after-market modification of the Model 12 \"Sporter\" rifle, keyed to fire a three round burst."
	burst_size = 3
	burst_delay = 0.6

	icon_state = "larker"
	inhand_icon_state = "larker"
	worn_icon_state = "larker"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	gun_firenames = list(FIREMODE_SEMIAUTO = "single", FIREMODE_BURST = "triptych")
	default_firemode = FIREMODE_BURST

/* woodsman */

/obj/item/gun/ballistic/automatic/marksman/woodsman
	name = "Model 23 Woodsman"
	desc = "A large semi-automatic hunting rifle manufactured by Serene Outdoors. Its powerful cartridge, excellent ergonomics and ease of use make it highly popular for hunting big game Chambered in 8x50mmR."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "woodsman"
	inhand_icon_state = "woodsman"
	worn_icon_state = "woodsman"
	show_bolt_icon = FALSE
	mag_display = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m23

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ssg669c.ogg'
	bolt_type = BOLT_TYPE_LOCKING
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK

	spread = -4
	spread_unwielded = 20
	recoil = 1.25
	recoil_unwielded = 6
	fire_delay = 0.5 SECONDS
	zoom_out_amt = 2

	can_be_sawn_off = FALSE

	valid_attachments = SERENE_ATTACHMENTS
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
		)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 32,
			"y" = 18,
		)
	)

/* super soaker */

/obj/item/gun/ballistic/automatic/m15
	name = "Model 15 Super Sporter"
	desc = "A popular semi-automatic hunting rifle produced by Serene Outdoors. Solid all-round performance, high accuracy, and ease of access compared to military rifles makes the Super Sporter a popular choice for hunting medium game and occasionally self-defense. Chambered in 5.56mm."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "m15"
	inhand_icon_state = "m15"
	worn_icon_state = "m15"
	show_bolt_icon = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m15

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/m16.ogg'

	bolt_type = BOLT_TYPE_LOCKING
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK

	spread = 0
	spread_unwielded = 20
	recoil = 0.5
	recoil_unwielded = 3
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	valid_attachments = SERENE_ATTACHMENTS
	slot_available = SERENE_ATTACH_SLOTS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 47,
			"y" = 21,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 13,
			"y" = 23,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 24,
			"y" = 19,
		)
	)

/* cuckmaster */

/obj/item/gun/ballistic/shotgun/automatic/m11
	name = "Model 11 \"Buckmaster\""
	desc = "A semi-automatic hunting shotgun produced by Serene Outdoors. Much lighter and handier than military combat shotguns, it offers the same fire rate and magazine capacity, making it an excellent choice for hunting birds and large game or for security forces looking to upgrade from pump action guns. Chambered in 12g."

	icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/serene_outdoors/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/serene_outdoors/onmob.dmi'
	icon_state = "buckmaster"
	inhand_icon_state = "buckmaster"
	worn_icon_state = "buckmaster"
	show_bolt_icon = FALSE
	inhand_x_dimension = 32
	inhand_y_dimension = 32

	fire_delay = 0.5 SECONDS
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/buckmaster
	w_class = WEIGHT_CLASS_BULKY
	bolt_type = BOLT_TYPE_LOCKING

	fire_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/bulldog.ogg'

	spread = 3
	spread_unwielded = 15
	recoil = 1
	recoil_unwielded = 4
	wield_slowdown = SHOTGUN_SLOWDOWN
	casing_ejector = TRUE

	valid_attachments = SERENE_ATTACHMENTS
	slot_available = SERENE_ATTACH_SLOTS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 45,
			"y" = 18,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 35,
			"y" = 17,
		)
	)

#undef SERENE_ATTACHMENTS
#undef SERENE_ATTACH_SLOTS
