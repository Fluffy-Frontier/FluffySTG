GLOBAL_LIST_EMPTY(eventmaker_datums)
GLOBAL_PROTECT(eventmaker_datums)

GLOBAL_VAR_INIT(eventmaker_href_token, GenerateToken())
GLOBAL_PROTECT(eventmaker_href_token)

/datum/admins/eventmakers
	name = "someone's eventmaker datum"

/datum/admins/eventmakers/New(ckey) // добавление
	if(!ckey)
		QDEL_IN(src, 0)
		CRASH("eventmaker datum created without a ckey")
	target = ckey(ckey)
	name = "[ckey]'s eventmaker datum"
	href_token = GenerateToken()
	admin_signature = "Nanotrasen Officer #[rand(0,9)][rand(0,9)][rand(0,9)]"
	GLOB.eventmaker_datums[target] = src

/datum/admins/eventmakers/rank_flags()
	return R_ADMIN | R_BUILD | R_DEBUG | R_FUN | R_SOUND | R_SPAWN | R_POSSESS |R_VAREDIT

/datum/admins/eventmakers/proc/remove_eventmaker() // удаление
	if(owner)
		GLOB.eventmakers -= owner
		owner.eventmaker_datum = null
		owner.holder?.disassociate()
		owner = null
	log_admin_private("[target] was removed from the rank of eventmaker.")
	GLOB.eventmaker_datums -= target
	qdel(src)

/datum/admins/eventmakers/activate()
	if(IsAdminAdvancedProcCall())
		alert_to_permissions_elevation_attempt(usr)
		return
	GLOB.deadmins -= target
	GLOB.eventmaker_datums[target] = src
	deadmined = FALSE
	plane_debug = new(src)
	if (GLOB.directory[target])
		associate(GLOB.directory[target]) //find the client for a ckey if they are connected and associate them with us


/datum/admins/eventmakers/deactivate()
	if(IsAdminAdvancedProcCall())
		alert_to_permissions_elevation_attempt(usr)
		return
	GLOB.deadmins[target] = src
	GLOB.eventmaker_datums -= target
	QDEL_NULL(plane_debug)
	deadmined = TRUE

	var/client/client = owner || GLOB.directory[target]

	if (!isnull(client))
		disassociate()
		add_verb(client, /client/proc/reeventmake)
		client.disable_combo_hud()
		client.update_special_keybinds()

/datum/admins/eventmakers/associate(client/client)
	if(IsAdminAdvancedProcCall())
		alert_to_permissions_elevation_attempt(usr)
		return

	if(!istype(client))
		return

	if(client?.ckey != target)
		var/msg = " has attempted to associate with [target]'s eventmaker datum"
		message_admins("[key_name_admin(client)][msg]")
		log_admin("[key_name(client)][msg]")
		return

	if (deadmined)
		activate()

	owner = client
	owner.holder = src
	owner.add_admin_verbs()
	remove_verb(owner, /client/proc/reeventmake)
	add_verb(owner, /client/proc/deeventmake)
	owner.init_verbs() //re-initialize the verb list
	owner.update_special_keybinds()
	GLOB.eventmakers |= client

	try_give_profiling()

/datum/admins/eventmakers/disassociate()
	if(IsAdminAdvancedProcCall())
		alert_to_permissions_elevation_attempt(usr)
		return
	if(owner)
		GLOB.eventmakers -= owner
		remove_verb(owner, /client/proc/deeventmake)
		owner.remove_admin_verbs()
		owner.holder = null
		owner = null

/client
	/// Acts the same way holder does towards admin: it holds the eventmaker datum. if set, the guy's a eventmaker.
	var/datum/admins/eventmakers/eventmaker_datum
