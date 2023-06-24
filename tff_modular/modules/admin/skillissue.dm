//Resolve ticket with IC Issue message
/datum/admin_help/proc/SKIssue(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return
	//SKYRAT Legacy begins
	if(handler && handler != usr.ckey)
		var/response = tgui_alert(usr, "This ticket is already being handled by [handler]. Do you want to continue?", "Ticket already assigned", list("Yes", "No"))
		if(!response || response == "No")
			return
	//SKYRAT Legacy ends
	var/msg = "<font color='red' size='4'><b>- AdminHelp marked as skill issue! -</b></font><br>"
	msg += "<font color='red'>Your issue has been determined by an administrator to be your skill issue and does NOT require administrator intervention at this time. For further resolution you should pursue options that help you git gud.</font>"

	if(initiator)
		to_chat(initiator, msg, confidential = TRUE)

	SSblackbox.record_feedback("tally", "ahelp_stats", 1, "SK")
	msg = "Ticket [TicketHref("#[id]")] marked as skill issue by [key_name]"
	message_admins(msg)
	log_admin_private(msg)
	AddInteraction("Marked as skill issue by [key_name]", player_message = "Marked as skill issue!")
	SSblackbox.LogAhelp(id, "Skill Issue", "Marked as skill issue by [usr.key]", null,  usr.ckey)
	Resolve(silent = TRUE)
