/obj/item/gun

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

/*
 *  Zooming
*/
	///Whether the gun generates a Zoom action on creation
	var/zoomable = FALSE
	//Zoom toggle
	var/zoomed = FALSE
	///Distance in TURFs to move the user's screen forward (the "zoom" effect)
	var/zoom_amt = 3
	var/zoom_out_amt = 0
	var/datum/action/toggle_scope_zoom/azoom

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
	if(zoomed)
		zoom(user, user.dir)

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



/// triggered on wield of two handed item
/obj/item/gun/proc/on_wield(obj/item/source, mob/user)
	user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/gun, multiplicative_slowdown = wield_slowdown)
	if(azoom)
		azoom.Grant(user)
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
	user.remove_movespeed_modifier(/datum/movespeed_modifier/gun)
	qdel(offhand_item)
	if(azoom)
		azoom.Remove(user)

/obj/item/gun/proc/is_wielded()
	return wielded

/obj/item/gun/proc/process_other(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	return //use this for 'underbarrels!!

/obj/item/gun/proc/process_other_two(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	return //reserved in case another fire mode is needed, if you need special behavior, put it here then call process_fire, or call process_fire and have the special behavior there

/obj/item/gun/proc/build_firemodes()
	if(FIREMODE_FULLAUTO in gun_firemodes)
		if(!GetComponent(/datum/component/automatic_fire))
			AddComponent(/datum/component/automatic_fire, fire_delay)
		default_firemode = FIREMODE_FULLAUTO
		SEND_SIGNAL(src, COMSIG_GUN_ENABLE_AUTOFIRE)
	if(burst_size > 1 && !(FIREMODE_BURST in gun_firemodes))
		default_firemode = FIREMODE_BURST
		LAZYADD(gun_firemodes, FIREMODE_BURST)
	for(var/datum/action/item_action/toggle_firemode/old_firemode in actions)
		old_firemode.Destroy()
	var/datum/action/item_action/our_action

	if(gun_firemodes.len > 1)
		our_action = new /datum/action/item_action/toggle_firemode(src)

	for(var/i=1, i <= gun_firemodes.len+1, i++)
		if(default_firemode == gun_firemodes[i])
			firemode_index = i
			if(gun_firemodes[i] == FIREMODE_FULLAUTO)
				SEND_SIGNAL(src, COMSIG_GUN_ENABLE_AUTOFIRE)
			if(our_action)
				our_action.build_all_button_icons(UPDATE_BUTTON_STATUS)
			return

	firemode_index = 1
	CRASH("default_firemode isn't in the gun_firemodes list of [src.type]!! Defaulting to 1!!")

//I need to refactor this into an attachment
/datum/action/toggle_scope_zoom
	name = "Aim Down Sights"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING
	button_icon = 'tff_modular/modules/modular_weaponry/icons/actions_items.dmi'
	button_icon_state = "sniper_zoom"

/datum/action/toggle_scope_zoom/Trigger(trigger_flags)
	if(!istype(target, /obj/item/gun) || !..())
		return

	var/obj/item/gun/gun = target
	gun.zoom(owner, owner.dir)
	gun.min_recoil = gun.min_recoil_aimed

/datum/action/toggle_scope_zoom/Remove(mob/user)
	if(!istype(target, /obj/item/gun))
		return ..()

	var/obj/item/gun/gun = target
	gun.zoom(user, user.dir, FALSE)

	..()

/obj/item/gun/proc/rotate(atom/thing, old_dir, new_dir)
	SIGNAL_HANDLER

	if(ismob(thing))
		var/mob/lad = thing
		lad.client.view_size.zoomOut(zoom_out_amt, zoom_amt, new_dir)

/obj/item/gun/proc/zoom(mob/living/user, direc, forced_zoom)
	if(!user || !user.client)
		return

	if(isnull(forced_zoom))
		if((!zoomed && wielded_fully) || zoomed)
			zoomed = !zoomed
		else
			to_chat(user, span_danger("You can't look down the sights without wielding [src]!"))
			zoomed = FALSE
	else
		zoomed = forced_zoom

	if(zoomed)
		RegisterSignal(user, COMSIG_ATOM_DIR_CHANGE, PROC_REF(rotate))
		ADD_TRAIT(user, TRAIT_AIMING, REF(src))
		user.client.view_size.zoomOut(zoom_out_amt, zoom_amt, direc)
		min_recoil = min_recoil_aimed
		user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/aiming, multiplicative_slowdown = aimed_wield_slowdown)
	else
		UnregisterSignal(user, COMSIG_ATOM_DIR_CHANGE)
		REMOVE_TRAIT(user, TRAIT_AIMING, REF(src))
		user.client.view_size.zoomIn()
		min_recoil = initial(min_recoil)
		user.remove_movespeed_modifier(/datum/movespeed_modifier/aiming)
	return zoomed

//Proc, so that gun accessories/scopes/etc. can easily add zooming.
/obj/item/gun/proc/build_zooming()
	if(azoom)
		return

	if(zoomable)
		azoom = new(src)

/obj/item/gun/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/toggle_firemode))
		fire_select(user)
	else
		..()

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

/obj/item/gun/proc/calculate_recoil(mob/user, recoil_bonus = 0)
	return clamp(recoil_bonus, min_recoil , INFINITY)

/obj/item/gun/proc/calculate_spread(mob/user, bonus_spread)
	var/final_spread = 0
	var/randomized_gun_spread = 0
	var/randomized_bonus_spread = 0

	final_spread += bonus_spread

	//We will then calculate gun spread depending on if we are fully wielding (after do_after) the gun or not
	randomized_gun_spread =	rand(0, wielded_fully ? spread : spread_unwielded)

	final_spread += randomized_gun_spread + randomized_bonus_spread

	//Clamp it down to avoid guns with negative spread to have worse recoil...
	final_spread = clamp(final_spread, 0, INFINITY)

	//So spread isn't JUST to the right
	if(prob(50))
		final_spread *= -1

	final_spread = round(final_spread)

	return final_spread

/obj/item/gun/secondary_action(user)
	if(gun_firemodes.len > 1)
		fire_select(user)

/datum/action/item_action/toggle_firemode/build_all_button_icons(status_only = FALSE, force = FALSE)
	var/obj/item/gun/our_gun = target

	var/current_firemode = our_gun.gun_firemodes[our_gun.firemode_index]
	if(current_firemode == FIREMODE_UNDERBARREL)
		button_icon_state = "[our_gun.underbarrel_prefix][current_firemode]"
	else
		button_icon_state = "[our_gun.fire_select_icon_state_prefix][current_firemode]"
	return ..()

/obj/item/gun/equipped(mob/living/user, slot)
	. = ..()
	if(zoomed && user.get_active_held_item() != src)
		zoom(user, user.dir, FALSE) //we can only stay zoomed in if it's in our hands	//yeah and we only unzoom if we're actually zoomed using the gun!!

/proc/recoil_camera(mob/recoilster, duration, backtime_duration, strength, angle)
	if(!recoilster || !recoilster.client)
		return
	strength *= world.icon_size
	var/client/client_to_shake = recoilster.client
	var/oldx = client_to_shake.pixel_x
	var/oldy = client_to_shake.pixel_y

	//get pixels to move the camera in an angle
	var/mpx = sin(angle) * strength
	var/mpy = cos(angle) * strength
	animate(client_to_shake, pixel_x = oldx+mpx, pixel_y = oldy+mpy, time = duration, flags = ANIMATION_RELATIVE)
	animate(pixel_x = oldx, pixel_y = oldy, time = backtime_duration, easing = BACK_EASING)

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
