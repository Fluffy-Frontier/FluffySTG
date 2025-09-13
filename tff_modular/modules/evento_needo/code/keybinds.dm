/datum/keybinding/movement/weapon_wield
	hotkey_keys = list("CtrlE")
	name = "weapon_wield"
	full_name = "army crawl"
	description = "wield your weapon like a man"
	keybind_signal = COMSIG_KB_MOB_WEAPON_WIELD

/datum/keybinding/human/secondary_action
	hotkey_keys = list("ShiftSpace")
	name = "secondary_action"
	full_name = "Perform secondary action"
	description = ""
	keybind_signal = COMSIG_KB_MOB_SECONDARYACTION

/datum/keybinding/human/secondary_action/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/current_human = user.mob
	current_human.do_secondary_action()
	return TRUE

/mob/verb/do_secondary_action()
	set name = "Do Secondary Action"
	set category = "Object"
	set src = usr

	if(ismecha(loc))
		return
	if(incapacitated)
		return

	var/obj/item/I = get_active_held_item()
	if(I)
		if(I.pre_secondary_action(src))
			return
		I.secondary_action(src)

/datum/keybinding/human/unique_action
	hotkey_keys = list("AltSpace")
	name = "unique_action"
	full_name = "Perform unique action"
	description = "Primarly used for guns"
	keybind_signal = COMSIG_KB_MOB_UNIQUEACTION

/datum/keybinding/human/unique_action/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/current_human = user.mob
	current_human.do_unique_action()
	return TRUE


///proc to call unique action on whatever we're holding.
/mob/verb/do_unique_action()
	set name = "Do Unique Action"
	set category = "Object"
	set src = usr

	if(incapacitated)
		return

	var/obj/item/I = get_active_held_item()
	if(I)
		if(I.pre_unique_action(src))
			return
		I.unique_action(src)
