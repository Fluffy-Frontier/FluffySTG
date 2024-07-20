#define COMSIG_MOB_EQUIPPED_SOME_ITEMS "comsig_mob_equipped_some_items"

/mob/update_held_items()
	. = ..()
	SEND_SIGNAL(src, COMSIG_MOB_EQUIPPED_SOME_ITEMS)

/**
 * Компонент, который позволяет одеть одежку вместе с другой одежкой.
 */

/datum/component/attached_clothing
	var/obj/item/deployable
	var/datum/action/item_action/toggle_action
	var/deployable_type
	var/equipped_slot
	var/action_name = ""
	var/destroy_on_removal
	var/currently_deployed = FALSE
	/// Если требуется изменять родительский спрайт родительской одежды.
	var/parent_icon_state_suffix = ""
	/// Если требуется изменять родительский спрайт родительской одежды когда капюшона\плаща нет.
	var/down_overlay_state_suffix = ""
	/// Если нужно изменять стейты плащика/другой шмоточки идущей в комлекте с одежкой.
	var/deployable_icon_up_state_suffix = ""
	var/deployable_icon_down_state_suffix = ""
	var/mutable_appearance/undeployed_overlay
	var/datum/callback/pre_creation_check
	var/datum/callback/on_created
	var/datum/callback/on_deployed
	var/datum/callback/on_removed

/datum/component/attached_clothing/Initialize(
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
	. = ..()
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

/datum/component/attached_clothing/Destroy(force)
	unequip_deployable()
	QDEL_NULL(deployable)
	QDEL_NULL(toggle_action)
	undeployed_overlay = null
	pre_creation_check = null
	on_created = null
	on_deployed = null
	on_removed = null
	return ..()

/datum/component/attached_clothing/proc/on_toggle_pressed(obj/item/source, mob/user, datum/action)
	SIGNAL_HANDLER
	if (action != toggle_action)
		return
	toggle_deployable()
	return COMPONENT_ACTION_HANDLED

/datum/component/attached_clothing/proc/on_action_slot_checked(obj/item/clothing/source, mob/user, datum/action, slot)
	SIGNAL_HANDLER
	if (action != toggle_action)
		return
	if (!(source.slot_flags & slot))
		return COMPONENT_ITEM_ACTION_SLOT_INVALID

/datum/component/attached_clothing/proc/on_checked_overlays(obj/item/source, list/overlays, mutable_appearance/standing, isinhands, icon_file)
	SIGNAL_HANDLER
	if (isinhands || currently_deployed)
		return
	overlays += undeployed_overlay

/datum/component/attached_clothing/proc/switch_deployable_icon()
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
/datum/component/attached_clothing/proc/toggle_deployable()
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
	RegisterSignal(wearer, COMSIG_MOB_EQUIPPED_SOME_ITEMS, PROC_REF(on_any_item_picked_up))
	on_deployed?.Invoke(deployable)
	if (parent_icon_state_suffix)
		parent_gear.icon_state = "[initial(parent_gear.icon_state)][parent_icon_state_suffix]"
		parent_gear.worn_icon_state = parent_gear.icon_state
	parent_gear.update_slot_icon()
	wearer.update_mob_action_buttons()

/// При перемещении в слот одежды пытается одеть и плащик.
/datum/component/attached_clothing/proc/on_parent_equipped(obj/item/clothing/source, mob/equipper, slot)
	SIGNAL_HANDLER
	if (slot & ITEM_SLOT_ICLOTHING)
		toggle_deployable()
		return
	remove_deployable()

/datum/component/attached_clothing/proc/on_any_item_picked_up()
	SIGNAL_HANDLER
	switch_deployable_icon()
	return

/// Если как костюм надет на старте игры - то плащик показываем.
/datum/component/attached_clothing/proc/on_parent_equipped_outfit(obj/item/clothing/source, mob/equipper, visuals_only, slot)
	SIGNAL_HANDLER
	create_deployable()
	toggle_deployable()

/// Создаем наш капюшон или плащик. Вернёт True если succes.
/datum/component/attached_clothing/proc/create_deployable()
	if (deployable)
		return FALSE
	if (pre_creation_check && !pre_creation_check.Invoke())
		return FALSE
	deployable = new deployable_type(parent)
	if (!istype(deployable))
		stack_trace("Tried to create non-clothing item from toggled clothing.")
	RegisterSignal(deployable, COMSIG_ITEM_DROPPED, PROC_REF(on_deployed_dropped))
	RegisterSignal(deployable, COMSIG_ITEM_EQUIPPED, PROC_REF(on_deployed_equipped))
	RegisterSignal(deployable, COMSIG_QDELETING, PROC_REF(on_deployed_destroyed))
	on_created?.Invoke(deployable)
	return TRUE

/datum/component/attached_clothing/proc/on_deployed_dropped()
	SIGNAL_HANDLER
	remove_deployable()

/// Equipped - не значит "надеть", а значит "подобрать". Из слота в слот перемещаем - тоже срабатывает.
/datum/component/attached_clothing/proc/on_deployed_equipped(obj/item/clothing/source, mob/equipper, slot)
	SIGNAL_HANDLER
	if (source.slot_flags & slot)
		return
	remove_deployable()

/datum/component/attached_clothing/proc/on_deployed_destroyed()
	SIGNAL_HANDLER
	remove_deployable()
	deployable = null

/// Прячем предмет из слота или откуда-либо ещё.
/datum/component/attached_clothing/proc/remove_deployable()
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
/datum/component/attached_clothing/proc/unequip_deployable()
	if (!deployable)
		return
	if (!ishuman(deployable.loc))
		deployable.forceMove(parent)
		return
	var/mob/living/carbon/human/wearer = deployable.loc
	UnregisterSignal(wearer, COMSIG_MOB_EQUIPPED_SOME_ITEMS)
	wearer.transferItemToLoc(deployable, parent, force = TRUE, silent = TRUE)
