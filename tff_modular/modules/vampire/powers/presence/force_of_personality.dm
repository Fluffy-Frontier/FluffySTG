/datum/action/cooldown/vampire/force_of_personality
	name = "Force of Personality"
	desc = "Project an overwhelming aura of authority that causes those around you to fall down."
	button_icon_state = "power_fop"
	power_explanation = "Project an aura around yourself that subtly pushes people to fall down.\n\
						Effects on those in 3 tile range.\n\
						Targets must be able to see you to be affected."
	vampire_power_flags = BP_AM_TOGGLE
	vampire_check_flags = BP_CANT_USE_IN_TORPOR | BP_CANT_USE_WHILE_STAKED | BP_CANT_USE_IN_FRENZY
	vitaecost = 30
	constant_vitaecost = 2
	cooldown_time = 30 SECONDS
	/// The range of the aura in tiles, this is further than the actual effect just so we can hit them with the status effect before they even get close enough.
	var/aura_range = 3

/datum/action/cooldown/vampire/force_of_personality/two
	constant_vitaecost = 1

/datum/action/cooldown/vampire/force_of_personality/activate_power()
	. = ..()
	to_chat(owner, span_notice("You project an overwhelming sense of authority."), type = MESSAGE_TYPE_INFO)
	for(var/mob/living/carbon/victims as anything in oviewers(aura_range, owner))
		if(!can_affect(victims))
			continue
		victims.Knockdown(2 SECONDS)
		victims.Stun(1)
		to_chat(victims, span_awe("Bend Down!"))

	deactivate_power()

/// Checks if this victim can be affected by the force of personality aura
/datum/action/cooldown/vampire/force_of_personality/proc/can_affect(mob/living/victim)
	if(!victim.client)
		return FALSE
	if(HAS_SILICON_ACCESS(victim))
		return FALSE
	if(victim.stat != CONSCIOUS)
		return FALSE
	if(!iscarbon(victim))
		return FALSE
	if(victim.is_blind() || victim.is_nearsighted_currently())
		return FALSE
	if(HAS_MIND_TRAIT(victim, TRAIT_VAMPIRE_ALIGNED) || IS_CURATOR(victim))
		return FALSE
	return TRUE
