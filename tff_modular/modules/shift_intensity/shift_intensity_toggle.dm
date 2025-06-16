ADMIN_VERB(disable_shift_intensity, R_ADMIN, "Disable Intensity Vote", "Turn Off the Shift Intensity Vote.", ADMIN_CATEGORY_SERVER)
	SSshift_intensity.can_fire = 0;
	if(istype(SSvote.current_vote, /datum/vote/shift_intensity))
		SSvote.reset()
	log_admin("[key_name(user)] turned off Shift Intensity Vote.")
	message_admins("[key_name_admin(user)] turned off Shift Intensity Vote.")
