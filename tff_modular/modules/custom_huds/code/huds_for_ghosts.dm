GLOBAL_LIST_INIT(additional_observer_huds, list(
	TRAIT_XENO_HUD,
))
GLOBAL_LIST_INIT(additional_combo_huds, list(
	TRAIT_XENO_HUD,
))

/client/enable_combo_hud()
	if(combo_hud_enabled)
		return
	mob.add_traits(GLOB.additional_combo_huds, ADMIN_TRAIT)
	return ..()

/client/disable_combo_hud()
	if(!combo_hud_enabled)
		return
	mob.remove_traits(GLOB.additional_combo_huds, ADMIN_TRAIT)
	return ..()


// For additional code check `code\modules\mob\dead\observer\observer.dm` proc/show_data_huds() and proc/remove_data_huds() !!
