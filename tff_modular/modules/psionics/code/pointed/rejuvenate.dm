/datum/action/cooldown/spell/pointed/psionic/rejuvenate
	name = "Psionic Rejuvenate"
	desc = "Restore a creature's blood and tried to and try to revive it."
	button_icon_state = "tech_resurrect"
	cast_range = 3
	point_cost = 3
	mana_cost = 80
	psionic_level = 2
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/rejuvenate/is_valid_target(atom/cast_on)
	if(iscarbon(cast_on))
		var/mob/living/carbon/human = cast_on
		if(human.stat == DEAD)
			return TRUE
		return FALSE
	return FALSE

/datum/action/cooldown/spell/pointed/psionic/rejuvenate/cast(atom/cast_on)
	. = ..()
	if(iscarbon(cast_on))
		var/mob/living/carbon/carbon_living = cast_on
		for(var/i in 1 to 3)
			if(!do_after(owner, 5 SECONDS, carbon_living, timed_action_flags = IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE))
				return FALSE

			carbon_living.heal_overall_damage(30, 30)
			playsound(carbon_living, 'sound/effects/singlebeat.ogg', vol = 50, vary = TRUE, ignore_walls = FALSE)
			playsound(carbon_living, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
			var/original_transform = carbon_living.transform
			animate(carbon_living, transform = carbon_living.transform.Translate(0, 3), time = 0.2 SECONDS, easing = CUBIC_EASING | EASE_OUT, flags = ANIMATION_PARALLEL)
			animate(transform = original_transform, time = 0.2 SECONDS, easing = CUBIC_EASING | EASE_IN, flags = ANIMATION_PARALLEL)

			carbon_living.visible_message(
				message = span_danger("\The [carbon_living] shake[carbon_living.p_their()] violently!"),
				ignored_mobs = owner
			)

		carbon_living.cure_husk()
		carbon_living.regenerate_organs(TRUE)
		carbon_living.regenerate_limbs()
		carbon_living.adjust_blood_volume(BLOOD_VOLUME_NORMAL, 0, BLOOD_VOLUME_NORMAL)
		if(!carbon_living.revive())
			owner.balloon_alert(owner, "revival failed!")
			return FALSE

		to_chat(owner, span_horizonblue("You successfully revive \the [owner]!"))
		drain_mana()
	else
		return FALSE
	return TRUE
