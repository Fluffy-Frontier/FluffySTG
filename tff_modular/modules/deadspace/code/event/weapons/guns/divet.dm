/**
Divet pistols
*/
//This is most handguns and bolt action rifles.  The bolt will lock back when it's empty.  You need yourgun_bolt and yourgun_bolt_locked icon states.
/obj/item/gun/ballistic/automatic/pistol/divet
	name = "Divet"
	desc = "A Winchester Arms NK-series pistol capable of fully automatic fire."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ds13guns.dmi'
	icon_state = "divet"
	inhand_icon_state = "divet"
	lefthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/lefthand_guns.dmi'
	righthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/righthand_guns.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/divet
	can_suppress = TRUE
	slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_POCKETS
	burst_size = 1
	fire_sound= 'tff_modular/modules/deadspace/sound/event/divet_fire.ogg'
	load_sound = 'sound/items/weapons/gun/pistol/mag_insert.ogg'
	eject_sound = 'sound/items/weapons/gun/pistol/mag_release.ogg'
	suppressed_sound = 'sound/items/weapons/gun/pistol/shot_suppressed.ogg'

/obj/item/gun/ballistic/automatic/pistol/divet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.3 SECONDS)

/obj/item/gun/ballistic/automatic/pistol/divet/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/divet/rb/Initialize(mapload)
	magazine = new /obj/item/ammo_box/magazine/divet/rb(src)
	return ..()

/obj/item/gun/ballistic/automatic/pistol/divet/spec_ops
	name = "special ops divet pistol"
	desc = "A modified version of the Winchester Arms NK-series pistol. An integrated suppressor lowers the audio profile fairly well."
	icon_state = "divet_spec"
	inhand_icon_state = "divet_spec"
	suppressed_volume = 40
	suppressed = TRUE
	can_unsuppress = FALSE
	//tier_2_bonus = 1

/obj/item/gun/ballistic/automatic/pistol/divet/rending//For Ketrai or another to do the necro tier bonus/debuff damage stuff
	name = "jury-rigged divet pistol"
	desc = "An illegaly modified version of the Winchester Arms NK-series pistol. Shoots bullets at brutal speed, but at an odd angle. Fractures bones easily"

/**
Magazines
*/

/obj/item/ammo_box/magazine/divet
	name = "divet magazine (pistol slug)"
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ammo.dmi'
	icon_state = "divet_slug"
	ammo_type = /obj/item/ammo_casing/divet
	caliber = CALIBER_DIVET
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/divet/hp
	name = "divet magazine (hollow point)"
	icon_state = "divet_hp"
	ammo_type = /obj/item/ammo_casing/divet/hp

/obj/item/ammo_box/magazine/divet/ap
	name = "divet magazine (AP)"
	icon_state = "divet_ap"
	ammo_type = /obj/item/ammo_casing/divet/ap

/obj/item/ammo_box/magazine/divet/rb
	name = "divet magazine (rubber)"
	icon_state = "divet_rb"
	ammo_type = /obj/item/ammo_casing/divet/rb

/obj/item/ammo_box/magazine/divet/fire
	name = "divet magazine (incendiary)"
	icon_state = "divet_incind"
	ammo_type = /obj/item/ammo_casing/divet/inc

/obj/item/ammo_box/magazine/divet/extended
	name = "divet magazine (extended)"
	icon_state = "divet_ext_slug"
	max_ammo = 24
	ammo_type = /obj/item/ammo_casing/divet/extended

/obj/item/ammo_box/magazine/divet/extended/expanded
	name = "divet magazine (expanded)"
	icon_state = "divet_exp_slug"
	max_ammo = 48

/obj/item/ammo_box/magazine/divet/blank
	name = "divet magazine (blank/practice)"
	icon_state = "divet_rb"
	ammo_type = /obj/item/ammo_casing/divet/blank

/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/divet
	name = "divet bullet casing"
	desc = "A divet bullet casing."
	caliber = CALIBER_DIVET
	projectile_type = /obj/projectile/bullet/divet

/obj/item/ammo_casing/divet/hp
	name = "divet hollow-point bullet casing"
	projectile_type = /obj/projectile/bullet/divet/hp

/obj/item/ammo_casing/divet/ap
	name = "divet armor-piercing bullet casing"
	projectile_type = /obj/projectile/bullet/divet/ap

/obj/item/ammo_casing/divet/rb
	name = "divet rubber bullet casing"
	projectile_type = /obj/projectile/bullet/divet/rb

/obj/item/ammo_casing/divet/inc
	name = "divet incendiary bullet casing"
	projectile_type = /obj/projectile/bullet/incendiary/divet

/obj/item/ammo_casing/divet/extended
	name = "divet steel bullet casing"
	projectile_type = /obj/projectile/bullet/divet/extended

/obj/item/ammo_casing/divet/blank
	name = "divet blank bullet casing"
	projectile_type = /obj/projectile/bullet/divet/blank
	harmful = FALSE

/**
Projectiles for the casings
*/

/obj/projectile/bullet/divet
	name = "divet bullet"
	icon = 'tff_modular/modules/deadspace/icons/event/obj/projectiles.dmi'
	icon_state = "divet"
	damage = 15
	armour_penetration = 10
	wound_falloff_tile = -10
	dismemberment = 5
	embed_type = /datum/embedding/divet

//More damage and shrapnel, less AP, structure damage and penetration
/obj/projectile/bullet/divet/hp
	name = "divet hollow-point bullet"
	icon_state = "divet_hp"
	damage = 20
	armour_penetration = 0
	weak_against_armour = TRUE

//Opposite of hollowpoint
/obj/projectile/bullet/divet/ap
	name = "divet armor-piercing bullet"
	icon_state = "divet_ap"
	damage = 12
	armour_penetration = 20

//Less lethal ammo. Rubber bullets, now with bounce!
/obj/projectile/bullet/divet/rb
	name = "divet rubber bullet"
	icon_state = "divet" //Maybe get rubber bullet sprite in future
	damage = 6
	stamina = 30
	weak_against_armour = TRUE
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embed_type = null

//Bullets that set people AND THE ENVIRONMENT on fire, have reduced armor penetration
//They also have reduced flat damage, likely due to much of the casing space being taken for incindiary use instead (and balance)
/obj/projectile/bullet/incendiary/divet
	name = "divet incendiary bullet"
	icon = 'tff_modular/modules/deadspace/icons/event/obj/projectiles.dmi'
	icon_state = "divet_incend"
	damage = 10
	armour_penetration = 5
	fire_stacks = 1

//Leaving here if someone wanted to try to use old incendiary stuff (slightly modified, not enougb to work though)
/obj/projectile/bullet/incendiary/divet/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()

	if(iscarbon(target))
		var/mob/living/carbon/gaslighter = target
		gaslighter.adjust_fire_stacks(fire_stacks)
		gaslighter.ignite_mob()

//Cheaper bullets that put inside the extended mags by default, to cut some costs of the more trigger happy prone who use the mags
/obj/projectile/bullet/divet/extended
	name = "divet steel bullet"
	damage = 15.5

/obj/projectile/bullet/divet/blank
	name = "divet blank bullet"
	icon_state = "divet"
	damage = 1 //Can do burn damage, reduced range...
	dismemberment = 0
	weak_against_armour = TRUE
	shrapnel_type = null
	sharpness = NONE
	embed_type = null

/**
Projectiles for the casings
*/

/obj/effect/projectile/divet
	name = "impact"
	icon = 'tff_modular/modules/deadspace/icons/event/obj/projectiles_effects.dmi'
	icon_state = "divet_hit"


/datum/embedding/divet
	embed_chance = 25
	fall_chance = 2
	jostle_chance = 2
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 3
	jostle_pain_mult = 5
	rip_time = 1 SECONDS
