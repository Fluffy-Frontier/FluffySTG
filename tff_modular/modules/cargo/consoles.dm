// Модульный оверрайд, чтобы отключить возможность взлома МУЛЬТИТУЛОМ для внешней консоли
/obj/item/circuitboard/computer/cargo/request/multitool_act(mob/living/user)
	return TRUE

/obj/machinery/computer/cargo/ui_close(mob/user)
	. = ..()
	var/name
	if(ishuman(user))
		var/mob/living/carbon/human/human = user
		name = human.get_authentification_name(hand_first = TRUE)
	else if(HAS_SILICON_ACCESS(user))
		name = user.real_name
	if(GLOB.cancelled_orders[name])
		var/obj/item/paper/requisition/cancelleds = new(get_turf(src))
		cancelleds.name = "cancelled orders - [station_time_timestamp()]"
		var/paper_text = "<h2>Cancelled Orders</h2>"
		paper_text += "<hr/>"
		paper_text += "As of: [station_time_timestamp()]<br/><br/>"
		for(var/datum/deleted_order/entry in GLOB.cancelled_orders[name])
			paper_text += "<b>[entry.name]</b></br>"
			paper_text += "- Order ID: [entry.id]</br>"
			paper_text += "- Ordered by: [entry.orderer] ([entry.orderer_rank])</br>"
			if(entry.paid_by)
				paper_text += "- Paid Privately by: [entry.paid_by]<br/>"
			paper_text += "- Cancelled by: [entry.canceller] ([entry.canceller_rank])</br>"
			if(entry.cancel_reason)
				paper_text += "- With a reason: [entry.cancel_reason]</br>"
			paper_text += "</br></br>"

		cancelleds.add_raw_text(paper_text)
		cancelleds.color = "#c9b43e"
		cancelleds.update_appearance()
		GLOB.cancelled_orders[name] = null

/obj/machinery/computer/cargo/proc/notify_buyer(mob/sender, target_name, message)
	for(var/messenger_ref in GLOB.pda_messengers)
		var/datum/computer_file/program/messenger/messenger = GLOB.pda_messengers[messenger_ref]
		if(messenger.computer.saved_identification == target_name)
			var/datum/signal/subspace/messaging/tablet_message/signal = new(src, list(
				"fakename" = "Order Notification",
				"fakejob" = "Cargo Server",
				"message" = message,
				"targets" = list(messenger),
				"automated" = TRUE,
			))
			signal.send_to_receivers()
			sender.log_message("(PDA: Cargo Server) sent \"[message]\" to [signal.format_target()]", LOG_PDA)
			break
