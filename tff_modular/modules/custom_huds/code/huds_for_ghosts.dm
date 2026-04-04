// Включает и выключает дополнительые худы у гостов и комбохуда
// Сами дополнительные худы указываются в 'code\__DEFINES\~ff_defines\_globalvars\lists\huds.dm'

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
