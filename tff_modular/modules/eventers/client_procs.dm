/client/New()
	. = ..()
	eventmaker_datum_set()

/client/Destroy()
	if(GLOB.eventmakers[src])
		GLOB.eventmakers -= src

	return ..()

/client/proc/eventmaker_datum_set()
	eventmaker_datum = GLOB.eventmaker_datums[ckey]

	if(eventmaker_datum)
		eventmaker_datum.owner = src
		GLOB.eventmakers[src] = TRUE

/**
 * Returns whether or not the user is qualified as a eventmaker.
 */
/client/proc/is_eventmaker()
	return !isnull(GLOB.eventmaker_datums[ckey]) || !isnull(GLOB.deadmins[ckey])
