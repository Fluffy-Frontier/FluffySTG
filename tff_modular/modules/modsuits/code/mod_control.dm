/obj/item/mod/control
	// Модификатор для потребления энергии любым модулем МОД костюма
	var/energy_effective = 1

/obj/item/mod/control/Initialize(mapload, datum/mod_theme/new_theme, new_skin, obj/item/mod/core/new_core)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_SPEED_POTION, INNATE_TRAIT)
	if(!new_theme)
		return
	if(new_theme.install_rig)
		install_rig()

/obj/item/mod/control/proc/install_rig()

/obj/item/mod/construction/plating/rnd
	icon = 'tff_modular/modules/modsuits/icons/items/mod_construction.dmi'
	theme = /datum/mod_theme/rnd

/obj/item/mod/control/rnd
	worn_icon = 'tff_modular/modules/modsuits/icons/worn_icons/mod_clothing.dmi'
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_clothing.dmi'
	icon_state = "rnd-control"
	theme = /datum/mod_theme/rnd

/obj/item/mod/control/pre_equipped/rnd
	worn_icon = 'tff_modular/modules/modsuits/icons/worn_icons/mod_clothing.dmi'
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_clothing.dmi'
	icon_state = "rnd-control"
	theme = /datum/mod_theme/rnd
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/tether,
	)
