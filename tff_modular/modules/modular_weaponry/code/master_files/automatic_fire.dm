/datum/component/automatic_fire/Initialize(autofire_shot_delay, windup_autofire, windup_autofire_reduction_multiplier, windup_autofire_cap, windup_spindown, allow_akimbo, firing_sound_loop)
	. = ..()
	RegisterSignal(parent, COMSIG_GUN_DISABLE_AUTOFIRE, PROC_REF(disable_autofire))
	RegisterSignal(parent, COMSIG_GUN_ENABLE_AUTOFIRE, PROC_REF(enable_autofire))
	RegisterSignal(parent, COMSIG_GUN_SET_AUTOFIRE_SPEED, PROC_REF(set_autofire_speed))

/datum/component/automatic_fire/autofire_off()
	UnregisterSignal(parent, list(COMSIG_GUN_DISABLE_AUTOFIRE, COMSIG_GUN_ENABLE_AUTOFIRE, COMSIG_GUN_SET_AUTOFIRE_SPEED))
	return ..()

/datum/component/automatic_fire/on_mouse_down(client/source, atom/_target, turf/location, control, params)
	if(!enabled)
		return
	return ..()

/obj/item/gun/on_autofire_start(mob/living/shooter)
	if(fire_cd || shooter.incapacitated || !can_trigger_gun(shooter))
		return FALSE
	if(!can_shoot())
		shoot_with_empty_chamber(shooter)
		return FALSE
	return TRUE
