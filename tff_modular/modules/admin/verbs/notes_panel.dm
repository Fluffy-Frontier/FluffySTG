ADMIN_VERB(notes_panel, R_ADMIN, "Player Notes Panel", "Shows Player Notes.", ADMIN_CATEGORY_MAIN)
	browse_messages(target_ckey = user.ckey, agegate = FALSE)
	BLACKBOX_LOG_ADMIN_VERB("Player Notes Panel")
