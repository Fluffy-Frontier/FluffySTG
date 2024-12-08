/**
 * Returns whether or not the user is qualified as a eventmaker.
 */
/client/proc/is_eventmaker()
	return holder?.ranks && holder.ranks[1].name == "Eventmaker"


/datum/controller/subsystem/admin_verbs/get_valid_verbs_for_admin(client/admin)
	if(isnull(admin.holder))
		CRASH("Why are we checking a non-admin for their valid... ahem... admin verbs?")

	var/list/has_permission = list()
	for(var/permission_flag in GLOB.bitflags)
		if(admin.holder.check_for_rights(permission_flag))
			has_permission["[permission_flag]"] = TRUE

	var/list/valid_verbs = list()
	for(var/datum/admin_verb/verb_type as anything in admin_verbs_by_type)
		var/datum/admin_verb/verb_singleton = admin_verbs_by_type[verb_type]
		if(!verify_visibility(admin, verb_singleton))
			continue

		if(admin.is_eventmaker() && GLOB.eventmakers_blacklist_verbs["[verb_singleton.name]"])
			continue

		var/verb_permissions = verb_singleton.permissions
		if(verb_permissions == R_NONE)
			valid_verbs |= list(verb_singleton)
		else for(var/permission_flag in bitfield_to_list(verb_permissions))
			if(!has_permission["[permission_flag]"])
				continue
			valid_verbs |= list(verb_singleton)

	return valid_verbs
