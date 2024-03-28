GLOBAL_VAR_INIT(merged_huds, merge_huds())

/proc/merge_huds()
	var/icon/huds = new('modular_nova/master_files/icons/mob/huds/hud.dmi')
	var/icon/ff_huds = new('tff_modular/modules/custom_huds/icons/hud.dmi')

	for(var/state in icon_states(ff_huds))
		huds.Insert(icon(ff_huds, state), state)
	return huds
