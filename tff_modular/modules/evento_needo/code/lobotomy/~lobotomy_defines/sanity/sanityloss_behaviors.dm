/datum/ai_behavior/say_line/insanity_lines
	var/line_type = "murder"

/datum/ai_behavior/say_line/insanity_lines/New()
	. = ..()
	lines = strings("insanity.json", line_type)

/datum/ai_behavior/say_line/insanity_lines/insanity_suicide
	line_type = "suicide"

/datum/ai_behavior/say_line/insanity_lines/insanity_wander
	line_type = "wander"

/datum/ai_behavior/say_line/insanity_lines/insanity_wander/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	var/sanity_damage = living_pawn.get_clothing_class_level(living_pawn.get_major_clothing_class()) * 10
	for(var/mob/living/carbon/human/H in view(9, living_pawn))
		if(H == living_pawn)
			continue
		if(HAS_TRAIT(H, TRAIT_COMBATFEAR_IMMUNE))
			continue
		H.apply_damage(sanity_damage, BRAIN, null, H.run_armor_check(null, BRAIN))

/datum/ai_behavior/say_line/insanity_lines/insanity_release
	line_type = "release"

/proc/get_cardinal_dir_no_random(atom/A, atom/B)
	var/dx = abs(B.x - A.x)
	var/dy = abs(B.y - A.y)
	return get_dir(A, B) & (dx < dy ? 3 : 12)

/datum/ai_behavior/insanity_mecha_attack/finish_action(datum/ai_controller/insane/murder/controller, succeeded)
	. = ..()
	controller.is_mech_attack_on_cooldown = FALSE
	if(controller.mech_attack_timer_id)
		deltimer(controller.mech_attack_timer_id)
		controller.mech_attack_timer_id = null
	controller.blackboard[BB_INSANE_CURRENT_ATTACK_TARGET] = null

/datum/ai_behavior/insanity_attack_mob
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM

/datum/ai_behavior/insanity_attack_mob/perform(delta_time, datum/ai_controller/insane/murder/controller)
	. = ..()
	var/mob/living/living_pawn = controller.pawn

	var/atom/target = controller.blackboard[BB_INSANE_CURRENT_ATTACK_TARGET]
	if(IS_DEAD_OR_INCAP(living_pawn) || QDELETED(target) || living_pawn.see_invisible < target.invisibility)
		finish_action(controller, TRUE)
		return
	if(!controller.CanTarget(target))
		finish_action(controller, TRUE)
		return
	if(isliving(target))
		var/mob/living/living_target = target
		if(living_target.stat == DEAD || HAS_TRAIT(living_target, TRAIT_GODMODE))
			finish_action(controller, TRUE)
			return
	else if(ismecha(target))
		var/obj/vehicle/sealed/mecha/mech_target = target
		if(!mech_target.occupants || mech_target.occupants.len < 1)
			finish_action(controller, TRUE)
			return
	else
		finish_action(controller, TRUE)
		return

	var/mob/living/carbon/C = living_pawn
	if(istype(C) && C.handcuffed)
		C.resist_restraints()
		return
	if(living_pawn.pulledby)
		living_pawn.resist_grab()
	if(living_pawn.buckled)
		living_pawn.resist_buckle()
		if(living_pawn.buckled)
			attack(controller, living_pawn.buckled, delta_time)
			return
	if(living_pawn.loc && !isturf(living_pawn.loc))
		living_pawn.loc.container_resist_act(living_pawn)
		if(!isturf(living_pawn.loc))
			attack(controller, living_pawn.loc, delta_time)
			return

	//make list of all weapons in inventory, drop unusable weapons, drop trash from hands.
	//Check whether pawn has appropriate weapon against main target if not then try find one
	//select best weapon against main target and put in hand
	var/list/item_blacklist = controller.blackboard[BB_INSANE_BLACKLISTITEMS]
	var/has_weapon = FALSE
	var/has_non_white_weapon = FALSE
	var/list/owned_weapons = list()
	for(var/obj/item/I in C.held_items)
		if(item_blacklist[I])
			living_pawn.dropItemToGround(I, force = TRUE)
			continue
		if(istype(I, /obj/item/offhand))
			continue
		if(I.force < INSANE_MINIMUM_WEAPON_FORCE)
			living_pawn.dropItemToGround(I, force = TRUE)
			continue
		var/obj/item/ego_weapon/EW = I
		var/obj/item/ego_weapon/ranged/EG = I
		if(istype(EW) && !EW.CanUseEgo(living_pawn))
			living_pawn.dropItemToGround(I, force = TRUE)
			item_blacklist[I] = TRUE
			continue
		if(istype(EG) && !EG.CanUseEgo(living_pawn))
			living_pawn.dropItemToGround(I, force = TRUE)
			item_blacklist[I] = TRUE
			continue
	if(C.held_items[1] && C.held_items[2])
		if(!istype(C.held_items[1], /obj/item/offhand) && !istype(C.held_items[2], /obj/item/offhand))
			if(GetEffectiveItemForce(C.held_items[1]) > GetEffectiveItemForce(C.held_items[2]))
				if(!C.equip_to_appropriate_slot(C.held_items[2]))
					C.dropItemToGround(C.held_items[2], TRUE)
			else
				if(!C.equip_to_appropriate_slot(C.held_items[1]))
					C.dropItemToGround(C.held_items[1], TRUE)
				C.put_in_hand(C.held_items[2], 1)
		else if(istype(C.held_items[1], /obj/item/offhand) && !istype(C.held_items[2], /obj/item/offhand))
			var/obj/item/I = C.held_items[2]
			living_pawn.temporarilyRemoveItemFromInventory(I, TRUE)
			C.put_in_hand(I, 1)

	for(var/obj/item/I in C.get_all_gear())
		if(istype(I, /obj/item/offhand))
			continue
		if(item_blacklist[I])
			living_pawn.dropItemToGround(I, force = TRUE)
			continue
		if(I.force < INSANE_MINIMUM_WEAPON_FORCE)
			continue
		var/obj/item/ego_weapon/EW = I
		var/obj/item/ego_weapon/ranged/EG = I
		if(istype(EW) && !EW.CanUseEgo(living_pawn))
			living_pawn.dropItemToGround(I, force = TRUE)
			item_blacklist[I] = TRUE
			continue
		if(istype(EG))
			if(!EG.CanUseEgo(living_pawn))
				living_pawn.dropItemToGround(I, force = TRUE)
				item_blacklist[I] = TRUE
				continue
			has_weapon = TRUE
			sorted_insert(owned_weapons, I , GLOBAL_PROC_REF(ComparatorItemForceGreater))
			var/obj/item/ammo_casing/casing = initial(EG.projectile_path)
			var/obj/projectile/boolet = initial(casing.projectile_type)
			if(initial(boolet.damage_type) != BRAIN)
				has_non_white_weapon = TRUE
			continue
		has_weapon = TRUE
		sorted_insert(owned_weapons, I , GLOBAL_PROC_REF(ComparatorItemForceGreater))
		if(I.damtype != BRAIN)
			has_non_white_weapon = TRUE

	var/mob/living/carbon/human/human_target = target
	var/need_non_white_weapon = FALSE
	if(istype(human_target) && human_target.sanity_lost)
		need_non_white_weapon = TRUE
	if(!has_weapon || need_non_white_weapon && !has_non_white_weapon)
		var/list/weapon_list = controller.TryFindWeapon(!need_non_white_weapon)
		if(weapon_list)
			finish_action(controller, TRUE)
			controller.TryEquipWeapon(weapon_list)
			return

	var/obj/item/selected_weapon = null
	for(var/obj/item/I in owned_weapons)
		if(need_non_white_weapon)
			var/obj/item/ego_weapon/ranged/EG = I
			if(istype(EG))
				var/obj/item/ammo_casing/casing = initial(EG.projectile_path)
				var/obj/projectile/boolet = initial(casing.projectile_type)
				if(initial(boolet.damage_type) != BRAIN)
					selected_weapon = I
					break
				continue
			if(I.damtype != BRAIN)
				selected_weapon = I
				break
			continue
		selected_weapon = I
		break
	if(selected_weapon)
		living_pawn.temporarilyRemoveItemFromInventory(selected_weapon, TRUE)
		var/obj/item/I = living_pawn.held_items[1]
		if(I && !living_pawn.equip_to_appropriate_slot(I))
			living_pawn.dropItemToGround(I, TRUE)
		living_pawn.put_in_hand(selected_weapon, 1)


	var/atom/thing_to_target
	if(isturf(target.loc))
		thing_to_target = target
	else if(isobj(target.loc))
		thing_to_target = target.loc
	if(thing_to_target)
		if(!controller.target_lost)
			if(istype(selected_weapon, /obj/item/ego_weapon/ranged))
				if(controller.melee_attack_timer_id)
					deltimer(controller.melee_attack_timer_id)
					controller.melee_attack_timer_id = null
				ranged_attack(controller, thing_to_target, delta_time)
				return
			DestroyPathToTarget(controller, thing_to_target, delta_time)
		if(!controller.is_melee_attack_on_cooldown)
			TryAttack(controller, delta_time, FALSE)
	else
		finish_action(controller, TRUE)
		return

/datum/ai_behavior/insanity_attack_mob/proc/TryAttack(datum/ai_controller/insane/murder/controller, delta_time, called_by_timer)
	if(QDELETED(controller))
		return
	if(called_by_timer)
		controller.melee_attack_timer_id = null
	controller.is_melee_attack_on_cooldown = FALSE
	var/mob/living/living_pawn = controller.pawn
	var/atom/main_target = controller.blackboard[BB_INSANE_CURRENT_ATTACK_TARGET]
	if(!(locate(/datum/ai_behavior/insanity_attack_mob) in controller.current_behaviors) || QDELETED(main_target) || isturf(main_target) || QDELETED(living_pawn) || !istype(living_pawn) || living_pawn.stat != CONSCIOUS || IS_DEAD_OR_INCAP(living_pawn) || !isturf(living_pawn.loc))
		if(controller.melee_attack_timer_id)
			deltimer(controller.melee_attack_timer_id)
			controller.melee_attack_timer_id = null
		return

	var/attack_reach = 1
	var/attack_cooldown = CLICK_CD_MELEE
	var/obj/item/weapon = living_pawn.held_items[1]
	if(weapon)
		attack_reach = weapon.reach
		var/obj/item/ego_weapon/EW = weapon
		if(istype(EW) && EW.attack_speed)
			attack_cooldown *= EW.attack_speed

	var/atom/attacked_target = null
	var/atom/thing_to_target = isturf(main_target.loc) ? main_target : main_target.loc
	var/should_gain_patience = FALSE
	if(!QDELETED(thing_to_target) && (thing_to_target.Adjacent(living_pawn) || attack_reach > 1 && get_dist(thing_to_target, living_pawn) <= attack_reach && can_see(living_pawn, thing_to_target, attack_reach)))
		//attack target
		attacked_target = thing_to_target
		should_gain_patience = TRUE
	else
		var/list/targets_in_range = controller.PossibleEnemies(attack_reach)
		if(targets_in_range.len > 0)
			//attack random thing in the list
			attacked_target = pick(targets_in_range)

	if(attacked_target)
		attacked_target = isturf(attacked_target.loc) ? attacked_target : attacked_target.loc
		var/must_use_fist = FALSE
		if(weapon && weapon.damtype == BRAIN && ishuman(attacked_target))
			var/mob/living/carbon/human/H = attacked_target
			if(H.sanity_lost)
				must_use_fist = TRUE
				attack_cooldown = CLICK_CD_MELEE
		if(!must_use_fist || get_dist(attacked_target, living_pawn) < 2)
			controller.is_melee_attack_on_cooldown = TRUE
			if(controller.melee_attack_timer_id)
				deltimer(controller.melee_attack_timer_id)
				controller.melee_attack_timer_id = null
			attack(controller, attacked_target, delta_time, must_use_fist)
			if(QDELETED(controller) || QDELETED(living_pawn) || living_pawn.stat != CONSCIOUS)
				return
			if(should_gain_patience)
				controller.GainPatience()
	if(!controller.melee_attack_timer_id)
		controller.melee_attack_timer_id = addtimer(CALLBACK(src, PROC_REF(TryAttack), controller, delta_time, TRUE), attack_cooldown, TIMER_STOPPABLE)

/datum/ai_behavior/insanity_attack_mob/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	controller.current_movement_target = null
	controller.blackboard[BB_INSANE_CURRENT_ATTACK_TARGET] = null

/// attack using a held weapon otherwise bite the enemy, then if we are angry there is a chance we might calm down a little
/datum/ai_behavior/insanity_attack_mob/proc/attack(datum/ai_controller/insane/murder/controller, atom/target, delta_time, must_use_fist = FALSE)
	var/mob/living/living_pawn = controller.pawn

	living_pawn.face_atom(target)

	var/obj/item/weapon = living_pawn.held_items[1]
	// attack with weapon if we have one
	if(weapon && !must_use_fist)
		weapon.melee_attack_chain(living_pawn, target)
	else if(isliving(target))
		var/mob/living/L = target
		// check if target has a weapon
		var/obj/item/W
		for(var/obj/item/I in L.held_items)
			if(!(I.item_flags & ABSTRACT) && I.force > INSANE_MINIMUM_WEAPON_FORCE)
				W = I
				break
		// if the target has a weapon, chance to disarm them
		if(W && prob(25))
			living_pawn.disarm(target, L)
		living_pawn.UnarmedAttack(target)
		living_pawn.changeNext_move(CLICK_CD_MELEE)

/// attack using this GUN we found.
/datum/ai_behavior/insanity_attack_mob/proc/ranged_attack(datum/ai_controller/insane/murder/controller, atom/target, delta_time)
	var/mob/living/living_pawn = controller.pawn
	if(!living_pawn)
		return

	if(living_pawn.next_move > world.time)
		return

	var/obj/item/ego_weapon/ranged/banger = living_pawn.held_items[1]

	if(!istype(banger))
		return
	if(banger.is_reloading)
		return
	if(banger.reloadtime && banger.shotsleft < 1)
		banger.attack_self(living_pawn)
		return

	living_pawn.face_atom(target)

	var/delay
	if(banger.autofire)
		delay = banger.autofire
	else
		delay = banger.fire_delay > CLICK_CD_RANGE ? banger.fire_delay : CLICK_CD_RANGE
	living_pawn.changeNext_move(CLICK_CD_RANGE)
	var/shots = max(floor(10 * delta_time / delay), 1)
	delay = 10 * delta_time / shots
	banger.spread += 25
	banger.spread -= 25
	controller.GainPatience()
	for(var/i in 2 to shots)
		addtimer(CALLBACK(src, PROC_REF(DelayedGunAttack), controller, living_pawn, banger, target, living_pawn.next_move), delay * (i - 1))

/datum/ai_behavior/insanity_attack_mob/proc/DelayedGunAttack(datum/ai_controller/insane/murder/controller, mob/living/user, obj/item/gun/weapon, atom/target, next_move)
	if(QDELETED(controller) || QDELETED(user) || QDELETED(target) || IS_DEAD_OR_INCAP(user))
		return
	if(!(locate(/datum/ai_behavior/insanity_attack_mob) in controller.current_behaviors))
		return
	if(!QDELETED(weapon) && (weapon in user.held_items))
		weapon.spread += 25
		weapon.spread -= 25
		user.next_move = next_move

/datum/ai_behavior/insanity_attack_mob/proc/DestroyPathToTarget(datum/ai_controller/insane/murder/controller, atom/target, delta_time)
	var/dir_to_target = get_dir(controller.pawn, target)
	var/dir_list = list()
	if(ISDIAGONALDIR(dir_to_target))
		for(var/direction in GLOB.cardinals)
			if(direction & dir_to_target)
				dir_list += direction
	else
		dir_list += dir_to_target
	var/turf/pawn_turf = get_turf(controller.pawn)
	for(var/obj/structure/window/W in pawn_turf)
		if(!W.CanAStarPass(null, dir_to_target))
			attack(controller, W, delta_time)
			return
	for(var/obj/structure/railing/R in pawn_turf)
		if(!R.CanAStarPass(null, dir_to_target, controller.pawn))
			attack(controller, R, delta_time)
			return
	for(var/direction in dir_list)
		var/turf/T = get_step(controller.pawn, direction)
		if(QDELETED(T))
			return
		for(var/obj/O in T.contents)
			if(!O.Adjacent(controller.pawn))
				continue
			if(ismecha(O) || ismachinery(O) || isstructure(O))
				if(O.resistance_flags & INDESTRUCTIBLE)
					continue
				if(!O.density)
					continue
				if(O.IsObscured())
					continue
				attack(controller, O, delta_time)
				return

/datum/ai_behavior/insane_equip
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/insane_equip/finish_action(datum/ai_controller/controller, success)
	. = ..()

	if(!success) //Don't try again on this item if we failed
		var/list/item_blacklist = controller.blackboard[BB_INSANE_BLACKLISTITEMS]
		var/obj/item/target = controller.blackboard[BB_INSANE_PICKUPTARGET]

		item_blacklist[target] = TRUE

	controller.current_movement_target = null
	controller.blackboard[BB_INSANE_PICKUPTARGET] = null

/datum/ai_behavior/insane_equip/proc/equip_item(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn

	var/obj/item/target = controller.blackboard[BB_INSANE_PICKUPTARGET]

	if(!isturf(living_pawn.loc))
		finish_action(controller, TRUE)
		return

	if(!target)
		finish_action(controller, TRUE)
		return

	if(target.anchored) //Can't pick it up, so stop trying.
		finish_action(controller, FALSE)
		return

	// If we can't move towards the item
	if(!get_path_to(living_pawn, get_turf(target), TYPE_PROC_REF(/turf, Distance_cardinal), 0, 30, 1, TYPE_PROC_REF(/turf, reachableTurftestWithMobs)) && living_pawn.loc != target.loc && target.loc != living_pawn && !(target.loc in living_pawn.contents))
		finish_action(controller, TRUE)
		return

	if(isturf(target.loc) || (target in living_pawn.contents) || (target.loc in living_pawn.contents))
		for(var/obj/item/I in living_pawn.held_items)
			if(!living_pawn.equip_to_appropriate_slot(I))
				living_pawn.dropItemToGround(I, force = TRUE)

		living_pawn.put_in_hand(target, 1)
		controller.blackboard[BB_INSANE_BEST_FORCE_FOUND] = GetEffectiveItemForce(target)
		finish_action(controller, TRUE)
		return
	finish_action(controller, TRUE)

/datum/ai_behavior/insane_equip/inventory/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	equip_item(controller)

/datum/ai_behavior/insane_equip/inventory/equip_item(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	var/obj/item/target = controller.blackboard[BB_INSANE_PICKUPTARGET]

	if(!living_pawn.temporarilyRemoveItemFromInventory(target))
		finish_action(controller, FALSE)
		return

	return ..()

/datum/ai_behavior/insane_equip/ground
	required_distance = 1

/datum/ai_behavior/insane_equip/ground/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	equip_item(controller)

/datum/ai_behavior/insanity_wander
	var/movement_mod = 0.002
	/*
	* Unique data can NOT be stored here.
	* These behaviors are non-individual and are shared between all people with this behavior.
	* Meaning if two people have "insanity_wander" and it stores its path in it, then they will both attempt to walk that same path.
	* Appropriate data to store here are stuff such as behavior tags, like `behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT`
	*/

/datum/ai_behavior/insanity_wander/perform(delta_time, datum/ai_controller/insane/controller)
	. = ..()

	var/mob/living/living_pawn = controller.pawn

	if(IS_DEAD_OR_INCAP(living_pawn))
		return

	var/turf/target = controller.blackboard[BB_INSANE_CURRENT_ATTACK_TARGET]
	if(living_pawn.Adjacent(target))
		controller.current_path.Cut()
		finish_action(controller, FALSE)
		return
	if(!LAZYLEN(controller.current_path))
		var/atom/movable/thing_to_move = living_pawn
		if(ismecha(living_pawn.loc))
			thing_to_move = living_pawn.loc
		controller.current_path = get_path_to(thing_to_move, target, TYPE_PROC_REF(/turf, Distance_cardinal), 0, 120)
		if(!LAZYLEN(controller.current_path)) // Returned FALSE or null.
			finish_action(controller, FALSE)
			return
		controller.current_path.Remove(controller.current_path[1])
		MoveInPath(controller)
		return
	if(!controller.timerid_wander)
		MoveInPath(controller)
		return

/datum/ai_behavior/insanity_wander/proc/MoveInPath(datum/ai_controller/insane/controller)
	controller.timerid_wander = null
	var/mob/living/living_pawn = controller.pawn
	if(!living_pawn || IS_DEAD_OR_INCAP(living_pawn))
		controller.current_path = list() // Reset the path and stop
		finish_action(controller, TRUE)
		return FALSE
	if(!PreMoveCheck(controller, living_pawn))
		if(!QDELETED(controller))
			controller.current_path.Cut()
			finish_action(controller, TRUE)
		return FALSE
	// Movement
	if(LAZYLEN(controller.current_path))
		var/target_turf = controller.current_path[1]
		var/obj/vehicle/sealed/mecha/the_mecha
		var/atom/movable/thing_to_move = living_pawn
		if(ismecha(living_pawn.loc))
			the_mecha = living_pawn.loc
			thing_to_move = the_mecha
		if(target_turf && get_dist(thing_to_move, target_turf) < 2)
			if(the_mecha)
				the_mecha.relaymove(living_pawn, get_dir(the_mecha, target_turf))
			else
				thing_to_move.Move(target_turf, get_dir(thing_to_move, target_turf))
			if(get_turf(thing_to_move) == target_turf)
				controller.current_path.Remove(target_turf)
			var/move_delay = max(0.8, 0.2 + living_pawn.cached_multiplicative_slowdown - (living_pawn.get_clothing_class_level(CLOTHING_ARMORED) * movement_mod))
			controller.timerid_wander = addtimer(CALLBACK(src, PROC_REF(MoveInPath), controller), move_delay, TIMER_STOPPABLE)
			return TRUE
	controller.current_path = list() // Reset the path and stop
	finish_action(controller, TRUE)
	return FALSE

/datum/ai_behavior/insanity_wander/proc/PreMoveCheck(datum/ai_controller/insane/controller, mob/living/living_pawn)
	if(!controller.blackboard[BB_INSANE_CURRENT_ATTACK_TARGET])
		return FALSE
	return TRUE

/datum/ai_behavior/insanity_wander/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	controller.blackboard[BB_INSANE_BLACKLISTITEMS][BB_INSANE_CURRENT_ATTACK_TARGET] = world.time + 10 SECONDS
	controller.blackboard[BB_INSANE_CURRENT_ATTACK_TARGET] = null

/datum/ai_behavior/insanity_wander/suicide_wander
	movement_mod = 0.004
	// Same as the above insanity, however it assumers wander controller and that the user will eventually attempt to off themselves

/datum/ai_behavior/insanity_wander/suicide_wander/PreMoveCheck(datum/ai_controller/insane/wander/controller, mob/living/living_pawn)
	. = ..()
	if(!.)
		return
	// Insanity lines
	if(world.time > controller.last_message + 4 SECONDS)
		controller.last_message = world.time
		controller.current_behaviors += GET_AI_BEHAVIOR(controller.lines_type)
	// Suicide replacement
	if(world.time > controller.suicide_enter)
		if(prob(10))
			living_pawn.visible_message("<span class='danger'>[living_pawn] freezes with an expression of despair on their face!</span>")
			QDEL_NULL(living_pawn.ai_controller)
			living_pawn.ai_controller = /datum/ai_controller/insane/suicide
			living_pawn.InitializeAIController()
			return FALSE
		controller.suicide_enter = world.time + 30 SECONDS

/datum/ai_behavior/insanity_wander/murder_wander
	movement_mod = 0.001
	// Same as the above insanity, but they look for a target between moves.

/datum/ai_behavior/insanity_wander/murder_wander/PreMoveCheck(datum/ai_controller/insane/murder/controller, mob/living/living_pawn)
	if(controller.FindEnemies())
		return FALSE
	return ..()








/datum/ai_behavior/say_line
	///List of potential lines to say
	var/list/lines

/datum/ai_behavior/say_line/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	INVOKE_ASYNC(living_pawn, TYPE_PROC_REF(/atom/movable, say), pick(lines))
	finish_action(controller, TRUE)
