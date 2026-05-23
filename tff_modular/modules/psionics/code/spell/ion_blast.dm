// Создаёт ЕМП в месте удара руки
/datum/action/cooldown/spell/psionic/emp
	name = "Ion Blast"
	desc = "Cause a small, but powerful EMP."
	button_icon_state = "tech_overload"
	cooldown_time = 30 SECONDS
	mana_cost = 50
	psionic_level = 2
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/psionic/emp/cast(atom/cast_on)
	. = ..()
	empulse(cast_on.loc, 3, 3)
	playsound(cast_on, 'tff_modular/modules/psionics/sounds/power_fail.ogg', 50, TRUE)
	drain_mana()
