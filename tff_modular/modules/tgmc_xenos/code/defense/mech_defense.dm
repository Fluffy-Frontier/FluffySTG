/// TGMC_XENOS (old nova sector xenos)

// Переопределяем прока атаки у меха, ведь мехи по сути неубиваемые для ксеносов
/obj/vehicle/sealed/mecha/attack_alien(mob/living/user, list/modifiers)
	// Если это обычный ксенос - выполняется обычный прок, если нет - наш
	if(!istype(user, /mob/living/carbon/alien/adult/tgmc))
		return ..()

	log_message("Attack by alien. Attacker - [user].", LOG_MECHA, color="red")
	playsound(loc, 'sound/items/weapons/slash.ogg', 100, TRUE)
	attack_generic(user, rand(user.mech_damage_lower, user.mech_damage_upper), BRUTE, MELEE, 0)
