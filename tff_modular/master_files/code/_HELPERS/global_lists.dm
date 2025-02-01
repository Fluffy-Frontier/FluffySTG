/proc/init_blooper_prefs()
	for(var/sound_blooper_path in subtypesof(/datum/blooper))
		var/datum/blooper/B = new sound_blooper_path()
		GLOB.blooper_list[B.id] = sound_blooper_path
		if(B.allow_random)
			GLOB.blooper_random_list[B.id] = sound_blooper_path

/proc/init_ds_bloody_runes()
	for(var/i = 1 to 10)
		GLOB.necro_runes += iconstate2appearance('tff_modular/modules/deadspace/icons/effects/runes.dmi', "rune-[i]")
