/client/CanProcCall(procname)
	if(usr.client.is_eventmaker())
		return FALSE
	. = ..()

/client/can_vv_get(var_name)
	if(usr?.client.is_eventmaker())
		return FALSE
	. = ..()

/datum/admins/can_vv_get(var_name)
	if(usr?.client.is_eventmaker())
		return FALSE
	. = ..()
