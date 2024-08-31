ADMIN_VERB(cmd_eventmaker_say, R_NONE, "ESay", "Send a message to eventmakes", ADMIN_CATEGORY_MAIN, message as text)
	message = emoji_parse(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	if(!message)
		return

	user.mob.log_talk(message, LOG_ASAY)
	message = keywords_lookup(message)
	message = "[span_eventmaker("[span_prefix("EVENTCHAT:")] <EM>[key_name_admin(user)]</EM> [ADMIN_FLW(user.mob)]: <span class='message linkify'>[message]")]</span></font>"
	to_chat(GLOB.admins,
		type = MESSAGE_TYPE_ADMINCHAT,
		html = message,
		confidential = TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Esay")
