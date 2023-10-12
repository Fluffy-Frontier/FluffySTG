#define MODULE_RIG_DEFAULT_NAME "rig_module_"


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

#undef MODULE_RIG_DEFAULT_NAME
