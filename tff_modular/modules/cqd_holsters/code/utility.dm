#define COMSIG_KB_HUMAN_CQD_HOLSTER_ACTION_DOWN "keybinding_human_cqd_holster_action_down"

/*
	Keybinding
*/

/datum/keybinding/human/cqd_holster_action
	hotkey_keys = list("Unbound")
	name = "cqd_holster_action"
	full_name = "CQD holster action"
	description = "Quickly equip or hide your gun in CQD holster"
	keybind_signal = COMSIG_KB_HUMAN_CQD_HOLSTER_ACTION_DOWN

/datum/keybinding/human/cqd_holster_action/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/H = user.mob
	H.quick_equip()
	return TRUE

/mob/verb/cqd_holster_action()
	set name = "cqd-holster-action"
	set hidden = TRUE

	DEFAULT_QUEUE_OR_CALL_VERB(VERB_CALLBACK(src, PROC_REF(execute_cqd_holster_action)))

/*
	Verb and proc
*/

/mob/proc/execute_cqd_holster_action()
	var/obj/item/I = get_active_held_item()
	if(!I)
		to_chat(src, span_warning("You are not holding anything!"))
		return
	if (temporarilyRemoveItemFromInventory(I) && !QDELETED(I))
		var/uniform
		if(get_item_by_slot(ITEM_SLOT_ICLOTHING))
			return
		if(put_in_active_hand(I))
			return
		I.forceMove(drop_location())
		
