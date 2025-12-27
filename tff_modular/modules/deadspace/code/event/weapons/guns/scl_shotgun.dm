/**
DS SCL Shotgun
*/

/obj/item/gun/ballistic/shotgun/scl_shotgun //Has no bola mode yet
	name = "\improper SCL Shotgun"
	desc = "The SCL Shotgun is a close to medium-ranged weapon developed by the Sovereign Colonies Armed Forces and utilized by SCAF Legionaries. \
	The shotgun has remained in use in private security and police departments as a riot-control tool, given its ability to fire incapacitating shells for capture and arrest, or lethal slugs in life-threatening situations. \
	The SCL Shotgun is magazine loaded and is effective at short range or for fugitive capture."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ds13guns48x32.dmi'
	icon_state = "scl_shotgun"
	icon_wielded = null
	lefthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/lefthand_guns.dmi'
	righthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/righthand_guns.dmi'
	worn_icon = 'tff_modular/modules/deadspace/icons/event/mob/onmob/back.dmi'
	worn_icon_state = "scl_shotgun"
	inhand_icon_state = null
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	accepted_magazine_type = /obj/item/ammo_box/magazine/ds12g
	weapon_weight = WEAPON_MEDIUM
	can_suppress = FALSE
	fire_delay = 10
	fire_sound = 'sound/items/weapons/gun/shotgun/shot_alt.ogg'
	spread = 40
	unwielded_spread = 40
	wielded_spread = 30
	recoil = 5
	unwielded_recoil = 5
	wielded_recoil = 0.1
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	empty_alarm = TRUE
	mag_display = TRUE
	semi_auto = TRUE
	internal_magazine = FALSE

/obj/item/gun/ballistic/shotgun/scl_shotgun/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed_gun, wielded_spread = wielded_spread, wielded_recoil = wielded_recoil, unwielded_spread = unwielded_spread, unwielded_recoil = unwielded_recoil, icon_wielded = icon_wielded)

/obj/item/gun/ballistic/shotgun/scl_shotgun/update_icon_state()
	. = ..()
	inhand_icon_state = "[initial(icon_state)][magazine? "_mag" : ""]"

/obj/item/gun/ballistic/shotgun/scl_shotgun/update_overlays()
	. = ..()
	. += "scl_shotgun[magazine ? "_mag" : ""]"

/obj/item/gun/ballistic/shotgun/scl_shotgun/no_mag
	spawnwithmagazine = FALSE

/**
Magazines
*/

/obj/item/ammo_box/magazine/ds12g
	name = "magazine SCL-shotgun buckshot"
	desc = "Magazine of 12 gauge shells."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ammo.dmi'
	icon_state = "shotgun_magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 7
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/ds12g/slug
	name = "magazine SCL-shotgun slug"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/ds12g/executioner //admin only, can dismember limbs
	name = "magazine SCL-shotgun executioner"
	ammo_type = /obj/item/ammo_casing/shotgun/executioner

/obj/item/ammo_box/magazine/ds12g/pulverizer //admin only, can crush bones
	name = "magazine SCL-shotgun pulverizer"
	ammo_type = /obj/item/ammo_casing/shotgun/pulverizer

/obj/item/ammo_box/magazine/ds12g/beanbag
	name = "magazine SCL-shotgun beanbag"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/magazine/ds12g/incendiary
	name = "magazine SCL-shotgun incendiary"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary

/obj/item/ammo_box/magazine/ds12g/dragonsbreath
	name = "magazine SCL-shotgun dragonsbreath"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/ammo_box/magazine/ds12g/stunslug
	name = "magazine SCL-shotgun stunslug"
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/magazine/ds12g/pulseslug
	name = "magazine SCL-shotgun pulseslug"
	ammo_type = /obj/item/ammo_casing/shotgun/pulseslug

/obj/item/ammo_box/magazine/ds12g/meteorslug
	name = "magazine SCL-shotgun meteorslug"
	ammo_type = /obj/item/ammo_casing/shotgun/meteorslug

/obj/item/ammo_box/magazine/ds12g/frag12
	name = "magazine SCL-shotgun frag12"
	ammo_type = /obj/item/ammo_casing/shotgun/frag12

/obj/item/ammo_box/magazine/ds12g/rb
	name = "magazine SCL-shotgun rubbershot"
	desc = "Magazine of rubbershot."
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/magazine/ds12g/incapacitate
	name = "magazine SCL-shotgun incapacitate"
	ammo_type = /obj/item/ammo_casing/shotgun/incapacitate

/obj/item/ammo_box/magazine/ds12g/dart
	name = "magazine SCL-shotgun dart"
	ammo_type = /obj/item/ammo_casing/shotgun/dart

/obj/item/ammo_box/magazine/ds12g/bioterror
	name = "magazine SCL-shotgun bioterror"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/bioterror

/**
Projectiles effects
*/

/obj/effect/projectile/shotgun
	name = "impact"
	icon = 'tff_modular/modules/deadspace/icons/event/obj/projectiles_effects.dmi'
	icon_state = "shotgun_hit"
