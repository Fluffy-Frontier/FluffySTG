//Coded by Coxswain, Sprited by Mel
/obj/structure/toolabnormality/clock
	name = "backwards clock"
	desc = "An abnormality resembling a clockwork machination, similar to an open container with 4 Nixie tubes attached to it, \
	display multiple gears at the front and a wind-up key to the right side."
	icon_state = "clock"
	light_color = COLOR_ORANGE
	light_range = 3
	light_power = 0

	var/light_count = 0
	var/duplicate_crankers = 0
	var/list/banned = list()
	var/list/crankers = list()
	var/clock_cooldown_time = 5 MINUTES
	var/clock_cooldown //prevents an exploit

	var/list/exceptions = list( //It only affects abnormalities and ordeals, so claw and arbiter are not even included.
		/mob/living/simple_animal/hostile/abnormality/white_night,
		///mob/living/simple_animal/hostile/abnormality/distortedform,
		/mob/living/simple_animal/hostile/abnormality/nihil,
		/mob/living/simple_animal/hostile/abnormality/sukuna,
	)

	ego_list = list(
		/datum/ego_datum/weapon/windup,
		/datum/ego_datum/armor/windup,
	)

/obj/structure/toolabnormality/clock/attack_hand(mob/living/carbon/human/user)
	..()
	if(user.ckey in banned)
		to_chat(user, span_notice("It won't respond to you at all."))
		return
	if(user.get_clothing_class_level(user.get_major_clothing_class()) <= 2)
		to_chat(user, span_notice("It won't budge!"))
		return
	if((clock_cooldown > world.time))
		to_chat(user, span_notice("It's too hot to operate!"))
		return
	if(!do_after(user, 30, user))
		return
	if(light_count < 4)
		if(user.ckey in crankers)
			to_chat(user, span_notice("You have already powered this, the machine gives off a hiss of protest!"))
			playsound(src.loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clock/end.ogg', 15, FALSE)
			duplicate_crankers += 1
		crankers += user.ckey
		playsound(src.loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clock/clank.ogg', 75, TRUE)
		sleep(10)
		playsound(src.loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clock/turn_on.ogg', 75, TRUE)
		src.set_light(3, (light_count * 2), "D4FAF37")
		light_count += 1
		update_icon()
		if(light_count == 4)
			playsound(src.loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clock/finish.ogg', 75, TRUE)
		return

	if(LAZYLEN(SSlobotomy_corp.current_ordeals))
		for(var/datum/ordeal/O in SSlobotomy_corp.current_ordeals)
			if(O.level >= 4)
				to_chat(user, span_notice("The abnormality cannot operate with such powerful ordeals present in the facility!"))
				playsound(src.loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clock/end.ogg', 75, TRUE)
				return //No helping with midnight ordeals!

	Operate(user.get_clothing_class_level(user.get_major_clothing_class()))
	clock_cooldown = world.time + clock_cooldown_time
	banned += user.ckey
	user.dust()
	light_count = 0
	sleep(70)
	update_icon()
	playsound(src.loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clock/end.ogg', 75, TRUE)
	src.set_light(3, (light_count * 2), "D4FAF37")

/obj/structure/toolabnormality/clock/proc/Operate(level)
	var/damage_dealt
	if(level < 5)
		damage_dealt = (level * 500)
	else if(level == 5)
		damage_dealt = 5000
	else
		damage_dealt = 10000
	if(duplicate_crankers)
		damage_dealt -= (200 * duplicate_crankers)
		duplicate_crankers = 0
	sound_to_playing_players(sound('tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clock/start.ogg'))
	playsound(src.loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/clock/work.ogg', 40, TRUE)
	light_count = clamp(light_count -= 4,0 ,4)
	for(var/mob/living/simple_animal/hostile/abnormality/A in GLOB.abnormality_mob_list)
		if(A.IsContained())
			continue
		if(A in exceptions)
			continue
		new /obj/effect/particle_effect/sparks/quantum(A)
		A.apply_damage(damage_dealt, BRUTE)

	for(var/mob/living/L in GLOB.ordeal_list)
		new /obj/effect/particle_effect/sparks/quantum(L)
		L.apply_damage(damage_dealt, BRUTE)


/obj/structure/toolabnormality/clock/update_overlays()
	. = ..()
	if(light_count)
		. += "clock_[light_count]"
