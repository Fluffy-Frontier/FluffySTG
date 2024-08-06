/datum/computer_file/program/budgetorders/master
	filename = "ordermasterapp"
	filedesc = "Supply Interface"
	program_open_overlay = "supply"
	var/list/loaded_coupons
	/// var that tracks message cooldown
	var/message_cooldown
	var/can_send = TRUE
	var/is_express = FALSE
	requestonly = FALSE
	can_approve_requests = TRUE
	program_flags = PROGRAM_REQUIRES_NTNET
	can_run_on_flags = PROGRAM_CONSOLE

/datum/computer_file/program/budgetorders/master/request
	filename = "orderslaveapp"
	filedesc = "Supply Request Interface"
	program_open_overlay = "request"
	can_send = FALSE
	requestonly = TRUE
	can_approve_requests = FALSE

/datum/computer_file/program/budgetorders/master/ui_data(mob/user)
	var/list/data = list()
	data["department"] = "Cargo" // Hardcoded here, for customization in budgetordering.dm AKA NT IRN
	data["location"] = SSshuttle.supply.getStatusText()
	var/datum/bank_account/D = SSeconomy.get_dep_account(cargo_account)
	if(D)
		data["points"] = D.account_balance
	data["grocery"] = SSshuttle.chef_groceries.len
	data["away"] = SSshuttle.supply.getDockedId() == docking_away
	data["self_paid"] = self_paid
	data["docked"] = SSshuttle.supply.mode == SHUTTLE_IDLE
	data["loan"] = !!SSshuttle.shuttle_loan
	data["loan_dispatched"] = SSshuttle.shuttle_loan && SSshuttle.shuttle_loan.dispatched
	data["can_send"] = can_send
	data["can_approve_requests"] = can_approve_requests
	var/message = "Remember to stamp and send back the supply manifests."
	if(SSshuttle.centcom_message)
		message = SSshuttle.centcom_message
	if(SSshuttle.supply_blocked)
		message = blockade_warning
	data["message"] = message

	var/list/amount_by_name = list()
	var/cart_list = list()
	for(var/datum/supply_order/order in SSshuttle.shopping_list)
		if(cart_list[order.pack.name])
			amount_by_name[order.pack.name] += 1
			cart_list[order.pack.name][1]["amount"]++
			cart_list[order.pack.name][1]["cost"] += order.get_final_cost()
			if(order.department_destination)
				cart_list[order.pack.name][1]["dep_order"]++
			if(!isnull(order.paying_account))
				cart_list[order.pack.name][1]["paid"]++
			continue

		amount_by_name[order.pack.name] += 1
		cart_list[order.pack.name] = list(list(
			"cost_type" = order.cost_type,
			"object" = order.pack.name,
			"cost" = order.get_final_cost(),
			"id" = order.id,
			"amount" = 1,
			"orderer" = order.orderer,
			"paid" = !isnull(order.paying_account) ? 1 : 0, //number of orders purchased privatly
			"dep_order" = order.department_destination ? 1 : 0, //number of orders purchased by a department
			"can_be_cancelled" = order.can_be_cancelled,
		))
	data["cart"] = list()
	for(var/item_id in cart_list)
		data["cart"] += cart_list[item_id]

	data["supplies"] = list()
	for(var/pack in SSshuttle.supply_packs)
		var/datum/supply_pack/P = SSshuttle.supply_packs[pack]
		var/obj/item/card/id/card = computer?.computer_id_slot?.GetID()
		if(!card)
			if (ishuman(user))
				var/mob/living/carbon/human/H = user
				card = H.get_idcard()
		if(!is_visible_pack(user, P.access_view , card ? card.GetAccess() : null, FALSE) || (P.hidden && !(computer.obj_flags & EMAGGED)))
			continue
		if(!data["supplies"][P.group])
			data["supplies"][P.group] = list(
				"name" = P.group,
				"packs" = list()
			)
		if(((P.hidden && !(computer.obj_flags & EMAGGED)) && (P.contraband && !contraband) || (P.special && !P.special_enabled) || P.drop_pod_only))
			continue
		data["supplies"][P.group]["packs"] += list(list(
			"name" = P.name,
			"cost" = P.get_cost(),
			"id" = pack,
			"desc" = P.desc || P.name, // If there is a description, use it. Otherwise use the pack's name.
			"goody" = P.goody,
			"access" = P.access
		))
	data["requests"] = list()
	for(var/datum/supply_order/order in SSshuttle.request_list)
		var/datum/supply_pack/pack = order.pack
		amount_by_name[pack.name] += 1
		data["requests"] += list(list(
			"object" = pack.name,
			"cost" = pack.get_cost(),
			"orderer" = order.orderer,
			"reason" = order.reason,
			"id" = order.id,
		))
	data["amount_by_name"] = amount_by_name

	return data

/datum/computer_file/program/budgetorders/master/proc/base_ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	SEND_SIGNAL(src, COMSIG_UI_ACT, usr, action, params)
	// If UI is not interactive or usr calling Topic is not the UI user, bail.
	if(!ui || ui.status != UI_INTERACTIVE)
		return TRUE


/datum/computer_file/program/budgetorders/master/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	SHOULD_CALL_PARENT(0)
	. = base_ui_act()

	switch(action)
		if("send")
			if(!SSshuttle.supply.canMove())
				computer.say(safety_warning)
				return
			if(SSshuttle.supply_blocked)
				computer.say(blockade_warning)
				return
			if(SSshuttle.supply.getDockedId() == docking_home)
				SSshuttle.moveShuttle(cargo_shuttle, docking_away, TRUE)
				computer.say("The supply shuttle is departing.")
				usr.investigate_log("sent the supply shuttle away.", INVESTIGATE_CARGO)
			else
				usr.investigate_log("called the supply shuttle.", INVESTIGATE_CARGO)
				computer.say("The supply shuttle has been called and will arrive in [SSshuttle.supply.timeLeft(600)] minutes.")
				SSshuttle.moveShuttle(cargo_shuttle, docking_home, TRUE)
			. = TRUE
		if("loan")
			if(!SSshuttle.shuttle_loan)
				return
			if(SSshuttle.supply_blocked)
				computer.say(blockade_warning)
				return
			else if(SSshuttle.supply.mode != SHUTTLE_IDLE)
				return
			else if(SSshuttle.supply.getDockedId() != docking_away)
				return
			else if(stationcargo != TRUE)
				return
			else
				SSshuttle.shuttle_loan.loan_shuttle()
				computer.say("The supply shuttle has been loaned to CentCom.")
				usr.investigate_log("accepted a shuttle loan event.", INVESTIGATE_CARGO)
				usr.log_message("accepted a shuttle loan event.", LOG_GAME)
				. = TRUE

		if("add")
			return add_item(ui.user, params["id"])
		if("add_by_name")
			var/supply_pack_id = name_to_id(params["order_name"])
			if(!supply_pack_id)
				return
			return add_item(ui.user, supply_pack_id)
		if("remove")
			var/order_name = params["order_name"]
			//try removing atleast one item with the specified name. An order may not be removed if it was from the department
			for(var/datum/supply_order/order in SSshuttle.shopping_list)
				if(order.pack.name != order_name)
					continue
				if(remove_item(order.id))
					return TRUE
		if("modify")
			var/order_name = params["order_name"]

			//clear out all orders with the above mentioned order_name name to make space for the new amount
			for(var/datum/supply_order/order in SSshuttle.shopping_list) //find corresponding order id for the order name
				if(order.pack.name == order_name)
					remove_item(order.id)

			//now add the new amount stuff
			var/amount = text2num(params["amount"])
			if(amount == 0)
				return TRUE
			if(amount > CARGO_MAX_ORDER)
				return
			var/supply_pack_id = name_to_id(order_name) //map order name to supply pack id for adding
			if(!supply_pack_id)
				return
			return add_item(ui.user, supply_pack_id, amount)
		if("clear")
			for(var/datum/supply_order/cancelled_order in SSshuttle.shopping_list)
				if(cancelled_order.department_destination || !cancelled_order.can_be_cancelled)
					continue //don't cancel other department's orders or orders that can't be cancelled
				SSshuttle.shopping_list -= cancelled_order
			. = TRUE
		if("approve")
			var/id = text2num(params["id"])
			for(var/datum/supply_order/SO in SSshuttle.request_list)
				if(SO.id == id)
					SO.paying_account = null
					SSshuttle.request_list -= SO
					SSshuttle.shopping_list += SO
					. = TRUE
					break
		if("deny")
			var/id = text2num(params["id"])
			for(var/datum/supply_order/SO in SSshuttle.request_list)
				if(SO.id == id)
					SSshuttle.request_list -= SO
					. = TRUE
					break
		if("denyall")
			SSshuttle.request_list.Cut()
			. = TRUE
		if("toggleprivate")
			self_paid = !self_paid
			. = TRUE
		//NOVA EDIT START
		if("company_import_window")
			var/datum/component/armament/company_imports/tweaked/gun_comp = computer.physical.GetComponent(/datum/component/armament/company_imports/tweaked)
			if(!gun_comp)
				computer.physical.AddComponent(/datum/component/armament/company_imports/tweaked, subtypesof(/datum/armament_entry/company_import), 0)
			gun_comp = computer.physical.GetComponent(/datum/component/armament/company_imports/tweaked)
			gun_comp.parent_prog ||= src
			gun_comp.ui_interact(usr)
			. = TRUE
		//NOVA EDIT END
	if(.)
		post_signal(cargo_shuttle)

/datum/computer_file/program/budgetorders/master/application_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (istype(tool, /obj/item/trade_chip))
		var/obj/item/trade_chip/contract = tool
		contract.try_to_unlock_contract(user)
		return ITEM_INTERACT_SUCCESS
	else if (istype(tool, /obj/item/coupon))
		var/obj/item/coupon/c = tool
		if(c.discount_pct_off == COUPON_OMEN)
			to_chat(user, span_warning("\The [computer] validates the coupon as authentic, but refuses to accept it..."))
			computer.say("Coupon fulfillment already in progress...")
			return ITEM_INTERACT_SUCCESS

		c.inserted_console = src // Well coupon deletion may suck
		LAZYADD(loaded_coupons, c)
		computer.say("Coupon for [initial(c.discounted_pack.name)] applied!")
		c.forceMove(computer)
		return ITEM_INTERACT_SUCCESS
	else if (istype(tool, /obj/item/paper/paperslip/ration_ticket))
		var/obj/item/paper/paperslip/ration_ticket/ticket = tool
		ticket.try_to_make_ration_order_list(computer.physical, user)
		return ITEM_INTERACT_SUCCESS
	else
		return ..()

/datum/computer_file/program/budgetorders/master/Destroy()
	if (computer)
		var/datum/component/armament/company_imports/tweaked/gun_comp = computer.physical.GetComponent(/datum/component/armament/company_imports/tweaked)
		if(gun_comp)
			RemoveComponentSource(REF(computer.physical), /datum/component/armament/company_imports/tweaked)

	// Eject unused coupons
	for(var/obj/item/coupon/c in loaded_coupons)
		c.forceMove(c.drop_location(computer ? computer.physical : disk_host))
		LAZYREMOVE(loaded_coupons, c)
		c.inserted_console = null

	. = ..()

/**
 * adds an supply pack to the checkout cart
 * * user - the mobe doing this order
 * * id - the type of pack to order
 * * amount - the amount to order. You may not order more then 10 things at once
 */
/datum/computer_file/program/budgetorders/master/proc/add_item(mob/user, id, amount = 1)
	if(is_express)
		return
	id = text2path(id) || id
	var/datum/supply_pack/pack = SSshuttle.supply_packs[id]
	if(!istype(pack))
		CRASH("Unknown supply pack id given by order console ui. ID: [id]")
	if(amount > CARGO_MAX_ORDER || amount < 1) // Holy shit fuck off
		CRASH("Invalid amount passed into add_item")
	if((pack.hidden && !(computer.obj_flags & EMAGGED)) || (pack.contraband && !contraband) || pack.drop_pod_only || (pack.special && !pack.special_enabled))
		return

	var/name = "*None Provided*"
	var/rank = "*None Provided*"
	var/ckey = user.ckey
	if(ishuman(user))
		var/mob/living/carbon/human/human = user
		name = human.get_authentification_name()
		rank = human.get_assignment(hand_first = TRUE)
	else if(HAS_SILICON_ACCESS(user))
		name = user.real_name
		rank = "Silicon"

	var/datum/bank_account/account
	if(self_paid && isliving(user))
		var/mob/living/living_user = user
		var/obj/item/card/id/id_card = living_user.get_idcard(TRUE)
		if(!istype(id_card))
			computer.say("No ID card detected.")
			return
		if(IS_DEPARTMENTAL_CARD(id_card))
			computer.say("The [src] rejects [id_card].")
			return
		account = id_card.registered_account
		if(!istype(account))
			computer.say("Invalid bank account.")
			return
		var/list/access = id_card.GetAccess()
		if(pack.access_view && !(pack.access_view in access))
			computer.say("[id_card] lacks the requisite access for this purchase.")
			return

	// The list we are operating on right now
	var/list/working_list = SSshuttle.shopping_list
	var/reason = ""
	if(requestonly && !self_paid)
		working_list = SSshuttle.request_list
		reason = tgui_input_text(user, "Reason", name)
		if(isnull(reason))
			return

	if(pack.goody && !self_paid)
		playsound(computer, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
		computer.say("ERROR: Small crates may only be purchased by private accounts.")
		return

	var/similar_count = SSshuttle.supply.get_order_count(pack)
	if(similar_count == OVER_ORDER_LIMIT)
		playsound(computer, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
		computer.say("ERROR: No more then [CARGO_MAX_ORDER] of any pack may be ordered at once")
		return

	amount = clamp(amount, 1, CARGO_MAX_ORDER - similar_count)
	for(var/count in 1 to amount)
		var/obj/item/coupon/applied_coupon
		for(var/obj/item/coupon/coupon_check in loaded_coupons)
			if(pack.type == coupon_check.discounted_pack)
				computer.say("Coupon found! [round(coupon_check.discount_pct_off * 100)]% off applied!")
				coupon_check.moveToNullspace()
				applied_coupon = coupon_check
				break

		var/datum/supply_order/order = new(
			pack = pack ,
			orderer = name,
			orderer_rank = rank,
			orderer_ckey = ckey,
			reason = reason,
			paying_account = account,
			coupon = applied_coupon,
			charge_on_purchase = TRUE, // NOVA EDIT ADDITION
		)
		if (requestonly || self_paid)
			order.generateRequisition(get_turf(computer))
		working_list += order

	if(self_paid)
		computer.say("Order processed. The price will be charged to [account.account_holder]'s bank account on delivery.")
	if(requestonly && message_cooldown < world.time)
		var/message = amount == 1 ? "A new order has been requested." : "[amount] order has been requested."
		// radio used by the console to send messages on supply channel
		var/obj/item/radio/headset/radio = new /obj/item/radio/headset/headset_cargo(computer)
		radio.talk_into(computer, message, RADIO_CHANNEL_SUPPLY)
		QDEL_NULL(radio)
		message_cooldown = world.time + 30 SECONDS
	. = TRUE

/**
 * removes an item from the checkout cart
 * * id - the id of the cart item to remove
 */
/datum/computer_file/program/budgetorders/master/proc/remove_item(id)
	for(var/datum/supply_order/order in SSshuttle.shopping_list)
		if(order.id != id)
			continue
		if(order.department_destination)
			computer.say("Only the department that ordered this item may cancel it.")
			return FALSE
		if(order.applied_coupon)
			computer.say("Coupon refunded.")
			order.applied_coupon.forceMove(get_turf(computer.physical))
		SSshuttle.shopping_list -= order
		qdel(order)
		return TRUE
	return FALSE

/**
 * maps the ordename displayed on the ui to its supply pack id
 * * order_name - the name of the order
 */
/datum/computer_file/program/budgetorders/master/proc/name_to_id(order_name)
	for(var/pack in SSshuttle.supply_packs)
		var/datum/supply_pack/supply = SSshuttle.supply_packs[pack]
		if(order_name == supply.name)
			return pack
	return null

// Company Imports

/datum/component/armament/company_imports/tweaked/ui_data(mob/user)
	var/list/data = list()

	var/mob/living/carbon/human/the_person = user
	var/obj/item/card/id/id_card
	var/datum/bank_account/buyer = SSeconomy.get_dep_account(ACCOUNT_CAR)

	id_card = parent_prog.computer.computer_id_slot?.GetID()
	if (!id_card)
		if(istype(the_person))
			id_card = the_person.get_idcard(TRUE)

	var/budget_name = "Cargo Budget"

	if(id_card)
		budget_name = self_paid ? id_card.name : buyer.account_holder

	data["budget_name"] = budget_name

	var/cant_buy_restricted = TRUE
	if (!parent_prog.requestonly)
		cant_buy_restricted = FALSE

	data["cant_buy_restricted"] = !!cant_buy_restricted
	data["budget_points"] = self_paid ? id_card?.registered_account?.account_balance : buyer?.account_balance
	data["ammo_amount"] = ammo_purchase_num
	data["self_paid"] = !!self_paid
	data["armaments_list"] = list()

	for(var/armament_category as anything in SSarmaments.entries)

		var/list/armament_subcategories = list()

		for(var/subcategory as anything in SSarmaments.entries[armament_category][CATEGORY_ENTRY])
			var/list/subcategory_items = list()
			for(var/datum/armament_entry/armament_entry as anything in SSarmaments.entries[armament_category][CATEGORY_ENTRY][subcategory])
				if(products && !(armament_entry.type in products))
					continue

				var/datum/armament_entry/company_import/gun_entry = armament_entry

				if(gun_entry.contraband)
					var/datum/computer_file/program/budgetorders/parent_console = parent_prog
					if(!parent_console.contraband)
						continue

				subcategory_items += list(list(
					"ref" = REF(armament_entry),
					"icon" = armament_entry.cached_base64,
					"name" = armament_entry.name,
					"cost" = armament_entry.cost,
					"buyable_ammo" = armament_entry.magazine ? TRUE : FALSE,
					"magazine_cost" = armament_entry.magazine_cost,
					"purchased" = purchased_items[armament_entry] ? purchased_items[armament_entry] : 0,
					"description" = armament_entry.description,
					"armament_category" = armament_entry.category,
					"equipment_subcategory" = armament_entry.subcategory,
					"restricted" = !!armament_entry.restricted,
				))

			if(!LAZYLEN(subcategory_items))
				continue

			armament_subcategories += list(list(
				"subcategory" = subcategory,
				"items" = subcategory_items,
			))

		if(!LAZYLEN(armament_subcategories))
			continue

		data["armaments_list"] += list(list(
			"category" = armament_category,
			"category_uses" = used_categories[armament_category],
			"subcategories" = armament_subcategories,
		))

	return data

/datum/component/armament/company_imports/tweaked/select_armament(mob/user, datum/armament_entry/company_import/armament_entry)
	var/datum/bank_account/buyer = SSeconomy.get_dep_account(ACCOUNT_CAR)
	var/obj/item/modular_computer/possible_downloader
	var/obj/machinery/computer/cargo/possible_console

	var/obj/machinery/modular_computer/comp = parent
	possible_downloader = comp.cpu

	if(!istype(armament_entry))
		return

	var/mob/living/carbon/human/the_person = user

	if(istype(the_person))

		var/obj/item/card/id/id_card

		id_card = parent_prog.computer.computer_id_slot?.GetID()
		if(!id_card)
			id_card = the_person.get_idcard(TRUE)

		if(self_paid)
			if(!istype(id_card))
				to_chat(user, span_warning("No ID card detected."))
				return

			if(istype(id_card, /obj/item/card/id/departmental_budget))
				to_chat(user, span_warning("[id_card] cannot be used to make purchases."))
				return

			var/datum/bank_account/account = id_card.registered_account

			if(!istype(account))
				to_chat(user, span_warning("Invalid bank account."))
				return

			buyer = account

	if(!buyer)
		to_chat(user, span_warning("No budget found!"))
		return

	if(!ishuman(user) && !issilicon(user))
		return

	if(!buyer.has_money(armament_entry.cost))
		to_chat(user, span_warning("Not enough money!"))
		return

	var/name

	if(issilicon(user))
		name = user.real_name
	else
		name = the_person.get_authentification_name()

	var/reason = ""

	if(possible_console)
		if(possible_console.requestonly && !self_paid)
			reason = tgui_input_text(user, "Reason", name)
			if(isnull(reason))
				return

	else if(possible_downloader)
		var/datum/computer_file/program/budgetorders/parent_file = parent_prog
		if((parent_file.requestonly && !self_paid) || !(possible_downloader.computer_id_slot?.GetID() || the_person.get_idcard(TRUE)))
			reason = tgui_input_text(user, "Reason", name)
			if(isnull(reason))
				return

	used_categories[armament_entry.category]++

	purchased_items[armament_entry]++

	var/datum/supply_pack/armament/created_pack = new
	created_pack.name = initial(armament_entry.item_type.name)
	created_pack.cost = cost_calculate(armament_entry.cost) //Paid for seperately
	created_pack.contains = list(armament_entry.item_type)

	var/rank

	if(issilicon(user))
		rank = "Silicon"
	else
		rank = the_person.get_assignment(hand_first = TRUE)

	var/ckey = user.ckey

	var/datum/supply_order/company_import/created_order
	if(buyer != SSeconomy.get_dep_account(ACCOUNT_CAR))
		created_order = new(created_pack, name, rank, ckey, paying_account = buyer, reason = reason, can_be_cancelled = TRUE)
	else
		created_pack.goody = FALSE // Cargo ordered stuff should just show up in a box I think
		created_order = new(created_pack, name, rank, ckey, reason = reason, can_be_cancelled = TRUE)
	created_order.selected_entry = armament_entry
	created_order.used_component = src

	var/datum/computer_file/program/budgetorders/comp_file = parent_prog
	created_order.generateRequisition(get_turf(parent))
	if(comp_file.requestonly && !self_paid)
		SSshuttle.request_list += created_order
	else
		SSshuttle.shopping_list += created_order

/datum/component/armament/company_imports/tweaked/ui_act(action, list/params)
	if (action == "toggleprivate")
		action = "toggleprivateHACK"

	. = ..()
	if(.)
		return

	switch(action)
		if("toggleprivateHACK")
			var/obj/item/card/id/id_card
			var/mob/living/carbon/human/the_person = usr

			if(!istype(the_person))
				if(issilicon(the_person))
					self_paid = FALSE
				return


			id_card = parent_prog.computer.computer_id_slot?.GetID()
			if(!id_card)
				id_card = the_person.get_idcard(TRUE)

			if(!id_card)
				return

			self_paid = !self_paid


/obj/item/computer_console_disk/cargo/budgetorders/master/slave
	program = /datum/computer_file/program/budgetorders/master/request

/obj/item/computer_console_disk/cargo/budgetorders/master
	program = /datum/computer_file/program/budgetorders/master

/obj/machinery/modular_computer/preset/battery_less/console/cargo
	name = "supply console"
	desc = "Used to order supplies, approve requests, and control the shuttle."
	console_disk = /obj/item/computer_console_disk/cargo/budgetorders/master


/obj/machinery/modular_computer/preset/battery_less/console/cargo/request
	name = "supply request console"
	desc = "Used to request supplies from cargo."
	console_disk = /obj/item/computer_console_disk/cargo/budgetorders/master/slave
