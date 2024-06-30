/obj/item/mod/control/pre_equipped/blueshield
	worn_icon = 'modular_nova/modules/blueshield/icons/worn_praetorian.dmi'
	icon = 'modular_nova/modules/blueshield/icons/praetorian.dmi'
	icon_state = "praetorian-control"
	theme = /datum/mod_theme/blueshield
<<<<<<< HEAD
	applied_cell = /obj/item/stock_parts/cell/super
=======
	applied_cell = /obj/item/stock_parts/power_store/cell/high
>>>>>>> 5064ac695a4 ([MIRROR] Adds a new power storage type: The Megacell. Drastically reduces power cell consumption/storage. [MDB Ignore] [MDB IGNORE] (#3268))
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/projectile_dampener,
		/obj/item/mod/module/quick_carry,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
	)
