/client/can_vv_get(var_name)
	if(usr?.client.eventmaker_datum)
		return FALSE
	. = ..()

/datum/admins/can_vv_get(var_name)
	if(usr?.client.eventmaker_datum)
		return FALSE
	. = ..()
