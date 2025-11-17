/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc
	hud_possible = list(ANTAG_HUD, XENO_HUD)

/mob/living/carbon/alien/adult/tgmc/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_XENO_HUD, INNATE_TRAIT)

	var/datum/atom_hud/data/xeno/xeno_hud = GLOB.huds[DATA_HUD_XENO]
	xeno_hud.add_atom_to_hud(src)

/mob/living/carbon/alien/adult/tgmc/med_hud_set_health()
	if(QDELETED(src))
		return

	var/amount = 0
	if(stat != DEAD)
		amount = health > 0 ? round(health * 100 / maxHealth, 10) : CEILING(health, 10)
		if(health < 0)
			amount = round((health / (-maxHealth)) * -100, 10)
		else
			amount = CEILING((health / maxHealth) * 100, 10)
		if(!amount)
			amount = -1 //don't want the 'zero health' icon when we are crit

	set_hud_image_state(XENO_HUD, "xenohealth[amount]", 32, -32)

/datum/atom_hud/data/xeno
	hud_icons = list(XENO_HUD)
