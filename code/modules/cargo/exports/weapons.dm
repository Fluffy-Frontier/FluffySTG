// Weapon exports. Stun batons, disablers, etc.

/datum/export/weapon
	include_subtypes = FALSE

/datum/export/weapon/baton
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "stun baton"
	export_types = list(/obj/item/melee/baton/security)
	exclude_types = list(/obj/item/melee/baton/security/cattleprod)
	include_subtypes = TRUE

/datum/export/weapon/knife
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "combat knife"
	export_types = list(/obj/item/knife/combat)


/datum/export/weapon/taser
	cost = CARGO_CRATE_VALUE
	unit_name = "advanced taser"
	export_types = list(/obj/item/gun/energy/e_gun/advtaser)

/datum/export/weapon/laser
	cost = CARGO_CRATE_VALUE
	unit_name = "laser gun"
	export_types = list(/obj/item/gun/energy/laser)

/datum/export/weapon/disabler
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "disabler"
	export_types = list(/obj/item/gun/energy/disabler)

/datum/export/weapon/energy_gun
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "energy gun"
	export_types = list(/obj/item/gun/energy/e_gun)

/datum/export/weapon/inferno
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "inferno pistol"
	export_types = list(/obj/item/gun/energy/laser/thermal/inferno)

/datum/export/weapon/cryo
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "cryo pistol"
	export_types = list(/obj/item/gun/energy/laser/thermal/cryo)

/datum/export/weapon/shotgun
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "combat shotgun"
	export_types = list(/obj/item/gun/ballistic/shotgun/automatic/combat)


/datum/export/weapon/flashbang
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "flashbang grenade"
	export_types = list(/obj/item/grenade/flashbang)

/datum/export/weapon/teargas
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "tear gas grenade"
	export_types = list(/obj/item/grenade/chem_grenade/teargas)


/datum/export/weapon/flash
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "handheld flash"
	export_types = list(/obj/item/assembly/flash)
	include_subtypes = TRUE

/datum/export/weapon/handcuffs
	cost = CARGO_CRATE_VALUE * 0.015
	unit_name = "pair"
	message = "of handcuffs"
	export_types = list(/obj/item/restraints/handcuffs)

/datum/export/weapon/wt550
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "WT-550 automatic rifle"
	export_types = list(/obj/item/gun/ballistic/automatic/wt550)

/datum/export/weapon/reagent_sword
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "reagent sword"
	export_types = list(/obj/item/forging/reagent_weapon/sword)

/datum/export/weapon/reagent_katana
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "reagent katana"
	export_types = list(/obj/item/forging/reagent_weapon/katana)

/datum/export/weapon/reagent_dagger
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "reagent dagger"
	export_types = list(/obj/item/forging/reagent_weapon/dagger)

/datum/export/weapon/reagent_staff
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "reagent staff"
	export_types = list(/obj/item/forging/reagent_weapon/staff)

/datum/export/weapon/reagent_spear
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "reagent spear"
	export_types = list(/obj/item/forging/reagent_weapon/spear)

/datum/export/weapon/reagent_axe
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "reagent axe"
	export_types = list(/obj/item/forging/reagent_weapon/axe)

/datum/export/weapon/reagent_hammer
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "reagent hammer"
	export_types = list(/obj/item/forging/reagent_weapon/hammer)

/datum/export/weapon/reagent_buckler
	cost = CARGO_CRATE_VALUE * 1.6
	unit_name = "reagent plated buckler shield"
	export_types = list(/obj/item/shield/buckler/reagent_weapon)

/datum/export/weapon/reagent_pavise_shield
	cost = CARGO_CRATE_VALUE * 1.6
	unit_name = "reagent plated pavise shield"
	export_types = list(/obj/item/shield/buckler/reagent_weapon/pavise)

/datum/export/weapon/reagent_pickaxe
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "reagent pickaxe"
	export_types = list(/obj/item/pickaxe/reagent_weapon)

/datum/export/weapon/reagent_shovel
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "reagent shovel"
	export_types = list(/obj/item/shovel/reagent_weapon)

/datum/export/weapon/reagent_bokken
	cost = CARGO_CRATE_VALUE * 1.3
	unit_name = "reagent bokken"
	export_types = list(/obj/item/forging/reagent_weapon/bokken)
