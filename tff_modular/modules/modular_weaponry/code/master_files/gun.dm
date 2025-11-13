/obj/item/gun

	///If you can examine a gun to see its current ammo count
	var/ammo_counter = FALSE


	///Screen shake when the weapon is fired while unwielded.
	var/recoil_unwielded = 0
	///a multiplier of the duration the recoil takes to go back to normal view, this is (recoil*recoil_backtime_multiplier)+1
	var/recoil_backtime_multiplier = 2
	///this is how much deviation the gun recoil can have, recoil pushes the screen towards the reverse angle you shot + some deviation which this is the max.
	var/recoil_deviation = 22.5

	///Used if the guns recoil is lower then the min, it clamps the highest recoil
	var/min_recoil = 0
	///if we want a min recoil (or lack of it) whilst aiming
	var/min_recoil_aimed = 0


	///How much the bullet scatters when fired while unwielded.
	var/spread_unwielded = 5


	var/battery_damage_multiplier = 1

	//true if the gun is wielded via twohanded component, shouldnt affect anything else
	var/wielded = FALSE
	//true if the gun is wielded after delay, should affects accuracy
	var/wielded_fully = FALSE
	///Slowdown for wielding
	var/wield_slowdown = NO_SLOWDOWN
	///slowdown for aiming whilst wielding
	var/aimed_wield_slowdown = NO_SLOWDOWN
	/// Reference to the offhand created for the item
	var/obj/item/offhand/offhand_item = null

	/*
 *  Attachment
*/

//Spawn Info (Stuff that becomes useless onces the gun is spawned, mostly here for mappers)
	///Attachments spawned on initialization. Should also be in valid attachments or it SHOULD(once i add that) fail
	var/list/default_attachments = list()

	///The types of attachments allowed, a list of types. SUBTYPES OF AN ALLOWED TYPE ARE ALSO ALLOWED.
	var/list/valid_attachments = list(
		/obj/item/attachment/ammo_counter,
	)
	///The types of attachments that are unique to this gun. Adds it to the base valid_attachments list. So if this gun takes a special stock, add it here.
	var/list/unique_attachments = list()
	///The types of attachments that aren't allowed. Removes it from the base valid_attachments list.
	var/list/refused_attachments
	///Number of attachments that can fit on a given slot
	var/list/slot_available = ATTACHMENT_DEFAULT_SLOT_AVAILABLE
	///Offsets for the slots on this gun. should be indexed by SLOT and then by X/Y
	var/list/slot_offsets = list()
	var/underbarrel_prefix = "" // so the action has the right icon for underbarrel gun


	/// after initializing, we set the firemode to this
	var/default_firemode = FIREMODE_SEMIAUTO
	///Firemode index, due to code shit this is the currently selected firemode
	var/firemode_index
	/// Our firemodes, subtract and add to this list as needed. NOTE that the autofire component is given on init when FIREMODE_FULLAUTO is here.
	//full list: FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_FULLAUTO, FIREMODE_OTHER, FIREMODE_OTHER_TWO
	var/list/gun_firemodes = list(FIREMODE_SEMIAUTO)
	/// A acoc list that determines the names of firemodes. Use if you wanna be weird and set the name of say, FIREMODE_OTHER to "Underbarrel grenade launcher" for example.
	var/list/gun_firenames = list(FIREMODE_SEMIAUTO = "single", FIREMODE_BURST = "burst fire", FIREMODE_FULLAUTO = "full auto", FIREMODE_OTHER = "misc. fire", FIREMODE_OTHER_TWO = "very misc. fire", FIREMODE_UNDERBARREL = "underbarrel weapon")
	///BASICALLY: the little button you select firing modes from? this is jsut the prefix of the icon state of that. For example, if we set it as "laser", the fire select will use "laser_single" and so on.
	var/fire_select_icon_state_prefix = ""
	///If true, we put "safety_" before fire_select_icon_state_prefix's prefix. ex. "safety_laser_single"
	var/adjust_fire_select_icon_state_on_safety = FALSE

	///Are we firing a burst? If so, dont fire again until burst is done
	var/currently_firing_burst = FALSE
	///This prevents gun from firing until the coodown is done, affected by lag
	var/current_cooldown = 0

/obj/item/gun/Initialize(mapload)
	. = ..()
	var/list/attachment_list = valid_attachments
	attachment_list += unique_attachments
	if(refused_attachments)
		for(var/to_remove in attachment_list)
			if(refused_attachments.Find(to_remove))
				attachment_list -= to_remove

	if(GetComponent(/datum/component/automatic_fire) && !(FIREMODE_FULLAUTO in gun_firemodes))
		gun_firemodes += FIREMODE_FULLAUTO

	build_firemodes()

	if(weapon_weight < WEAPON_MEDIUM && (/obj/item/attachment/sling in valid_attachments))
		valid_attachments -= /obj/item/attachment/sling

	AddComponent(/datum/component/attachment_holder, slot_available, attachment_list, slot_offsets, default_attachments)
	RegisterSignal(src, COMSIG_KB_MOB_WEAPON_WIELD, PROC_REF(on_wield))

/obj/item/gun/Destroy()
	if(offhand_item)
		qdel(offhand_item)
	return ..()

/obj/item/gun/dropped(mob/user)
	. = ..()
	on_unwield(src, user)
	update_appearance()

/obj/item/gun/equipped(mob/living/user, slot)
	. = ..()
	if(offhand_item)
		qdel(offhand_item)

/obj/item/gun/examine_more(mob/user)
	. = ..()
	. += span_info("Оружие можно взять в двуручный хват по нажатию CTRL + E. Изменить режим стрельбы, если такое доступно, можно нажав SHIFT + SPACE. Обе комбинации можно изменить в настройках.")
	if(atom_integrity < max_integrity)
		. += span_info("Используя сварку можно отремонтировать.")
	if(GetComponent(/datum/component/gun_safety))
		. += span_info("Используя кусачки можно спилить предохранитель с оружия.")
	if(istype(src, /obj/item/gun/energy))
		. += span_info("У этого оружия можно открыть слот для батареи с помощью отвертки.")
	//. += "Если на оружии надет обвес - его можно снять нажав ALT + ЛКМ в боевом режиме."
	if(gun_firemodes.len > 1)
		. += "You can change the [src]'s firemode by pressing the <b>secondary action</b> key. By default, this is <b>Shift + Space</b>"

/obj/item/gun/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(HAS_TRAIT(user, TRAIT_USER_SCOPED) && !is_wielded())
		bonus_spread += 10
	return ..()

/// triggered on wield of two handed item
/obj/item/gun/proc/on_wield(obj/item/source, mob/user)
	user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/gun, multiplicative_slowdown = wield_slowdown)
	wielded_fully = TRUE
	wielded = TRUE

	// Let's reserve the other hand
	offhand_item = new(user)
	offhand_item.name = "[name] - offhand"
	offhand_item.wielded = TRUE
	user.put_in_inactive_hand(offhand_item)

/obj/item/gun/proc/do_wield(mob/user)
	var/obj/item/bodypart/other_hand = user.has_hand_for_held_index(user.get_inactive_hand_index()) //returns non-disabled inactive hands
	if((user.get_inactive_held_item() || !other_hand) && !istype(user.get_inactive_held_item(), offhand_item))
		balloon_alert(user, "you need both hands!")
		return FALSE
	if(!wielded)
		on_wield(src, user)
	else
		on_unwield(src, user)
	balloon_alert(user, wielded ? "wielded" : "unwielded")
	return TRUE

/// triggered on unwield of two handed item
/obj/item/gun/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE
	wielded_fully = FALSE
	try_stop_zooming(user, GetComponent(/datum/component/scope))
	user.remove_movespeed_modifier(/datum/movespeed_modifier/gun)
	qdel(offhand_item)

/obj/item/gun/proc/try_stop_zooming(mob/user, datum/component/scope/zoom)
	if(zoom)
		zoom.stop_zooming(user)
	return

/obj/item/gun/proc/is_wielded()
	return wielded

/obj/item/gun/proc/process_other(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	return //use this for 'underbarrels!!

/obj/item/gun/proc/process_other_two(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	return //reserved in case another fire mode is needed, if you need special behavior, put it here then call process_fire, or call process_fire and have the special behavior there

/obj/item/gun/proc/build_firemodes()
	if(FIREMODE_FULLAUTO in gun_firemodes)
		default_firemode = FIREMODE_FULLAUTO
		if(!GetComponent(/datum/component/automatic_fire))
			AddComponent(/datum/component/automatic_fire, fire_delay)
	if(burst_size > 1 && !(FIREMODE_BURST in gun_firemodes))
		default_firemode = FIREMODE_BURST
		LAZYADD(gun_firemodes, FIREMODE_BURST)

	for(var/datum/action/item_action/toggle_firemode/old_firemode in actions)
		old_firemode.Destroy()
	//TODO: подствольники gun_attachment
	//if(gun_firemodes.len > 1)
	//	add_item_action(/datum/action/item_action/toggle_firemode)

	for(var/i=1, i <= gun_firemodes.len+1, i++)
		if(default_firemode == gun_firemodes[i])
			firemode_index = i
			if(gun_firemodes[i] == FIREMODE_FULLAUTO)
				SEND_SIGNAL(src, COMSIG_GUN_ENABLE_AUTOFIRE)
			return

	firemode_index = 1
	CRASH("default_firemode isn't in the gun_firemodes list of [src.type]!! Defaulting to 1!!")

/obj/item/gun/proc/fire_select(mob/living/carbon/human/user)
	firemode_index++
	if(firemode_index > gun_firemodes.len)
		firemode_index = 1 //reset to the first index if it's over the limit. Byond arrays start at 1 instead of 0, hence why its set to 1.

	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode == FIREMODE_FULLAUTO)
		SEND_SIGNAL(src, COMSIG_GUN_ENABLE_AUTOFIRE)
	else
		SEND_SIGNAL(src, COMSIG_GUN_DISABLE_AUTOFIRE)

//wawa
	to_chat(user, span_notice("Switched to [gun_firenames[current_firemode]]."))
	playsound(user, SFX_FIRE_MODE_SWITCH, 100, TRUE)
	update_appearance()
	for(var/datum/action/current_action as anything in actions)
		current_action.build_all_button_icons(UPDATE_BUTTON_STATUS)

/obj/item/gun/secondary_action(user)
	if(gun_firemodes.len > 1)
		fire_select(user)

///Intended for interactions with guns, like swapping firemodes
/obj/item/proc/secondary_action(mob/living/user)

///Called before unique action, if any other associated items should do a secondary action or override it.
/obj/item/proc/pre_secondary_action(mob/living/user)
	if(SEND_SIGNAL(src,COMSIG_CLICK_SECONDARY_ACTION,user) & OVERRIDE_SECONDARY_ACTION)
		return TRUE
	return FALSE //return true if the proc should end here


/obj/item/gun/wirecutter_act(mob/living/user, obj/item/I)
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	if(GetComponent(/datum/component/gun_safety) && user.is_holding(src))
		user.visible_message(span_warning("[user] attempts to remove gun safety from [src] with [I]."),
		span_notice("You attempt to remove gun safety from [src]."), null, 3)
		if(I.use_tool(src, user, 3 SECONDS, volume = 50))
			if(GetComponent(/datum/component/gun_safety)) //check to see if the gun safety is still there, or we can spam messages by clicking multiple times during the tool delay
				user.visible_message(span_notice("Gun safety removed out of [src] by [user]."),
									span_warning("You pry gun safity out with [I]."), null, 3)
				qdel(GetComponent(/datum/component/gun_safety))
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/welder_act(mob/living/user, obj/item/I)
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	if(atom_integrity < max_integrity)
		user.visible_message(span_warning("[user] attempts to repair [src] with [I]."),
		span_notice("You attempt to repair [src]."), null, 3)
		if(I.use_tool(src, user, 3 SECONDS, volume = 50))
			user.visible_message(span_notice("[src] was repaired by [user]."),
								span_warning("You repair [src] with [I]."), null, 3)
			repair_damage(20)
			return ITEM_INTERACT_SUCCESS
