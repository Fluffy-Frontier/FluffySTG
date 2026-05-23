/datum/action/cooldown/spell/psionic/stamina
	name = "Psionic Nutrients Weave"
	desc = "Activate this spell to regenerate your nutrients a little bit."
	button_icon_state = "tech_mend_template"
	point_cost = 1
	cooldown_time = 20 SECONDS
	mana_cost = 5
	locked = FALSE
	var/charging = FALSE

/datum/action/cooldown/spell/psionic/stamina/cast(atom/cast_on)
	. = ..()
	regenerate_nutrients(cast_on)
	return TRUE

/datum/action/cooldown/spell/psionic/stamina/before_cast(atom/cast_on)
	if(charging)
		return SPELL_CANCEL_CAST

/datum/action/cooldown/spell/psionic/stamina/proc/regenerate_nutrients(mob/living/carbon/human/human_living)
	if(!do_after(human_living, 1 SECONDS))
		charging = FALSE
		return FALSE
	charging = TRUE
	human_living.adjust_nutrition(5)
	playsound(human_living, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	regenerate_nutrients(human_living)
	drain_mana()
