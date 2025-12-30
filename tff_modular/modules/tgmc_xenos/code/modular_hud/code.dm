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

/mob/dead/observer/show_data_huds()
	. = ..()
	add_traits(GLOB.additional_observer_huds, REF(src))

/mob/dead/observer/remove_data_huds()
	. = ..()
	remove_traits(GLOB.additional_observer_huds, REF(src))

