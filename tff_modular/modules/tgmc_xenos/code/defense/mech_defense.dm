/// TGMC_XENOS (old nova sector xenos)

// Переопределяем прока атаки у меха, ведь мехи по сути неубиваемые для ксеносов
/obj/vehicle/sealed/mecha/attack_alien(mob/living/carbon/alien/adult/tgmc/user, list/modifiers)
	// Если это обычный ксенос - выполняется обычный прок, если нет - наш
	if(!istype(user))
		return ..()

	log_message("Attack by alien. Attacker - [user].", LOG_MECHA, color="red")
	playsound(loc, 'sound/items/weapons/slash.ogg', 100, TRUE)
	var/damage = round(rand(user.melee_damage_lower, user.melee_damage_upper) * user.mech_damage_multiplier)
	attack_generic(user, damage, BRUTE, MELEE, 0)
