/obj/item/gun/ballistic/automatic/c20r_interdyne
	name = "\improper C-20r Special"
	desc = "A special full-auto version of C-20r carabine, designed for planetary combat. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp."
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/rifle_heavy.ogg'
	fire_sound_volume = 70
	icon_state = "c20r"
	inhand_icon_state = "c20r"
	selector_switch_icon = FALSE
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 1
	accepted_magazine_type = /obj/item/ammo_box/magazine/smgm45 //на практике это .460 церес
	pin = /obj/item/firing_pin/implant/pindicate
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	recoil = 0.5
	spread = 3

/obj/item/gun/ballistic/automatic/vks017
	name = "\improper Sindano Special"
	desc = "A deeply modified version of the Sindano."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns32x.dmi'
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/pistol_light.ogg'
	icon_state = "sindano_evil"
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "sindano_evil"
	special_mags = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	bolt_type = BOLT_TYPE_OPEN
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT
	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol
	spawn_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol/stendo/improved
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 1
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	recoil = 0.2
	spread = 3

/obj/item/gun/ballistic/shotgun/riot/sol/evil/special
	recoil = 1

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/improved
	name = "\improper Sol extended improved magazine"
	desc = "An extended magazine for SolFed pistols. Customized for the needs of security guards and private companies."
	w_class = WEIGHT_CLASS_TINY

// Даём им плюшки (кому надо)
/obj/item/gun/ballistic/automatic/c20r_interdyne/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.18 SECONDS)

/obj/item/gun/ballistic/automatic/vks017/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.18 SECONDS)

/obj/item/gun/ballistic/automatic/vks017/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 9)

// делаем пушкам ящики
/obj/item/storage/toolbox/guncase/interdyne
	name = "Special gun case"
	desc = "A weapon's case. Has a blood-red 'S' stamped on the cover."

/obj/item/storage/toolbox/guncase/interdyne/c20r/PopulateContents()
	new /obj/item/gun/ballistic/automatic/c20r_interdyne(src)
	new /obj/item/ammo_box/magazine/smgm45(src)
	new /obj/item/ammo_box/magazine/smgm45(src)

/obj/item/storage/toolbox/guncase/interdyne/vks017/PopulateContents()
	new /obj/item/gun/ballistic/automatic/vks017(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo/improved(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo/improved(src)

// Делаем есворд для офицера
/obj/item/melee/energy/sword/saber/green/dyne
	name = "Officer energy sword"
	desc = "“When death comes for me, I will look it right in the eye” - reads the inscription on the hilt."
