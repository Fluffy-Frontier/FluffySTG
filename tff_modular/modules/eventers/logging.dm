GLOBAL_LIST_EMPTY(eventmakerlog)
GLOBAL_PROTECT(eventmakerlog)

/proc/log_eventmaker(text, list/data)
	GLOB.eventmakerlog.Add(text)
	logger.Log(LOG_CATEGORY_GAME_EVENTMAKER, text, data)

/datum/admins/proc/eventmakerLogSecret()
	var/dat = "<B>EventMaker Log<HR></B>"
	for(var/l in GLOB.eventmakerlog)
		dat += "<li>[l]</li>"

	if(!GLOB.eventmakerlog.len)
		dat += "No eventmakers have done anything this round!"
	usr << browse(dat, "window=eventmaker_log")
