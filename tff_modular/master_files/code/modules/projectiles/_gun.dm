/obj/item/gun/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	var/addictional_spread = bonus_spread
	if(HAS_TRAIT(user, TRAIT_WEAK_BODY) && weapon_weight > 1)
		addictional_spread += 40
		if(weapon_weight > 2)
			addictional_spread += 20
	..(target, user, message, params, zone_override, addictional_spread)
