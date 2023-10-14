/**
 * Модуль эффективной траты энергии : уменьшает потребление энергии вдвое, замедляет также.
 */

/obj/item/mod/module/energy_effective
	name = "MOD gnergy effective module"
	desc = "A MOD module installed in MOD control, make them more power effective, but general movement slower"
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_power_effective"
	complexity = 2
	idle_power_cost = 0
	incompatible_modules = list(
		/obj/item/mod/module/energy_effective,
		/obj/item/mod/module/movemenet_effective,
	)
	var/added_modifaer

/obj/item/mod/module/energy_effective/on_suit_activation()
	. = ..()
	mod.charge_drain = (mod.charge_drain * 0.5)
	added_modifaer = mod.slowdown_active * 2
	mod.slowdown += added_modifaer
	mod.wearer.update_equipment_speed_mods()


/obj/item/mod/module/energy_effective/on_suit_deactivation(deleting)
	. = ..()
	mod.charge_drain = initial(mod.charge_drain)
	mod.slowdown -= added_modifaer
	mod.wearer.update_equipment_speed_mods()

/**
 * Модуль эффективности движения: вдвое срезает замедление при движении, но вдводе увеличивает трату энергии.
 */

/obj/item/mod/module/movemenet_effective
	name = "MOD movement effective module"
	desc = "MOD module installed in MOD control, adjust movement speed by causing faster power drain."
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_movement_effective"
	complexity = 3
	idle_power_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(
		/obj/item/mod/module/movemenet_effective,
		/obj/item/mod/module/energy_effective,
	)
	var/added_modifaer

/obj/item/mod/module/movemenet_effective/on_suit_activation()
	. = ..()
	added_modifaer = min(0.5, mod.slowdown_active * 0.5)
	mod.slowdown -= added_modifaer
	mod.wearer.update_equipment_speed_mods()

/obj/item/mod/module/movemenet_effective/on_suit_deactivation(deleting)
	. = ..()
	mod.slowdown += added_modifaer
	mod.wearer.update_equipment_speed_mods()

/**
 * Модуль эффективности вмещения: увеличивает максимальное кол-во модулей, что можно установить, ценой отсуствия любого модуля хранения.
 */

/obj/item/mod/module/complexity_effective
	name = "MOD complexity effective module"
	desc = "MOD module installed in MOD control, adjust number of maximum installed modules, bu causing impossible install storage modules."
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "complexity_effective"
	complexity = 0
	incompatible_modules = list(
		/obj/item/mod/module/plate_compression,
		/obj/item/mod/module/storage,
		/obj/item/mod/module/complexity_effective,
	)

/obj/item/mod/module/complexity_effective/on_install()
	. = ..()
	mod.complexity += 10

/obj/item/mod/module/complexity_effective/on_uninstall(deleting)
	. = ..()
	mod.complexity = initial(mod.complexity)

/**
 * Модуль спринтера: позволяет получить значительно повышенную скорость, ценой огромного энергопотребления.
 */

/obj/item/mod/module/sprinter
	name = "MOD sprinter module"
	desc = "MOD module installed in wearer legs. Allow to adjust movemenet speed causing hight power use."
	icon = 'tff_modular/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	overlay_icon_file = 'tff_modular/master_files/icons/mob/clothing/modsuits/mod_modules.dmi'
	module_type = MODULE_ACTIVE
	icon_state = "module_sprinter"
	overlay_state_active = "sprinter_module"
	overlay_state_inactive = "sprinter_module"
	complexity = 2
	incompatible_modules = list(
		/obj/item/mod/module/sprinter,
		/obj/item/mod/module/movemenet_effective,
	)
	var/added_speed = 1
	var/power_use_per_step = 50

/obj/item/mod/module/sprinter/on_activation()
	. = ..()
	mod.wearer.balloon_alert(mod.wearer, "Actutor overstressed!")
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(on_wearer_move))
	mod.slowdown -= added_speed
	mod.wearer.update_equipment_speed_mods()

/obj/item/mod/module/sprinter/on_deactivation(display_message, deleting)
	. = ..()
	mod.wearer.balloon_alert(mod.wearer, "Actutor stabilized!")
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)
	mod.slowdown += added_speed
	mod.wearer.update_equipment_speed_mods()

/obj/item/mod/module/sprinter/proc/on_wearer_move()
	SIGNAL_HANDLER
	mod.subtract_charge(power_use_per_step)

