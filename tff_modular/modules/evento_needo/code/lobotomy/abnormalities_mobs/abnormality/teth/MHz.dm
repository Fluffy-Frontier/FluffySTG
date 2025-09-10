/mob/living/simple_animal/hostile/abnormality/mhz
	name = "1.76 MHz"
	desc = "You can't see anything but static."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96.dmi'
	icon_state = "mhz"
	icon_living = "mhz"
	pixel_x = -32
	base_pixel_x = -32
	pixel_y = -32
	base_pixel_y = -32
	maxHealth = 400
	health = 400
	blood_volume = 0
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/noise,
		/datum/ego_datum/armor/noise,
	)
	gift_type =  /datum/ego_gifts/noise
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/quiet_day = 1.5,
		///mob/living/simple_animal/hostile/abnormality/khz = 1.5,
		/mob/living/simple_animal/hostile/abnormality/army = 1.5,
	)

	observation_prompt = "You remember that day and this room still does. <br>\
		As you wait, your radio hisses with static and ghostly voices, buried in electromagnetic snow. <br>\
		\"h...e...l...p\" <br>\
		A ghost from the past calls out, the voice is familiar but you can't place who it belongs to."


	var/reset_time = 4 MINUTES //Qliphoth resets after this time. To prevent bugs

/mob/living/simple_animal/hostile/abnormality/mhz/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(!.)
		return
	var/chance = neutral_chance
	if(user.get_clothing_class_level(CLOTHING_ENGINEERING) < 2)
		chance *= 1.25

	qliphoth_change(1)

	if(!prob(chance))
		qliphoth_change(-1)
	if(user.sanity_lost)
		qliphoth_change(-1)

/mob/living/simple_animal/hostile/abnormality/mhz/ZeroQliphoth(mob/living/carbon/human/user)
	var/rose_available
	for(var/mob/living/simple_animal/hostile/abnormality/staining_rose/J in GLOB.mob_list)
		rose_available = TRUE
		break

	addtimer(CALLBACK (src, PROC_REF(qliphoth_change), 4), reset_time)

	if(!rose_available)
		SSweather.run_weather(/datum/weather/mhz)
		return

	//Rose? Do a different, neutered effect
	for(var/mob/living/L in GLOB.player_list)
		if(faction_check_atom(L, FALSE) || L.z != z || L.stat == DEAD)
			continue
		new /obj/effect/temp_visual/dir_setting/ninja(get_turf(L))
		L.apply_damage(20, BRUTE)


//We're gonna make it a weather that affects all hallways.
//We've tried the spreading stuff effect with Snow White and it's super laggy. Having 2 at once would be horrible.
/datum/weather/mhz
	name = "static"
	immunity_type = "static"
	desc = "Static created by 1.76 MHz."
	telegraph_message = span_warning("You hear something in the distance.")
	telegraph_duration = 300
	weather_message = span_userdanger("<i>Are.... those the sounds of humans wailing? Are they suffering?</i>")
	weather_overlay = "mhz"
	weather_duration_lower = 1200		//2-3 minutes.
	weather_duration_upper = 1800
	end_duration = 100
	end_message = span_boldannounce("It's all calm once more. You feel at peace.")
	target_trait = ZTRAIT_STATION

/datum/weather/mhz/weather_act_mob(mob/living/living)
	if(ishuman(living))
		living.apply_damage(5, BRUTE)
	return ..()
