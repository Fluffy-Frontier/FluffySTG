/datum/action/cooldown/spell/pointed/psionic/psi_throw
	name = "Psionic Throw"
	desc = "Throw an object in the opposite direction from yourself. Works on living beings."
	button_icon_state = "wiz_mm"
	category = "Tier 2"
	cooldown_time = 25 SECONDS
	psionic_level = 2
	point_cost = 2
	mana_cost = 20
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/psi_throw/is_valid_target(atom/cast_on)
	if(cast_on == owner)
		return FALSE
	if(isobj(cast_on) || isliving(cast_on))
		var/atom/movable/AM = cast_on
		if(AM.anchored)
			return FALSE
		return TRUE
	return FALSE

/datum/action/cooldown/spell/pointed/psionic/psi_throw/cast(atom/cast_on)
	. = ..()
	var/turf/throwtarget = get_edge_target_turf(owner, get_dir(owner, get_step_away(cast_on, owner)))
	var/dist_from_caster = get_dist(cast_on, owner)
	if(dist_from_caster == 0)
		if(isliving(cast_on))
			var/mob/living/victim = cast_on
			victim.Paralyze(10 SECONDS)
			victim.adjust_brute_loss(5)
			to_chat(victim, span_userdanger("You're psionically slammed into the floor by [owner]!"))
	else
		if(isliving(cast_on))
			var/mob/living/victim = cast_on
			victim.Paralyze(2 SECONDS)
			to_chat(victim, span_userdanger("You're psionically thrown back by [owner]!"))

		var/atom/movable/to_throw = cast_on
		to_throw.safe_throw_at(
			target = throwtarget,
			range = 4 * cast_power,
			speed = 2,
			thrower = owner,
			force = MOVE_FORCE_STRONG,
		)

	playsound(owner, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	drain_mana()
	return TRUE
