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
	psionic_level = 2
	point_cost = 2

/datum/action/cooldown/spell/pointed/projectile/psionic/air_bullet/before_cast(atom/cast_on)
	. = ..()
	if(do_after(owner, 0.5 SECONDS, timed_action_flags = IGNORE_USER_LOC_CHANGE | IGNORE_SLOWDOWNS))
		return FALSE
	psionic_datum.adjust_psi_energy(-10)

/obj/projectile/magic/air_bullet
	damage = 20

// Стреляет снарядом вотчера, замораживая жертву. Требует почти максимально возможный запас маны
/datum/action/cooldown/spell/pointed/projectile/psionic/freeze
	name = "Psionic Freeze"
	desc = "Fire freezing shark at a target, encasing them in an ice prison."
	button_icon = 'icons/effects/freeze.dmi'
	button_icon_state = "ice_cube"
	cooldown_time = 1 SECONDS
	mana_cost = 35
	cast_range = 9
	active_msg = "You prepare to fire ice shard..."
	deactive_msg = "You relax."
	projectile_type = /obj/projectile/temp/watcher/psionic_freeze
	psionic_level = 2
	point_cost = 1
	category = "manipulation"

/datum/action/cooldown/spell/pointed/projectile/psionic/freeze/is_valid_target(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/projectile/psionic/freeze/cast(mob/living/cast_on)
	drain_mana()
	. = ..()
	return TRUE

// Вывел в отдельный тип, потому что в оригинальном ice_wing снаряде видимо баг(?) и он не замораживает, хотя должен.
/obj/projectile/temp/watcher/psionic_freeze
	name = "freezing blast"
	damage = 0 // Нет дамага, вместо этого замораживает

/obj/projectile/temp/watcher/psionic_freeze/apply_status(mob/living/target)
	if(HAS_TRAIT(target, TRAIT_RESISTCOLD)) // Вот тут у ice_wing лишний !
		return
	target.apply_status_effect(/datum/status_effect/freon/watcher/psionic_freeze)

/datum/status_effect/freon/watcher/psionic_freeze
	duration = 4 // 4 секунды вместо 8
	can_melt = TRUE
