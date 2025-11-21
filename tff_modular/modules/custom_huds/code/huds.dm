GLOBAL_VAR_INIT(merged_huds, merge_huds())

/proc/merge_huds()
	var/icon/huds = icon('modular_nova/master_files/icons/mob/huds/hud.dmi')
	var/list/icon/additional_huds = list(
		icon('tff_modular/modules/custom_huds/icons/hud.dmi'),
		icon('tff_modular/modules/tgmc_xenos/icons/xeno_hud.dmi'),
	)

	for(var/icon/hud in additional_huds)
		for(var/state in icon_states(hud))
			huds.Insert(icon(hud, state), state)
	return huds
