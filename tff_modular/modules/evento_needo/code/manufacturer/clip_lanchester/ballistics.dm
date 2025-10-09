#define CLIP_ATTACHMENTS list(/obj/item/attachment/silencer, /obj/item/attachment/laser_sight, /obj/item/attachment/rail_light, /obj/item/attachment/bayonet, /obj/item/attachment/scope, /obj/item/attachment/long_scope, /obj/item/attachment/sling, /obj/item/attachment/gun, /obj/item/attachment/ammo_counter)
#define CLIP_ATTACHMENT_POINTS list(ATTACHMENT_SLOT_MUZZLE = 1,ATTACHMENT_SLOT_RAIL = 1,ATTACHMENT_SLOT_SCOPE=1)


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

	default_attachments = list(/obj/item/attachment/laser_sight)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		),
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 29,
			"y" = 20,
		)
	)

	recoil_unwielded = 3

/obj/item/gun/ballistic/automatic/pistol/cm23/empty
	spawn_magazine_type = /obj/item/ammo_box/magazine/cm23/empty

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
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	default_firemode = FIREMODE_SEMIAUTO

	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

	fire_sound = 'tff_modular/modules/evento_needo/sounds/pistol/cm70.ogg'

	spread = 8
	spread_unwielded = 20

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 23,
			"y" = 17,
		),
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 31,
			"y" = 21,
		)
	)

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

	recoil_unwielded = 4
	recoil = 1

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 23,
			"y" = 16,
		)
	)

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
	spread_unwielded = 7

	valid_attachments = CLIP_ATTACHMENTS
	slot_available = CLIP_ATTACHMENT_POINTS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 38,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 27,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 12,
			"y" = 23,
		)
	)

	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

/obj/item/gun/ballistic/automatic/smg/cm5/rubber
	spawn_magazine_type = /obj/item/ammo_box/magazine/cm5_9mm/rubber

/obj/item/gun/ballistic/automatic/smg/cm5/compact
	name = "\improper CM-5c"
	desc = "A modification of the CM-5 featuring a dramatically shortened barrel and removed stock. Designed for CLIP-GOLD covert enforcement agents to maximize portability without sacrificing firepower, though accuracy at range is abysmal at best. Chambered in 9mm."
	icon_state = "cm5c"
	inhand_icon_state = "cm5c"

	w_class = WEIGHT_CLASS_NORMAL
	spread = 10
	spread_unwielded = 20

	fire_delay = 0.1 SECONDS

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 30,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 22,
			"y" = 17,
		)
	)


	recoil = 1
	recoil_unwielded = 2
	wield_slowdown = 0.15

	var/obj/item/storage/briefcase/current_case

/obj/item/gun/ballistic/automatic/smg/cm5/compact/empty
	spawn_magazine_type = /obj/item/ammo_box/magazine/cm5_9mm/empty

/obj/item/gun/ballistic/automatic/smg/cm5/compact/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(current_case)
		return
	if(!istype(attacking_item, /obj/item/storage/briefcase))
		return
	if(attacking_item.contents.len != 0)
		return
	to_chat(user, span_notice("...? You rig [src] to fire from within [attacking_item]."))
	current_case = attacking_item
	attacking_item.forceMove(src)
	icon = attacking_item.icon
	base_icon_state = attacking_item.icon_state
	inhand_icon_state = attacking_item.inhand_icon_state
	name = attacking_item.name
	lefthand_file = attacking_item.lefthand_file
	righthand_file = attacking_item.righthand_file
	pickup_sound = attacking_item.pickup_sound
	drop_sound = attacking_item.drop_sound
	w_class = WEIGHT_CLASS_BULKY

//how are you even supposed to hold it like this...?
	spread += 10
	spread_unwielded +=10

	cut_overlays()
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/cm5/compact/click_alt(mob/user)
	if(!current_case)
		return ..()
	user.put_in_hands(current_case)
	icon = src::icon
	base_icon_state = src::icon_state
	inhand_icon_state = src::inhand_icon_state
	name = src::name
	lefthand_file = src::lefthand_file
	righthand_file = src::righthand_file
	pickup_sound = src::pickup_sound
	drop_sound = src::drop_sound
	w_class = WEIGHT_CLASS_NORMAL

	spread = src::spread
	spread_unwielded = src::spread_unwielded
	to_chat(user, span_notice("You remove the [current_case] from [src]"))
	current_case = null

	cut_overlays()
	update_appearance()


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

	valid_attachments = CLIP_ATTACHMENTS
	slot_available = CLIP_ATTACHMENT_POINTS
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 17,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 35,
			"y" = 16,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 18,
			"y" = 22,
		)
	)

	default_attachments = list(/obj/item/attachment/scope)

	wield_slowdown = DMR_SLOWDOWN
	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

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
	spread_unwielded = 35
	recoil = 2
	recoil_unwielded = 10
	wield_slowdown = SNIPER_SLOWDOWN
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 16,
		),
	)

	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

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

	valid_attachments = CLIP_ATTACHMENTS
	slot_available = CLIP_ATTACHMENT_POINTS

	load_sound = 'tff_modular/modules/evento_needo/sounds/rifle/cm82_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/cm82_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/rifle/cm82_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/cm82_unload.ogg'

	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 47,
			"y" = 19,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 29,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 15,
			"y" = 24,
		)
	)

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
	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE

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
	spread_unwielded = 35

	recoil = 1
	recoil_unwielded = 7 //same as skm

	wield_slowdown = SAW_SLOWDOWN //not as severe as other lmgs, but worse than the normal skm

	has_bipod = TRUE

	//you get the rail slot back when the bipod is an attachment
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_SCOPE = 1
	)


	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 19,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 12,
			"y" = 25,
		)
	)

	deploy_recoil_bonus = -2
	deploy_spread_bonus = -6

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
	mag_display = FALSE //TEMP SARGASSUM FIX IT BRUH


	fire_sound = 'tff_modular/modules/evento_needo/sounds/hmg/hmg.ogg'

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	fire_delay = 0.3 SECONDS //chunky machine gun

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	bolt_type = BOLT_TYPE_STANDARD
	tac_reloads = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/rottweiler_308_box

	spread = 12
	spread_unwielded = 35

	recoil = 3 //it's firing .308
	recoil_unwielded = 8

	has_bipod = TRUE

	deploy_recoil_bonus = -3
	deploy_spread_bonus = -10 //2 degree spread when deployed, making it VERY accurate for an lmg

	valid_attachments = CLIP_ATTACHMENTS
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_SCOPE = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 49,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 19,
			"y" = 21,
		)
	)

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

	fire_select_icon_state_prefix = "clip_"
	adjust_fire_select_icon_state_on_safety = TRUE


	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/cm15_12g

	empty_indicator = FALSE
	semi_auto = TRUE
	internal_magazine = FALSE
	casing_ejector = TRUE
	tac_reloads = TRUE
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
	spread_unwielded = 15
	recoil = 1
	recoil_unwielded = 4
	wield_slowdown = HEAVY_SHOTGUN_SLOWDOWN
	fire_delay = 0.4 SECONDS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 34,
			"y" = 15,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 44,
			"y" = 19,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 21,
			"y" = 25,
		)
	)
