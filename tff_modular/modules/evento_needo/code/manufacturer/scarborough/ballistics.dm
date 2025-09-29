#define SCARBOROUGH_ATTACHMENTS list(/obj/item/attachment/silencer, /obj/item/attachment/laser_sight, /obj/item/attachment/rail_light, /obj/item/attachment/bayonet, /obj/item/attachment/energy_bayonet, /obj/item/attachment/scope, /obj/item/attachment/gun, /obj/item/attachment/sling, /obj/item/attachment/ammo_counter)
#define SCARBOROUGH_ATTACH_SLOTS list(ATTACHMENT_SLOT_MUZZLE = 1, ATTACHMENT_SLOT_SCOPE = 1, ATTACHMENT_SLOT_RAIL = 1)

//########### PISTOLS ###########//
/obj/item/gun/ballistic/automatic/pistol/ringneck
	name = "PC-76 \"Ringneck\""
	desc = "A compact handgun used by most Syndicate-affiliated groups. Small enough to conceal in most pockets, making it popular for covert elements and simply as a compact defensive weapon. Chambered in 10x22mm."
	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'
	icon_state = "ringneck"
	inhand_icon_state = "sa_generic"
	worn_icon_state = null

	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m10mm_ringneck


	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/shot.ogg'
	dry_fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/dry_fire.ogg'
	suppressed_sound = 'tff_modular/modules/evento_needo/sounds/pistol/shot_suppressed.ogg'

	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert_alt.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert_alt.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release_alt.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release_alt.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/rack_small.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/lock_small.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/drop_small.ogg'

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 27,
			"y" = 23,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 25,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 21,
			"y" = 19,
		)
	)


	spread = 6 //becuase its compact, spread is slightly worse
	spread_unwielded = 9
	recoil_unwielded = 2

/obj/item/gun/ballistic/automatic/pistol/ringneck/indie
	name = "Ringneck-76"
	desc = "A service handgun popular among law enforcement, mercenaries, and independent spacers with discerning tastes. Chambered in 10x22mm."

	icon_state = "ringneck76"
	inhand_icon_state = "sa_indie"

	w_class = WEIGHT_CLASS_NORMAL

	spread = 5 //this one is normal sized, thus in theory its better, in theory at least
	spread_unwielded = 7
	recoil_unwielded = 3

/obj/item/gun/ballistic/automatic/pistol/asp
	name = "BC-81 \"Asp\""
	desc = "An armor-piercing combat handgun once used by Syndicate strike teams, now primarily used by descendants of the Gorlex Marauders. Chambered in 5.7mm."

	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'
	icon_state = "asp"
	inhand_icon_state = "sa_generic"
	worn_icon_state = null
	accepted_magazine_type = /obj/item/ammo_box/magazine/m57_39_asp

	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/asp.ogg'

	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/rack.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/lock_small.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/drop_small.ogg'

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 32,
			"y" = 23,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 15,
			"y" = 26,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 23,
			"y" = 19,
		)
	)

/obj/item/gun/ballistic/revolver/viper
	name = "R-23 \"Viper\""
	desc = "An imposing revolver used by officers and certain agents of Syndicate member factions during the ICW, still favored by captains and high-ranking officers of the former Syndicate. Chambered in .357 Magnum."

	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'

	icon_state = "viper"
	inhand_icon_state = "sa_generic"
	worn_icon_state = null

	fire_sound = 'tff_modular/modules/evento_needo/sounds/revolver/viper.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/revolver/viper_prime.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/revolver/load_bullet.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/revolver/empty.ogg'

	dry_fire_sound = 'tff_modular/modules/evento_needo/sounds/revolver/dry_fire.ogg'

	fire_delay = 0.35 SECONDS

	spread = 3
	recoil = 1
	recoil_unwielded = 2

	semi_auto = TRUE //double action

/obj/item/gun/ballistic/revolver/viper/indie
	name = "Viper-23"
	desc = "A powerful bull-barrel revolver. Very popular among mercenaries and the occasional well-to-do spacer or pirate for its flashy appearance and powerful cartridge. Chambered in .357 Magnum."

	icon_state = "viper23"
	inhand_icon_state = "viper23"
	spread = 5
	spread_unwielded = 10

/obj/item/gun/ballistic/revolver/viper/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ammo_hud_shiptest/revolver)

/obj/item/gun/ballistic/automatic/pistol/rattlesnake
	name = "MP-84 \"Rattlesnake\""
	desc = "A machine pistol, once used by Syndicate infiltrators and special forces during the ICW. Still used by specialists in former Syndicate factions. Chambered in 9x18mm."

	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'

	icon_state = "rattlesnake"
	inhand_icon_state = "rattlesnake"
	worn_icon_state = null
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm_rattlesnake

	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/rattlesnake.ogg'
	dry_fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/dry_fire.ogg'
	suppressed_sound = 'tff_modular/modules/evento_needo/sounds/pistol/shot_suppressed.ogg'

	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert_alt.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert_alt.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release_alt.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release_alt.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/rack_small.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/lock_small.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/drop_small.ogg'

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 40,
			"y" = 26,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 14,
			"y" = 29,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 22,
			"y" = 21,
		)
	)

	burst_size = 3
	burst_delay = 0.1 SECONDS
	fire_delay = 0.4 SECONDS
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	default_firemode = FIREMODE_SEMIAUTO

/obj/item/gun/ballistic/automatic/pistol/rattlesnake/inteq
	name = "MP-84m Kingsnake"
	desc = "A machine pistol obtained from Syndicate stockpiles and lightly modified to Inteq standards. Generally issued only to specialists. Chambered in 9x18mm."

	icon_state = "rattlesnake_inteq"
	inhand_icon_state = "rattlesnake_inteq"

/obj/item/gun/ballistic/automatic/pistol/himehabu
	name = "PC-81 \"Himehabu\""
	desc = "An astonishingly compact machine pistol firing ultra-light projectiles, designed to be as small and concealable as possible while remaining a credible threat at very close range. Armor penetration is practically non-existent. Chambered in .22."

	icon_state = "himehabu"
	inhand_icon_state = "sa_generic"
	worn_icon_state = null

	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'


	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m22lr_himehabu
	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/himehabu.ogg'

	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert_alt.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_insert_alt.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release_alt.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/mag_release_alt.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/rack_small.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/lock_small.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/drop_small.ogg'

	valid_attachments = list(
		/obj/item/attachment/silencer,
	)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_SCOPE = 1,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 28,
			"y" = 22,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 12,
			"y" = 25,
		)
	)

	recoil = -2
	recoil_unwielded = -2
	spread_unwielded = 0
	wield_slowdown = 0

//########### SMGS ###########//


/obj/item/gun/ballistic/automatic/smg/cobra
	name = "C-20r \"Cobra\""
	desc = "A bullpup submachine gun, heavily used by Syndicate strike teams during the ICW. Still sees widespread use by the descendants of the Gorlex Marauders. Chambered in .45."
	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'
	icon_state = "cobra"
	inhand_icon_state = "cobra"
	worn_icon_state = "cobra"
	accepted_magazine_type = /obj/item/ammo_box/magazine/m45_cobra

	fire_sound = 'tff_modular/modules/evento_needo/sounds/smg/cobra.ogg'

	load_sound = 'tff_modular/modules/evento_needo/sounds/smg/cm5_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/cm5_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/smg/cm5_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/cm5_unload.ogg'

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 27,
			"y" = 23,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 28,
			"y" = 16,
		)
	)

/obj/item/gun/ballistic/automatic/smg/cobra/indie
	name = "Cobra-20"
	desc = "An older model of submachine gun manufactured by Scarborough Arms and marketed to mercenaries, law enforcement, and independent militia. Only became popular after the end of the ICW. Chambered in .45."
	icon_state = "cobra20"
	inhand_icon_state = "cobra20"
	worn_icon_state = "cobra20"

/obj/item/gun/ballistic/automatic/smg/sidewinder
	name = "CDW-81 \"Sidewinder\""
	desc = "An armor-piercing, compact personal defense weapon, introduced late into the Inter-Corporate War as an improvement over the C-20r when fighting armored personnel. Issued only in small numbers, and used today by specialists of former Syndicate factions. Chambered in 5.7mm."
	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'
	icon_state = "sidewinder"
	inhand_icon_state = "sidewinder"
	worn_icon_state = "sidewinder"
	accepted_magazine_type = /obj/item/ammo_box/magazine/m57_39_sidewinder

	fire_sound = 'tff_modular/modules/evento_needo/sounds/smg/sidewinder.ogg'

	load_sound = 'tff_modular/modules/evento_needo/sounds/smg/sidewinder_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/sidewinder_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/smg/sidewinder_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/smg/sidewinder_unload.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/smg/sidewinder_cocked.ogg'

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	unique_attachments = list(
		/obj/item/attachment/foldable_stock/sidewinder
	)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_STOCK = 1,
		ATTACHMENT_SLOT_SCOPE = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 44,
			"y" = 18,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 35,
			"y" = 17,
		),
		ATTACHMENT_SLOT_STOCK = list(
			"x" = 17,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 21,
			"y" = 24,
		)
	)

	spread = 7
	spread_unwielded = 10

	recoil = 2
	recoil_unwielded = 4

	default_attachments = list(/obj/item/attachment/foldable_stock/sidewinder)

//########### MARKSMAN ###########//
/obj/item/gun/ballistic/automatic/marksman/boomslang
	name = "MSR-90 \"Boomslang\""
	desc = "A bullpup semi-automatic sniper rifle with a high-magnification scope. Compact and capable of rapid follow-up fire without sacrificing power. Used by Syndicate support units and infiltrators during the ICW. Chambered in 7.5x64mm CLIP."

	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'

	icon_state = "boomslang"
	inhand_icon_state = "boomslang"
	worn_icon_state = "boomslang"
	special_mags = TRUE

	fire_sound = 'tff_modular/modules/evento_needo/sounds/sniper/cmf90.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/boomslang
	w_class = WEIGHT_CLASS_BULKY

	fire_delay = 1 SECONDS

	slot_flags = ITEM_SLOT_BACK
	spread = -5
	spread_unwielded = 35
	recoil = 2
	recoil_unwielded = 10
	wield_slowdown = SNIPER_SLOWDOWN
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 19,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 28,
			"y" = 10,
		)
	)

/obj/item/gun/ballistic/automatic/marksman/boomslang/indie
	name = "Boomslang-90"
	desc = "A modern semi-automatic hunting rifle. Its relative portability and fast follow-up potential compared to other weapons in its class have made it very popular with well-to-do hunters and the occasional law enforcement agency or mercenary. Chambered in 7.5x64mm CLIP."

	icon_state = "boomslang90"
	inhand_icon_state = "boomslang90"
	worn_icon_state = "boomslang90"

	zoom_amt = 6
	zoom_out_amt = 2

/obj/item/gun/ballistic/automatic/marksman/taipan
	name = "AMR-83 \"Taipan\""
	desc = "A monstrous semi-automatic anti-materiel rifle, surprisingly short for its class. Designed to destroy mechs, light vehicles, and equipment, but more than capable of obliterating regular personnel. Chambered in .50 BMG."

	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'

	icon_state = "taipan"
	inhand_icon_state = "taipan"
	worn_icon_state = "taipan"
	fire_sound = 'tff_modular/modules/evento_needo/sounds/sniper/shot.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	load_sound = 'tff_modular/modules/evento_needo/sounds/sniper/mag_insert.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/sniper/rack.ogg'
	suppressed_sound = 'tff_modular/modules/evento_needo/sounds/general/heavy_shot_suppressed.ogg'
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/sniper_rounds
	w_class = WEIGHT_CLASS_BULKY
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5
	slot_flags = ITEM_SLOT_BACK
	actions_types = list()
	burst_size = 1
	fire_delay = 1 SECONDS
	spread = -5
	spread_unwielded = 40
	recoil = 5
	recoil_unwielded = 50
	valid_attachments = list()
	slot_available = list()

//########### RIFLES ###########//
/obj/item/gun/ballistic/automatic/assault/hydra
	name = "SMR-80 \"Hydra\""
	desc = "Scarborough Arms' premier modular assault rifle platform. This is the basic configuration, optimized for light weight and handiness. A very well-regarded, if expensive and rare, assault rifle. Chambered in 5.56mm CLIP."

	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'
	icon_state = "hydra"
	inhand_icon_state = "hydra"
	worn_icon_state = "hydra"
	mag_display = FALSE //TEMP SARGASSUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/m556_42_hydra
	gun_firenames = list(FIREMODE_SEMIAUTO = "single", FIREMODE_BURST = "burst fire", FIREMODE_FULLAUTO = "full auto")
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	//gun_firemodes = list(FIREMODE_SEMIAUTO FIREMODE_OTHER)
	default_firemode = FIREMODE_SEMIAUTO

	load_sound = 'tff_modular/modules/evento_needo/sounds/rifle/m16_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/m16_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/rifle/m16_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/m16_unload.ogg'

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/hydra.ogg'
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	burst_size = 2
	burst_delay = 0.1 SECONDS
	fire_delay = 0.18 SECONDS
	spread = 1
	spread_unwielded = 8
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN

	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 42,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 21,
			"y" = 24,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 30,
			"y" = 15,
		)
	)

//we hard code "hydra", why? because if not, i would need to duplicate the extended/short magazine sprites like 3 fucking times for every variant with a different icon state. this eases the spriting burden
/obj/item/gun/ballistic/automatic/assault/hydra/update_overlays()
	. = ..()
	if (magazine)
		. += "hydra_mag_[magazine.base_icon_state]"
		var/capacity_number = 0
		switch(get_ammo() / magazine.max_ammo)
			if(0.2 to 0.39)
				capacity_number = 20
			if(0.4 to 0.59)
				capacity_number = 40
			if(0.6 to 0.79)
				capacity_number = 60
			if(0.8 to 0.99)
				capacity_number = 80
			if(1.0 to 2.0) //to catch the chambered round
				capacity_number = 100
		if (capacity_number)
			. += "hydra_mag_[magazine.base_icon_state]_[capacity_number]"


/obj/item/gun/ballistic/automatic/assault/hydra/lmg
	name = "SAW-80 \"Hydra\""
	desc = "Scarborough Arms' premier modular assault rifle platform. This example is configured as a support weapon, with heavier components for sustained firing and a large muzzle brake. Chambered in 5.56mm CLIP."

	icon_state = "hydra_lmg"
	inhand_icon_state = "hydra_lmg"
	worn_icon_state = "hydra_lmg"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

	burst_delay = 0.2 SECONDS
	burst_size = 1
	fire_delay = 0.2 SECONDS
	spread = 7
	spread_unwielded = 25
	recoil = 0.7
	recoil_unwielded = 4
	wield_slowdown = SAW_SLOWDOWN
	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 19,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 21,
			"y" = 24,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 30,
			"y" = 15,
		)
	)

/obj/item/gun/ballistic/automatic/assault/hydra/lmg/extended
	spawnwithmagazine = /obj/item/ammo_box/magazine/m556_42_hydra/extended

/obj/item/gun/ballistic/automatic/assault/hydra/lmg/casket_mag
	spawnwithmagazine = /obj/item/ammo_box/magazine/m556_42_hydra/casket

/obj/item/gun/ballistic/automatic/assault/hydra/dmr
	name = "SBR-80 \"Hydra\""
	desc = "Scarborough Arms' premier modular assault rifle platform. This example is configured as a marksman rifle, with an extended barrel and medium-zoom scope. Its lightweight cartridge is compensated for with a 2-round burst action. Chambered in 5.56mm CLIP."

	icon_state = "hydra_dmr"
	inhand_icon_state = "hydra_dmr"
	worn_icon_state = "hydra_dmr"

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	burst_size = 2
	fire_delay = 0.3 SECONDS
	spread = 0
	spread_unwielded = 12
	wield_slowdown = DMR_SLOWDOWN //dmrrrr
	zoomable = TRUE
	zoom_amt = 6
	zoom_out_amt = 2

/obj/item/gun/ballistic/automatic/assault/hydra/underbarrel_gl
	name = "SMR-80 \"Hydra\""
	desc = "Scarborough Arms' premier modular assault rifle platform. This is the basic configuration, optimized for light weight and handiness. A very well-regarded, if expensive and rare, assault rifle. This one has an underslung grenade launcher attached. Chambered in 5.56x42mm CLIP."

	default_attachments = list(/obj/item/attachment/gun/ballistic/launcher)

//########### MISC ###########//
// Bulldog shotgun //

/obj/item/gun/ballistic/shotgun/automatic/bulldog
	name = "SG-60r \"Bulldog\""
	desc = "A bullpup combat shotgun usually seen with a characteristic drum magazine. Wildly popular among Syndicate strike teams during the ICW, although it proved less useful against military-grade equipment. Still popular among former Syndicate factions, especially the Ramzi Clique pirates. Chambered in 12g."
	icon = 'tff_modular/modules/evento_needo/icons/scarborough/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/scarborough/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/scarborough/onmob.dmi'
	icon_state = "bulldog"
	inhand_icon_state = "bulldog"
	worn_icon_state = "bulldog"
	inhand_x_dimension = 32
	inhand_y_dimension = 32

	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/m12g_bulldog
	fire_delay = 0.4 SECONDS // this NEEDS the old delay.
	fire_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/bulldog.ogg'
//	empty_indicator = TRUE
	empty_alarm = TRUE
	internal_magazine = FALSE
	casing_ejector = TRUE
	tac_reloads = TRUE

	load_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_unload.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_cock.ogg'

	spread = 3
	spread_unwielded = 15
	recoil = 1
	recoil_unwielded = 4
	wield_slowdown = HEAVY_SHOTGUN_SLOWDOWN
	valid_attachments = SCARBOROUGH_ATTACHMENTS
	slot_available = SCARBOROUGH_ATTACH_SLOTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 44,
			"y" = 19,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 25,
			"y" = 24,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 30,
			"y" = 18,
		)
	)

/obj/item/gun/ballistic/shotgun/automatic/bulldog/drum
	spawnwithmagazine = /obj/item/ammo_box/magazine/m12g_bulldog/drum

#undef SCARBOROUGH_ATTACHMENTS
#undef SCARBOROUGH_ATTACH_SLOTS
