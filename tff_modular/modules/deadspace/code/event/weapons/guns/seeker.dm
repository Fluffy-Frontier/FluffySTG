/**
Seeker Rifles
*/

/obj/item/gun/ballistic/automatic/sniper_rifle/seeker
	name = "Seeker Rifle"
	desc = "The Seeker Rifle is a suppressed riot control device that is meant for accuracy at long-range. Comes with a built-in scope."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ds13guns48x32.dmi'
	icon_state = "seeker"
	icon_wielded = "seeker-wielded"
	lefthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/lefthand_guns.dmi'
	righthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/righthand_guns.dmi'
	worn_icon = 'tff_modular/modules/deadspace/icons/event/mob/onmob/back.dmi'
	worn_icon_state = null
	inhand_icon_state = null
	mag_display = FALSE
	show_bolt_icon = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/seeker
	weapon_weight = WEAPON_MEDIUM
	fire_delay = 1.5 SECONDS
	suppressed = TRUE
	can_unsuppress = FALSE
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	block_chance = 10 //The seeker sucks quite a bit at blocking compared to other guns
	spread = 50
	wielded_spread = 5
	unwielded_spread = 50
	recoil = 6
	wielded_recoil = 0.1
	unwielded_recoil = 6
	burst_size = 1
	actions_types = list()
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	eject_sound = 'sound/machines/eject.ogg'
	suppressed_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'

/obj/item/gun/ballistic/automatic/sniper_rifle/seeker/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed_gun, wielded_spread = wielded_spread, wielded_recoil = wielded_recoil, unwielded_spread = unwielded_spread, unwielded_recoil = unwielded_recoil, icon_wielded = icon_wielded)


/obj/item/gun/ballistic/automatic/sniper_rifle/seeker/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/sniper_rifle/seeker/egov
	name = "Earthgov Seeker Rifle"
	desc = "The Earthgov Seeker Rifle is a riot control device that is meant for accuracy at long-range. Comes with a built-in scope."
	icon_state = "seeker" //Maybe get a new sprite for it in the future
	projectile_damage_multiplier = 1.15

/**
Magazines
*/

/obj/item/ammo_box/magazine/seeker
	name = "seeker shells"
	desc = "High caliber armor piercing shells designed for use in the Seeker Rifle."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ammo.dmi'
	icon_state = "seeker"
	base_icon_state = "seeker-6"
	ammo_type = /obj/item/ammo_casing/seeker
	caliber = CALIBER_SEEKER
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET

//Can potentially add alternative ammo, like the .50 cal. Soporific, penetrator, marksman, etc

/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/seeker
	name = "seeker shell"
	desc = "A high caliber round designed for the Seeker Rifle."
	icon_state = ".50"
	caliber = CALIBER_SEEKER
	projectile_type = /obj/projectile/bullet/seeker

/**
Projectiles for the casings
*/

/obj/projectile/bullet/seeker
	name ="seeker shell"
	speed = 1
	damage = 60
	paralyze = 10
	dismemberment = 30
	armour_penetration = 50
	embed_type = /datum/embedding/seeker
	// var/breakthings = TRUE

//Taken from .50 sniper. Keeping here for now, as something to check on later
// /obj/projectile/bullet/seeker/on_hit(atom/target, blocked = 0)
// 	if(isobj(target) && (blocked != 100) && breakthings)
// 		var/obj/O = target
// 		O.take_damage(80, BRUTE, BULLET, FALSE)
// 	return ..()

/datum/embedding/seeker
	embed_chance = 50
	fall_chance = 2
	jostle_chance = 2
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 7
	rip_time = 8 SECONDS
