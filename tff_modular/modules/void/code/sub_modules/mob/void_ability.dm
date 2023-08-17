/datum/action/cooldown/void_ability
	//Должна ли эта кнопка быть ~Ч-и-Т-е-Р-с-К-о-Й~
	var/adminabuse = TRUE

	background_icon_state = "bg_demon"
	cooldown_time = 1 SECONDS

/datum/action/cooldown/void_ability/IsAvailable(feedback)
	if(adminabuse)
		return TRUE
	if(owner.stat & DEAD)
		return FALSE
	..()
