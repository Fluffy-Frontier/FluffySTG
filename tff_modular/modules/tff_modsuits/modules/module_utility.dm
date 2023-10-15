#define MODULE_RIG_DEFAULT_NAME "rig_module_"

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
	added_modifaer = max(0.5, mod.slowdown_active * 0.5)
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
	icon_state = "module_complexity_effective"
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
	module_type = MODULE_TOGGLE
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

/**
 * Модуль РИГ'а
 */

/obj/item/mod/module/rig_module
	name = "MOD RIG module"
	desc = "A module installed to users spine. That analyse information about user health."
	removable = FALSE
	complexity = 0
	idle_power_cost = 0
	module_type = MODULE_PASSIVE

	overlay_icon_file = 'tff_modular/master_files/icons/mob/clothing/modsuits/mod_modules.dmi'
	overlay_state_inactive = "rig_module_dead"

	var/true_rig_icon = 'tff_modular/master_files/icons/mob/clothing/modsuits/mod_modules.dmi'

/obj/item/mod/module/rig_module/on_suit_activation()
	. = ..()
	if(!mod.wearer)
		return
	if(istesharialt(mod.wearer))
		true_rig_icon = 'tff_modular/master_files/icons/mob/clothing/species/teshari/mod_modules.dmi'
	RegisterSignal(mod.wearer, COMSIG_LIVING_DEATH, PROC_REF(wearer_dead))

/obj/item/mod/module/rig_module/on_suit_deactivation(deleting)
	. = ..()
	true_rig_icon = initial(src.true_rig_icon)
	UnregisterSignal(mod.wearer, COMSIG_LIVING_DEATH)

/obj/item/mod/module/rig_module/generate_worn_overlay(mutable_appearance/standing)
	. = ..()
	if(!mod.active)
		return
	//Актуально обновляем внешний вид нашего РИГ'а
	var/mutable_appearance/rig_icon = mutable_appearance(true_rig_icon, calculate_health(), layer = standing.layer + 0.1)
	rig_icon.appearance_flags |= RESET_COLOR
	. += rig_icon

/obj/item/mod/module/rig_module/on_process(seconds_per_tick)
	. = ..()
	on_use() //Для того, чтобы вызвать обновление аппаренса модуля, необходимо вызвать любой прок в нем - это наиболее простой и эффективный способ.

/obj/item/mod/module/rig_module/proc/wearer_dead()
	SIGNAL_HANDLER
	playsound(get_turf(mod.wearer), 'tff_modular/master_files/sounds/rig_module_dead.ogg', 40)

/obj/item/mod/module/rig_module/proc/calculate_health()
	if(!mod.wearer)
		return
	if(mod.wearer.stat & DEAD)
		return MODULE_RIG_DEFAULT_NAME + "dead"

	var/target_state = MODULE_RIG_DEFAULT_NAME
	switch(mod.wearer?.health || 0)
		if(80 to INFINITY)
			target_state += "normal"
		if(40 to 79)
			target_state += "damaged"
		if(-200 to 39)
			target_state += "critical"

	return target_state

/datum/mod_theme
	inbuilt_modules = list(/obj/item/mod/module/rig_module)
/datum/mod_theme/advanced
	inbuilt_modules = list(/obj/item/mod/module/rig_module, /obj/item/mod/module/magboot/advanced)
/datum/mod_theme/rescue
	inbuilt_modules = list(/obj/item/mod/module/rig_module, /obj/item/mod/module/quick_carry/advanced)

#undef MODULE_RIG_DEFAULT_NAME
