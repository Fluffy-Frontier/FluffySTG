/obj/structure/abno_core
	name = "blank abnormality core"
	desc = "You shouldn't be seeing this. Please let someone know!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/abno_cores/_cores.dmi'
	icon_state = "1"//blank icon states exist for each risk level.
	anchored = FALSE
	density = FALSE
	resistance_flags = INDESTRUCTIBLE
	base_pixel_x = -16
	pixel_x = -16
	var/mob/living/simple_animal/hostile/abnormality/contained_abno
	var/release_time = 420 SECONDS//this is going to be reduced by a minute for every risk level
	var/fear_level
	var/ego_list = list()
	var/opening = FALSE
	var/neutralized = FALSE
	var/angried = FALSE
	var/silent = FALSE


/obj/structure/abno_core/Initialize(mapload, new_type)
	contained_abno = !isnull(new_type) ? new_type : SSabnormality_queue.SpawnAbno()

	if(!contained_abno) //Аномалии кончились
		qdel(src)
		return
	. = ..()
	icon_state = SSabnormality_queue.GetAbnoCoreIcon() ? "[SSabnormality_queue.GetAbnoCoreIcon()]" : "[rand(1, 5)]"

/obj/structure/abno_core/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if(opening)
		return
	. = TRUE
	opening = TRUE
	var/failed = FALSE
	user.show_aso_blurb("Выпустив аномалию ты не сможешь передвинуть её. Ты уверен в своем решении?", 3 SECONDS)
	sleep(3 SECONDS)
	var/choice = tgui_input_list(user, "Выпустить аномалию?", "Выбор", list("Выпустить", "Нейтрализовать", "Не сейчас"), timeout = 10 SECONDS)
	switch(choice)
		//Не сейчас и провал нейтрализации блокируют открытие коробки
		if("Не сейчас")
			failed = TRUE
		if("Нейтрализовать")
			user.show_aso_blurb("Удачи тебе", 3 SECONDS)
			sleep(3 SECONDS)
			playsound(loc, 'sound/machines/ding.ogg', 50, TRUE)
			sleep(1 SECONDS)

			if(fear_level < HE_LEVEL)
				if(prob(10)) //УПС
					angried = TRUE
				else
					if(prob(fear_level * 12))
						user.apply_damage(40, BRUTE, wound_bonus = 20)
						failed = TRUE
					else
						neutralized = TRUE
			else
				if(prob(50))
					user.apply_damage(130, BRUTE, wound_bonus = 50)
					if(prob(2)) //OH NO
						angried = TRUE
					else
						failed = TRUE
				else
					neutralized = TRUE
	opening = FALSE
	if(!failed)
		Release()
	return ..()

//Выпуск аномалии
/obj/structure/abno_core/proc/Release()
	if(!contained_abno)//Is this core properly generated?
		return
	anchored = TRUE
	animate(src, alpha = 1,pixel_x = -16, pixel_z = 32, time = 3 SECONDS)
	playsound(src,'tff_modular/modules/evento_needo/sounds/Tegusounds/abno_extract.ogg', 50, 5)
	sleep(3 SECONDS)
	SSabnormality_queue.PostSpawn()
	var/mob/living/simple_animal/hostile/abnormality/abno = new contained_abno(get_turf(src))
	if(neutralized)
		do_sparks(3, FALSE, abno)
		abno.death()
		qdel(src)
		return
	if(angried)
		abno.qliphoth_change(-abno.datum_reference.qliphoth_meter_max)

	if(!silent)
		priority_announce(angried ? "An abnormality has breached into the facility!" : "New abnormality has arrived at the facility!", "M.O.G. ANNOUNCEMENT", sound = 'sound/machines/beep/triple_beep.ogg')

	log_admin("[key_name(usr)] заспавнил [contained_abno].")
	message_admins("[key_name(usr)] заспавнил [contained_abno].")

	SSblackbox.record_feedback("nested tally", "core_spawn_abnormality", 1, list("Initiated Spawn Abnormality", "[SSabnormality_queue.queued_abnormality]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


	qdel(src)

/obj/machinery/abno_core_extractor
	name = "abnormality core containment unit"
	desc = "A device used to transfer abnormalities into containment cells."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_structures_64x64.dmi'
	icon_state = "extraction"
	pixel_x = -16
	base_pixel_x = -16
	//pixel_y = 16
	//base_pixel_y = 16
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER
	var/cooldown
	var/cooldown_time = 17 MINUTES
	var/needed_players = 23

/obj/machinery/abno_core_extractor/attack_hand(mob/living/user, list/modifiers)
	if(cooldown > world.time)
		to_chat(user, span_warning("Машина еще не готова."))
		return
	if(GLOB.player_list.len < needed_players)
		to_chat(user, span_warning("Слишком мало членов экипажа для использования этой машины."))
		return
	GrabAnimation()
	sleep(4 SECONDS)
	new /obj/structure/abno_core(get_turf(src))
	cooldown = world.time + cooldown_time

/obj/machinery/abno_core_extractor/proc/GrabAnimation()
	flick("extraction_closed", src)
	animate(src, pixel_y = 56, time = 3 SECONDS, loop = 1, ANIMATION_RELATIVE)
	animate(pixel_y = initial(pixel_y), time = 1 SECONDS, ANIMATION_RELATIVE)
