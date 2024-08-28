/client/CanProcCall(procname)
	to_chat(world, procname)
	if(usr.client.is_eventmaker())
		return FALSE
	. = ..()
