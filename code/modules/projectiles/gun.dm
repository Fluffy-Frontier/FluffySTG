#define DUALWIELD_PENALTY_EXTRA_MULTIPLIER 1.4
#define FIRING_PIN_REMOVAL_DELAY 50

/obj/item/gun
	name = "gun"
	desc = "It's a gun. It's pretty terrible, though."
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "revolver"
	inhand_icon_state = "gun"
	worn_icon_state = "gun"
	abstract_type = /obj/item/gun
	obj_flags = CONDUCTS_ELECTRICITY
	appearance_flags = TILE_BOUND|PIXEL_SCALE|LONG_GLIDE|KEEP_TOGETHER
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	force = 5
	item_flags = NEEDS_PERMIT
	attack_verb_continuous = list("strikes", "hits", "bashes")
	attack_verb_simple = list("strike", "hit", "bash")
	action_slots = ALL

	var/gun_flags = NONE
	var/fire_sound = 'sound/items/weapons/gun/pistol/shot.ogg'
	var/vary_fire_sound = TRUE
	var/fire_sound_volume = 50
	var/dry_fire_sound = 'sound/items/weapons/gun/general/dry_fire.ogg'
	var/dry_fire_sound_volume = 30
	var/suppressed = null //whether or not a message is displayed when fired
	var/can_suppress = FALSE
	var/suppressed_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	var/suppressed_volume = 60
	/// whether a gun can be unsuppressed. for ballistics, also determines if it generates a suppressor overlay
	var/can_unsuppress = TRUE
	var/recoil = 0 //boom boom shake the room
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

	var/clumsy_check = TRUE
	var/obj/item/ammo_casing/chambered = null
	trigger_guard = TRIGGER_GUARD_NORMAL //trigger guard on the weapon, hulks can't fire them with their big meaty fingers
	var/sawn_desc = null //description change if weapon is sawn-off
	var/sawn_off = FALSE
	var/burst_size = 1 //how large a burst is
	/// Delay between shots in a burst.
	var/burst_delay = 2
	/// Delay between bursts (if burst-firing) or individual shots (if weapon is single-fire).
	var/fire_delay = 0
	var/firing_burst = 0 //Prevent the weapon from firing again while already firing
	/// firing cooldown, true if this gun shouldn't be allowed to manually fire
	var/fire_cd = 0
	var/weapon_weight = WEAPON_LIGHT
	var/dual_wield_spread = 24 //additional spread when dual wielding
	///Can we hold up our target with this? Default to yes
	var/can_hold_up = TRUE
	/// If TRUE, and we aim at ourselves, it will initiate a do after to fire at ourselves.
	/// If FALSE it will just try to fire at ourselves straight up.
	var/doafter_self_shoot = TRUE

	/// Just 'slightly' snowflakey way to modify projectile damage for projectiles fired from this gun.
	var/projectile_damage_multiplier = 1
	var/battery_damage_multiplier = 1

	/// Even snowflakier way to modify projectile wounding bonus/potential for projectiles fired from this gun.
	var/projectile_wound_bonus = 0

	/// The most reasonable way to modify projectile speed values for projectile fired from this gun. Honest.
	/// Lower values are worse, higher values are better.
	var/projectile_speed_multiplier = 1

	var/spread = 0 //Spread induced by the gun itself.
	///How much the bullet scatters when fired while unwielded.
	var/spread_unwielded = 12

	var/randomspread = 1 //Set to 0 for shotguns. This is used for weapons that don't fire all their bullets at once.

	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'

	var/obj/item/firing_pin/pin = /obj/item/firing_pin //standard firing pin for most guns
	/// True if a gun dosen't need a pin, mostly used for abstract guns like tentacles and meathooks
	var/pinless = FALSE

	var/ammo_x_offset = 0 //used for positioning ammo count overlay on sprite
	var/ammo_y_offset = 0

	var/pb_knockback = 0

	//true if the gun is wielded via twohanded component, shouldnt affect anything else
	var/wielded = FALSE
	//true if the gun is wielded after delay, should affects accuracy
	var/wielded_fully = FALSE
	///Slowdown for wielding
	var/wield_slowdown = 0.1
	///slowdown for aiming whilst wielding
	var/aimed_wield_slowdown = 0.1
	/// Reference to the offhand created for the item
	var/obj/item/offhand/offhand_item = null


// BALLISTIC
	///Actual magazine currently contained within the gun
	var/obj/item/ammo_box/magazine/magazine
	///Whether the gun has to be racked each shot or not.
	var/semi_auto = TRUE
	///The bolt type of the gun, affects quite a bit of functionality, see gun.dm in defines for bolt types: BOLT_TYPE_STANDARD; BOLT_TYPE_LOCKING; BOLT_TYPE_OPEN; BOLT_TYPE_NO_BOLT
	var/bolt_type = BOLT_TYPE_STANDARD
	///Used for locking bolt and open bolt guns. Set a bit differently for the two but prevents firing when true for both.
	var/bolt_locked = FALSE
	///Phrasing of the bolt in examine and notification messages; ex: bolt, slide, etc.
	var/bolt_wording = "bolt"
	///length between individual racks
	var/rack_delay = 5
	///time of the most recent rack, used for cooldown purposes
	var/recent_rack = 0

	///Whether the gun can be sawn off by sawing tools
	var/can_be_sawn_off = FALSE

		///sound when inserting magazine
	var/load_sound = 'sound/items/weapons/gun/general/magazine_insert_full.ogg'
	///sound when inserting an empty magazine
	var/load_empty_sound = 'sound/items/weapons/gun/general/magazine_insert_empty.ogg'
	///volume of loading sound
	var/load_sound_volume = 40
	///whether loading sound should vary
	var/load_sound_vary = TRUE

	///sound of racking
	var/rack_sound = 'sound/items/weapons/gun/general/bolt_rack.ogg'
	///volume of racking
	var/rack_sound_volume = 60
	///whether racking sound should vary
	var/rack_sound_vary = TRUE
	///sound of when the bolt is locked back manually
	var/lock_back_sound = 'sound/items/weapons/gun/general/slide_lock_1.ogg'
	///volume of lock back
	var/lock_back_sound_volume = 60
	///whether lock back varies
	var/lock_back_sound_vary = TRUE

	///sound of dropping the bolt or releasing a slide
	var/bolt_drop_sound = 'sound/items/weapons/gun/general/bolt_drop.ogg'
	///volume of bolt drop/slide release
	var/bolt_drop_sound_volume = 60
	///Whether the gun alarms when empty or not.
	var/empty_alarm = FALSE
	///empty alarm sound (if enabled)
	var/empty_alarm_sound = 'sound/items/weapons/gun/general/empty_alarm.ogg'
	///empty alarm volume sound
	var/empty_alarm_volume = 70
	///whether empty alarm sound varies
	var/empty_alarm_vary = TRUE

//ENERGY
	/// What type of power cell this uses
	var/obj/item/stock_parts/power_store/cell
	var/cell_type = /obj/item/stock_parts/power_store/cell
	///if the gun's cell cannot be replaced
	var/internal_cell = FALSE
	///if the weapon has custom icons for individual ammo types it can switch between. ie disabler beams, taser, laser/lethals, ect.
	var/modifystate = FALSE
	var/list/ammo_type = list(/obj/item/ammo_casing/energy)
	///The state of the select fire switch. Determines from the ammo_type list what kind of shot is fired next.
	var/select = 1
	///If the user can select the firemode through attack_self.
	var/can_select = TRUE
	///Can it be charged in a recharger?
	var/can_charge = TRUE
	///Do we handle overlays with base update_icon()?
	var/automatic_charge_overlays = TRUE
	var/charge_sections = 4
	//if this gun uses a stateful charge bar for more detail
	var/shaded_charge = FALSE

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

	///Whether the gun can be tacloaded by slapping a fresh magazine directly on it
	var/tac_reloads = TRUE
	///Whether the gun has an internal magazine or a detatchable one. Overridden by BOLT_TYPE_NO_BOLT.
	var/internal_magazine = FALSE
	///If we have the 'snowflake mechanic,' how long should it take to reload?
	var/tactical_reload_delay = 1 SECONDS

	/// Cooldown for the visible message sent from gun flipping.
	COOLDOWN_DECLARE(flip_cooldown)

/obj/item/gun/Initialize(mapload)
	. = ..()
	if(ispath(pin))
		pin = new pin
		pin.gun_insert(new_gun = src)

	var/list/attachment_list = valid_attachments
	attachment_list += unique_attachments
	if(refused_attachments)
		for(var/to_remove in attachment_list)
			if(refused_attachments.Find(to_remove))
				attachment_list -= to_remove

	build_firemodes()
	AddComponent(/datum/component/attachment_holder, slot_available, attachment_list, slot_offsets, default_attachments)

	add_seclight_point()
	give_gun_safeties()
	add_bayonet_point()
	RegisterSignal(src, COMSIG_KB_MOB_WEAPON_WIELD, PROC_REF(on_wield))

/obj/item/gun/Destroy()
	if(isobj(pin)) //Can still be the initial path, then we skip
		QDEL_NULL(pin)
	if(chambered) //Not all guns are chambered (EMP'ed energy guns etc)
		QDEL_NULL(chambered)
	if(isatom(suppressed)) //SUPPRESSED IS USED AS BOTH A TRUE/FALSE AND AS A REF, WHAT THE FUCKKKKKKKKKKKKKKKKK
		QDEL_NULL(suppressed)
	if(offhand_item)
		qdel(offhand_item)
	return ..()

/obj/item/gun/apply_fantasy_bonuses(bonus)
	. = ..()
	fire_delay = modify_fantasy_variable("fire_delay", fire_delay, -bonus, 0)
	burst_delay = modify_fantasy_variable("burst_delay", burst_delay, -bonus, 0)
	projectile_damage_multiplier = modify_fantasy_variable("projectile_damage_multiplier", projectile_damage_multiplier, bonus/10, 0.1)

/obj/item/gun/remove_fantasy_bonuses(bonus)
	fire_delay = reset_fantasy_variable("fire_delay", fire_delay)
	burst_delay = reset_fantasy_variable("burst_delay", burst_delay)
	projectile_damage_multiplier = reset_fantasy_variable("projectile_damage_multiplier", projectile_damage_multiplier)
	return ..()

/obj/item/gun/dropped(mob/user)
	. = ..()
	on_unwield(src, user)

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

/// Handles adding [the seclite mount component][/datum/component/seclite_attachable] to the gun.
/// If the gun shouldn't have a seclight mount, override this with a return.
/// Or, if a child of a gun with a seclite mount has slightly different behavior or icons, extend this.
/obj/item/gun/proc/add_seclight_point()
	return

/// Similarly to add_seclight_point(), handles [the bayonet attachment component][/datum/component/bayonet_attachable]
/obj/item/gun/proc/add_bayonet_point()
	return

/obj/item/gun/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == pin)
		pin = null
	if(gone == chambered)
		chambered = null
		update_appearance()
	if(gone == suppressed)
		clear_suppressor()

///Clears var and updates icon. In the case of ballistic weapons, also updates the gun's weight.
/obj/item/gun/proc/clear_suppressor()
	if(!can_unsuppress)
		return
	suppressed = null
	update_appearance()

/obj/item/gun/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(isliving(hit_atom))
		var/mob/living/thrower = throwingdatum?.get_thrower()
		toss_gun_hard(thrower, hit_atom)

/obj/item/gun/proc/toss_gun_hard(mob/living/thrower, mob/living/target) //throw a gun at them. They don't expect it.
	if(isnull(thrower))
		return FALSE
	if(!HAS_TRAIT(thrower, TRAIT_TOSS_GUN_HARD))
		return FALSE
	target.Knockdown(0.5 SECONDS)
	target.apply_damage(damage = max(w_class * 5 - throwforce, 10), damagetype = BRUTE, def_zone = thrower.zone_selected, wound_bonus = CANT_WOUND, attacking_item = src)
	return TRUE

/obj/item/gun/examine(mob/user)
	. = ..()
	. += span_info("Оружие можно взять в двуручный хват по нажатию CTRL + E. Изменить режим стрельбы, если такое доступно, можно нажав SHIFT + SPACE. Обе комбинации можно изменить в настройках.")
	if(atom_integrity < max_integrity)
		. += span_info("Используя сварку можно отремонтировать.")
	if(GetComponent(/datum/component/gun_safety))
		. += span_info("Используя кусачки можно спилить предохранитель с оружия.")
	if(istype(src, /obj/item/gun/energy))
		. += span_info("У этого оружия можно открыть слот для батареи с помощью отвертки.")
	if(cell)
		. += span_info("It has [cell.name] installed")
	//. += "Если на оружии надет обвес - его можно снять нажав ALT + ЛКМ в боевом режиме."
	if(!pinless)
		if(pin)
			. += "It has \a [pin] installed."
			if(pin.pin_removable)
				. += span_info("[pin] looks like [pin.p_they()] could be removed with some <b>tools</b>.")
			else
				. += span_info("[pin] looks like [pin.p_theyre()] firmly locked in, [pin.p_they()] looks impossible to remove.")
		else
			. += "It doesn't have a <b>firing pin</b> installed, and won't fire."

	var/healthpercent = (atom_integrity/max_integrity) * 100
	switch(healthpercent)
		if(60 to 95)
			. += span_info("It looks slightly damaged.")
		if(25 to 60)
			. += span_warning("It appears heavily damaged.")
		if(0 to 25)
			. += span_boldwarning("It's falling apart!")

/obj/item/gun/examine_more(mob/user)
	. = ..()
	if(gun_firemodes.len > 1)
		. += "You can change the [src]'s firemode by pressing the <b>secondary action</b> key. By default, this is <b>Shift + Space</b>"


//called after the gun has successfully fired its chambered ammo.
/obj/item/gun/proc/process_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	handle_chamber(empty_chamber, from_firing, chamber_next_round)
	SEND_SIGNAL(src, COMSIG_GUN_CHAMBER_PROCESSED)

/obj/item/gun/proc/handle_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	return

//check if there's enough ammo/energy/whatever to shoot one time
//i.e if clicking would make it shoot
/obj/item/gun/proc/can_shoot()
	return TRUE

/obj/item/gun/proc/tk_firing(mob/living/user)
	return !user.contains(src)

/obj/item/gun/proc/shoot_with_empty_chamber(mob/living/user as mob|obj)
	balloon_alert_to_viewers("*click*")
	playsound(src, dry_fire_sound, dry_fire_sound_volume, TRUE)

/obj/item/gun/proc/fire_sounds()
	if(suppressed)
		playsound(src, suppressed_sound, suppressed_volume, vary_fire_sound, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(src, fire_sound, fire_sound_volume, vary_fire_sound)

/obj/item/gun/proc/shoot_live_shot(mob/living/user, pointblank = FALSE, atom/pbtarget = null, message = TRUE)
	if(recoil && !tk_firing(user))
		shake_camera(user, recoil + 1, wielded_fully ? recoil : recoil_unwielded)
	fire_sounds()
	if(suppressed || !message)
		return FALSE
	if(tk_firing(user))
		visible_message(
			span_danger("[src] fires itself[pointblank ? " point blank at [pbtarget]!" : "!"]"),
			blind_message = span_hear("You hear a gunshot!"),
			vision_distance = COMBAT_MESSAGE_RANGE
		)
	else if(pointblank)
		if(user == pbtarget)
			user.visible_message(
				span_danger("[user] fires [src] point blank at [user.p_them()]self!"),
				span_userdanger("You fire [src] point blank at yourself!"),
				span_hear("You hear a gunshot!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
				visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			)
		else
			user.visible_message(
				span_danger("[user] fires [src] point blank at [pbtarget]!"),
				span_danger("You fire [src] point blank at [pbtarget]!"),
				span_hear("You hear a gunshot!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
				ignored_mobs = pbtarget,
				visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			)
			to_chat(pbtarget, span_userdanger("[user] fires [src] point blank at you!"))
		if(pb_knockback > 0 && ismob(pbtarget))
			var/mob/PBT = pbtarget
			var/atom/throw_target = get_edge_target_turf(PBT, user.dir)
			PBT.throw_at(throw_target, pb_knockback, 2)
	else if(!tk_firing(user))
		user.visible_message(
			span_danger("[user] fires [src]!"),
			span_danger("You fire [src]!"),
			span_hear("You hear a gunshot!"),
			vision_distance = COMBAT_MESSAGE_RANGE,
			ignored_mobs = user,
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

	if(chambered?.integrity_damage)
		take_damage(chambered.integrity_damage, sound_effect = FALSE)
	return TRUE

/obj/item/gun/atom_destruction(damage_flag)
	if(!isliving(loc))
		return ..()
	var/mob/living/holder = loc
	if(holder.is_holding(src) && holder.stat < UNCONSCIOUS)
		to_chat(holder, span_boldwarning("[src] breaks down!"))
		holder.playsound_local(get_turf(src), 'sound/items/weapons/smash.ogg', 50, TRUE)
	return ..()

/obj/item/gun/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		for(var/obj/inside in contents)
			inside.emp_act(severity)

/obj/item/gun/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(.)
		return

	if(pinless)
		return

	if(!HAS_TRAIT(user, TRAIT_GUNFLIP))
		return

	SpinAnimation(4, 2) // The spin happens regardless of the cooldown

	if(!COOLDOWN_FINISHED(src, flip_cooldown))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	COOLDOWN_START(src, flip_cooldown, 3 SECONDS)
	if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(40))
		// yes this will sound silly for bows and wands, but that's a "gun" moment for you
		user.visible_message(
			span_danger("While trying to flip [src] [user] pulls the trigger accidentally!"),
			span_userdanger("While trying to flip [src] you pull the trigger accidentally!"),
		)
		process_fire(user, user, FALSE, user.get_random_valid_zone(even_weights = TRUE))
		user.dropItemToGround(src, TRUE)
	else
		user.visible_message(
			span_notice("[user] spins [src] around [user.p_their()] finger by the trigger. That's pretty badass."),
			span_notice("You spin [src] around your finger by the trigger. That's pretty badass."),
		)
		playsound(src, 'sound/items/handling/ammobox_pickup.ogg', 20, FALSE)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/gun/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(try_fire_gun(interacting_with, user, list2params(modifiers)))
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/gun/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.combat_mode && isliving(interacting_with))
		return ITEM_INTERACT_SKIP_TO_ATTACK // Gun bash / bayonet attack

	if(!can_hold_up || !isliving(interacting_with))
		return interact_with_atom(interacting_with, user, modifiers)

	var/datum/component/gunpoint/gunpoint_component = user.GetComponent(/datum/component/gunpoint)
	if (gunpoint_component)
		balloon_alert(user, "already holding [gunpoint_component.target == interacting_with ? "them" : "someone"] up!")
		return ITEM_INTERACT_BLOCKING
	if (user == interacting_with)
		balloon_alert(user, "can't hold yourself up!")
		return ITEM_INTERACT_BLOCKING

	if(do_after(user, 0.5 SECONDS, interacting_with))
		user.AddComponent(/datum/component/gunpoint, interacting_with, src)
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(try_fire_gun(interacting_with, user, list2params(modifiers)))
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/gun/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(IN_GIVEN_RANGE(user, interacting_with, GUNPOINT_SHOOTER_STRAY_RANGE))
		return interact_with_atom_secondary(interacting_with, user, modifiers)
	return ..()

/obj/item/gun/proc/try_fire_gun(atom/target, mob/living/user, params)
	return fire_gun(target, user, user.Adjacent(target), params)

/obj/item/gun/proc/fire_gun(atom/target, mob/living/user, flag, params)
	if(QDELETED(target))
		return
	if(firing_burst)
		return

	if(SEND_SIGNAL(user, COMSIG_MOB_TRYING_TO_FIRE_GUN, src, target, flag, params) & COMPONENT_CANCEL_GUN_FIRE)
		return

	if(SEND_SIGNAL(src, COMSIG_GUN_TRY_FIRE, user, target, flag, params) & COMPONENT_CANCEL_GUN_FIRE)
		return
	if(flag) //It's adjacent, is the user, or is on the user's person
		if(target in user.contents) //can't shoot stuff inside us.
			return
		if(!ismob(target)) //melee attack
			return
		if(target == user && (user.zone_selected != BODY_ZONE_PRECISE_MOUTH && doafter_self_shoot)) //so we can't shoot ourselves (unless mouth selected)
			return
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			for(var/i in C.all_wounds)
				var/datum/wound/W = i
				if(W.try_treating(src, user))
					return // another coward cured!

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return

	if(flag && doafter_self_shoot && user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		handle_suicide(user, target, params)
		return

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can shoot.
		shoot_with_empty_chamber(user)
		return

	if(check_botched(user, target))
		return

	//if(weapon_weight == WEAPON_HEAVY  && (!istype(user.get_inactive_held_item(), /obj/item/offhand) && !isnull(user.get_inactive_held_item())))
	//	balloon_alert(user, "use both hands!")
	//	return
	//DUAL (or more!) WIELDING
	var/bonus_spread = 0
	var/loop_counter = 0
	if(user.combat_mode && !HAS_TRAIT(user, TRAIT_NO_GUN_AKIMBO))
		for(var/obj/item/gun/gun in user.held_items)
			if(gun == src || gun.weapon_weight > weapon_weight)
				continue
			else if(gun.can_trigger_gun(user, akimbo_usage = TRUE))
				if(gun.weapon_weight >= WEAPON_MEDIUM)
					user.adjustStaminaLoss(15 * gun.weapon_weight) //НЕДОЛГО ПЕСЕНКА ИГРАЛА
					bonus_spread += 20
				bonus_spread += dual_wield_spread
				loop_counter++
				addtimer(CALLBACK(gun, TYPE_PROC_REF(/obj/item/gun, process_fire), target, user, TRUE, params, null, bonus_spread), loop_counter)

	return process_fire(target, user, TRUE, params, null, bonus_spread)

/obj/item/gun/proc/check_botched(mob/living/user, atom/target)
	if(clumsy_check)
		if(istype(user))
			if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(40))
				var/target_zone = user.get_random_valid_zone(blacklisted_parts = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM), even_weights = TRUE, bypass_warning = TRUE)
				if(!target_zone)
					return
				to_chat(user, span_userdanger("You shoot yourself in the foot with [src]!"))
				process_fire(user, user, FALSE, null, target_zone)
				SEND_SIGNAL(user, COMSIG_MOB_CLUMSY_SHOOT_FOOT)
				if(!tk_firing(user) && !HAS_TRAIT(src, TRAIT_NODROP))
					user.dropItemToGround(src, TRUE)
				return TRUE

/obj/item/gun/can_trigger_gun(mob/living/user, akimbo_usage)
	. = ..()
	if(!handle_pins(user))
		return FALSE

/obj/item/gun/proc/handle_pins(mob/living/user)
	if(pinless)
		return TRUE
	if(pin)
		if(pin.pin_auth(user) || (pin.obj_flags & EMAGGED))
			return TRUE
		else
			pin.auth_fail(user)
			return FALSE
	else
		to_chat(user, span_warning("[src]'s trigger is locked. This weapon doesn't have a firing pin installed!"))
		balloon_alert(user, "trigger locked, firing pin needed!")
	return FALSE

/obj/item/gun/proc/recharge_newshot()
	return

/obj/item/gun/proc/process_burst(mob/living/user, atom/target, message = TRUE, params=null, zone_override = "", random_spread = 0, burst_spread_mult = 0, iteration = 0)
	if(!user || !firing_burst)
		firing_burst = FALSE
		return FALSE
	if(!issilicon(user))
		if(iteration > 1 && !(user.is_holding(src))) //for burst firing
			firing_burst = FALSE
			return FALSE
	if(chambered?.loaded_projectile)
		if(HAS_TRAIT(user, TRAIT_PACIFISM)) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
			if(chambered.harmful) // Is the bullet chambered harmful?
				to_chat(user, span_warning("[src] is lethally chambered! You don't want to risk harming anyone..."))
				firing_burst = FALSE
				return FALSE
		var/sprd
		if(randomspread)
			sprd = round((rand(0, 1) - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (random_spread))
		else //Smart spread
			sprd = round((((burst_spread_mult/burst_size) * iteration) - (0.5 + (burst_spread_mult * 0.25))) * (random_spread))
		before_firing(target,user)
		if(!chambered.fire_casing(target, user, params, ,suppressed, zone_override, sprd, src))
			shoot_with_empty_chamber(user)
			firing_burst = FALSE
			return FALSE
		else
			if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
				shoot_live_shot(user, TRUE, target, message)
			else
				shoot_live_shot(user, FALSE, target, message)
			if (iteration >= burst_size)
				firing_burst = FALSE
	else
		shoot_with_empty_chamber(user)
		firing_burst = FALSE
		return FALSE
	process_chamber()
	update_appearance()
	return TRUE

///returns true if the gun successfully fires
/obj/item/gun/proc/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	var/base_bonus_spread = 0
	if(user)
		var/list/bonus_spread_values = list(base_bonus_spread, bonus_spread)
		SEND_SIGNAL(user, COMSIG_MOB_FIRED_GUN, src, target, params, zone_override, bonus_spread_values)
		base_bonus_spread = bonus_spread_values[MIN_BONUS_SPREAD_INDEX]
		bonus_spread = bonus_spread_values[MAX_BONUS_SPREAD_INDEX]

	SEND_SIGNAL(src, COMSIG_GUN_FIRED, user, target, params, zone_override)

	add_fingerprint(user)

	//get current firemode
	var/current_firemode = gun_firemodes[firemode_index]
	//FIREMODE_OTHER and its sister directs you to another proc for special handling
	if(current_firemode == FIREMODE_OTHER)
		return process_other(target, user, message, params, zone_override, bonus_spread)
	if(current_firemode == FIREMODE_OTHER_TWO)
		return process_other_two(target, user, message, params, zone_override, bonus_spread)


	if(fire_cd)
		return

	//Vary by at least this much
	var/randomized_bonus_spread = rand(base_bonus_spread, bonus_spread)
	var/randomized_gun_spread = rand(0, wielded_fully ? spread : spread_unwielded)
	var/total_random_spread = max(0, randomized_bonus_spread + randomized_gun_spread)
	var/burst_spread_mult = rand()

	var/modified_burst_delay = burst_delay
	var/modified_fire_delay = fire_delay
	if(user && HAS_TRAIT(user, TRAIT_DOUBLE_TAP))
		modified_burst_delay = ROUND_UP(burst_delay * 0.5)
		modified_fire_delay = ROUND_UP(fire_delay * 0.5)

	if(burst_size > 1 && gun_firemodes[firemode_index] == FIREMODE_BURST)
		firing_burst = TRUE
		fire_cd = TRUE
		for(var/i = 1 to burst_size)
			addtimer(CALLBACK(src, PROC_REF(process_burst), user, target, message, params, zone_override, total_random_spread, burst_spread_mult, i), modified_burst_delay * (i - 1))
			addtimer(CALLBACK(src, PROC_REF(reset_fire_cd)), modified_fire_delay) // for the case of fire delay longer than burst
	else
		if(chambered)
			if(HAS_TRAIT(user, TRAIT_PACIFISM)) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
				if(chambered.harmful) // Is the bullet chambered harmful?
					to_chat(user, span_warning("[src] is lethally chambered! You don't want to risk harming anyone..."))
					return
			var/sprd = round((rand(0, 1) - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * total_random_spread)
			before_firing(target,user)
			if(!chambered.fire_casing(target, user, params, , suppressed, zone_override, sprd, src))
				shoot_with_empty_chamber(user)
				return
			else
				if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
					shoot_live_shot(user, TRUE, target, message)
				else
					shoot_live_shot(user, FALSE, target, message)
		else
			shoot_with_empty_chamber(user)
			return
		// If gun gets destroyed as a result of firing
		if (!QDELETED(src))
			process_chamber()
			update_appearance()
			fire_cd = TRUE
			addtimer(CALLBACK(src, PROC_REF(reset_fire_cd)), modified_fire_delay)

	if(user)
		user.update_held_items()
	SSblackbox.record_feedback("tally", "gun_fired", 1, type)

	return TRUE

/obj/item/gun/proc/process_other(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	return //use this for 'underbarrels!!

/obj/item/gun/proc/process_other_two(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	return //reserved in case another fire mode is needed, if you need special behavior, put it here then call process_fire, or call process_fire and have the special behavior there

/obj/item/gun/proc/reset_fire_cd()
	fire_cd = FALSE

/obj/item/gun/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	if(pin?.pin_removable && user.is_holding(src))
		user.visible_message(span_warning("[user] attempts to remove [pin] from [src] with [I]."),
		span_notice("You attempt to remove [pin] from [src]. (It will take [DisplayTimeText(FIRING_PIN_REMOVAL_DELAY)].)"), null, 3)
		if(I.use_tool(src, user, FIRING_PIN_REMOVAL_DELAY, volume = 50))
			if(!pin) //check to see if the pin is still there, or we can spam messages by clicking multiple times during the tool delay
				return
			user.visible_message(span_notice("[pin] is pried out of [src] by [user], destroying the pin in the process."),
								span_warning("You pry [pin] out with [I], destroying the pin in the process."), null, 3)
			QDEL_NULL(pin)
			return ITEM_INTERACT_SUCCESS

/obj/item/gun/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	if(atom_integrity < max_integrity)
		user.visible_message(span_warning("[user] attempts to repair [src] with [I]."),
		span_notice("You attempt to repair [src]."), null, 3)
		if(I.use_tool(src, user, FIRING_PIN_REMOVAL_DELAY, volume = 50))
			user.visible_message(span_notice("[src] was repaired by [user]."),
								span_warning("You repair [src] with [I]."), null, 3)
			repair_damage(20)
			return ITEM_INTERACT_SUCCESS

/obj/item/gun/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	if(GetComponent(/datum/component/gun_safety))
		user.visible_message(span_warning("[user] attempts to remove gun safety from [src] with [I]."),
		span_notice("You attempt to remove gun safety from [src]."), null, 3)
		if(I.use_tool(src, user, FIRING_PIN_REMOVAL_DELAY, volume = 50))
			if(!GetComponent(/datum/component/gun_safety)) //check to see if the pin is still there, or we can spam messages by clicking multiple times during the tool delay
				return
			user.visible_message(span_notice("Gun safety removed out of [src] by [user]."),
								span_warning("You pry gun safity out with [I]."), null, 3)
			qdel(GetComponent(/datum/component/gun_safety))
			return ITEM_INTERACT_SUCCESS

/obj/item/gun/animate_atom_living(mob/living/owner)
	new /mob/living/basic/mimic/copy/ranged(drop_location(), src, owner)

/obj/item/gun/proc/handle_suicide(mob/living/carbon/human/user, mob/living/carbon/human/target, params, bypass_timer)
	if(!ishuman(user) || !ishuman(target))
		return

	if(fire_cd)
		return

	if(user == target)
		target.visible_message(span_warning("[user] sticks [src] in [user.p_their()] mouth, ready to pull the trigger..."), \
			span_userdanger("You stick [src] in your mouth, ready to pull the trigger..."))
	else
		target.visible_message(span_warning("[user] points [src] at [target]'s head, ready to pull the trigger..."), \
			span_userdanger("[user] points [src] at your head, ready to pull the trigger..."))

	fire_cd = TRUE

	if(!bypass_timer && (!do_after(user, 12 SECONDS, target) || user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		if(user)
			if(user == target)
				user.visible_message(span_notice("[user] decided not to shoot."))
			else if(target?.Adjacent(user))
				target.visible_message(span_notice("[user] has decided to spare [target]"), span_notice("[user] has decided to spare your life!"))
		fire_cd = FALSE
		return

	fire_cd = FALSE

	target.visible_message(span_warning("[user] pulls the trigger!"), span_userdanger("[(user == target) ? "You pull" : "[user] pulls"] the trigger!"))

	if(chambered?.loaded_projectile)
		chambered.loaded_projectile.damage *= 5
		if(chambered.loaded_projectile.wound_bonus != CANT_WOUND)
			chambered.loaded_projectile.wound_bonus += 5 // much more dramatic on multiple pellet'd projectiles really

	var/fired = process_fire(target, user, TRUE, params, BODY_ZONE_HEAD)
	if(!fired && chambered?.loaded_projectile)
		chambered.loaded_projectile.damage /= 5
		if(chambered.loaded_projectile.wound_bonus != CANT_WOUND)
			chambered.loaded_projectile.wound_bonus -= 5

/obj/item/gun/proc/unlock() //used in summon guns and as a convience for admins
	if(pin)
		qdel(pin)
	var/obj/item/firing_pin/new_pin = new
	new_pin.gun_insert(new_gun = src)

//Happens before the actual projectile creation
/obj/item/gun/proc/before_firing(atom/target,mob/user)
	return


/obj/item/gun/proc/build_firemodes()
	if(FIREMODE_FULLAUTO in gun_firemodes)
		if(!GetComponent(/datum/component/automatic_fire))
			AddComponent(/datum/component/automatic_fire, fire_delay)
		SEND_SIGNAL(src, COMSIG_GUN_DISABLE_AUTOFIRE)
	if(burst_size > 1 && !(FIREMODE_BURST in gun_firemodes))
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
	button_icon = 'tff_modular/modules/evento_needo/icons/actions_items.dmi'
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

	//gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_FULLAUTO, FIREMODE_OTHER)

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
	playsound(user, 'tff_modular/modules/evento_needo/sounds/general/selector.ogg', 100, TRUE)
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

/obj/item/gun/dropped(mob/user)
	. = ..()
	update_appearance()
	if(zoomed)
		zoom(user, user.dir)


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

#undef FIRING_PIN_REMOVAL_DELAY
#undef DUALWIELD_PENALTY_EXTRA_MULTIPLIER
