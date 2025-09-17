//Coded by me, Kirie Saito!
/mob/living/simple_animal/hostile/abnormality/silence
	name = "The Price of Silence"
	desc = "A scythe with a clock attached, quietly ticking."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64.dmi'
	icon_state = "silence"
	fear_level = WAW_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/thirteen,
		/datum/ego_datum/armor/thirteen,
	)
	gift_type = /datum/ego_gifts/thirteen
	observation_prompt = "Time's wasting. <br>Time's running out... <br>They are nothing but meaningless tantrums. <br>\
		The watch will not only take your lost time back, but also give you even more time."


	var/meltdown_cooldown_time = 13 MINUTES
	var/meltdown_cooldown
	var/worldwide_damage = 70	//If you're unarmored, it obliterates you
	var/safe = FALSE //work on it and you're safe for 13 minutes
	var/reset_time = 3 MINUTES //Don't hit everyone with the global pale if it was hit in a small period of time
	var/datum/looping_sound/silence/soundloop // Tick-tock, tick-tock
	neutral_chance = 50

/mob/living/simple_animal/hostile/abnormality/silence/Initialize()
	. = ..()
	soundloop = new(list(src), TRUE)
	addtimer(CALLBACK(src, PROC_REF(meltdown_check)), meltdown_cooldown_time)

/mob/living/simple_animal/hostile/abnormality/silence/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/mob/living/simple_animal/hostile/abnormality/silence/SuccessEffect(mob/living/carbon/human/user)
	safe = TRUE
	to_chat(user, span_nicegreen("The bells do not toll for thee. Not yet."))
	return

/mob/living/simple_animal/hostile/abnormality/silence/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	safe = TRUE
	to_chat(user, span_nicegreen("The bells do not toll for thee. Not yet."))

/mob/living/simple_animal/hostile/abnormality/silence/proc/meltdown_check()
	sound_to_playing_players(sound('tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/silence/ambience.ogg'))
	if(!safe)
		qliphoth_change(-1)
	safe = FALSE
	return

//Meltdown
/mob/living/simple_animal/hostile/abnormality/silence/ZeroQliphoth(mob/living/carbon/human/user)
	// You have mere seconds to live
	//SLEEP_CHECK_DEATH(5 SECONDS, src)
	sound_to_playing_players(sound('tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/silence/price.ogg', volume = 25))
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(faction_check_atom(H, FALSE) || H.z != z || H.stat == DEAD)
			continue

		new /obj/effect/temp_visual/thirteen(get_turf(H))	//A visual effect if it hits
		H.apply_damage(worldwide_damage, BRUTE)
	addtimer(CALLBACK(src, PROC_REF(Reset)), reset_time)
	return

/mob/living/simple_animal/hostile/abnormality/silence/proc/Reset()
	qliphoth_change(1)
