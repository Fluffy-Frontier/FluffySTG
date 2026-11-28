GLOBAL_VAR_INIT(merged_huds, merge_huds())

/proc/merge_huds()
	var/icon/huds = icon(DEFAULT_HUDS_DMI)
	var/list/icon/additional_huds = list(
		icon('tff_modular/modules/custom_huds/icons/hud.dmi')
	)

	for(var/icon/hud in additional_huds)
		for(var/state in icon_states(hud))
			huds.Insert(icon(hud, state), state)
	return huds
