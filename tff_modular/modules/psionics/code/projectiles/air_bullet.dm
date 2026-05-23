// Тут все заклинания, создающие снаряды.
/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet
	name = "Psionic Air Bullet"
	desc = "Wrap air in a psionic bubble, compress it, then send it flying at your enemies."
	button_icon_state = "tech_repelmissiles"
	cooldown_time = 1 SECONDS
	mana_cost = 10
	cast_range = 9
	active_msg = "You prepare to charge air bullet..."
	deactive_msg = "You relax."
	projectile_type = /obj/projectile/magic/air_bullet
	projectile_amount = INFINITY
	psionic_level = 1
	point_cost = 2
	locked = FALSE

/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet/ready_projectile(obj/projectile/to_fire, atom/target, mob/user, iteration)
	. = ..()
	to_fire.damage = 10 * cast_power

/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet/fire_projectile(atom/target)
	. = ..()
	drain_mana()
	playsound(owner, 'tff_modular/modules/psionics/sounds/power_feedback.ogg', 50, TRUE)

/obj/projectile/magic/air_bullet
	icon = 'tff_modular/modules/psionics/icons/projectiles.dmi'
	icon_state = "air_bubble"
	damage = 10
	damage_type = BRUTE
