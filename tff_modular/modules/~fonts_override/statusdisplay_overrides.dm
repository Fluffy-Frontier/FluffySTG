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


//style = "img.icon { width: auto; height: auto } .center { text-align: center; } .maptext { font-family: 'Graph 35+ pix'; font-size: 6pt; -dm-text-outline: 1px black; color: white; line-height: 1.0; } .command_headset { font-weight: bold; } .context { font-family: 'Pixellari'; font-size: 12pt; -dm-text-outline: 1px black; }  .subcontext { font-family: 'TinyUnicode'; font-size: 12pt; line-height: 0.75; } .small { font-family: 'Graph 35+ pix'; font-size: 6pt; line-height: 1.4; } .big { font-family: 'Pixellari'; font-size: 12pt; } .reallybig { font-size: 12pt; } .extremelybig { font-size: 12pt; } .greentext { color: #00FF00; font-size: 6pt; } .redtext { color: #FF0000; font-size: 6pt; } .clown { color: #FF69BF; font-weight: bold; } .his_grace { color: #15D512; } .hypnophrase { color: #0d0d0d; font-weight: bold; } .yell { font-weight: bold; } .italics { font-family: 'Graph 35+ pix'; font-size: 6pt; line-height: 1.4; }"
