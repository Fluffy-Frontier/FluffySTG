/datum/action/cooldown/spell/psionic/transparency
	name = "Psionic Transparency"
	desc = "You become invisible for 10 seconds. You can't take damage and interact with the world."
	button_icon_state = "tech_illusion"
	category = "Tier 2"
	cooldown_time = 120 SECONDS
	psionic_level = 2
	mana_cost = 70
	point_cost = 2
	locked = FALSE

/datum/action/cooldown/spell/psionic/transparency/is_valid_target(atom/cast_on)
	if(!iscarbon(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/psionic/transparency/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/living_human = cast_on
	living_human.apply_status_effect(/datum/status_effect/transparency)

/datum/status_effect/transparency
	id = "Transparency"
	status_type = STATUS_EFFECT_REFRESH
	duration = 10 SECONDS
	alert_type = null
	var/static/list/transparency_traits = list(TRAIT_GODMODE, TRAIT_HANDS_BLOCKED, TRAIT_SECLUDED_LOCATION)

/datum/status_effect/transparency/on_apply()
	animate(owner, alpha = 0, time = 1 SECONDS)
	owner.set_density(FALSE)
	RegisterSignal(owner, COMSIG_MOB_BEFORE_SPELL_CAST, PROC_REF(prevent_spell_usage))
	RegisterSignal(owner, COMSIG_CARBON_CUFF_ATTEMPTED, PROC_REF(prevent_cuff))
	RegisterSignal(owner, COMSIG_BEING_STRIPPED, PROC_REF(no_strip))
	owner.add_traits(transparency_traits, TRAIT_STATUS_EFFECT(id))
	return TRUE

/datum/status_effect/transparency/on_remove()
	owner.remove_traits(transparency_traits, TRAIT_STATUS_EFFECT(id))
	owner.alpha = initial(owner.alpha)
	owner.density = initial(owner.density)
	UnregisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_ALLOW_HERETIC_CASTING))
	UnregisterSignal(owner, COMSIG_MOB_BEFORE_SPELL_CAST)
	UnregisterSignal(owner, COMSIG_ATOM_HOLYATTACK)
	UnregisterSignal(owner, COMSIG_CARBON_CUFF_ATTEMPTED)
	UnregisterSignal(owner, COMSIG_BEING_STRIPPED)
	owner.visible_message(
		span_warning("The haze around [owner] disappears, leaving them materialized!"),
		span_notice("You exit the transparency."),
	)
	return TRUE

/datum/status_effect/transparency/get_examine_text()
	return span_horizonblue("How do you see [owner]?")

/datum/status_effect/transparency/proc/no_strip(atom/source, mob/user, obj/item/equipping)
	SIGNAL_HANDLER
	to_chat(user, span_warning("You fail to put anything on [source] as they are incorporeal!"))
	return COMPONENT_CANT_STRIP

/datum/status_effect/transparency/proc/prevent_spell_usage(datum/source, datum/spell)
	SIGNAL_HANDLER
	owner.balloon_alert(owner, "may not cast spells in transparency!")
	return SPELL_CANCEL_CAST

/datum/status_effect/transparency/proc/prevent_cuff(datum/source, mob/attemptee)
	SIGNAL_HANDLER
	return COMSIG_CARBON_CUFF_PREVENT
