/datum/uplink_item/suits/energy_shield
	name = "MOD Energy Shield Module"
	item = /obj/item/mod/module/advanced_energy_shield
	cost = 6
	purchasable_from = (UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)

/datum/uplink_item/suits/mod_armblade_module
	name = "MOD armblade module"
	desc = "Massive MOD blade built into the arm. Possesses monstrous strength."
	item = /obj/item/mod/module/mob_blade/armblade
	category = /datum/uplink_category/suits
	cost = 10
	surplus = 10
	purchasable_from = (UPLINK_ALL_SYNDIE_OPS)

/datum/uplink_item/suits/mod_stasis_module
	name = "MOD stasis module"
	desc = "MOD module installed in the user's hand, allowing them to create a \
			special environment in which objects slow down and cool significantly. \
			Refilled with cryostaline. This module comes pre-refilled."
	item = /obj/item/mod/module/stasis/prefueled/advanced
	category = /datum/uplink_category/suits
	cost = 4
	surplus = 10
	purchasable_from = (UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)
