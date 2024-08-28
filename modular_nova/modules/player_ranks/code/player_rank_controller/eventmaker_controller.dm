// The eventmaker system is a bit more complex than the other player ranks, so it's
// got its own handling and global lists declarations in the `eventmaker` module.

/datum/player_rank_controller/eventmaker
	rank_title = "eventmaker"


/datum/player_rank_controller/eventmaker/New()
	. = ..()
	legacy_file_path = "[global.config.directory]/nova/eventmakers.txt"


/datum/player_rank_controller/eventmaker/add_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	ckey = ckey(ckey)

	new /datum/admins/eventmakers(ckey)


/datum/player_rank_controller/eventmaker/remove_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	var/datum/admins/eventmakers/eventmaker_datum = GLOB.eventmaker_datums[ckey]
	eventmaker_datum?.remove_eventmaker()


/datum/player_rank_controller/eventmaker/get_ckeys_for_legacy_save()
	if(IsAdminAdvancedProcCall())
		return

	// This whole mess is just to only save the eventmakers that were in the config
	// already so that we don't add every admin to the config file, which would
	// be a pain to maintain afterwards.
	// We don't save eventmakers that are new to the `GLOB.eventmaker_datums` list,
	// because they should have already been saved from `add_player_legacy()`.
	var/list/eventmakers_to_save = list()
	var/list/existing_eventmaker_config = world.file2list(legacy_file_path)
	for(var/line in existing_eventmaker_config)
		if(!length(line))
			continue

		if(findtextEx(line, "#", 1, 2))
			continue

		var/existing_eventmaker = ckey(line)
		if(!existing_eventmaker)
			continue

		// Only save them if they're still in the eventmaker datums list in-game.
		if(!GLOB.eventmaker_datums[existing_eventmaker])
			continue

		// Associative list for extra SPEED!
		eventmakers_to_save[existing_eventmaker] = TRUE

	return eventmakers_to_save


/datum/player_rank_controller/eventmaker/should_use_legacy_system()
	return CONFIG_GET(flag/eventmaker_legacy_system)


/datum/player_rank_controller/eventmaker/clear_existing_rank_data()
	if(IsAdminAdvancedProcCall())
		return

	GLOB.eventmaker_datums.Cut()

	for(var/client/ex_eventmaker as anything in GLOB.eventmakers)
		ex_eventmaker.eventmaker_datum = null

	GLOB.eventmakers.Cut()
