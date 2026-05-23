/datum/action/cooldown/spell/pointed/psionic/awakening
	name = "Psionic Awaken"
	desc = "Stimulate a living being's Zona Bovinae and bring them to Psionically Harmonious rank."
	button_icon_state = "const_repairaura"
	mana_cost = 0
	cooldown_time = 10 SECONDS
	point_cost = 3
	locked = FALSE
	psionic_level = 2
	category = "Tier 2"
	cast_range = 2
	var/is_psionic = FALSE

/datum/action/cooldown/spell/pointed/psionic/awakening/is_valid_target(atom/cast_on)
	var/mob/living/victim = cast_on
	var/datum/psionic/victim_psionic = victim.get_psionic()
	if(!isliving(victim))
		return FALSE
	if(istype(victim_psionic, /datum/psionic/harmonious))
		to_chat(owner, span_horizonblue("Their psi sensivity is strong enough!"))
		return FALSE
	if(HAS_TRAIT(victim, TRAIT_ZONA_BOVINAE_ABSORBED))
		to_chat(owner, span_horizonblue("Their psi sensivity is shattered!"))
		return FALSE
	if(HAS_TRAIT(victim, TRAIT_PSIONIC_INFLUENCED))
		to_chat(owner, span_horizonblue("Their psi sensivity is already influenced!"))
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/awakening/before_cast(atom/cast_on)
	. = ..()
	var/mob/living/victim = cast_on
	if(HAS_TRAIT(victim, TRAIT_PSIONIC_USER))
		is_psionic = TRUE

/datum/action/cooldown/spell/pointed/psionic/awakening/cast(atom/cast_on)
	. = ..()
	var/mob/living/victim = cast_on
	to_chat(victim, span_horizonblue("You can feel your psionic energy getting stronger..."))
	if(!do_after(owner, 10 SECONDS, victim))
		return FALSE
	if(is_psionic)
		victim.remove_psionic()
		victim.add_psionic(/datum/psionic/harmonious)
		victim.psi_sensivity.psi_point = 7
	else
		victim.add_psionic(/datum/psionic/sensitive)

	ADD_TRAIT(victim, TRAIT_PSIONIC_INFLUENCED, PSIONIC_TRAIT)
