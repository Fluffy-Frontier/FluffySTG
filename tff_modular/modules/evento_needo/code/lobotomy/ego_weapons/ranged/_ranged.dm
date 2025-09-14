#define DUALWIELD_PENALTY_EXTRA_MULTIPLIER 1.4

/obj/item/ego_weapon/ranged
	name = "ego gun"
	desc = "Some sort of weapon..?"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_weapons.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_righthand.dmi'
	icon_state = "detective"
	inhand_icon_state = "gun"
	worn_icon_state = "gun"
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron=2000)
	w_class = WEIGHT_CLASS_BULKY //No more stupid 10 egos in bag
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	force = 5
	item_flags = NEEDS_PERMIT
	attack_verb_continuous = list("strikes", "hits", "bashes")
	attack_verb_simple = list("strike", "hit", "bash")
	is_ranged = TRUE

	var/fire_sound = 'sound/items/weapons/emitter.ogg' //What sound should play when this ammo is fired

	trigger_guard = TRIGGER_GUARD_ALLOW_ALL	//trigger guard on the weapon, hulks can't fire them with their big meaty fingers

	/// The current projectile we are shooting
	var/obj/projectile/projectile_path = null

	/// Just 'slightly' snowflakey way to modify projectile damage for projectiles fired from this gun.
	var/projectile_damage_multiplier = 1
	/// If the weapon allows dual-weilding/can be used in 1 hand/needs 2 hands
	var/weapon_weight = WEAPON_LIGHT

	/// If set, the gun will allow you to hold your mouse instead of clicking it to fire.
	/// In Rounds per decisecond
	var/autofire = 0

	//// Reload/Ammo mechanics
	/// The amount of shots we hold.
	var/shotsleft = 0
	/// How long it takes to reload this weapon, if blank it wont need to be reloaded
	var/reloadtime = 0 SECONDS
	/// Are we currently reloading?
	var/is_reloading = FALSE

	/// Vars used for when you examine a gun
	var/last_projectile_damage = 0
	var/last_projectile_type = BRUTE

	/// Controls if pacifists can use the gun or not. Should be TRUE unless you are doing something funky
	var/lethal = TRUE
	/// Should clumsy people shoot themselfes at a chance with it? Usually unused
	var/clumsy_check = TRUE

	/// Sound controls
	var/vary_fire_sound = TRUE
	var/fire_sound_volume = 50
	var/dry_fire_sound = 'sound/items/weapons/gun/general/dry_fire.ogg'

	var/recoil = 0						//boom boom shake the room
	var/burst_size = 1					//how large a burst is
	var/fire_delay = 0					//rate of fire for burst firing and semi auto
	var/firing_burst = 0				//Prevent the weapon from firing again while already firing
	var/semicd = 0						//cooldown handler
	var/dual_wield_spread = 24			//additional spread when dual wielding
	var/forced_melee = FALSE			//forced to melee attack. Currently only used for the ego_gun subtype

	var/spread = 0						//Spread induced by the gun itself.
	var/randomspread = 1				//Set to 0 for shotguns. This is used for weapons that don't fire all their bullets at once.

	var/ammo_x_offset = 0 //used for positioning ammo count overlay on sprite
	var/ammo_y_offset = 0
	var/flight_x_offset = 0
	var/flight_y_offset = 0

	//Zooming
	var/zoomable = FALSE //whether the gun generates a Zoom action on creation
	var/zoomed = FALSE //Zoom toggle
	var/zoom_amt = 3 //Distance in TURFs to move the user's screen forward (the "zoom" effect)
	var/zoom_out_amt = 0
	var/datum/action/toggle_scope_zoom/azoom
	var/pb_knockback = 0

/obj/item/ego_weapon/ranged/pistol
	attack_speed = CLICK_CD_RAPID
	force = 6

/obj/item/ego_weapon/ranged/Initialize()
	qdel(src) // Временно выключено. Заменю на /obj/item/gun
	. = ..()
	build_zooming()
	if(autofire)
		AddComponent(/datum/component/automatic_fire, autofire)

	update_projectile_examine()

/obj/item/ego_weapon/ranged/Destroy()
	if(azoom)
		QDEL_NULL(azoom)
	return ..()

/obj/item/ego_weapon/ranged/examine(mob/user)
	. = ..()
	. += GunAttackInfo()
	if(!reloadtime)
		. += span_notice("This weapon has unlimited ammo.")
	else if(shotsleft>0)
		. += span_notice("Ammo Counter: [shotsleft]/[initial(shotsleft)].")
	else
		. += span_danger("Ammo Counter: [shotsleft]/[initial(shotsleft)].")

	if(reloadtime)
		switch(reloadtime)
			if(0 to 0.71 SECONDS)
				. += span_nicegreen("This weapon has a very fast reload.")
			if(0.71 SECONDS to 1.21 SECONDS)
				. += span_notice("This weapon has a fast reload.")
			if(1.21 SECONDS to 1.71 SECONDS)
				. += span_notice("This weapon has a normal reload speed.")
			if(1.71 SECONDS to 2.51 SECONDS)
				. += span_danger("This weapon has a slow reload.")
			if(2.51 to INFINITY)
				. += span_danger("This weapon has an extremely slow reload.")

	switch(weapon_weight)
		if(WEAPON_HEAVY)
			. += span_danger("This weapon requires both hands to fire.")
		if(WEAPON_MEDIUM)
			. += span_notice("This weapon can be fired with one hand.")
		if(WEAPON_LIGHT)
			. += span_nicegreen("This weapon can be dual wielded.")

	if(!autofire)
		switch(fire_delay)
			if(0 to 5)
				. += span_nicegreen("This weapon fires fast.")
			if(6 to 10)
				. += span_notice("This weapon fires at a normal speed.")
			if(11 to 15)
				. += span_notice("This weapon fires slightly slower than usual.")
			if(16 to 20)
				. += span_danger("This weapon fires slowly.")
			else
				. += span_danger("This weapon fires extremely slowly.")
	else
		//Give it to 'em in true rounds per minute, accurate to the 5s
		var/rpm = 600 / autofire
		rpm = round(rpm,5)
		. += span_nicegreen("This weapon is automatic.")
		. += span_notice("This weapon fires at [rpm] rounds per minute.")

	. += span_notice("Examine this weapon more for melee information.")

/obj/item/ego_weapon/ranged/EgoAttackInfo()
	return span_notice("It deals [force] [damtype] damage in melee.")

/obj/item/ego_weapon/ranged/proc/GunAttackInfo()
	if(!last_projectile_damage || !last_projectile_type)
		return span_userdanger("The bullet of this EGO gun has not properly initialized, report this to coders!")
	var/damage = round(last_projectile_damage, 0.1)
	if(pellets > 1)	//for shotguns
		return span_notice("Its bullets deal [damage] x [pellets] [last_projectile_type] damage.[projectile_damage_multiplier != 1 ? " (+ [(projectile_damage_multiplier - 1) * 100]%)" : ""]")
	return span_notice("Its bullets deal [damage] [last_projectile_type] damage.[projectile_damage_multiplier != 1 ? " (+ [(projectile_damage_multiplier - 1) * 100]%)" : ""]")

/// Updates the damage/type of projectiles inside of the gun
/obj/item/ego_weapon/ranged/proc/update_projectile_examine()
	if(isnull(projectile_path))
		message_admins("[src] has an invalid projectile path.")
		return
	var/obj/projectile/projectile = new projectile_path(src, src)
	last_projectile_damage = projectile.damage
	last_projectile_type = projectile.damage_type
	qdel(projectile)

/obj/item/ego_weapon/ranged/attack_self(mob/user)
	if(reloadtime && !is_reloading)
		INVOKE_ASYNC(src, PROC_REF(reload_ego), user)
	return ..()

/obj/item/ego_weapon/ranged/proc/reload_ego(mob/user)
	is_reloading = TRUE
	to_chat(user,span_notice("You start loading a new magazine."))
	playsound(src, 'sound/items/weapons/gun/general/slide_lock_1.ogg', 50, TRUE)
	if(do_after(user, reloadtime, src)) //gotta reload
		playsound(src, 'sound/items/weapons/gun/general/bolt_rack.ogg', 50, TRUE)
		shotsleft = initial(shotsleft)
		forced_melee = FALSE //no longer forced to resort to melee

	is_reloading = FALSE

/obj/item/ego_weapon/ranged/equipped(mob/living/user, slot)
	. = ..()
	if(zoomed && user.get_active_held_item() != src)
		zoom(user, user.dir, FALSE) //we can only stay zoomed in if it's in our hands	//yeah and we only unzoom if we're actually zoomed using the gun!!

/obj/item/ego_weapon/ranged/pickup(mob/user)
	..()
	if(azoom)
		azoom.Grant(user)

/obj/item/ego_weapon/ranged/dropped(mob/user)
	. = ..()
	if(azoom)
		azoom.Remove(user)
	if(zoomed)
		zoom(user, user.dir)

//called after the gun has successfully fired its chambered ammo.
/obj/item/ego_weapon/ranged/proc/process_chamber()
	if(reloadtime && shotsleft)
		shotsleft -= 1

//check if there's enough ammo to shoot one time
//i.e if clicking would make it shoot
/obj/item/ego_weapon/ranged/proc/can_shoot()
	if(reloadtime && !shotsleft)
		visible_message(span_notice("The gun is out of ammo."))
		shoot_with_empty_chamber()
		return FALSE

	if(is_reloading)
		return FALSE

	return TRUE

/obj/item/ego_weapon/ranged/proc/shoot_with_empty_chamber(mob/living/user as mob|obj)
	to_chat(user, span_danger("*click*"))
	playsound(src, dry_fire_sound, 30, TRUE)
	return TRUE

/// Happens before projectile creation
/obj/item/ego_weapon/ranged/proc/before_firing(atom/target, mob/user)
	return

/obj/item/ego_weapon/ranged/proc/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
	if(recoil)
		shake_camera(user, recoil + 1, recoil)

	playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
	if(!message)
		return

	if(!pointblank)
		user.visible_message(span_danger("[user] fires [src]!"), \
							span_danger("You fire [src]!"), \
							span_hear("You hear a gunshot!"), COMBAT_MESSAGE_RANGE)
		return

	user.visible_message(span_danger("[user] fires [src] point blank at [pbtarget]!"), \
						span_danger("You fire [src] point blank at [pbtarget]!"), \
						span_hear("You hear a gunshot!"), COMBAT_MESSAGE_RANGE, pbtarget)
	to_chat(pbtarget, span_userdanger("[user] fires [src] point blank at you!"))
	if(pb_knockback > 0 && ismob(pbtarget))
		var/mob/PBT = pbtarget
		var/atom/throw_target = get_edge_target_turf(PBT, user.dir)
		PBT.throw_at(throw_target, pb_knockback, 2)







/obj/item/ego_weapon/ranged/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(try_fire_gun(interacting_with, user, list2params(modifiers)))
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/ego_weapon/ranged/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.combat_mode && isliving(interacting_with))
		return ITEM_INTERACT_SKIP_TO_ATTACK // Gun bash / bayonet attack

	if(!isliving(interacting_with))
		return interact_with_atom(interacting_with, user, modifiers)

	return ITEM_INTERACT_SUCCESS

/obj/item/ego_weapon/ranged/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(try_fire_gun(interacting_with, user, list2params(modifiers)))
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/ego_weapon/ranged/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(IN_GIVEN_RANGE(user, interacting_with, GUNPOINT_SHOOTER_STRAY_RANGE))
		return interact_with_atom_secondary(interacting_with, user, modifiers)
	return ..()

/obj/item/ego_weapon/ranged/proc/try_fire_gun(atom/target, mob/living/user, params)
	return pre_fire_gun(target, user, user.Adjacent(target), params)

/obj/item/ego_weapon/ranged/proc/pre_fire_gun(atom/target, mob/living/user, flag, params)
	if(QDELETED(target))
		return FALSE
	if(firing_burst)
		return FALSE
	if(flag) //It's adjacent, is the user, or is on the user's person
		if(target in user.contents) //can't shoot stuff inside us.
			return FALSE
		if(!ismob(target) || user.combat_mode || forced_melee) //melee attack
			return FALSE
		if(target == user && user.zone_selected != BODY_ZONE_PRECISE_MOUTH) //so we can't shoot ourselves (unless mouth selected)
			return FALSE
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			for(var/i in C.all_wounds)
				var/datum/wound/W = i
				if(W.try_treating(src, user))
					return FALSE // another coward cured!

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return FALSE

	if(flag)
		if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
			return handle_suicide(user, target, params)

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can shoot.
		return shoot_with_empty_chamber(user)

	if(check_botched(user))
		return FALSE

	var/obj/item/bodypart/other_hand = user.has_hand_for_held_index(user.get_inactive_hand_index()) //returns non-disabled inactive hands
	if(weapon_weight == WEAPON_HEAVY && (user.get_inactive_held_item() || !other_hand))
		to_chat(user, span_warning("You need two hands to fire [src]!"))
		return FALSE
	//DUAL (or more!) WIELDING
	var/bonus_spread = 0
	var/loop_counter = 0
	if(ishuman(user) && user.combat_mode)
		var/mob/living/carbon/human/H = user
		for(var/obj/item/ego_weapon/ranged/G in H.held_items)
			if(G == src || G.weapon_weight >= WEAPON_MEDIUM)
				continue
			else if(G.can_trigger_gun(user) && G.can_shoot())
				bonus_spread += dual_wield_spread
				loop_counter++
				addtimer(CALLBACK(G, TYPE_PROC_REF(/obj/item/ego_weapon/ranged, process_fire), target, user, TRUE, params, null, bonus_spread), loop_counter)

	return process_fire(target, user, TRUE, params, null, bonus_spread)

/obj/item/ego_weapon/ranged/proc/check_botched(mob/living/user, params)
	if(clumsy_check && istype(user))
		if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(40))
			to_chat(user, span_userdanger("You shoot yourself in the foot with [src]!"))
			var/shot_leg = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			process_fire(user, user, FALSE, params, shot_leg)
			SEND_SIGNAL(user, COMSIG_MOB_CLUMSY_SHOOT_FOOT)
			user.dropItemToGround(src, TRUE)
			return TRUE

/obj/item/ego_weapon/ranged/proc/process_burst(mob/living/user, atom/target, message = TRUE, params=null, zone_override = "", sprd = 0, randomized_gun_spread = 0, randomized_bonus_spread = 0, rand_spr = 0, iteration = 0)
	if(!user || !firing_burst)
		firing_burst = FALSE
		return FALSE

	if(!issilicon(user))
		if(iteration > 1 && !(user.is_holding(src))) //for burst firing
			firing_burst = FALSE
			return FALSE

	if(randomspread)
		sprd = round((rand() - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (randomized_gun_spread + randomized_bonus_spread))
	else //Smart spread
		sprd = round((((rand_spr/burst_size) * iteration) - (0.5 + (rand_spr * 0.25))) * (randomized_gun_spread + randomized_bonus_spread))

	before_firing(target,user)
	fire_projectile(target, user, params, 0, FALSE, zone_override, sprd, src)

	if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
		shoot_live_shot(user, 1, target, message)
	else
		shoot_live_shot(user, 0, target, message)
	if(iteration >= burst_size)
		firing_burst = FALSE

	process_chamber()
	return TRUE

/obj/item/ego_weapon/ranged/proc/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, temporary_damage_multiplier = 1)
	//if(!CanUseEgo(user))
	//	return FALSE

	if(HAS_TRAIT(user, TRAIT_PACIFISM) && lethal) // If the user has the pacifist trait, then they won't be able to fire [src] if the [lethal] var is TRUE.
		to_chat(user, span_warning("[src] is lethal! You don't want to risk harming anyone..."))
		return FALSE

	if(user)
		SEND_SIGNAL(user, COMSIG_MOB_FIRED_GUN, src, target, params, zone_override)

	SEND_SIGNAL(src, COMSIG_GUN_FIRED, user, target, params, zone_override)

	add_fingerprint(user)

	if(semicd)
		return FALSE

	var/sprd = 0
	var/randomized_gun_spread = 0
	var/rand_spr = rand()
	if(spread)
		randomized_gun_spread =	rand(0,spread)
	if(user.has_quirk(/datum/quirk/poor_aim)) //nice shootin' tex
		bonus_spread += 25
	var/randomized_bonus_spread = rand(0, bonus_spread)

	if(burst_size > 1)
		firing_burst = TRUE
		for(var/i = 1 to burst_size)
			addtimer(CALLBACK(src, PROC_REF(process_burst), user, target, message, params, zone_override, sprd, randomized_gun_spread, randomized_bonus_spread, rand_spr, i), fire_delay * (i - 1))
	else
		sprd = round((rand() - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (randomized_gun_spread + randomized_bonus_spread))

		before_firing(target,user)
		fire_projectile(target, user, params, 0, FALSE, zone_override, sprd, src, temporary_damage_multiplier)

		if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
			shoot_live_shot(user, 1, target, message)
		else
			shoot_live_shot(user, 0, target, message)

		process_chamber()
		semicd = TRUE
		addtimer(CALLBACK(src, PROC_REF(reset_semicd)), fire_delay)
	SSblackbox.record_feedback("tally", "gun_fired", 1, type)

	return TRUE

/obj/item/ego_weapon/ranged/proc/reset_semicd()
	semicd = FALSE

/obj/item/ego_weapon/ranged/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!CanUseEgo(user))
		return FALSE

	if(!can_shoot())
		forced_melee = TRUE // Forces us to melee

	if(user.combat_mode || forced_melee) //Flogging
		return ..()

	return TRUE

/obj/item/ego_weapon/ranged/proc/handle_suicide(mob/living/carbon/human/user, mob/living/carbon/human/target, params, bypass_timer)
	if(!ishuman(user) || !ishuman(target))
		return FALSE

	if(semicd)
		return FALSE

	if(user == target)
		target.visible_message(span_warning("[user] sticks [src] in [user.p_their()] mouth, ready to pull the trigger..."), \
			span_userdanger("You stick [src] in your mouth, ready to pull the trigger..."))
	else
		target.visible_message(span_warning("[user] points [src] at [target]'s head, ready to pull the trigger..."), \
			span_userdanger("[user] points [src] at your head, ready to pull the trigger..."))

	semicd = TRUE

	if(!bypass_timer && (!do_after(user, 120, target) || user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		if(user)
			if(user == target)
				user.visible_message(span_notice("[user] decided not to shoot."))
			else if(target?.Adjacent(user))
				target.visible_message(span_notice("[user] has decided to spare [target]"), span_notice("[user] has decided to spare your life!"))
		semicd = FALSE
		return FALSE

	semicd = FALSE

	target.visible_message(span_warning("[user] pulls the trigger!"), span_userdanger("[(user == target) ? "You pull" : "[user] pulls"] the trigger!"))
	return process_fire(target, user, TRUE, params, BODY_ZONE_HEAD, temporary_damage_multiplier = 5)

/////////////
// ZOOMING //
/////////////

/obj/item/ego_weapon/ranged/proc/rotate(atom/thing, old_dir, new_dir)
	SIGNAL_HANDLER

	if(ismob(thing))
		var/mob/lad = thing
		lad.client.view_size.zoomOut(zoom_out_amt, zoom_amt, new_dir)

/obj/item/ego_weapon/ranged/proc/zoom(mob/living/user, direc, forced_zoom)
	if(!user || !user.client)
		return

	if(isnull(forced_zoom))
		zoomed = !zoomed
	else
		zoomed = forced_zoom

	if(zoomed)
		RegisterSignal(user, COMSIG_ATOM_DIR_CHANGE, PROC_REF(rotate))
		user.client.view_size.zoomOut(zoom_out_amt, zoom_amt, direc)
	else
		UnregisterSignal(user, COMSIG_ATOM_DIR_CHANGE)
		user.client.view_size.zoomIn()
	return zoomed

//Proc, so that gun accessories/scopes/etc. can easily add zooming.
/obj/item/ego_weapon/ranged/proc/build_zooming()
	if(azoom)
		return

	if(zoomable)
		azoom = new(src)

#undef DUALWIELD_PENALTY_EXTRA_MULTIPLIER

//Least important part: Melee attack info
//Has to be coded differently as an examine_more.
//Shoot me now - Kitsunemitsu/Kirie
/obj/item/ego_weapon/ranged/examine_more(mob/user)
	. = ..()
	. += span_notice("This weapon deals [force] [damtype] damage in melee.")

	if(reach>1)
		. += span_notice("This weapon has a reach of [reach].")

	if(throwforce>force)
		. += span_notice("This weapon deals [throwforce] [damtype] damage when thrown.")

	switch(attack_speed)
		if(-INFINITY to 0.39)
			. += span_notice("This weapon has a very fast attack speed.")

		if(0.4 to 0.69) // nice
			. += span_notice("This weapon has a fast attack speed.")

		if(0.7 to 0.99)
			. += span_notice("This weapon attacks slightly faster than normal.")

		if(1.01 to 1.49)
			. += span_notice("This weapon attacks slightly slower than normal.")

		if(1.5 to 1.99)
			. += span_notice("This weapon has a slow attack speed.")

		if(2 to INFINITY)
			. += span_notice("This weapon attacks extremely slow.")

	switch(swingstyle)
		if(WEAPONSWING_LARGESWEEP)
			. += span_notice("This weapon can be swung in an arc instead of at a specific target.")

		if(WEAPONSWING_THRUST)
			. += span_notice("This weapon can be thrust at tiles up to [reach] tiles away instead of a specific target.")

	switch(stuntime)
		if(1 to 2)
			. += span_notice("This weapon stuns you for a very short duration on hit.")
		if(2 to 4)
			. += span_notice("This weapon stuns you for a short duration on hit.")
		if(5 to 6)
			. += span_notice("This weapon stuns you for a moderate duration on hit.")
		if(6 to 8)
			. += span_warning("CAUTION: This weapon stuns you for a long duration on hit.")
		if(9 to INFINITY)
			. += span_warning("WARNING: This weapon stuns you for a very long duration on hit.")


	switch(knockback)
		if(KNOCKBACK_LIGHT)
			. += span_notice("This weapon has slight enemy knockback.")

		if(KNOCKBACK_MEDIUM)
			. += span_notice("This weapon has decent enemy knockback.")

		if(KNOCKBACK_HEAVY)
			. += span_notice("This weapon has neck-snapping enemy knockback.")

		else if(knockback)
			. += span_notice("This weapon has [knockback >= 10 ? "neck-snapping": ""] enemy knockback.")
	return .
