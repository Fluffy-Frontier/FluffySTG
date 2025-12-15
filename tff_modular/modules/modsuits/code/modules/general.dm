/**
 * Модуль спринтера: позволяет получить значительно повышенную скорость, ценой огромного энергопотребления.
 */

/obj/item/mod/module/sprinter
	name = "MOD sprinter module"
	desc = "MOD module installed in wearer legs. Allow to adjust movemenet speed causing hight power use."
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	overlay_icon_file = 'tff_modular/modules/modsuits/icons/worn_icons/mod_modules.dmi'
	module_type = MODULE_TOGGLE
	icon_state = "module_sprinter"
	overlay_state_active = "sprinter_module"
	overlay_state_inactive = "sprinter_module"
	complexity = 2

	required_slots = list(ITEM_SLOT_FEET)
	incompatible_modules = list(
		/obj/item/mod/module/sprinter,
		/obj/item/mod/module/movemenet_effective,
		/obj/item/mod/module/energy_effective,
	)

	// Дополнительная скорость, которую получает пользователь при активации модуля
	var/added_speed = 1
	// Цена каждого шага, что делает пользователь при движении
	var/power_use_per_step = POWER_CELL_USE_HIGH * 1.2
	// Трейты что получает пользователь при включнии модуля
	var/sprinter_traits = list(TRAIT_PASSTABLE, TRAIT_FREERUNNING, TRAIT_IGNORESLOWDOWN)

	COOLDOWN_DECLARE(emp_damage_cooldown)

/obj/item/mod/module/sprinter/on_select(mob/activator)
	if(!COOLDOWN_FINISHED(src, emp_damage_cooldown))
		balloon_alert(mod.wearer, "Module reloading!")
		return
	. = ..()

/obj/item/mod/module/sprinter/activate(mob/activator)
	. = ..()
	balloon_alert(mod.wearer, "Actutor overstressed!")
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(on_wearer_move))
	mod.slowdown -= added_speed
	mod.wearer.add_traits(sprinter_traits, REF(src))
	mod.wearer.update_movespeed()

/obj/item/mod/module/sprinter/deactivate(mob/activator, display_message, deleting)
	. = ..()
	balloon_alert(mod.wearer, "Actutor stabilized!")
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)
	mod.slowdown += added_speed
	mod.wearer.remove_traits(sprinter_traits, REF(src))
	mod.wearer.update_movespeed()

/obj/item/mod/module/sprinter/emp_act(severity)
	. = ..()
	if(active)
		deactivate()
	COOLDOWN_START(src, emp_damage_cooldown, rand(5, 20) SECONDS)

/obj/item/mod/module/sprinter/proc/on_wearer_move()
	SIGNAL_HANDLER
	drain_power(power_use_per_step)

/**
 * Модуль энергоэффективности. Ниже скорость - меньше энергопотребление
 */

/obj/item/mod/module/energy_effective
	name = "MOD energy effective module"
	desc = "A MOD module installed in MOD control, make them more power effective, but general movement slower."
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "module_power_effective"
	complexity = 2
	idle_power_cost = 0
	incompatible_modules = list(/obj/item/mod/module/energy_effective)

	// Оригинальный модификатор
	var/original_slowdown
	var/original_energy_effective
	var/original_drain
	// Модификатор энергопотребления
	var/charge_drain_multiply = 0.5
	// Модификатор замедления от костюма
	var/slowdown_multiply = 1.5
	// Модификатор для общего снижения энергопотребления
	var/energy_effective_multiply = 0.6



/obj/item/mod/module/energy_effective/on_part_activation()
	. = ..()
	original_drain = mod.charge_drain
	original_slowdown = mod.energy_effective
	mod.charge_drain = mod.charge_drain * charge_drain_multiply
	original_slowdown = mod.slowdown
	mod.slowdown_deployed = (mod.slowdown ? mod.slowdown : 0.5) *  slowdown_multiply
	mod.wearer.update_movespeed()
	mod.energy_effective = energy_effective_multiply

/obj/item/mod/module/energy_effective/on_part_deactivation(deleting)
	. = ..()
	mod.charge_drain = original_drain
	mod.slowdown_deployed = original_slowdown
	mod.energy_effective = original_energy_effective
	mod.wearer.update_movespeed()

/**
 * Модуль эффективности скорости. Выше скорость ценной более высокого энергопотребления
 */


/obj/item/mod/module/movemenet_effective
	name = "MOD movement effective module"
	desc = "MOD module installed in MOD control, adjust movement speed by causing faster power drain."
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "module_movement_effective"
	complexity = 2
	idle_power_cost = 0
	incompatible_modules = list(
		/obj/item/mod/module/movemenet_effective,
		/obj/item/mod/module/energy_effective
	)
	var/original_drain
	// Модификатор энергопотребления
	var/charge_drain_multiply = 2
	// Модификатор замедления от костюма
	var/slowdown_multiply = 0.5
	// Оригинальный модификатор
	var/original_slowdown



/obj/item/mod/module/movemenet_effective/on_part_activation()
	. = ..()
	original_drain = mod.charge_drain
	original_slowdown = mod.slowdown_deployed
	mod.charge_drain = mod.charge_drain * charge_drain_multiply
	mod.slowdown_deployed = (mod.slowdown ? mod.slowdown : 0) - slowdown_multiply
	mod.wearer.update_movespeed()

/obj/item/mod/module/movemenet_effective/on_part_deactivation(deleting)
	. = ..()
	mod.charge_drain = original_drain
	mod.slowdown_deployed = original_slowdown
	mod.wearer.update_movespeed()


/**
 * Модуль расширения вместительности модулей. Увеличивает максимальное /complexity у МОД костюма, ценой невозможности установки хранилищ
 */


/obj/item/mod/module/complexity_effective
	name = "MOD complexity effective module"
	desc = "A MOD module installed in MOD control, make them more power effective, but general movement slower"
	icon = 'tff_modular/modules/modsuits/icons/mod_icons/mod_modules.dmi'
	icon_state = "module_movement_effective"
	complexity = 2
	idle_power_cost = 0
	incompatible_modules = list(
		/obj/item/mod/module/complexity_effective,
		/obj/item/mod/module/infiltrator,
		/obj/item/mod/module/storage,
	)
	var/addictional_complexity = 10


/obj/item/mod/module/complexity_effective/on_install()
	. = ..()
	mod.complexity_max += 10

/obj/item/mod/module/complexity_effective/on_uninstall(deleting)
	. = ..()
	mod.complexity_max -= 10
	if(mod.complexity <= mod.complexity_max || deleting)
		return
	if(usr)
		balloon_alert(usr, "Over max complexity!")
	while(mod.complexity > mod.complexity_max)
		var/obj/item/mod/module/module = pick(mod.modules)
		mod.uninstall(module)
		module.forceMove(get_turf(mod))


