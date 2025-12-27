/obj/item/gun/ballistic/rifle/boltaction/harpoon/javelin
	name = "T15 Javelin Gun"
	desc = "a telemetric survey tool manufactured by Timson Tools, designed to fire titanium spikes or 'javelins' at high speeds with extreme accuracy and piercing power."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ds13guns48x32.dmi'
	icon_state = "javelin"
	icon_wielded = null
	inhand_icon_state = null
	lefthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/lefthand_guns.dmi'
	righthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/righthand_guns.dmi'
	worn_icon = 'tff_modular/modules/deadspace/icons/event/mob/onmob/back.dmi'
	worn_icon_state = "javelin"
	empty_alarm = FALSE
	mag_display = TRUE
	internal_magazine = FALSE
	show_bolt_icon = FALSE
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/javelin
	fire_delay = 1.5 SECONDS
	can_suppress = FALSE
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	spread = 50
	unwielded_spread = 50
	wielded_spread = 0.5
	recoil = 2
	unwielded_recoil = 2
	wielded_recoil = 0.1
	burst_size = 1
	semi_auto = TRUE
	actions_types = list()
	fire_sound = 'tff_modular/modules/deadspace/sound/event/jav_fire.ogg'
	fire_sound_volume = 90
	load_sound = 'tff_modular/modules/deadspace/sound/event/jav_magin.ogg'
	eject_sound = 'tff_modular/modules/deadspace/sound/event/jav_magout.ogg'

/obj/item/gun/ballistic/rifle/boltaction/harpoon/javelin/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/rifle/boltaction/harpoon/javelin/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed_gun, wielded_spread = wielded_spread, wielded_recoil = wielded_recoil, unwielded_spread = unwielded_spread, unwielded_recoil = unwielded_recoil, icon_wielded = icon_wielded)
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/gun/ballistic/rifle/boltaction/harpoon/javelin/update_icon_state()
	. = ..()
	inhand_icon_state = "[initial(icon_state)][magazine? "_mag" : ""]"

/obj/item/gun/ballistic/rifle/boltaction/harpoon/javelin/update_overlays()
	. = ..()
	. += "javelin[magazine ? "_mag" : ""]"

/**
Magazines
*/

/obj/item/ammo_box/magazine/javelin
	name = "javelin rack"
	desc = "A set of javelins for the T15 Javelin Gun."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ammo.dmi'
	icon_state = "javelin"
	base_icon_state = "javelin-6"
	caliber = CALIBER_JAVELIN
	ammo_type = /obj/item/ammo_casing/caseless/javelin
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET


/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/caseless/javelin
	name = "javelin spear"
	desc = "a titanium spike."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ammo.dmi'
	icon_state = "javelin_bolt"
	base_icon_state = "javelin_bolt"
	caliber = CALIBER_JAVELIN
	projectile_type = /obj/projectile/bullet/javelin

/**
Projectiles for the casings
*/

/obj/projectile/bullet/javelin
	name = "javelin"
	icon = 'tff_modular/modules/deadspace/icons/event/obj/projectiles.dmi'
	icon_state = "javelin_flight"
	damage = 60
	armour_penetration = 50
	embed_type = /datum/embedding/ds_javelin

/datum/embedding/ds_javelin
	embed_chance = 100
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 10 SECONDS
