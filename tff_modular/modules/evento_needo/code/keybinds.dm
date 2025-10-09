/datum/keybinding/human/weapon_wield
	hotkey_keys = list("CtrlE")
	name = "weapon_wield"
	full_name = "army crawl"
	description = "wield your weapon like a man"
	keybind_signal = COMSIG_KB_MOB_WEAPON_WIELD

/datum/keybinding/human/weapon_wield/down(client/user, turf/target)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/H = user.mob
	var/obj/item/gun/weapon = istype(H.get_active_held_item(), /obj/item/gun) ? H.get_active_held_item() : null
	if(!weapon)
		to_chat(H, "No weapon to wield!")
		return FALSE
	var/obj/item/gun/second_weapon = istype(H.get_inactive_held_item(), /obj/item/gun) ? H.get_inactive_held_item() : null
	if(second_weapon)
		if(second_weapon.weapon_weight < WEAPON_MEDIUM)
			second_weapon.equip_to_best_slot(H)
	weapon.do_wield(H)
	return TRUE

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
