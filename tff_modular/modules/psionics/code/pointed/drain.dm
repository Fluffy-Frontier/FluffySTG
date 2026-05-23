/datum/action/cooldown/spell/pointed/psionic/drain
	name = "Psionic Drain"
	desc = "Drain psi-stamina from a living being, will harm it!"
	button_icon_state = "gen_project"
	cooldown_time = 10 SECONDS
	psionic_level = 1
	point_cost = 2
	mana_cost = 0
	locked = FALSE
	cast_range = 3

/datum/action/cooldown/spell/pointed/psionic/drain/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE
	if(cast_on == owner)
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/drain/cast(atom/cast_on)
	. = ..()
	drain_psi_stamina(cast_on)
	to_chat(cast_on, span_horizonblue("You begin to feel weak..."))

/datum/action/cooldown/spell/pointed/psionic/drain/proc/drain_psi_stamina(atom/cast_on)
	var/mob/living/carbon/human/victim = cast_on
	if(!do_after(owner, 1 SECONDS, victim, IGNORE_TARGET_LOC_CHANGE))
		return FALSE
	victim.adjust_stamina_loss(10)
	psionic_datum.adjust_psi_energy(10)
	to_chat(victim, span_horizonblue("You're getting worse..."))
	playsound(victim, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	drain_psi_stamina(victim)
