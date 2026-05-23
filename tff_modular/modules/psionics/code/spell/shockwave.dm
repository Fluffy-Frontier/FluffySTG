/datum/action/cooldown/spell/psionic/shockwave
	name = "Psionic Shockwave"
	desc = "Create a wave of telekinetic energy to pummel the ground around you."
	button_icon_state = "tech_corona"
	category = "Tier 2"
	mana_cost = 20
	cooldown_time = 50 SECONDS
	point_cost = 1
	locked = FALSE
	psionic_level = 2

/datum/action/cooldown/spell/psionic/shockwave/can_cast_spell(feedback)
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_INCAPACITATED))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/psionic/shockwave/before_cast(atom/cast_on)
	. = ..()
	if(isspaceturf(get_turf(cast_on)))
		to_chat(cast_on, span_horizonblue("You charge your shockwave, slam your foot down... and then remember that you're in space."))
		return SPELL_CANCEL_CAST

/datum/action/cooldown/spell/psionic/shockwave/cast(atom/cast_on)
	. = ..()
	for(var/mob/living/victims as anything in get_hearers_in_view(7, cast_on))
		if(!isliving(victims))
			continue
		if(victims == cast_on)
			continue
		shake_camera(victims, 2 SECONDS, 2)
		victims.Paralyze(2 SECONDS)
	cast_on.visible_message(span_horizonblue("[cast_on]'s foot starts to cover in blue energy, and then he stomps on the floor"), span_horizonblue("You channel psionic energy into your foot, and then stomp on the floor."))
	playsound(cast_on, 'sound/effects/meteorimpact.ogg', 100, TRUE)
