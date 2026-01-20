/// TGMC_XENOS (old nova sector xenos)

// Переопределяем прока атаки у меха, ведь мехи по сути неубиваемые для ксеносов
/obj/vehicle/sealed/mecha/attack_alien(mob/living/carbon/alien/adult/tgmc/user, list/modifiers)
	// Если это обычный ксенос - выполняется обычный прок, если нет - наш
	if(!istype(user))
		return ..()

	log_message("Attack by alien. Attacker - [user].", LOG_MECHA, color="red")
	playsound(loc, 'sound/items/weapons/slash.ogg', 100, TRUE)
	var/damage = rand(user.melee_damage_lower, user.melee_damage_upper)
	attack_generic(user, damage, BRUTE, MELEE, 0, armor_penetration = user.mecha_armor_penetration)

// Так как плевки не могут наносить урон мехам из-за их брони к кислоте, то мы просто будем переопределять armor_flag этих самых плевков с кислоты на лазер
/obj/vehicle/sealed/mecha/bullet_act(obj/projectile/source, def_zone, mode)
	if(istype(source, /obj/projectile/neurotoxin/tgmc/acid))
		source.armor_flag = LASER
		source.damage /= 2
	return ..()

/obj/durand_shield/projectile_hit(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE, blocked = null)
	if(istype(hitting_projectile, /obj/projectile/neurotoxin/tgmc/acid))
		hitting_projectile.armor_flag = LASER
		hitting_projectile.damage /= 2
	return ..()
