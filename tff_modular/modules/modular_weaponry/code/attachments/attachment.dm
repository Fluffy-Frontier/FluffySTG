/datum/component/attachment
	///Slot the attachment goes on, also used in descriptions so should be player readable
	var/slot
	///various yes no flags associated with attachments. See defines for these: [_DEFINES/guns.dm]
	var/attach_features_flags
	///Unused so far, should probally handle it in the parent unless you have a specific reason
	var/list/valid_parent_types
	var/datum/callback/on_attach
	var/datum/callback/on_detach
	var/datum/callback/on_toggle
	var/datum/callback/on_attacked
	var/datum/callback/on_unique_action
	var/datum/callback/on_ctrl_click
	var/datum/callback/on_alt_click
	var/datum/callback/on_examine
	var/datum/callback/on_attack_hand
	///Called on the parents preattack
	var/datum/callback/on_preattack
	///Called on the parents wield
	var/datum/callback/on_wield
	///Called on the parents unwield
	var/datum/callback/on_unwield
	///Unused...Also a little broken..
	var/list/datum/action/actions
	///Generated if the attachment can toggle, sends COMSIG_ATTACHMENT_TOGGLE
	var/datum/action/item_action/attachment/attachment_toggle_action

/datum/component/attachment/Initialize(
		slot = ATTACHMENT_SLOT_RAIL,
		attach_features_flags = ATTACH_REMOVABLE_HAND,
		valid_parent_types = list(/obj/item/gun),
		datum/callback/on_attach = null,
		datum/callback/on_detach = null,
		datum/callback/on_toggle = null,
		datum/callback/on_preattack = null,
		datum/callback/on_attacked = null,
		datum/callback/on_unique_action = null,
		datum/callback/on_ctrl_click = null,
		datum/callback/on_wield = null,
		datum/callback/on_unwield = null,
		datum/callback/on_examine = null,
		datum/callback/on_alt_click = null,
		datum/callback/on_attack_hand = null,
		list/signals = null
	)

	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.slot = slot
	src.attach_features_flags = attach_features_flags
	src.valid_parent_types = valid_parent_types
	src.on_attach = on_attach
	src.on_detach = on_detach
	src.on_toggle = on_toggle
	src.on_preattack = on_preattack
	src.on_attacked = on_attacked
	src.on_unique_action = on_unique_action
	src.on_ctrl_click = on_ctrl_click
	src.on_wield = on_wield
	src.on_unwield = on_unwield
	src.on_examine = on_examine
	src.on_alt_click = on_alt_click
	src.on_attack_hand = on_attack_hand

	ADD_TRAIT(parent, TRAIT_ATTACHABLE, "attachable")
	RegisterSignal(parent, COMSIG_ATTACHMENT_ATTACH, PROC_REF(try_attach))
	RegisterSignal(parent, COMSIG_ATTACHMENT_DETACH, PROC_REF(try_detach))
	RegisterSignal(parent, COMSIG_ATTACHMENT_EXAMINE, PROC_REF(handle_examine))
	RegisterSignal(parent, COMSIG_ATTACHMENT_EXAMINE_MORE, PROC_REF(handle_examine_more))
	if(attach_features_flags & ATTACH_TOGGLE)
		RegisterSignal(parent, COMSIG_ATTACHMENT_TOGGLE, PROC_REF(try_toggle))
		attachment_toggle_action = new /datum/action/item_action/attachment(parent)
	RegisterSignal(parent, COMSIG_ATTACHMENT_PRE_ATTACK, PROC_REF(relay_pre_attack))
	RegisterSignal(parent, COMSIG_ATTACHMENT_UPDATE_OVERLAY, PROC_REF(update_overlays))
	RegisterSignal(parent, COMSIG_ATTACHMENT_GET_SLOT, PROC_REF(send_slot))
	RegisterSignal(parent, COMSIG_ATTACHMENT_WIELD, PROC_REF(try_wield))
	RegisterSignal(parent, COMSIG_ATTACHMENT_UNWIELD, PROC_REF(try_unwield))
	RegisterSignal(parent, COMSIG_ATTACHMENT_ATTACK, PROC_REF(relay_attacked))
	RegisterSignal(parent, COMSIG_ATTACHMENT_UNIQUE_ACTION, PROC_REF(relay_unique_action))
	RegisterSignal(parent, COMSIG_ATTACHMENT_CTRL_CLICK, PROC_REF(relay_ctrl_click))
	RegisterSignal(parent, COMSIG_ATTACHMENT_ALT_CLICK, PROC_REF(relay_alt_click))
	RegisterSignal(parent, COMSIG_ATTACHMENT_ATTACK_HAND, PROC_REF(relay_attack_hand))

	for(var/signal in signals)
		RegisterSignal(parent, signal, signals[signal])

/datum/component/attachment/Destroy(force)
	REMOVE_TRAIT(parent, TRAIT_ATTACHABLE, "attachable")
	if(actions && length(actions))
		var/obj/item/gun/parent = src.parent
		parent.actions -= actions
		QDEL_LIST(actions)
	qdel(attachment_toggle_action)
	return ..()

/datum/component/attachment/proc/try_toggle(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER
	if(attach_features_flags & ATTACH_TOGGLE)
		INVOKE_ASYNC(src, PROC_REF(do_toggle), parent, holder, user)
		holder.update_icon()
		attachment_toggle_action.build_all_button_icons()

/datum/component/attachment/proc/do_toggle(obj/item/parent, obj/item/holder, mob/user)
	if(on_toggle)
		on_toggle.Invoke(holder, user)
		return TRUE

	parent.attack_self(user)
	return TRUE

/datum/component/attachment/proc/update_overlays(obj/item/attachment/parent, list/overlays, list/offset)
	if(!(attach_features_flags & ATTACH_NO_SPRITE))
		//var/overlay_layer = ABOVE_OBJ_LAYER
		//var/overlay_plane = ABOVE_HUD_PLANE
		//if(parent.render_layer)
		//	overlay_layer = parent.render_layer
		//if(parent.render_plane)
		//	overlay_layer = parent.render_plane
		overlays += mutable_appearance(parent.icon, "[parent.icon_state]-attached")

/datum/component/attachment/proc/try_attach(obj/item/parent, obj/item/holder, mob/user, bypass_checks)
	SIGNAL_HANDLER

	if(!bypass_checks)
		if(!user.is_holding(parent) || !parent.Adjacent(user) || (length(valid_parent_types) && !(holder.type in valid_parent_types)))
			return FALSE
	if(on_attach && !on_attach.Invoke(holder, user))
		return FALSE

	parent.forceMove(holder)

	if(attach_features_flags & ATTACH_TOGGLE)
		holder.actions += list(attachment_toggle_action)
		attachment_toggle_action.gun = holder
		if(user && user.is_holding(holder))
			attachment_toggle_action.Grant(user)

	return TRUE

/datum/component/attachment/proc/try_detach(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER

	if(!parent.Adjacent(user))
		return FALSE

	if(on_attach && !on_detach.Invoke(holder, user))
		return FALSE

	if(attach_features_flags & ATTACH_TOGGLE)
		holder.actions -= list(attachment_toggle_action)
		attachment_toggle_action.gun = null
		if(user)
			attachment_toggle_action.Remove(user)

	if(user.can_put_in_hand(parent, user.active_hand_index))
		user.put_in_hand(parent, user.active_hand_index)
		return TRUE
	else
		parent.forceMove(holder.drop_location())
	return TRUE

/datum/component/attachment/proc/handle_examine(obj/item/parent, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(on_examine)
		on_examine.Invoke(parent, user, examine_list)

/datum/component/attachment/proc/handle_examine_more(obj/item/parent, mob/user, list/examine_list)
	SIGNAL_HANDLER

	return

/datum/component/attachment/proc/relay_pre_attack(obj/item/parent, obj/item/gun, atom/target_atom, mob/user, params)
	SIGNAL_HANDLER

	if(on_preattack)
		return on_preattack.Invoke(gun, target_atom, user, params)

/datum/component/attachment/proc/relay_attacked(obj/item/parent, obj/item/gun, obj/item, mob/user, params)
	SIGNAL_HANDLER

	if(on_attacked)
		return on_attacked.Invoke(gun, user, item)

/datum/component/attachment/proc/try_wield(obj/item/parent, obj/item/gun, mob/user, params)
	SIGNAL_HANDLER

	if(on_wield)
		return on_wield.Invoke(gun, user, params)

/datum/component/attachment/proc/try_unwield(obj/item/parent, obj/item/gun, mob/user, params)
	SIGNAL_HANDLER

	if(on_unwield)
		return on_unwield.Invoke(gun, user, params)

/datum/component/attachment/proc/relay_unique_action(obj/item/parent, obj/item/gun, mob/user, params)
	SIGNAL_HANDLER

	if(on_unique_action)
		return on_unique_action.Invoke(gun, user, params)

/datum/component/attachment/proc/relay_ctrl_click(obj/item/parent, obj/item/gun, mob/user, params)
	SIGNAL_HANDLER

	if(on_ctrl_click)
		return on_ctrl_click.Invoke(gun, user, params)

/datum/component/attachment/proc/relay_alt_click(obj/item/parent, obj/item/gun, mob/user, params)
	SIGNAL_HANDLER

	if(on_alt_click)
		return on_alt_click.Invoke(gun, user, params)

/datum/component/attachment/proc/relay_attack_hand(obj/item/parent, obj/item/gun, mob/user, params)
	SIGNAL_HANDLER

	if(on_attack_hand)
		return on_attack_hand.Invoke(gun, user, params)

/datum/component/attachment/proc/send_slot(obj/item/parent)
	SIGNAL_HANDLER
	return attachment_slot_to_bflag(slot)

/datum/action/item_action/attachment
	name = "Toggle Attachment"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS
	button_icon_state = null
	///Decides where we send our toggle signal for when pressed
	var/obj/item/gun/gun = null
	var/obj/target_attachment

/datum/action/item_action/attachment/New(Target)
	..()
	target_attachment = Target
	name = "Toggle [target_attachment.name]"
	button_icon = target_attachment.icon
	button_icon_state = target_attachment.icon_state

/datum/action/item_action/attachment/Destroy()
	. = ..()
	target_attachment = null
	gun = null

/datum/action/item_action/attachment/Trigger(trigger_flags)
	..()
	SEND_SIGNAL(target, COMSIG_ATTACHMENT_TOGGLE, gun, owner)

/datum/action/item_action/attachment/build_all_button_icons(update_flags, force)
	button_icon = target_attachment?.icon
	button_icon_state = target_attachment?.icon_state
	..()
