/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/Initialize(mapload)
	. = ..()
	var/datum/component/boss_music/current = GetComponent(/datum/component/boss_music)
	current.boss_track = 'tff_modular/modules/megafauna_music/sounds/bdm_music.ogg'
	current.track_duration = 76 SECONDS
