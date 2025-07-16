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

	spread = 6 //becuase its compact, spread is slightly worse

/obj/item/gun/ballistic/automatic/pistol/ringneck/indie
	name = "Ringneck-76"
	desc = "A service handgun popular among law enforcement, mercenaries, and independent spacers with discerning tastes. Chambered in 10x22mm."

	icon_state = "ringneck76"
	inhand_icon_state = "sa_indie"

	w_class = WEIGHT_CLASS_NORMAL

	spread = 5 //this one is normal sized, thus in theory its better, in theory at least

/obj/item/ammo_box/magazine/m10mm_ringneck
	name = "Ringneck pistol magazine (10x22mm)"
	desc = "An 8-round magazine for the Ringneck pistol. These rounds do moderate damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "ringneck_mag"
	base_icon_state = "ringneck_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 8

/obj/item/ammo_box/magazine/m10mm_ringneck/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m10mm_ringneck/empty
	start_empty = TRUE

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


/obj/item/ammo_box/magazine/m57_39_asp
	name = "Asp magazine (5.7x39mm)"
	desc = "A 12-round, double-stack magazine for the Asp pistol. These rounds do okay damage with average performance against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "asp_mag-12"
	base_icon_state = "asp_mag"
	ammo_type = /obj/item/ammo_casing/c57x39mm
	caliber = CALIBER_57X39MM
	max_ammo = 12

/obj/item/ammo_box/magazine/m57_39_asp/update_icon_state()
	. = ..()
	if(ammo_count() == 12)
		icon_state = "[base_icon_state]-12"
	else if(ammo_count() >= 10)
		icon_state = "[base_icon_state]-10"
	else if(ammo_count() >= 5)
		icon_state = "[base_icon_state]-5"
	else if(ammo_count() >= 1)
		icon_state = "[base_icon_state]-1"
	else
		icon_state = "[base_icon_state]-0"

/obj/item/ammo_box/magazine/m57_39_asp/empty
	start_empty = TRUE

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

	semi_auto = TRUE //double action

/obj/item/gun/ballistic/revolver/viper/no_mag
	magazine = null

/obj/item/gun/ballistic/revolver/viper/indie
	name = "Viper-23"
	desc = "A powerful bull-barrel revolver. Very popular among mercenaries and the occasional well-to-do spacer or pirate for its flashy appearance and powerful cartridge. Chambered in .357 Magnum."

	icon_state = "viper23"
	inhand_icon_state = "viper23"
	spread = 5

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

	burst_size = 3
	burst_delay = 0.1 SECONDS
	fire_delay = 0.4 SECONDS

/obj/item/gun/ballistic/automatic/pistol/rattlesnake/inteq
	name = "MP-84m Kingsnake"
	desc = "A machine pistol obtained from Syndicate stockpiles and lightly modified to Inteq standards. Generally issued only to specialists. Chambered in 9x18mm."

	icon_state = "rattlesnake_inteq"
	inhand_icon_state = "rattlesnake_inteq"

/obj/item/ammo_box/magazine/m9mm_rattlesnake
	name = "Rattlesnake magazine (9x18mm)"
	desc = "A long, 18-round double-stack magazine designed for the Rattlesnake machine pistol. These rounds do okay damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "rattlesnake_mag_18"
	base_icon_state = "rattlesnake_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 18

/obj/item/ammo_box/magazine/m9mm_rattlesnake/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

/obj/item/ammo_box/magazine/m9mm_rattlesnake/empty
	start_empty = TRUE

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

	recoil = -2

/obj/item/ammo_box/magazine/m22lr_himehabu
	name = "pistol magazine (.22 LR)"
	desc = "A single-stack handgun magazine designed to chamber .22 LR. It's rather tiny, all things considered."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "himehabu_mag"
	base_icon_state = "himehabu_mag"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = CALIBER_22LR
	max_ammo = 10
	w_class = WEIGHT_CLASS_SMALL
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/m22lr_himehabu/empty
	start_empty = TRUE

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

/obj/item/gun/ballistic/automatic/smg/cobra/indie
	name = "Cobra-20"
	desc = "An older model of submachine gun manufactured by Scarborough Arms and marketed to mercenaries, law enforcement, and independent militia. Only became popular after the end of the ICW. Chambered in .45."
	icon_state = "cobra20"
	inhand_icon_state = "cobra20"
	worn_icon_state = "cobra20"

/obj/item/ammo_box/magazine/m45_cobra
	name = "Cobra magazine (.45)"
	desc = "A 24-round magazine for the Cobra submachine gun. These rounds do moderate damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cobra_mag-24"
	base_icon_state = "cobra_mag"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = CALIBER_45
	max_ammo = 24

/obj/item/ammo_box/magazine/m45_cobra/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/m45_cobra/empty
	start_empty = TRUE

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
	spread = 7
	recoil = 0

/obj/item/ammo_box/magazine/m57_39_sidewinder
	name = "Sidewinder magazine (5.7x39mm)"
	desc = "A 30-round magazine for the Sidewinder submachine gun. These rounds do okay damage with average performance against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "sidewinder_mag-1"
	base_icon_state = "sidewinder_mag"
	ammo_type = /obj/item/ammo_casing/c57x39mm
	caliber = CALIBER_57X39MM
	max_ammo = 30

/obj/item/ammo_box/magazine/m57_39_sidewinder/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m57_39_sidewinder/empty
	start_empty = TRUE

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
	recoil = 2

/obj/item/gun/ballistic/automatic/marksman/boomslang/indie
	name = "Boomslang-90"
	desc = "A modern semi-automatic hunting rifle. Its relative portability and fast follow-up potential compared to other weapons in its class have made it very popular with well-to-do hunters and the occasional law enforcement agency or mercenary. Chambered in 7.5x64mm CLIP."

	icon_state = "boomslang90"
	inhand_icon_state = "boomslang90"
	worn_icon_state = "boomslang90"

/obj/item/ammo_box/magazine/boomslang
	name = "\improper Boomslang Magazine (7.5x64mm CLIP)"
	desc = "A large 10-round box magazine for Boomslang sniper rifles. These rounds deal amazing damage and can pierce protective equipment, excluding armored vehicles."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "boomslang"
	icon_state = "boomslang"
	ammo_type = /obj/item/ammo_casing/a75clip
	caliber = CALIBER_75X64MM
	max_ammo = 10
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/boomslang/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/boomslang/short
	name = "\improper Boomslang Magazine (7.5x64mm CLIP)"
	desc = "A 5-round box magazine for Boomslang sniper rifles. These rounds deal amazing damage and can pierce protective equipment, excluding armored vehicles."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "boomslang_short"
	icon_state = "boomslang_short"
	ammo_type = /obj/item/ammo_casing/a75clip
	caliber = CALIBER_75X64MM
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/boomslang/short/empty
	start_empty = TRUE

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
	slot_flags = ITEM_SLOT_BACK
	actions_types = list()
	burst_size = 1
	fire_delay = 1 SECONDS
	spread = -5
	recoil = 5

/obj/item/gun/ballistic/automatic/marksman/taipan/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

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
	mag_display = FALSE //TEMP
	accepted_magazine_type = /obj/item/ammo_box/magazine/m556_42_hydra
	load_sound = 'tff_modular/modules/evento_needo/sounds/rifle/m16_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/m16_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/rifle/m16_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/m16_unload.ogg'

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/hydra.ogg'

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	burst_size = 2
	burst_delay = 0.2 SECONDS
	fire_delay = 0.4 SECONDS
	spread = 1

/obj/item/gun/ballistic/automatic/assault/hydra/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

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

	burst_delay = 0.2 SECONDS
	burst_size = 1
	fire_delay = 0.2 SECONDS
	spread = 7
	recoil = 0.7

/obj/item/gun/ballistic/automatic/assault/hydra/lmg/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/assault/hydra/lmg/extended
	accepted_magazine_type = /obj/item/ammo_box/magazine/m556_42_hydra/extended

/obj/item/gun/ballistic/automatic/assault/hydra/lmg/casket_mag
	accepted_magazine_type = /obj/item/ammo_box/magazine/m556_42_hydra/casket

/obj/item/gun/ballistic/automatic/assault/hydra/dmr
	name = "SBR-80 \"Hydra\""
	desc = "Scarborough Arms' premier modular assault rifle platform. This example is configured as a marksman rifle, with an extended barrel and medium-zoom scope. Its lightweight cartridge is compensated for with a 2-round burst action. Chambered in 5.56mm CLIP."

	icon_state = "hydra_dmr"
	inhand_icon_state = "hydra_dmr"
	worn_icon_state = "hydra_dmr"

	burst_size = 1
	fire_delay = 0.3 SECONDS
	spread = 0

/obj/item/ammo_box/magazine/m556_42_hydra
	name = "Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A simple, 30-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "hydra_mag-30"
	base_icon_state = "hydra_mag"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = CALIBER_556X42MM
	max_ammo = 30

/obj/item/ammo_box/magazine/m556_42_hydra/update_icon_state()
	. = ..()
	if(max_ammo > 30)
		icon_state = "[base_icon_state]-[!!ammo_count()]"
	else
		icon_state = "[base_icon_state]-[ammo_count() == 1 ? 1 : round(ammo_count(),5)]"

/obj/item/ammo_box/magazine/m556_42_hydra/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m556_42_hydra/small
	name = "Short Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A short, 20-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles; intended for the DMR variant. These rounds do moderate damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "hydra_small_mag-20"
	base_icon_state = "hydra_small_mag"
	max_ammo = 20

/obj/item/ammo_box/magazine/m556_42_hydra/small/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m556_42_hydra/extended
	name = "extended Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A bulkier, 60-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon_state = "hydra_extended_mag"
	base_icon_state = "hydra_extended_mag"
	max_ammo = 60

/obj/item/ammo_box/magazine/m556_42_hydra/extended/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m556_42_hydra/casket
	name = "casket Hydra assault rifle magazine (5.56x42mm CLIP)"
	desc = "A very long and bulky 100-round magazine for the Hydra platform of 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon_state = "hydra_casket_mag"
	base_icon_state = "hydra_casket_mag"
	max_ammo = 100
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	w_class = WEIGHT_CLASS_NORMAL

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
	special_mags = TRUE

	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/m12g_bulldog
	fire_delay = 0.4 SECONDS // this NEEDS the old delay.
	fire_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/bulldog.ogg'
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
	recoil = 1

/obj/item/gun/ballistic/shotgun/automatic/bulldog/drum
	mag_display = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m12g_bulldog/drum

/obj/item/ammo_box/magazine/m12g_bulldog
	name = "shotgun box magazine (12g buckshot)"
	desc = "A single-stack, 8-round box magazine for the Bulldog shotgun and it's derivatives."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "bulldog_mag"
	base_icon_state = "bulldog_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 8

/obj/item/ammo_box/magazine/m12g_bulldog/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m12g_bulldog/slug
	name = "shotgun box magazine (12g Slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/m12g_bulldog/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m12g_bulldog/drum
	name = "shotgun drum magazine (12g buckshot)"
	desc = "A bulky 12-round drum designed for the Bulldog shotgun and it's derivatives."
	icon_state = "bulldog_drum"
	base_icon_state = "bulldog_drum"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 12
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/m12g_bulldog/drum/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m12g_bulldog/drum/stun
	name = "shotgun drum magazine (12g taser slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/magazine/m12g_bulldog/drum/slug
	name = "shotgun drum magazine (12g slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/m12g_bulldog/drum/dragon
	name = "shotgun drum magazine (12g dragon's breath)"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/ammo_box/magazine/m12g_bulldog/drum/bioterror
	name = "shotgun drum magazine (12g bioterror)"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/bioterror

/obj/item/ammo_box/magazine/m12g_bulldog/drum/meteor
	name = "shotgun drum magazine (12g meteor slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun/meteorslug
