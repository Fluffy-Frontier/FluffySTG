/// TGMC_XENOS (old nova sector xenos)

#define ROUNY_ICON_FILE 'tff_modular/modules/tgmc_xenos/icons/rouny.dmi'

/mob/living/carbon/alien/adult/tgmc/update_icon(updates)
	if(GLOB.xeno_rounymode && icon_exists(ROUNY_ICON_FILE, icon_state))
		icon = ROUNY_ICON_FILE
	else if(icon == ROUNY_ICON_FILE)
		icon = initial(icon)
	return ..()

/proc/toggle_rouny_mode()
	GLOB.xeno_rounymode = !GLOB.xeno_rounymode
	for(var/mob/living/carbon/alien/adult/tgmc/xeno in GLOB.alive_mob_list)
		xeno.update_icon()

#undef ROUNY_ICON_FILE
