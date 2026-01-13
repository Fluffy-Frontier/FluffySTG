ADMIN_VERB(disable_shift_intensity, R_ADMIN, "Disable Intensity Vote", "Turn Off the Shift Intensity Vote.", ADMIN_CATEGORY_SERVER)
	SSshift_intensity.can_fire = 0;
	if(istype(SSvote.current_vote, /datum/vote/shift_intensity))
		SSvote.reset()
	log_admin("[key_name(user)] turned off Shift Intensity Vote.")
	message_admins("[key_name_admin(user)] turned off Shift Intensity Vote.")

ADMIN_VERB(toggle_hell_intensity, R_ADMIN, "Toggle Hell Intensity", "Toggle Hell option in Shift Intensity Vote.", ADMIN_CATEGORY_SERVER)
	SSshift_intensity.enable_hell_shift = !SSshift_intensity.enable_hell_shift
	log_admin("[key_name(user)] turned [SSshift_intensity.enable_hell_shift ? "On" : "Off"] Hell option in Shift Intensity Vote.")
	message_admins("[key_name_admin(user)] turned [SSshift_intensity.enable_hell_shift ? "On" : "Off"] Hell option in Shift Intensity Vote.")
