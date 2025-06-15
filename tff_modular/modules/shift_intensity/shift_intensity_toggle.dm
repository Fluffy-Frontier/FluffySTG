ADMIN_VERB(toggle_shift_intensity, R_ADMIN, "Toggle Shift Inensity Vote", "Toggle the Shift Inensity Vote.", ADMIN_CATEGORY_SERVER)
	SSshift_intensity.can_fire = 0;
	if(istype(SSvote.current_vote, /datum/vote/shift_intensity))
		SSvote.reset()
	log_admin("[key_name(user)] toggled Shift Inensity Vote.")
	message_admins("[key_name_admin(user)] toggled Shift Inensity Vote.")
