/obj/item/circuitboard/machine/grimdye
	name = "Grimdye machine"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/grimdye

/obj/machinery/grimdye
	name = "Grimdye color machine"
	desc = "A machine used for color clothing."
	icon = 'icons/obj/machines/display.dmi'
	icon_state = "laserbox_open"
	circuit = /obj/item/circuitboard/machine/grimdye

	use_power = NO_POWER_USE
	//Предмет находящийся внутри машины.
	var/obj/item/holding_item
	//Текущий активный интерфейс.
	var/datum/weakref/active_ui

/obj/machinery/grimdye/attacked_by(obj/item/attacking_item, mob/living/user)
	. = ..()
	if(panel_open)
		user.balloon_alert(user, "Close panel!")
		return
	if(holding_item)
		user.balloon_alert(user, "Item inside!")
		return
	if(!istype(attacking_item, /obj/item/clothing))
		user.balloon_alert(user, "Wrong object type!")
		return
	store(attacking_item)
	user.balloon_alert(user, "Item stored!")

/obj/machinery/grimdye/AltClick(mob/user)
	. = ..()
	if(!holding_item)
		user.balloon_alert(user, "Empty!")
		return
	draw(holding_item)
	user.balloon_alert(user, "Item drawed!")

/obj/machinery/grimdye/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!holding_item)
		user.balloon_alert(user, "No item inside!")
		return
	if(active_ui)
		var/ui = active_ui.resolve()
		qdel(ui)
		active_ui = null
	var/use_greyscale = FALSE
	if(holding_item.greyscale_config)
		use_greyscale = TRUE
	//Если предмет обладает настройкой grayscale конфига, вызываем соотсутствующее меню для покраски.
	if(use_greyscale)
		var/list/configs = list()
		if(initial(holding_item.greyscale_config_worn))
			configs += "[initial(holding_item.greyscale_config_worn)]"
		if(initial(holding_item.greyscale_config_inhand_left))
			configs += "[initial(holding_item.greyscale_config_inhand_left)]"
		if(initial(holding_item.greyscale_config_inhand_right))
			configs += "[initial(holding_item.greyscale_config_inhand_right)]"

		var/datum/greyscale_modify_menu/color_menu = new(\
			target = holding_item,\
			user = user.client,\
			allowed_configs = configs,\
			starting_icon_state = initial(holding_item.icon_state),\
			starting_config = initial(holding_item.greyscale_config)
		)
		active_ui = WEAKREF(color_menu)
		return
	to_chat(user, span_warning("No grayscale config found! running matrix mode."))
	var/datum/color_matrix_editor/editor = new /datum/color_matrix_editor(user.client, in_atom)
	editor.wait()
	editor.ui_interact(user.client)
	active_ui = WEAKREF(editor)

/obj/machinery/grimdye/proc/store(obj/item/item_to_store, mob/user)
	if(!istype(item_to_store))
		return
	item_to_store.forceMove(src)
	holding_item = item_to_store

/obj/machinery/grimdye/proc/draw(obj/item/object_to_draw, mob/user)
	if(active_ui)
		var/handlet_ui = active_ui.resolve()
		qdel(handlet_ui)
		active_ui = null
	holding_item.forceMove(get_turf(src))
	holding_item = null
