#define COMSIG_KB_HUMAN_CQD_HOLSTER_ACTION_DOWN "keybinding_human_cqd_holster_action_down"

/*
	Keybinding and verb
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
	H.cqd_holster_action()
	return TRUE

/mob/living/carbon/human/verb/cqd_holster_action()
	set name = "cqd-holster-action"
	set hidden = TRUE

	DEFAULT_QUEUE_OR_CALL_VERB(VERB_CALLBACK(src, PROC_REF(execute_cqd_holster_action)))

/*
	Proc
*/

/mob/living/carbon/human/proc/execute_cqd_holster_action()
	if(!can_perform_action(src, NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING))
		return
	var/obj/item/clothing/under/u = get_item_by_slot(ITEM_SLOT_ICLOTHING)
	if(!u)
		return
	var/obj/item/clothing/accessory/cqd_holster/holster
	for(var/accessory in u.attached_accessories) 
		if(istype(accessory, /obj/item/clothing/accessory/cqd_holster))
			holster = accessory
			break
	if(!holster)
		return
	var/obj/item/item_in_hand = get_active_held_item()
	if(item_in_hand)
		holster.atom_storage.attempt_insert(item_in_hand, src)
	else
		if(length(holster.contents))
			var/obj/item/I = holster.contents[1]
			if(I.attack_hand(src))
				visible_message(span_notice("[src] takes [I] out of [src]."), span_notice("You take [I] out of [holster]."))
		else
			to_chat(src, span_warning("You are not holding anything and the holster is empty!"))
			return	
		
		
