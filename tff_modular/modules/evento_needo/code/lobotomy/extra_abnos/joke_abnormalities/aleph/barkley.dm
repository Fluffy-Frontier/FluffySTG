/mob/living/simple_animal/hostile/abnormality/barkley
	name = "Charles Barkley Shut Up And Jam Gaiden: Part 1 of the Hoopz Barkley Saga"
	desc = "A large man wearing a basketball jersey."
	health = 4000
	maxHealth = 4000
	pixel_x = -12
	base_pixel_x = -12
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x64.dmi'
	icon_state = "barkley"
	icon_living = "barkley"
	damage_coeff = list(BRUTE = 1, BRUTE = 1, BRUTE = 1)
	del_on_death = FALSE

	ego_list = list(
		/datum/ego_datum/weapon/chaosdunk,
		/datum/ego_datum/armor/chaosdunk,
	)
	var/explosion_amt = 3

/mob/living/simple_animal/hostile/abnormality/barkley/ZeroQliphoth(mob/living/carbon/human/user)
	. = ..()
	ChaosDunk(user)

/mob/living/simple_animal/hostile/abnormality/barkley/OnQliphothChange()
	. = ..()
	if(datum_reference.qliphoth_meter == 1)
		icon_state = "barkley_angry"
	else
		icon_state = icon_living

/mob/living/simple_animal/hostile/abnormality/barkley/proc/ChaosDunk()
	show_global_blurb(10 SECONDS, "CHAOS DUNK ADVISORY", text_align = "center", screen_location = "Center-6,Center+3")
	priority_announce("FACILITY CHAOS DUNK ADVISORY WARNING! A MEASURED 19.7 MEGAJOULE OF NEGATIVE B-BALL PROTONS HAS BEEN DETECTED.\
	A CHAOS DUNK IS IMMINENET. FIND SHELTER IMMEDIATELY. THIS IS NOT A DRILL.", "Chaos Dunk Advisory", sound='tff_modular/modules/evento_needo/sounds/Tegusounds/combat_suppression_start.ogg')
	explosion(src, 20, 20)
	sleep(10 SECONDS)
	Explode()
	play_cinematic(/datum/cinematic/chaosdunk, world)

/mob/living/simple_animal/hostile/abnormality/barkley/proc/Explode()
	set waitfor = FALSE
	sleep(5 SECONDS)
	var/list/spawns = GLOB.generic_event_spawns.Copy()
	var/list/depts = GLOB.generic_event_spawns.Copy()
	for(var/i = 1 to explosion_amt)
		if(prob(70))
			for(var/turf/T in depts)
				explosion(T, 20, 20)
				sleep(10)
			continue
		for(var/turf/T in spawns)
			explosion(T, 20, 20)//this is in EVERY xenospawn
	qdel(src)


/datum/cinematic/chaosdunk

/datum/cinematic/chaosdunk/play_cinematic()
	flick("chaos_dunk",screen)
	stoplag(6.8 SECONDS)
	sound_to_playing_players(sound('tff_modular/modules/evento_needo/sounds/Tegusounds/nest_announcement.ogg'))
