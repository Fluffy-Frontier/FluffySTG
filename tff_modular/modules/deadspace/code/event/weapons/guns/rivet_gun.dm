/obj/item/gun/ballistic/automatic/pistol/rivet
	name = "711-MarkCL Rivet Gun"
	desc = "The latest refinement from Timson Tools' long line of friendly tools."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ds13guns48x32.dmi'
	icon_state = "rivetgun"
	inhand_icon_state = "rivetgun"
	lefthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/lefthand_guns.dmi'
	righthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/righthand_guns.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/rivet
	slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_POCKETS
	burst_size = 1
	show_bolt_icon = FALSE
	fire_sound= 'tff_modular/modules/deadspace/sound/weapons/guns/fire/rivet_fire.ogg'
	load_sound = 'tff_modular/modules/deadspace/sound/weapons/guns/interaction/rivet_magin.ogg'
	eject_sound = 'tff_modular/modules/deadspace/sound/weapons/guns/interaction/rivet_magout.ogg'

/obj/item/gun/ballistic/automatic/pistol/rivet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.3 SECONDS)

/obj/item/gun/ballistic/automatic/pistol/rivet/no_mag
	spawnwithmagazine = FALSE

/**
Magazines
*/

/obj/item/ammo_box/magazine/rivet
	name = "rivet magazine"
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ammo.dmi'
	icon_state = "rivet"
	ammo_type = /obj/item/ammo_casing/caseless/rivet
	caliber = CALIBER_RIVET
	max_ammo = 16
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/caseless/rivet
	name = "rivet"
	desc = "A spent rivet."
	icon_state = "762-casing"
	caliber = CALIBER_RIVET
	projectile_type = /obj/projectile/bullet/rivet

/obj/projectile/bullet/rivet
	name = "rivet bullet"
	icon = 'tff_modular/modules/deadspace/icons/event/obj/projectiles.dmi'
	icon_state = "rivet"
	damage = 13
	armour_penetration = 10
	wound_falloff_tile = -10
	dismemberment = 5
	embed_type = /datum/embedding/rivet

/datum/embedding/rivet
	embed_chance = 25
	fall_chance = 2
	jostle_chance = 2
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 3
	jostle_pain_mult = 5
	rip_time = 1 SECONDS
