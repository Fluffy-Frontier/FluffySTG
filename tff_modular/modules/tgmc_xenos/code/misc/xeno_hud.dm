/// TGMC_XENOS (old nova sector xenos)

/datum/atom_hud/data/xeno
	hud_icons = list(XENO_HUD, XENOPLASMA_HUD)


/mob/living/carbon/alien/adult/tgmc/med_hud_set_health()
	xeno_hud_set_health()

/mob/living/carbon/alien/adult/tgmc/adjustPlasma(amount)
	. = ..()
	xeno_hud_set_plasma()


/mob/living/carbon/alien/adult/tgmc/proc/xeno_hud_set_health()
	if(QDELETED(src))
		return

	var/amount = 0
	if(stat != DEAD)
		amount = health > 0 ? round(health * 100 / maxHealth, 10) : CEILING(health, 10)
		if(health < 0)
			amount = round((health / (HEALTH_THRESHOLD_DEAD)) * -100, 10)
		else
			amount = CEILING((health / maxHealth) * 100, 10)
		if(!amount)
			amount = -1 //don't want the 'zero health' icon when we are crit

	set_hud_image_state(XENO_HUD, "xenohealth[amount]", 32, -32)

/mob/living/carbon/alien/adult/tgmc/proc/xeno_hud_set_plasma()
	var/amount = 0
	if(stat != DEAD || get_max_plasma() > 0)
		amount = round(getPlasma() * 100 / get_max_plasma(), 10)

	set_hud_image_state(XENOPLASMA_HUD, "plasma[amount]", 32, -32)
