/client/CanProcCall(procname)
	if(usr.client.is_eventmaker())
		return FALSE
	. = ..()
