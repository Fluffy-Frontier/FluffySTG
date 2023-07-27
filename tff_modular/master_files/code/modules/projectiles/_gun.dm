/obj/item/gun/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	var/addictional_spread = bonus_spread
	if(HAS_TRAIT(user, TRAIT_WEAK_BODY) && weapon_weight > 1)
		addictional_spread += 40
		if(weapon_weight > 2 && !do_weapon_knockback(user, weapon_weight))
			addictional_spread += 20
	..(target, user, message, params, zone_override, addictional_spread)

// Оружие имеет такую сильную отдачу, что откидывает пользователя назад, нанося ему вред.
/obj/item/gun/proc/do_weapon_knockback(mob/living/user, weapon_weigh, force = TRUE)
	if(!user)
		return FALSE
	if(HAS_TRAIT(user, TRAIT_NEGATES_GRAVITY))
		return FALSE

	var/knockdown_range = weapon_weigh
	if(istype(src, /obj/item/gun/ballistic/rocketlauncher))
		knockdown_range *= 2
	var/target_dir = NORTH
	if(user.dir == NORTH)
		target_dir = SOUTH
	else if(user.dir == WEST)
		target_dir = EAST
	else if(user.dir == EAST)
		target_dir = WEST
	var/target = get_ranged_target_turf(user, target_dir, knockdown_range)

	if(force)
		user.Knockdown(weapon_weigh * 2)
		user.Paralyze(weapon_weigh)

	user.visible_message(span_warning("[user.name] shoot from [src.name], but the recoil was so strong it knocked [user.p_they()] backwards!"), span_danger("The violent recoil sent you flying backwards!"))
	user.throw_at(target, knockdown_range, weapon_weigh)
	return TRUE
