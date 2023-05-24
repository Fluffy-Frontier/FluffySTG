//Just a SQL check if valid in row is true. Dont give a user to use null token later.
/datum/controller/subsystem/discord/proc/is_ckey_verified(ckey)
	var/datum/db_query/query_insert_link_record = SSdbcore.NewQuery(
		"SELECT * FROM [format_table_name("discord_links")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	if(!query_insert_link_record.Execute())
		qdel(query_insert_link_record)
		return

	if(query_insert_link_record.NextRow())
		var/result = query_insert_link_record.item
		qdel(query_insert_link_record)
		if(!result[6]) return FALSE
		return TRUE

//Override of verb, to include is_ckey_verified, and change logic of getting token. I removed check of prefix, 'cause it's dont need to us.
/client/verify_in_discord()
	set category = "OOC"
	set name = "Verify Discord Account"
	set desc = "Verify your discord account with your BYOND account"

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(src, span_warning("This feature requires the SQL backend to be running."))
		return

	var/message = ""

	if(SSdiscord.is_ckey_verified(ckey))
		message = "You are already verified. To replace a linked Discord account, contact the administrators."
	else
		var/cached_one_time_token = SSdiscord.reverify_cache[usr.ckey]
		if(cached_one_time_token && cached_one_time_token != "")
			message = "To verify, you must link your BYOND account on our Discord server. Join the following link <b>[CONFIG_GET(string/discord_link)]</b>, then go to #verification channel, and insert the following token in the pop-up window:<br><br>[cached_one_time_token]"
		else
			var/one_time_token = SSdiscord.get_or_generate_one_time_token_for_ckey(ckey)
			SSdiscord.reverify_cache[usr.ckey] = one_time_token
			message = "To verify, you must link your BYOND account on our Discord server. Join the following link <b>[CONFIG_GET(string/discord_link)]</b>, then go to #verification channel, and insert the following token in the pop-up window:<br><br>\n[one_time_token]"


	//Now give them a browse window so they can't miss whatever we told them
	var/datum/browser/window = new/datum/browser(usr, "discordverification", "Discord verification")
	window.set_content("<span>[message]</span>")
	window.open()

//Override of proc, to remove timebound = TRUE, we dont need to create new tokens. 1 user = 1 token, if authed, token go free.
/datum/controller/subsystem/discord/get_or_generate_one_time_token_for_ckey(ckey)
	// Is there an existing valid one time token
	var/datum/discord_link_record/link = find_discord_link_by_ckey(ckey, timebound = FALSE)//that was changed
	if(link)
		return link.one_time_token

	// Otherwise we make one
	return SSdiscord.generate_one_time_token(ckey)
