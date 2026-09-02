// PDA app for changing displays
// Allowing non asii text (yeah we posting it twice, I know)
/datum/computer_file/program/status/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(action == "setStatusMessage")
		upper_text = reject_bad_text(params["upperText"] || "", MAX_STATUS_LINE_LENGTH, FALSE)
		lower_text = reject_bad_text(params["lowerText"] || "", MAX_STATUS_LINE_LENGTH, FALSE)

		post_message(upper_text, lower_text)

// Communcations consoles also can change displays
// Allowing non asii text (yeah we posting it twice, I know)
/obj/machinery/computer/communications/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/ui_state)
	. = ..()

	var/mob/user = ui.user
	if(action == "setStatusMessage" && authenticated(user) && has_communication())
		var/line_one = reject_bad_text(params["upperText"] || "", MAX_STATUS_LINE_LENGTH, FALSE)
		var/line_two = reject_bad_text(params["lowerText"] || "", MAX_STATUS_LINE_LENGTH, FALSE)
		post_status("message", line_one, line_two)
		last_status_display = list(line_one, line_two)
