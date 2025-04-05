#define COMSIG_TWOHANDED_GUN_WIELD "twohanded_gun_wield"
	#define COMPONENT_TWOHANDED_BLOCK_GUN_WIELD (1<<0)
#define COMSIG_TWOHANDED_GUN_UNWIELD "twohanded_GUN_unwield"


/obj/item/gun
	var/unwielded_recoil = 0
	var/wielded_recoil = 0
	var/unwielded_spread = 0
	var/wielded_spread = 0
	var/icon_wielded = null


/datum/component/two_handed_gun
	var/wielded = FALSE
	var/unwielded_recoil = 0
	var/wielded_recoil = 0
	var/unwielded_spread = 0
	var/wielded_spread = 0
	var/icon_wielded = null
	var/obj/item/offhand/offhand_item = null
	var/datum/callback/wield_callback
	var/datum/callback/unwield_callback
	var/datum/action/item_action/wield_gun/wielded_action

/datum/component/two_handed_gun/Initialize(
	unwielded_recoil,
	wielded_recoil,
	unwielded_spread,
	wielded_spread,
	icon_wielded,
	datum/callback/wield_call,
	datum/callback/unwield_callback
)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.unwielded_recoil = unwielded_recoil
	src.wielded_recoil = wielded_recoil
	src.unwielded_spread = unwielded_spread
	src.wielded_spread = wielded_spread
	src.icon_wielded = icon_wielded
	src.wield_callback = wield_callback
	src.unwield_callback = unwield_callback
	var/obj/item/gun/weapon_parent = parent
	wielded_action = weapon_parent.add_item_action(/datum/action/item_action/wield_gun)


/datum/component/two_handed_gun/Destroy(force)
	offhand_item = null
	wield_callback = null
	unwield_callback = null
	if(wielded_action)
		QDEL_NULL(wielded_action)
	return ..()

/datum/component/two_handed_gun/InheritComponent(
	datum/component/two_handed_gun/new_comp,
	original,
	unwielded_recoil,
	wielded_recoil,
	unwielded_spread,
	wielded_spread,
	icon_wielded,
	datum/callback/wield_call,
	datum/callback/unwield_callback
)
	if(!original)
		return
	if(unwielded_recoil)
		src.unwielded_recoil = unwielded_recoil
	if(wielded_recoil)
		src.wielded_recoil = wielded_recoil
	if(unwielded_spread)
		src.unwielded_spread = unwielded_spread
	if(wielded_spread)
		src.wielded_spread = wielded_spread
	if(icon_wielded)
		src.icon_wielded = icon_wielded
	if(wield_callback)
		src.wield_callback = wield_callback
	if(unwield_callback)
		src.unwield_callback = unwield_callback

/datum/component/two_handed_gun/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_POST_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	RegisterSignal(parent, COMSIG_ITEM_UI_ACTION_CLICK, PROC_REF(change_wield))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_ICON, PROC_REF(on_update_icon))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	RegisterSignal(parent, COMSIG_ITEM_APPLY_FANTASY_BONUSES, PROC_REF(apply_fantasy_bonuses))
	RegisterSignal(parent, COMSIG_ITEM_REMOVE_FANTASY_BONUSES, PROC_REF(remove_fantasy_bonuses))

/datum/component/two_handed_gun/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_ITEM_POST_EQUIPPED,
		COMSIG_ITEM_DROPPED,
		COMSIG_ITEM_UI_ACTION_CLICK,
		COMSIG_ITEM_ATTACK,
		COMSIG_ATOM_UPDATE_ICON,
		COMSIG_MOVABLE_MOVED,
		COMSIG_ITEM_SHARPEN_ACT,
		COMSIG_ITEM_APPLY_FANTASY_BONUSES,
		COMSIG_ITEM_REMOVE_FANTASY_BONUSES,
	))

/datum/component/two_handed_gun/proc/on_equip(datum/source, mob/user, slot)
	SIGNAL_HANDLER
	if(!user.is_holding(parent) && wielded)
		unwield(user)

/datum/component/two_handed_gun/proc/on_drop(datum/source, mob/user)
	SIGNAL_HANDLER

	if(wielded)
		unwield(user)
	if(source == offhand_item && !QDELETED(source))
		offhand_item = null
		qdel(source)

/datum/component/two_handed_gun/proc/on_destroy(datum/source)
	SIGNAL_HANDLER
	offhand_item = null

/datum/component/two_handed_gun/proc/change_wield(datum/source, mob/user, datum/actiontype)
	SIGNAL_HANDLER
	if(istype(actiontype, wielded_action))
		if(wielded)
			unwield(user)
		else if(user.is_holding(parent))
			wield(user)

	return COMPONENT_ACTION_HANDLED

/datum/component/two_handed_gun/proc/wield(mob/user)
	if(wielded)
		return

	var/atom/atom_parent = parent
	if(user.get_inactive_held_item())
		atom_parent.balloon_alert(user, "holding something in other hand!")
		return COMPONENT_EQUIPPED_FAILED
	if(SEND_SIGNAL(parent, COMSIG_TWOHANDED_GUN_WIELD, user) & COMPONENT_TWOHANDED_BLOCK_GUN_WIELD)
		user.dropItemToGround(parent, force = TRUE)
		return COMPONENT_EQUIPPED_FAILED
	if (wield_callback?.Invoke(parent, user) & COMPONENT_TWOHANDED_BLOCK_GUN_WIELD)
		return
	wielded = TRUE
	ADD_TRAIT(parent, TRAIT_WIELDED, REF(src))
	RegisterSignal(user, COMSIG_MOB_SWAPPING_HANDS, PROC_REF(on_swapping_hands))

	var/obj/item/gun/parent_item = parent
	if(wielded_recoil)
		parent_item.recoil = wielded_recoil
	if(wielded_spread)
		parent_item.spread = wielded_spread
	parent_item.name = "[parent_item.name] (Wielded)"
	parent_item.update_appearance()

	offhand_item = new(user)
	offhand_item.name = "[parent_item.name] - offhand"
	offhand_item.desc = "Your second grip on [parent_item]."
	offhand_item.wielded = TRUE
	RegisterSignal(offhand_item, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	RegisterSignal(offhand_item, COMSIG_QDELETING, PROC_REF(on_destroy))
	user.put_in_inactive_hand(offhand_item)


/datum/component/two_handed_gun/proc/unwield(mob/living/carbon/user, show_message=TRUE, can_drop=TRUE)
	if(!wielded)
		return

	wielded = FALSE
	UnregisterSignal(user, COMSIG_MOB_SWAPPING_HANDS)
	SEND_SIGNAL(parent, COMSIG_TWOHANDED_UNWIELD, user)
	REMOVE_TRAIT(parent, TRAIT_WIELDED, REF(src))
	unwield_callback?.Invoke(parent, user)

	var/obj/item/gun/parent_item = parent
	if(unwielded_recoil)
		parent_item.recoil = unwielded_recoil
	if(unwielded_spread)
		parent_item.spread = unwielded_spread

	var/sf = findtext(parent_item.name, " (Wielded)", -10) // 10 == length(" (Wielded)")
	if(sf)
		parent_item.name = copytext(parent_item.name, 1, sf)
	else
		parent_item.name = "[initial(parent_item.name)]"

	parent_item.update_appearance()

	if(istype(user))
		if(user.get_item_by_slot(ITEM_SLOT_BACK) == parent)
			user.update_worn_back()
		else
			user.update_held_items()

	if(show_message)
		to_chat(user, span_notice("You are now carrying [parent] with one hand."))

	if(offhand_item)
		UnregisterSignal(offhand_item, list(COMSIG_ITEM_DROPPED, COMSIG_QDELETING))
		qdel(offhand_item)
	offhand_item = null

/datum/component/two_handed_gun/proc/on_update_icon(obj/item/source)
	SIGNAL_HANDLER
	if(!wielded)
		return NONE
	if(!icon_wielded)
		return NONE
	source.icon_state = icon_wielded
	return COMSIG_ATOM_NO_UPDATE_ICON_STATE

/datum/component/two_handed_gun/proc/on_moved(datum/source, mob/user, dir)
	SIGNAL_HANDLER

	unwield(user, can_drop=FALSE)

/datum/component/two_handed_gun/proc/on_swapping_hands(mob/user, obj/item/held_item)
	SIGNAL_HANDLER

	if(!held_item)
		return
	if(held_item == parent)
		return COMPONENT_BLOCK_SWAP




/datum/component/two_handed_gun/proc/apply_fantasy_bonuses(obj/item/source, bonus)
	SIGNAL_HANDLER
	wielded_recoil = source.modify_fantasy_variable("wielded_recoil", wielded_recoil, bonus)
	unwielded_recoil = source.modify_fantasy_variable("unwielded_recoil", unwielded_recoil, bonus)
	wielded_spread = source.modify_fantasy_variable("wielded_spread", wielded_spread, bonus)
	unwielded_spread = source.modify_fantasy_variable("unwielded_spread", unwielded_spread, bonus)
	if(wielded && ismob(source.loc))
		unwield(source.loc)




/datum/component/two_handed_gun/proc/remove_fantasy_bonuses(obj/item/source, bonus)
	SIGNAL_HANDLER
	wielded_recoil = source.reset_fantasy_variable("wielded_recoil", wielded_recoil)
	unwielded_recoil = source.reset_fantasy_variable("unwielded_recoil", unwielded_recoil)
	wielded_spread = source.reset_fantasy_variable("wielded_spread", wielded_spread,)
	unwielded_spread = source.reset_fantasy_variable("unwielded_spread", unwielded_spread)
	if(wielded && ismob(source.loc))
		unwield(source.loc)

/datum/action/item_action/wield_gun
	name = "Wield gun"

/datum/action/item_action/wield_gun/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/component/two_handed_gun/wieldable = target.GetComponent(/datum/component/two_handed_gun)
	if(wieldable)
		wieldable.change_wield()
