/datum/component/toggle_attached_clothing/left_side_cloak
	/// Если нужно изменять стейты плащика/другой шмоточки идущей в комлекте с одежкой.
	var/deployable_icon_up_state_suffix = ""
	var/deployable_icon_down_state_suffix = ""

/datum/component/toggle_attached_clothing/left_side_cloak/Initialize(
	deployable_type,
	equipped_slot,
	action_name = "Toggle",
	destroy_on_removal = FALSE,
	parent_icon_state_suffix = "",
	down_overlay_state_suffix = "",
	deployable_icon_up_state_suffix = "",
	deployable_icon_down_state_suffix = "",
	datum/callback/pre_creation_check,
	datum/callback/on_created,
	datum/callback/on_deployed,
	datum/callback/on_removed,
)
	if (!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	if (!deployable_type || !equipped_slot)
		return COMPONENT_INCOMPATIBLE
	src.deployable_type = deployable_type
	src.equipped_slot = equipped_slot
	src.destroy_on_removal = destroy_on_removal

	src.parent_icon_state_suffix = parent_icon_state_suffix
	src.down_overlay_state_suffix = down_overlay_state_suffix
	src.deployable_icon_up_state_suffix = deployable_icon_up_state_suffix
	src.deployable_icon_down_state_suffix = deployable_icon_down_state_suffix

	src.pre_creation_check = pre_creation_check
	src.on_created = on_created
	src.on_deployed = on_deployed
	src.on_removed = on_removed

	var/obj/item/clothing_parent = parent
	toggle_action = new(parent)
	toggle_action.name = action_name
	clothing_parent.add_item_action(toggle_action)

	RegisterSignal(parent, COMSIG_ITEM_UI_ACTION_CLICK, PROC_REF(on_toggle_pressed))
	RegisterSignal(parent, COMSIG_ITEM_UI_ACTION_SLOT_CHECKED, PROC_REF(on_action_slot_checked))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_parent_equipped))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED_AS_OUTFIT, PROC_REF(on_parent_equipped_outfit))

	if (down_overlay_state_suffix)
		var/overlay_state = "[initial(clothing_parent.icon_state)][down_overlay_state_suffix]"
		undeployed_overlay = mutable_appearance(initial(clothing_parent.worn_icon), overlay_state, -SUIT_LAYER)
		RegisterSignal(parent, COMSIG_ITEM_GET_WORN_OVERLAYS, PROC_REF(on_checked_overlays))
		clothing_parent.update_slot_icon()

	if (!destroy_on_removal)
		create_deployable()

/datum/component/toggle_attached_clothing/left_side_cloak/proc/on_any_item_picked_up()
	SIGNAL_HANDLER
	switch_deployable_icon()
	return

/datum/component/toggle_attached_clothing/left_side_cloak/proc/switch_deployable_icon()
	if (currently_deployed)
		var/obj/item/parent_gear = parent
		if (!ishuman(parent_gear.loc))
			return
		var/mob/living/carbon/human/wearer = parent_gear.loc
		if(deployable_icon_up_state_suffix)
			if(wearer.held_items[1])
				deployable.icon_state = "[initial(deployable.icon_state)][deployable_icon_up_state_suffix]"
				deployable.worn_icon_state = deployable.icon_state
			else
				deployable.icon_state = "[initial(deployable.icon_state)][deployable_icon_down_state_suffix]"
				deployable.worn_icon_state = deployable.icon_state
			deployable.update_slot_icon()
		return

/// Самая перегруженная функция, где и будет вся-вся логика.
/datum/component/toggle_attached_clothing/left_side_cloak/toggle_deployable()
	if (currently_deployed)
		return
	var/obj/item/parent_gear = parent
	if (!ishuman(parent_gear.loc))
		return
	var/mob/living/carbon/human/wearer = parent_gear.loc
	if (wearer.is_holding(parent_gear))
		return
	if (wearer.get_item_by_slot(equipped_slot))
		return
	if (!deployable)
		create_deployable()
	if (!wearer.equip_to_slot_if_possible(deployable, slot = equipped_slot))
		return
	currently_deployed = TRUE
	RegisterSignal(wearer, COMSIG_MOB_UPDATE_HELD_ITEMS, PROC_REF(on_any_item_picked_up))
	on_deployed?.Invoke(deployable)
	if (parent_icon_state_suffix)
		parent_gear.icon_state = "[initial(parent_gear.icon_state)][parent_icon_state_suffix]"
		parent_gear.worn_icon_state = parent_gear.icon_state
	parent_gear.update_slot_icon()
	wearer.update_mob_action_buttons()

/// При перемещении в слот одежды пытается одеть и плащик.
/datum/component/toggle_attached_clothing/left_side_cloak/on_parent_equipped(obj/item/clothing/source, mob/equipper, slot)
	SIGNAL_HANDLER
	if (slot & ITEM_SLOT_ICLOTHING)
		toggle_deployable()
		return
	remove_deployable()

/// Прячем предмет из слота или откуда-либо ещё.

/datum/component/toggle_attached_clothing/left_side_cloak/remove_deployable()
	unequip_deployable()
	currently_deployed = FALSE
	on_removed?.Invoke(deployable)

	var/obj/item/parent_gear = parent
	if (destroy_on_removal)
		QDEL_NULL(deployable)
	else if (parent_icon_state_suffix)
		parent_gear.icon_state = "[initial(parent_gear.icon_state)]"
		parent_gear.worn_icon_state = parent_gear.icon_state
	parent_gear.update_slot_icon()
	parent_gear.update_item_action_buttons()

/// Правильно снимает предмет с слота носителя.
/datum/component/toggle_attached_clothing/left_side_cloak/unequip_deployable()
	if (!deployable)
		return
	if (!ishuman(deployable.loc))
		deployable.forceMove(parent)
		return
	var/mob/living/carbon/human/wearer = deployable.loc
	UnregisterSignal(wearer, COMSIG_MOB_UPDATE_HELD_ITEMS)
	wearer.transferItemToLoc(deployable, parent, force = TRUE, silent = TRUE)
