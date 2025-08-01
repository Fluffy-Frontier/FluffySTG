//########### PISTOLS ###########//
/obj/item/gun/ballistic/automatic/pistol/cm23
	name = "\improper CM-23"
	desc = "CLIP's standard service pistol. 10 rounds of 10mm ammunition make the CM-23 deadlier than many other service pistols, but its weight and bulk have made it unpopular as a sidearm. It has largely been phased out outside of specialized units and patrols on the fringes of CLIP space. Chambered in 10mm."
	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	icon_state = "cm23"
	inhand_icon_state = "clip_generic"
	worn_icon_state = "cm1"
	mag_display = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/cm23
	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/cm23.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_cocked.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/slide_lock.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/slide_drop.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_unload.ogg'

/obj/item/gun/ballistic/automatic/pistol/cm23/no_mag
	spawnwithmagazine = FALSE

/obj/item/ammo_box/magazine/cm23
	name = "CM-23 pistol magazine (10x22mm)"
	desc = "An 10-round magazine magazine designed for the CM-23 pistol. These rounds do moderate damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm23_mag-1"
	base_icon_state = "cm23_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 10

/obj/item/ammo_box/magazine/cm23/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm23/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/pistol/cm70
	name = "CM-70 machine pistol"
	desc = "A compact machine pistol designed to rapidly fire 3-round bursts. Popular with officers and certain special units, the CM-70 is incredibly dangerous at close range. Chambered in 9mm."
	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'
	icon_state = "cm70"
	inhand_icon_state = "clip_generic"
	worn_icon_state = "cm1"
	mag_display = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm_cm70
	burst_size = 3
	burst_delay = 0.25 SECONDS
	fire_delay = 0.4 SECONDS

	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/cm70.ogg'

	spread = 8

/obj/item/ammo_box/magazine/m9mm_cm70
	name = "CM-70 machine pistol magazine (9x18mm)"
	desc = "A 18-round magazine designed for the CM-70 machine pistol. These rounds do okay damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm70_mag_18"
	base_icon_state = "cm70_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 18

/obj/item/ammo_box/magazine/m9mm_cm70/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

/obj/item/ammo_box/magazine/m9mm_cm70/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/pistol/cm357
	name = "\improper CM-357"
	desc = "A powerful semi-automatic handgun designed for CLIP-BARD's megafauna removal unit, as standard handguns had proven ineffective as backup weapons. The heft and power of the weapon have made it a status symbol among the few CLIP officers able to requisition one. Chambered in .357."
	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	icon_state = "cm357"
	inhand_icon_state = "clip_generic"
	worn_icon_state = "cm1"
	mag_display = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/cm357
	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/deagle.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_cocked.ogg'
	lock_back_sound = 'tff_modular/modules/evento_needo/sounds/pistol/slide_lock.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/pistol/slide_drop.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/pistol/candor_unload.ogg'

	recoil = 1

/obj/item/ammo_box/magazine/cm357
	name = "CM-357 pistol magazine (.357)"
	desc = "A 7-round magazine designed for the CM-357 pistol. These rounds do good damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm23_mag"
	base_icon_state = "cm23_mag"
	ammo_type = /obj/item/ammo_casing/c357
	caliber = CALIBER_357
	max_ammo = 7

/obj/item/ammo_box/magazine/cm357/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm357/empty
	start_empty = TRUE

//########### SMGS ###########//
/obj/item/gun/ballistic/automatic/smg/cm5
	name = "\improper CM-5"
	desc = "CLIP's standard-issue submachine gun. Well-liked for its accuracy, stability, and ease of use compared to other submachineguns. Chambered in 9mm."
	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	icon_state = "cm5"
	inhand_icon_state = "cm5"
	worn_icon_state = "cm5"
	accepted_magazine_type = /obj/item/ammo_box/magazine/cm5_9mm
	bolt_type = BOLT_TYPE_STANDARD
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'tff_modular/modules/evento_needo/sounds/smg/cm5.ogg'
	spread = 3

/obj/item/gun/ballistic/automatic/smg/cm5/rubber
	spawn_magazine_type = /obj/item/ammo_box/magazine/cm5_9mm/rubber

/obj/item/ammo_box/magazine/cm5_9mm
	name = "CM-5 magazine (9x18mm)"
	desc = "A 30-round magazine for the CM-5 submachine gun. These rounds do okay damage, but struggle against armor."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm5_mag"
	base_icon_state = "cm5_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 30

/obj/item/ammo_box/magazine/cm5_9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm5_9mm/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/cm5_9mm/rubber
	desc = "A 30-round magazine for the CM-5 submachine gun. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

//########### MARKSMAN ###########//
/obj/item/gun/ballistic/automatic/marksman/f4
	name = "CM-F4"
	desc = "CLIP's marksman rifle, used by both military and law enforcement units. Designed not long after the CM-24, the venerable F4 has adapted well to continued upgrades. Chambered in .308."

	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	icon_state = "f4"
	inhand_icon_state = "f4"
	worn_icon_state = "f4"
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	bolt_type = BOLT_TYPE_STANDARD
	accepted_magazine_type = /obj/item/ammo_box/magazine/f4_308
	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/f4.ogg'
	burst_size = 1
	actions_types = list()
	spread = -4

/obj/item/ammo_box/magazine/f4_308
	name = "\improper F4 Magazine (.308)"
	desc = "A standard 10-round magazine for F4 platform DMRs. These rounds do good damage with significant armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "gal_mag"
	base_icon_state = "gal_mag"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = CALIBER_308
	max_ammo = 10

/obj/item/ammo_box/magazine/f4_308/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/f4_308/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/marksman/f4/inteq
	name = "\improper SsG-04"
	desc = "An F4 rifle purchased from CLIP and modified to suit IRMG's needs. Chambered in .308."
	icon = 'tff_modular/modules/evento_needo/icons/inteq/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/inteq/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/inteq/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/inteq/onmob.dmi'
	icon_state = "f4_inteq"
	inhand_icon_state = "f4_inteq"
	worn_icon_state = "f4_inteq"

/obj/item/gun/ballistic/automatic/marksman/f90
	name = "CM-F90"
	desc = "A powerful sniper rifle used by vanishingly rare CLIP specialists, capable of impressive range and penetrating power. Chambered in 6.5mm CLIP."
	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	icon_state = "f90"
	inhand_icon_state = "f90"
	worn_icon_state = "f90"

	fire_sound = 'tff_modular/modules/evento_needo/sounds/sniper/cmf90.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/f90
	bolt_type = BOLT_TYPE_STANDARD
	fire_delay = 0.5 SECONDS
	burst_size = 1
	spread = -5
	recoil = 2

/obj/item/gun/ballistic/automatic/marksman/f90/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/ammo_box/magazine/f90
	name = "\improper CM-F90 Magazine (6.5x57mm CLIP)"
	desc = "A large 5-round box magazine for the CM-F90 sniper rifles. These rounds deal amazing damage and bypass half of their protective equipment, though it isn't a high enough caliber to pierce armored vehicles."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "f90_mag"
	icon_state = "f90_mag-1"
	ammo_type = /obj/item/ammo_casing/a75clip
	caliber = CALIBER_75X64MM
	max_ammo = 5

/obj/item/ammo_box/magazine/f90/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/f90/empty
	start_empty = TRUE

//########### RIFLES ###########//
/obj/item/gun/ballistic/automatic/assault/cm82
	name = "\improper CM-82"
	desc = "CLIP's standard assault rifle, a relatively new service weapon. Accurate, reliable, and easy to use, the CM-82 replaced the CM-24 as CLIP's assault rifle almost overnight, and has proven immensely popular since. Chambered in 5.56mm."
	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/cm82.ogg'
	icon_state = "cm82"
	inhand_icon_state = "cm82"
	worn_icon_state = "cm82"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	bolt_type = BOLT_TYPE_STANDARD
	accepted_magazine_type = /obj/item/ammo_box/magazine/p16
	spread = 2
	fire_delay = 0.3 SECONDS
	burst_size = 1

	load_sound = 'tff_modular/modules/evento_needo/sounds/rifle/cm82_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/cm82_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/rifle/cm82_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/cm82_unload.ogg'

/obj/item/gun/ballistic/automatic/assault/cm82/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/p16 //repath to /obj/item/ammo_box/magazine/generic_556 sometime
	name = "assault rifle magazine (5.56x42mm CLIP)"
	desc = "A simple, 30-round magazine for 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "p16_mag"
	base_icon_state = "p16_mag"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = CALIBER_556X42MM
	max_ammo = 30

/obj/item/ammo_box/magazine/p16/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/p16/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/assault/skm/cm24
	name = "\improper CM-24"
	desc = "An obsolete and very rugged assault rifle with a heavy projectile and slow action for its class. Once CLIP's standard assault rifle produced in phenomenal numbers for the First Frontiersman War, it now serves as an acceptable, if rare, battle rifle. Chambered in 7.62mm CLIP."

	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	accepted_magazine_type = /obj/item/ammo_box/magazine/skm_762_40
	icon_state = "cm24"
	inhand_icon_state = "cm24"
	worn_icon_state = "cm24"

	fire_delay = 0.5 SECONDS
	burst_size = 1
	special_mags = TRUE

/obj/item/gun/ballistic/automatic/assault/skm/cm24/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/skm_762_40
	name = "assault rifle magazine (7.62x40mm CLIP)"
	desc = "A slightly curved, 20-round magazine for the 7.62x40mm CLIP variants of the SKM assault rifle family. These rounds do good damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "skm_mag"
	icon_state = "skm_mag"
	ammo_type = /obj/item/ammo_casing/a762_40
	caliber = CALIBER_762X40MM
	max_ammo = 20

/obj/item/ammo_box/magazine/skm_762_40/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/skm_762_40/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/skm_762_40/extended
	name = "extended assault rifle magazine (7.62x40mm CLIP)"
	desc = "A very curved, 40-round magazine for the 7.62x40mm CLIP variants of the SKM assault rifle family. These rounds do good damage with good armor penetration."
	base_icon_state = "skm_extended_mag"
	icon_state = "skm_extended_mag"
	max_ammo = 40

/obj/item/ammo_box/magazine/skm_762_40/extended/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/skm_762_40/drum
	name = "assault rifle drum (7.62x40mm CLIP)"
	desc = "A 75-round drum for the 7.62x40mm CLIP variants of the SKM assault rifle family. These rounds do good damage with good armor penetration."
	base_icon_state = "skm_drum"
	icon_state = "skm_drum"
	max_ammo = 75
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/automatic/hmg/cm40
	name = "\improper CM-40"
	desc = "A light machine gun used by CLIP heavy weapons teams, capable of withering suppressive fire. The weight and recoil make it nearly impossible to use without deploying the bipod against appropriate cover, such as a table, or bracing against solid cover. Chambered in 7.62x40mm CLIP."
	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	icon_state = "cm40"
	inhand_icon_state = "cm40"
	worn_icon_state = "cm40"

	fire_sound = 'tff_modular/modules/evento_needo/sounds/hmg/cm40.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/hmg/cm40_cocked.ogg'

	rack_sound_vary = FALSE

	load_sound_vary = FALSE
	eject_sound_vary = FALSE

	load_sound = 'tff_modular/modules/evento_needo/sounds/hmg/cm40_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/hmg/cm40_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/hmg/cm40_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/hmg/cm40_unload.ogg'

	fire_delay = 0.2 SECONDS

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/cm40_762_40_box

	spread = 10
	recoil = 1

/obj/item/gun/ballistic/automatic/hmg/cm40/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/cm40_762_40_box
	name = "CM-40 box magazine (7.62x40mm CLIP)"
	desc = "An 80 round box magazine for CM-40 light machine gun. These rounds do good damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "cm40_mag"
	icon_state = "cm40_mag"
	ammo_type = /obj/item/ammo_casing/a762_40
	caliber = CALIBER_762X40MM
	max_ammo = 80
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/cm40_762_40_box/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm40_762_40_box/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/hmg/rottweiler
	name = "\improper KM-05 Rottweiler"
	desc = "An F4 rifle purchased from CLIP and extensively modified into a belt fed machine gun. Heavy and firing a powerful cartridge, this weapon is unwieldy without a bipod support. Uniquely, the KM-05 Rottweiler can accept F4 magazines into the magazine well."
	icon = 'tff_modular/modules/evento_needo/icons/inteq/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/inteq/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/inteq/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/inteq/onmob.dmi'

	icon_state = "rottweiler"
	inhand_icon_state = "rottweiler"
	worn_icon_state = "rottweiler"
	mag_display_ammo = TRUE
	mag_display = FALSE //TEMP
	fire_sound = 'tff_modular/modules/evento_needo/sounds/hmg/hmg.ogg'
	fire_delay = 0.3 SECONDS //chunky machine gun

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	bolt_type = BOLT_TYPE_STANDARD
	tac_reloads = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/rottweiler_308_box

	spread = 12
	recoil = 2

/obj/item/gun/ballistic/automatic/hmg/rottweiler/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/rottweiler_308_box
	name = "Rottweiler box magazine (.308)"
	desc = "A 50 round box magazine for Rottweiler machine gun. These rounds do good damage with significant armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	base_icon_state = "rottweiler_mag"
	icon_state = "rottweiler_mag-1"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = CALIBER_308
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/rottweiler_308_box/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/rottweiler_308_box/empty
	start_empty = TRUE

//########### MISC ###########//

/obj/item/gun/ballistic/shotgun/cm15
	name = "\improper CM-15"
	desc = "A large automatic shotgun used by CLIP. Generally employed by law enforcement and breaching specialists, and rarely by CLIP-BARD (typically with incendiary ammunition). Chambered in 12 gauge."
	icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/clip_lanchester/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/clip_lanchester/onmob.dmi'

	icon_state = "cm15"
	inhand_icon_state = "cm15"
	worn_icon_state = "cm15"

	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/cm15_12g

	empty_indicator = FALSE
	semi_auto = TRUE
	internal_magazine = FALSE
	casing_ejector = TRUE
	tac_reloads = TRUE
	inhand_x_dimension = 32
	inhand_y_dimension = 32

	fire_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/bulldog.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_unload.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_cock.ogg'

	spread = 3
	recoil = 1
	fire_delay = 0.4 SECONDS

/obj/item/ammo_box/magazine/cm15_12g
	name = "CM-15 magazine (12g buckshot)"
	desc = "An almost straight, 8-round magazine designed for the CM-15 shotgun."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "cm15_mag-1"
	base_icon_state = "cm15_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 8

/obj/item/ammo_box/magazine/cm15_12g/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm15_12g/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/cm15_12g/incendiary
	name = "CM-15 magazine (12g incendiary)"
	desc = "An almost straight, 8-round magazine designed for the CM-15 shotgun. This one was loaded with incendiary slugs. Be careful!"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary
