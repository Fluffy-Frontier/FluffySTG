/datum/action/cooldown/spell/pointed/psionic/zona_bovinae
	name = "Zona Bovinae Absorption"
	desc = "Absorb a psionic energy from a being's Zona Bovinae, granting you an extra point to be used in the Point Shop. The victim will not be able to make it psionic energy stronger in future."
	button_icon_state = "tech_illusion"
	mana_cost = 0
	cooldown_time = 10 SECONDS
	point_cost = 0
	locked = FALSE
	psionic_level = 2
	category = "Tier 2"
	cast_range = 2

/datum/action/cooldown/spell/pointed/psionic/zona_bovinae/is_valid_target(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/victim = cast_on
	if(!iscarbon(victim))
		to_chat(owner, span_horizonblue("Victim need to be a humanoid!"))
		return FALSE
	if(!victim.mind)
		to_chat(owner, span_horizonblue("Victim need to have mind!"))
		return FALSE
	if(victim.stat == DEAD)
		to_chat(owner, span_horizonblue("There is nothing interesting..."))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/zona_bovinae/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/absorber = owner
	var/mob/living/carbon/human/victim = cast_on
	to_chat(absorber, span_horizonblue("You're trying to get into the [victim]'s mind..."))
	to_chat(victim, span_horizonblue("You feel like [absorber] entering your mind..."))
	if(!do_after(absorber, 10 SECONDS, victim, extra_checks=CALLBACK(src, PROC_REF(still_near))))
		return FALSE
	victim.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10, 80)
	victim.Paralyze(8 SECONDS)
	to_chat(absorber, span_horizonblue("You're trying to get [victim]'s memories..."))
	to_chat(victim, span_horizonblue("You feel like [absorber] touching your memories..."))
	victim.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20, 80)
	victim.Paralyze(8 SECONDS)
	if(!do_after(absorber, 10 SECONDS, victim, extra_checks=CALLBACK(src, PROC_REF(still_near))))
		return FALSE
	to_chat(absorber, span_horizonblue("You're trying to absorb [victim]'s Zona Bovinae..."))
	to_chat(victim, span_horizonblue("You feel like [absorber] empties your mind..."))
	if(!do_after(absorber, 10 SECONDS, victim, extra_checks=CALLBACK(src, PROC_REF(still_near))))
		return FALSE
	victim.adjust_organ_loss(ORGAN_SLOT_BRAIN, 50, 80)
	victim.Paralyze(8 SECONDS)
	ADD_TRAIT(victim, TRAIT_ZONA_BOVINAE_ABSORBED, PSIONIC_TRAIT)
	psionic_datum.psi_point += 1
	to_chat(absorber, span_horizonblue("You absorbed [victim]'s Zona Bovinae!"))
	to_chat(victim, span_horizonblue("You feel like your mind shattered."))

/datum/action/cooldown/spell/pointed/psionic/zona_bovinae/proc/still_near(mob/living/carbon/human/absorber, mob/living/carbon/human/victim)
	var/distance = get_dist(absorber, victim)
	if(distance > cast_range)
		return FALSE
	return TRUE
