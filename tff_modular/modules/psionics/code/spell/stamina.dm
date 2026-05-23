/datum/action/cooldown/spell/psionic/stamina
	name = "Psionic Stamina Weave"
	desc = "Activate this spell to regenerate your psi-mana and nutrients a little bit."
	button_icon_state = "tech_mend_template"
	point_cost = 1
	cooldown_time = 20 SECONDS
	mana_cost = 0
	locked = FALSE
	var/charging = FALSE

/datum/action/cooldown/spell/psionic/stamina/cast(atom/cast_on)
	. = ..()
	regenerate_stamina(cast_on)
	return TRUE

/datum/action/cooldown/spell/psionic/stamina/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return charging

/datum/action/cooldown/spell/psionic/stamina/proc/regenerate_stamina(mob/living/carbon/human/human_living)
	if(!do_after(human_living, 1 SECONDS))
		charging = FALSE
		return FALSE
	charging = TRUE
	psionic_datum.adjust_psi_energy(5)
	human_living.adjust_nutrition(5)
	playsound(human_living, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	regenerate_stamina(human_living)
