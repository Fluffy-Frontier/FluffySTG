/*
*	Holster for new gun and its ammo.
*/

/obj/item/storage/belt/holster/energy/blueshield
	name = "5GUARD-S model shoulder holster"
	desc = "A rather plain pair of shoulder holsters with a bit of insulated padding inside. Designed to hold blueshield's energy weaponry and ammo for it."
	badass = FALSE
	icon = '~ff/blueshield-rearm/icons/holster.dmi'
	icon_state = "blueshield_holster"
	worn_icon = '~ff/blueshield-rearm/icons/holster.dmi'
	worn_icon_teshari = '~ff/blueshield-rearm/icons/holster_teshari.dmi'
	worn_icon_state = "blueshield_holster_worn"
	

/obj/item/storage/belt/holster/energy/blueshield/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 4
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.set_holdable(list(
		/obj/item/gun/ballistic/revolver/blueshield,
		/obj/item/ammo_box/revolver_blueshield,
		))

/obj/item/storage/belt/holster/energy/blueshield/PopulateContents()
	. = ..()
	new	/obj/item/gun/ballistic/revolver/blueshield(src)
	new	/obj/item/ammo_box/revolver_blueshield/stun(src)
	new	/obj/item/ammo_box/revolver_blueshield/laser(src)
	new	/obj/item/ammo_box/revolver_blueshield/concentrated(src)

/obj/item/storage/belt/holster/energy/blueshield/equipped(mob/user, slot) // because when things are in suit storage slot - they are not using teshari's icons.
	. = ..()
	if(is_species(user, /datum/species/teshari))
		worn_icon = '~ff/blueshield-rearm/icons/holster_teshari.dmi'
	else
		worn_icon = '~ff/blueshield-rearm/icons/holster.dmi'

/*
*	 New gun.
*/

/obj/item/gun/ballistic/revolver/blueshield
	name = "\improper SR-8 energy revolver"
	desc = "SR-8 is a experemental energy revolver that utilises special energy capsules."
	icon = '~ff/blueshield-rearm/icons/sr-8.dmi'
	righthand_file = '~ff/blueshield-rearm/icons/righthand.dmi'
	lefthand_file = '~ff/blueshield-rearm/icons/lefthand.dmi'
	icon_state = "sr-8"
	inhand_icon_state = "sr-8"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/blueshield
	fire_sound = 'sound/weapons/pulse.ogg'
	fire_delay = 1.90

/obj/item/gun/ballistic/revolver/blueshield/spin()
	set name = "Spin Chamber"
	set category = "Object"
	set desc = "Click to spin your revolver's chamber."
	var/mob/M = usr
	if(M.stat || !in_range(M,src))
		return
	if (recent_spin > world.time)
		return
	recent_spin = world.time + spin_delay
	usr.visible_message(self_message = span_notice("You try to spin [src]'s chamber, but it is not spinnable and constructionaly more alike internal magazine."))


/obj/item/gun/ballistic/revolver/revolution/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/revolver/blueshield/fire_sounds()
	playsound(src, chambered.fire_sound, fire_sound_volume, vary_fire_sound)

/obj/item/ammo_box/magazine/internal/cylinder/blueshield
	name = "\improper SR-8 internal capsule storage"
	ammo_type = /obj/item/ammo_casing/energy_capsule/stun
	caliber = "energy_capsule"
	max_ammo = 8

/obj/item/ammo_box/revolver_blueshield
	name = "\improper blueshield's gun speedloader"
	desc = "Speedloader designed to help reloading special energy capsule revolver. Speedloaders of this model are much more complex and bulkier that regular ones due heavy over-engineering."
	icon_state = "speedloader"
	icon = '~ff/blueshield-rearm/icons/mags.dmi'
	ammo_type = /obj/item/ammo_casing/energy_capsule
	max_ammo = 8
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	caliber = "energy_capsule"
	start_empty = TRUE
	w_class = WEIGHT_CLASS_NORMAL


/obj/item/ammo_box/revolver_blueshield/laser
	name = "\improper SR-8 laser speedloader"
	desc = "Speedloader designed to help reloading special energy capsule revolver. Speedloaders of this model are much more complex and bulkier that regular ones due heavy over-engineering. This speedloader meant to hold basic lethal capsules."
	ammo_type = /obj/item/ammo_casing/energy_capsule
	icon_state = "speedloader_laser"
	start_empty = FALSE


/obj/item/ammo_box/revolver_blueshield/stun
	name = "\improper SR-8 s-shots speedloader"
	desc = "Speedloader designed to help reloading special energy capsule revolver. Speedloaders of this model are much more complex and bulkier that regular ones due heavy over-engineering. This speedloader meant to hold non-lethal disabler capsules."
	ammo_type = /obj/item/ammo_casing/energy_capsule/stun
	icon_state = "speedloader_stun"
	start_empty = FALSE

/obj/item/ammo_box/revolver_blueshield/concentrated
	name = "\improper SR-8 gun e-bullets speedloader"
	desc = "Speedloader designed to help reloading special energy capsule revolver. Speedloaders of this model are much more complex and bulkier that regular ones due heavy over-engineering. This speedloader meant to hold energy bullet lethal capsules."
	ammo_type = /obj/item/ammo_casing/energy_capsule/concentrated
	start_empty = FALSE
	icon_state = "speedloader_bullet"


/*
*	New ammo.
*/


/obj/item/ammo_casing/energy_capsule
	name = "energy capsule"
	desc = "Energy bulletcapsule for special weaponry. Energy capsules are special disposable micro-cells designed for special type of weaponry."
	caliber = "energy_capsule"
	icon = '~ff/blueshield-rearm/icons/ammo.dmi'
	icon_state = "l-capsule"
	projectile_type = /obj/projectile/beam/laser/hellfire
	fire_sound = '~ff/blueshield-rearm/sounds/laser.ogg'
	can_be_printed = FALSE

/obj/item/ammo_casing/energy_capsule/stun
	name = "stun-shot energy capsule"
	desc = "Energy bulletcapsule for special weaponry. Energy capsules are special disposable micro-cells designed for special type of weaponry. That capsule is non-lethal subtype."
	projectile_type = /obj/projectile/beam/disabler/charged
	fire_sound = 'sound/weapons/taser2.ogg'
	icon_state = "d-capsule"

/obj/item/ammo_casing/energy_capsule/concentrated
	name = "e-bullet energy capsule"
	desc = "Energy bulletcapsule for special weaponry. Energy capsules are special disposable micro-cells designed for special type of weaponry. That capsule is Energy Bullet subtype, that makes gun generate highly concentrated energy beam that acts like a bullet."
	projectile_type = /obj/projectile/bullet/concentrated_energy
	fire_sound = '~ff/blueshield-rearm/sounds/bullet.ogg'
	icon_state = "b-capsule"

/*
    Projectiles.
*/

/obj/projectile/beam/disabler/charged
	name = "charged disabler beam"
	damage = 35

/obj/projectile/bullet/concentrated_energy
	name = "concentrated energy"
	damage = 25
	icon_state = "gaussphase"

/*
*	Cargo.
*/

/datum/supply_pack/goody/sr8_ammo_stun
	name = "SR-8 s-shots speedloader"
	desc = "Single speedloader for our blueshield's special SR-8 revolver. This one is non-lethal s-shots type."
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/ammo_box/revolver_blueshield/stun)

/datum/supply_pack/goody/sr8_ammo_laser
	name = "SR-8 laser speedloader"
	desc = "Single speedloader for our blueshield's special SR-8 revolver. This one is basic lethal laser type."
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/ammo_box/revolver_blueshield/laser)

/datum/supply_pack/goody/sr8_ammo_bullet
	name = "SR-8 e-bullets speedloader"
	desc = "Single speedloader for our blueshield's special SR-8 revolver. This one is e-bullet type."
	cost = PAYCHECK_CREW * 6
	contains = list(/obj/item/ammo_box/revolver_blueshield/concentrated)
