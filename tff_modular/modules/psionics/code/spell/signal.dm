/datum/action/cooldown/spell/psionic/signal
	name = "Psionic Signal"
	desc = "Sends a signal to all psionics in the sector."
	mana_cost = 5

/datum/action/cooldown/spell/psionic/signal/can_cast_spell(feedback)
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_INCAPACITATED))
		return SPELL_CANCEL_CAST

/datum/action/cooldown/spell/psionic/signal/cast(atom/cast_on)
	. = ..()
	var/mob/living/caster = cast_on
	var/list/mob/living/psionic_list = list()
	if(isnull(psionic_list))
		for(var/mob/living/psionics as anything in world)
			if(!psionics.get_psionic())
				continue
			if(psionics.stat == DEAD)
				continue
			if(psionics.psi_sensivity.is_suppressed())
				continue
			if(!is_valid_z_level(caster.z, psionics.z))
				continue
			psionic_list += psionics

	if(isnull(psionic_list))
		to_chat(caster, span_horizonblue("There is no one you can send signal."))
		return FALSE

	var/text = tgui_input_text(caster, "Psionic Signal", "What kind of signal do you want to send to other psionics?", "Meow", 400)
	if(!text || caster.stat == DEAD || QDELETED(caster))
		return FALSE

	text = lowertext(text)

	to_chat(psionic_list, span_horizonblue("[text]"))
