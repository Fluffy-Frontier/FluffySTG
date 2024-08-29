/client/can_vv_get(var_name)
	if(usr?.client.is_eventmaker())
		return FALSE
	. = ..()

/datum/admins/can_vv_get(var_name)
	if(usr?.client.is_eventmaker())
		return FALSE
	. = ..()
