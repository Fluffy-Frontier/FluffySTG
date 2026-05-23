/datum/action/cooldown/spell/psionic/sunder
	name = "Psionic Sunder"
	desc = "Destroy a Zona Bovinae of psionic creature you pulling. This will make them force-suppressed."
	button_icon_state = "ling_berserk"
	category = "Tier 2"
	cooldown_time = 10 SECONDS
	psionic_level = 2
	mana_cost = 30
	locked = FALSE

/datum/action/cooldown/spell/psionic/sunder/before_cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/human_living = cast_on
	var/mob/living/carbon/human/victim = human_living.pulling
	var/datum/psionic/victim_psionic = victim.get_psionic()
	if(!victim)
		to_chat(human_living, span_horizonblue("You must grab victim to use this ability!"))
		return FALSE
	if(!victim_psionic)
		to_chat(human_living, span_horizonblue("Not a Psionic!"))
		return FALSE
	if(victim_psionic.get_level() > 1)
		to_chat(human_living, span_horizonblue("Their psi mind is too strong!"))
		return FALSE

/datum/action/cooldown/spell/psionic/sunder/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/human_living = cast_on
	var/mob/living/carbon/human/victim = human_living.pulling
	to_chat(victim, span_big(span_horizonblue("You feel your psionic energy leaving your mind...")))
	if(!do_after(human_living, 10 SECONDS, victim))
		return FALSE
	ADD_TRAIT(victim, TRAIT_PSIONIC_SUPPRESSED, SUNDER_TRAIT)
	playsound(human_living, 'tff_modular/modules/psionics/sounds/power_fabrication.ogg', 50, TRUE)
