/**
 * 	СЛАБОЕ ТЕЛО
 *
 * 	Этот компонент нанесет на установленного пользователя массу дебафов, что так, или иначе скажутся
 * 	На его работоспособности.
 *
 * 	Переменные:
 *
 *	block_grab - Если положительно, будет разрывать граб пользоветля.
 *	max_allow_w_class - Максимально допустимый вес предмета, что может тянуть пользователь.
 * 	block_range_weapon - Если положительно, будет оказывать дебаф на использование дальнобоейного оружия.
 * 	block_melee_weapon - дебафф при использовании оружия ближнего боя.
 *
 */
/datum/component/weak_body
	dupe_mode = COMPONENT_DUPE_HIGHLANDER
	var/block_grab
	var/max_allow_w_class
	var/block_range_weapon
	var/block_melee_weapon

/datum/component/weak_body/Initialize(block_range = TRUE, block_melee = TRUE, weak_grab = TRUE, max_w_class = WEIGHT_CLASS_BULKY)
	block_melee_weapon = block_melee
	block_range_weapon = block_range
	block_grab = weak_grab
	max_allow_w_class =	max_w_class
	RegisterWithParent()

/datum/component/weak_body/Destroy(force, silent)
	. = ..()
	if(!parent)
		return

	UnregisterSignal(parent, list(COMSIG_MOB_ITEM_AFTERATTACK, COMSIG_MOB_ITEM_AFTERATTACK_SECONDARY, COMSIG_MOB_FIRED_GUN, COMSIG_HUMAN_DISARM_HIT, COMSIG_LIVING_PICKED_UP_ITEM))
	if(block_grab)
		UnregisterSignal(parent, list(COMSIG_MOVABLE_SET_GRAB_STATE, COMSIG_LIVING_START_PULL))

/datum/component/weak_body/RegisterWithParent()
	if(!parent)
		return

	RegisterSignals(parent, list(COMSIG_MOB_ITEM_AFTERATTACK, COMSIG_MOB_ITEM_AFTERATTACK_SECONDARY), PROC_REF(aftet_attack_act), override = TRUE)
	RegisterSignal(parent, COMSIG_MOB_FIRED_GUN, PROC_REF(fired_gun_act), override = TRUE)
	RegisterSignal(parent, COMSIG_HUMAN_DISARM_HIT, PROC_REF(after_disarm), override = TRUE)
	RegisterSignal(parent, COMSIG_LIVING_PICKED_UP_ITEM ,PROC_REF(pickup_item_act), override = TRUE)
	if(block_grab)
		RegisterSignal(parent, COMSIG_MOVABLE_SET_GRAB_STATE, PROC_REF(upgrade_grab), override = TRUE)
		RegisterSignal(parent, COMSIG_LIVING_START_PULL, PROC_REF(pull_act), override = TRUE)


// Проверяем надет ли и включен на пользователе МОД костюм.
/datum/component/weak_body/proc/check_mod()
	var/mob/living/carbon/human/victim = parent

	if(istype(victim.back, /obj/item/mod/control))
		var/obj/item/mod/control/m = victim.back
		if(m.active)
			victim.balloon_alert(victim, "Mod assisted!")
			m.subtract_charge(5)
			return TRUE
	return FALSE

/datum/component/weak_body/proc/check_antagonists()
	var/mob/living/carbon/human/victim = parent
	if((IS_TRAITOR(victim) || IS_NUKE_OP(victim) || IS_HERETIC(victim) || IS_CULTIST(victim)))
		return TRUE
	return FALSE

/datum/component/weak_body/proc/pickup_item_act(mob/user, obj/item/picked_up_item)
	if((picked_up_item.w_class > max_allow_w_class) && !check_mod())
		addtimer(CALLBACK(src, PROC_REF(drop_item), picked_up_item), 5)
	//Дополнительно проверяем, что не пытаемся взять сумку, в которой кто-нибудь лежит.
	if(istype(picked_up_item, /obj/item/storage/backpack))
		var/obj/item/storage/backpack/bag = picked_up_item
		for(var/thing in bag.contents)
			if(!istype(thing, /obj/item/clothing/head/mob_holder/human))
				continue
			if(check_mod())
				return
			addtimer(CALLBACK(src, PROC_REF(drop_item), picked_up_item), 5)

/datum/component/weak_body/proc/drop_item(obj/item/I)
	var/mob/living/carbon/human/victim = parent
	victim.visible_message(span_notice("[victim.name] try pickup [I], but it too heavy for [victim.p_they()]"), span_danger("You try pickup [I.name], but it too heavy for you!"))
	victim.dropItemToGround(I)

/datum/component/weak_body/proc/after_disarm(mob/user, mob/living/carbon/human/attacker, zone_targeted)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/victim = parent
	if(check_antagonists())
		return
	var/fall_chance = rand(0, 50)

	if(HAS_TRAIT(attacker, TRAIT_OVERSIZED))
		fall_chance = 100

	var/should_fall = FALSE
	switch(fall_chance)
		if(0 to 29)
			should_fall = pick(TRUE, FALSE, FALSE, FALSE)
		if(30 to 49)
			should_fall = pick(TRUE, FALSE, FALSE)
		if(50 to 99)
			should_fall = pick(TRUE, FALSE)
		if(100 to INFINITE)
			should_fall = TRUE
	if(should_fall && !check_mod())
		victim.Knockdown(3 SECONDS)

/datum/component/weak_body/proc/pull_act(mob/user, atom/movable/pulled, state, force)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/victim = parent

	if(isitem(pulled))
		var/obj/item/i = pulled
		if((i.w_class > max_allow_w_class) && !check_mod())
			victim.stop_pulling()
			victim.visible_message(span_notice("[victim.name] start pulling [i], [i.name], but too heavy for [victim.p_their()]"), span_danger("You start pulling [i.name], but it too heavy for you!"))
			return

	if(isobj(pulled))
		var/obj/o = pulled
		// Т.к каких-то фиксированных значений для обьектов у нас нет, стоит отталкиваться от того, какое замедление они оказывают.
		if((o.drag_slowdown >= 1.5) && !check_mod())
			victim.stop_pulling()
			victim.visible_message(span_notice("[victim.name] start pulling [o], but [o.name] too heavy for [victim.p_their()]"), span_danger("You start pulling [o.name], but it too heavy for you!"))
			return

	if(ishuman(pulled) && (state >= GRAB_AGGRESSIVE))
		// Если мы антагонист, то мы можем превозмочь рассовые сложности.
		if(check_antagonists() || check_mod())
			return
		var/mob/living/carbon/human/h = pulled
		if(HAS_TRAIT(h, TRAIT_WEAK_BODY))
			return
		victim.visible_message(span_notice("[victim.name] grabed [h.name], but [h.p_they()] too heavy for [victim.p_their()]"), span_danger("You start pulling [h.name], but [h.p_they()] too heavy for you!"))
		victim.stop_pulling()
		victim.grab_state = 0

/datum/component/weak_body/proc/upgrade_grab(mob/user, new_state)
	SIGNAL_HANDLER
	if(!user.pulling)
		return
	addtimer(CALLBACK(src, PROC_REF(pull_act), user, user.pulling, new_state), 5)

// ДЕБАФ НА ОРУЖИЕ ДАЛЬНЕГО БОЯ
/datum/component/weak_body/proc/fired_gun_act(mob/user, obj/item/gun/weapon, atom/target, params, zone_override, bonus_spread_values)
	SIGNAL_HANDLER
	var/addictional_spread = bonus_spread_values

	if(weapon.weapon_weight >= WEAPON_MEDIUM)
		addictional_spread += 20
		if(weapon.weapon_weight >= WEAPON_HEAVY)
			addictional_spread += 30
			knockback_user(weapon)

	weapon.spread = addictional_spread
	addtimer(CALLBACK(src, PROC_REF(after_gun_fired), weapon), 1 SECONDS)

/datum/component/weak_body/proc/knockback_user(obj/item/gun/weapon)
	var/mob/living/carbon/human/victim = parent
	if(HAS_TRAIT(victim, TRAIT_NEGATES_GRAVITY))
		return

	var/knockdown_range = weapon.weapon_weight
	if(istype(weapon, /obj/item/gun/ballistic/rocketlauncher))
		knockdown_range *= 2

	var/target_dir = turn(victim.dir, 180)
	var/knockdown_target = get_ranged_target_turf(victim, target_dir, knockdown_range)

	victim.Knockdown((weapon.weapon_weight * 2) SECONDS)
	victim.Paralyze(weapon.weapon_weight SECONDS)
	victim.visible_message(span_warning("[victim.name] shoot from [weapon.name], but the recoil was so strong it knocked [victim.p_they()] backwards!"), span_danger("The violent recoil sent you flying backwards!"))
	victim.throw_at(knockdown_target, knockdown_range, weapon.weapon_weight)

/datum/component/weak_body/proc/after_gun_fired(obj/item/gun/weapon)
	// Возращаем оружие в норму.
	weapon.spread = initial(weapon.spread)

// ДЕБАФ НА ДВУРУЧНОЕ ОРУЖИЕ
// Сбивает нас с ног, если мы используем двуручное оружие. Можем защититься с помощью магнитных ботинок!
/datum/component/weak_body/proc/aftet_attack_act(mob/user, atom/target, obj/item/weapon, proximity_flag, click_parameters)
	SIGNAL_HANDLER
	if(!ismob(target))
		return

	var/mob/living/carbon/human/victim = parent
	var/obj/item/inactive = victim.get_inactive_held_item()

	if(!istype(inactive, /obj/item/offhand))
		return

	if(check_antagonists() || check_mod() || HAS_TRAIT(parent, TRAIT_NEGATES_GRAVITY))
		return

	victim.visible_message(span_danger("[victim.name] fall aftet attack [target], [weapon.name] too heavy for [victim.p_their()]"), span_danger("You attack [target], but [weapon.name] too heavy for you."))
	victim.Knockdown(3 SECONDS)
	victim.Stun(2 SECONDS)
