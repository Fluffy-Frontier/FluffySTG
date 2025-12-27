/**
Pulse Rifles
*/

/obj/item/gun/ballistic/pulse
	name = "SWS Motorized Pulse Rifle"
	desc = "The SWS Motorized Pulse Rifle is a military-grade, triple-barreled assault rifle, manufactured by Winchester Arms, is capable of a rapid rate of fire. \
			The Pulse Rifle is the standard-issue service rifle of the Earth Defense Force and is also common among corporate security officers. "
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ds13guns48x32.dmi'
	icon_state = "pulserifle"
	icon_wielded = "pulserifle-wielded"
	lefthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/lefthand_guns.dmi'
	righthand_file = 'tff_modular/modules/deadspace/icons/event/mob/onmob/righthand_guns.dmi'
	worn_icon = 'tff_modular/modules/deadspace/icons/event/mob/onmob/back.dmi'
	worn_icon_state = null
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	mag_display = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/pulse
	empty_alarm = TRUE
	show_bolt_icon = FALSE
	burst_size = 1
	can_suppress = FALSE
	spread = 15
	unwielded_spread = 15
	wielded_spread = 5
	recoil = 3
	wielded_recoil = 1
	unwielded_recoil = 3
	fire_sound = 'tff_modular/modules/deadspace/sound/event/pulse_shot.ogg'
	load_sound = 'tff_modular/modules/deadspace/sound/event/pulse_magin.ogg'
	eject_sound = 'tff_modular/modules/deadspace/sound/event/pulse_magout.ogg'

/obj/item/gun/ballistic/pulse/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/pulse/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed_gun, wielded_spread = wielded_spread, wielded_recoil = wielded_recoil, unwielded_spread = unwielded_spread, unwielded_recoil = unwielded_recoil, icon_wielded = icon_wielded)
	AddComponent(/datum/component/automatic_fire, 0.1 SECONDS)

/obj/item/gun/ballistic/pulse/egov //Same situation as rending divet
	name = "Earthgov SWS Motorized Pulse Rifle"
	desc = "The SWS Motorized Pulse Rifle is a military-grade, triple-barreled assault rifle, manufactured by Winchester Arms, is capable of a rapid rate of fire. \
This variant is of standard earthgov issue, featuring the highest grade parts."
	icon_state = "pulserifle_egov"
	base_icon_state = "pulserifle_egov"
	icon_wielded = "pulserifle_egov-wielded"
	inhand_icon_state = null
	projectile_damage_multiplier = 1.10
	spread = 4

/obj/item/gun/ballistic/pulse/egov/Initialize(mapload)
	. = ..()
	magazine = new /obj/item/ammo_box/magazine/pulse/hv(src)

/**
Magazines
*/

/obj/item/ammo_box/magazine/pulse
	name = "pulse magazine (standard)"
	desc = "With a distinctive \"bell and stock\" design, pulse magazines can be inserted and removed from the Pulse Rifle with minimal effort and risk."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/ammo.dmi'
	icon_state = "pulse_rounds"
	caliber = CALIBER_PULSE
	ammo_type = /obj/item/ammo_casing/caseless/pulse
	max_ammo = 50 //To low? 65 normal on 1.0
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/pulse/hv
	name = "pulse magazine (high velocity)"
	desc = "With a distinctive \"bell and stock\" design, pulse magazines can be inserted and removed from the Pulse Rifle with minimal effort and risk. This one contains hypersonic rounds, unsafe for naval usage."
	icon_state = "pulse_rounds_hv"
	ammo_type = /obj/item/ammo_casing/caseless/pulse/hv

/obj/item/ammo_box/magazine/pulse/df
	name = "pulse magazine (deflection)"
	desc = "With a distinctive \"bell and stock\" design, pulse magazines can be inserted and removed from the Pulse Rifle with minimal effort and risk. This one contains EXPERIMENTAL deflection rounds. Extremely dangerous, these rounds are with a deflective tip, letting them bounce of surfaces."
	icon_state = "pulse_rounds_df"
	ammo_type = /obj/item/ammo_casing/caseless/pulse/df

/obj/item/ammo_box/magazine/pulse/blank
	name = "pulse magazine (blank/practice)"
	desc = "With a distinctive \"bell and stock\" design, pulse magazines can be inserted and removed from the Pulse Rifle with minimal effort and risk. This one contains practice rounds, used in training for its nonlethality."
	ammo_type = /obj/item/ammo_casing/caseless/pulse/blank

/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/caseless/pulse
	name = "pulse round"
	desc = "A ultra-small caliber round designed for the SWS Motorized Pulse Rifle."
	icon_state = "s-casing"
	caliber = CALIBER_PULSE
	projectile_type = /obj/projectile/bullet/pulse

/obj/item/ammo_casing/caseless/pulse/hv
	name = "high velocity pulse round"
	desc = "A ultra-small caliber hypersonic round designed for the SWS Motorized Pulse Rifle."
	projectile_type = /obj/projectile/bullet/pulse/hv

/obj/item/ammo_casing/caseless/pulse/df
	name = "deflection pulse round"
	desc = "A ultra-small caliber deflection round designed for the SWS Motorized Pulse Rifle."
	projectile_type = /obj/projectile/bullet/pulse/df

/obj/item/ammo_casing/caseless/pulse/blank
	name = "blank pulse round"
	desc = "A ultra-small caliber round designed for the SWS Motorized Pulse Rifle as practice shooting."
	projectile_type = /obj/projectile/bullet/pulse/blank
	harmful = FALSE

/obj/projectile/bullet/pulse
	name = "pulse"
	icon = 'tff_modular/modules/deadspace/icons/event/obj/projectiles.dmi'
	icon_state = "pulse"
	damage = 14
	speed = 1
	armour_penetration = 4 //Should be quite low I'd think, especially for standard rounds. Bullet made to shred and liquify flesh but not affect materialistic objects much.
	shrapnel_type = null
	embed_type = null
	muzzle_type = /obj/effect/projectile/pulse/light

/obj/projectile/bullet/pulse/hv
	icon_state = "pulse_hv"
	damage = 15.5
	armour_penetration = 12
	muzzle_type = /obj/effect/projectile/pulse/hv

/obj/projectile/bullet/pulse/df
	icon_state = "pulse_df"
	damage = 12
	stamina = 8
	ricochets_max = 2
	ricochet_incidence_leeway = 0
	ricochet_chance = 120
	ricochet_auto_aim_angle = 40
	ricochet_auto_aim_range = 5
	ricochet_decay_damage = 0.9
	muzzle_type = /obj/effect/projectile/pulse/df

/obj/projectile/bullet/pulse/blank //Use Divet blank when it changes
	damage = 1 //Can maybe do burn damage, reduced range
	armour_penetration = 0
	weak_against_armour = TRUE
	sharpness = NONE
	muzzle_type = /obj/effect/projectile/pulse/df

/**
Projectiles effects
*/

/obj/effect/projectile/pulse
	icon = 'tff_modular/modules/deadspace/icons/event/obj/projectiles.dmi'
	icon_state = "muzzle_pulse"
	light_power = 0.7
	light_color = COLOR_DEEP_SKY_BLUE

/obj/effect/projectile/pulse/light
	icon_state = "muzzle_pulse_light"
	light_power = 0.6
	light_color = COLOR_DEEP_SKY_BLUE

/obj/effect/projectile/pulse/hv
	icon_state = "muzzle_pulse_hv"
	light_power = 0.6
	light_color = COLOR_MARKER_RED

/obj/effect/projectile/pulse/df
	icon_state = "muzzle_pulse_light"
	light_power = 0.6
	light_color = COLOR_YELLOW

/obj/effect/projectile/pulse_impact
	name = "impact"
	icon = 'tff_modular/modules/deadspace/icons/event/obj/projectiles_effects.dmi'
	icon_state = "pulse_hit"
