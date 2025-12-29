/**
 * Returns whether or not the user is qualified as a eventmaker.
 */
/client/proc/is_eventmaker()
	return holder?.ranks && holder.ranks[1].name == "Eventmaker"

/datum/controller/subsystem/admin_verbs/verify_visibility(client/admin, datum/admin_verb/verb_singleton)
	. = ..()
	if(. && admin.is_eventmaker() && (verb_singleton.name in GLOB.eventmakers_blacklist_verbs))
		return FALSE
