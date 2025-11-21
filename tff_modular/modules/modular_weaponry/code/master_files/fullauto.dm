/datum/component/automatic_fire/wake_up(datum/source, mob/user, slot)
	if(autofire_stat == AUTOFIRE_STAT_ALERT)
		return //We've updated the firemode. No need for more.
	if(autofire_stat == AUTOFIRE_STAT_FIRING)
		stop_autofiring() //Let's stop shooting to avoid issues.
		return
	var/obj/item/gun/weapon = parent
	if(user.is_holding(weapon) && weapon.gun_firemodes[weapon.firemode_index] == FIREMODE_FULLAUTO)
		autofire_on(user.client)
