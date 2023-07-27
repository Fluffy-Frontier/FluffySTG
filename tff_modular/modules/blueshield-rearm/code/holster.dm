/*
*	Holster for the SR-8 and its ammo.
*/

/obj/item/storage/belt/holster/energy/blueshield
	name = "5GUARD-S model holster"
	desc = "Pretty robust webbing with magnetic holsters. Designed to hold blueshield's energy weaponry and a few cells for it."
	badass = FALSE
	icon = 'tff_modular/modules/blueshield-rearm/icons/holster.dmi'
	icon_state = "blueshield_holster"
	worn_icon = 'tff_modular/modules/blueshield-rearm/icons/holster.dmi'
	worn_icon_teshari = 'tff_modular/modules/blueshield-rearm/icons/holster_teshari.dmi'
	worn_icon_state = "blueshield_holster_worn"

/obj/item/storage/belt/holster/energy/blueshield/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 2
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.set_holdable(list(
		/obj/item/gun/energy/blueshield,
		/obj/item/stock_parts/cell,
		))

/obj/item/storage/belt/holster/energy/blueshield/PopulateContents()
	. = ..()
	new	/obj/item/gun/energy/blueshield(src)
	new	/obj/item/stock_parts/cell/super(src)
	new	/obj/item/stock_parts/cell/super(src)

// worn_icon_teshari не используеться когда что-то надеваеться в хранилище верхней одежды.
/obj/item/storage/belt/holster/energy/blueshield/equipped(mob/user, slot) 
	. = ..()
	if(is_species(user, /datum/species/teshari))
		worn_icon = 'tff_modular/modules/blueshield-rearm/icons/holster_teshari.dmi'
	else
		worn_icon = 'tff_modular/modules/blueshield-rearm/icons/holster.dmi'
