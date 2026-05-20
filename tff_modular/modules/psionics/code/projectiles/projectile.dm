// Тут все заклинания, создающие снаряды.
/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet
	name = "Psionic Air Bullet"
	desc = "Wrap air in a psionic bubble, compress it, then send it flying at your enemies."
	button_icon_state = "force_missle"
	cooldown_time = 1 SECONDS
	mana_cost = 0
	cast_range = 9
	active_msg = "You prepare to charge air bullet..."
	deactive_msg = "You relax."
	projectile_type = /obj/projectile/magic/air_bullet
	projectile_amount = INFINITY
	psionic_level = 1
	point_cost = 2
	locked = FALSE
	var/casting = FALSE

/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet/before_cast(atom/cast_on)
	. = ..()
	if(!casting)
		casting = TRUE
		if(!do_after(owner, 0.5 SECONDS, timed_action_flags = IGNORE_USER_LOC_CHANGE | IGNORE_SLOWDOWNS))
			return FALSE
		psionic_datum.adjust_psi_energy(-10)
	else
		return FALSE

/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet/cast(atom/cast_on)
	. = ..()
	casting = FALSE

/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet/ready_projectile(obj/projectile/to_fire, atom/target, mob/user, iteration)
	. = ..()
	to_fire.damage = 10 * cast_power

/obj/projectile/magic/air_bullet
	icon = 'tff_modular/modules/psionics/icons/projectiles.dmi'
	icon_state = "air_bubble"
	damage = 10
	damage_type = BRUTE

// Стреляет снарядом вотчера, замораживая жертву. Требует почти максимально возможный запас маны
/datum/action/cooldown/spell/pointed/projectile/psionic/freeze
	name = "Psionic Freeze"
	desc = "Fire freezing shark at a target, encasing them in an ice prison."
	button_icon = 'icons/effects/freeze.dmi'
	button_icon_state = "ice_cube"
	cooldown_time = 1 SECONDS
	mana_cost = 20
	cast_range = 9
	active_msg = "You prepare to fire ice shard..."
	deactive_msg = "You relax."
	projectile_type = /obj/projectile/temp/watcher/psionic_freeze
	psionic_level = 1
	point_cost = 1
	category = "Tier 1"
	locked = FALSE

/datum/action/cooldown/spell/pointed/projectile/psionic/freeze/cast(mob/living/cast_on)
	drain_mana()
	. = ..()
	return TRUE

/datum/action/cooldown/spell/pointed/projectile/psionic/freeze/ready_projectile(obj/projectile/to_fire, atom/target, mob/user, iteration)
	. = ..()
	var/obj/projectile/temp/watcher/psionic_freeze/psi_freeze = to_fire
	psi_freeze.power = cast_power

// Вывел в отдельный тип, потому что в оригинальном ice_wing снаряде видимо баг(?) и он не замораживает, хотя должен.
/obj/projectile/temp/watcher/psionic_freeze
	name = "freezing blast"
	damage = 0 // Нет дамага, вместо этого замораживает
	var/power = 1

/obj/projectile/temp/watcher/psionic_freeze/apply_status(mob/living/target)
	if(HAS_TRAIT(target, TRAIT_RESISTCOLD)) // Вот тут у ice_wing лишний !
		return
	target.set_timed_status_effect(power * 4, /datum/status_effect/freon/watcher/psionic_freeze)

/datum/status_effect/freon/watcher/psionic_freeze
	duration = 4 SECONDS
	can_melt = TRUE
