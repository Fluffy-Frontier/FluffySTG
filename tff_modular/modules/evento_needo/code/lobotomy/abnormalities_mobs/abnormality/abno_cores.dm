/obj/structure/abno_core
	name = "blank abnormality core"
	desc = "You shouldn't be seeing this. Please let someone know!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/abno_cores/_cores.dmi'
	icon_state = ""//blank icon states exist for each risk level.
	anchored = FALSE
	density = FALSE
	resistance_flags = INDESTRUCTIBLE
	base_pixel_x = -16
	pixel_x = -16
	var/mob/living/simple_animal/hostile/abnormality/contained_abno
	var/release_time = 420 SECONDS//this is going to be reduced by a minute for every risk level
	var/fear_level
	var/ego_list = list()

/obj/structure/abno_core/Initialize(mapload)
	contained_abno = SSabnormality_queue.SpawnAbno()

	if(!contained_abno) //Аномалии кончились
		qdel(src)
		return
	icon_state = initial(SSabnormality_queue.queued_abnormality.fear_level)
	return ..()

/obj/structure/abno_core/attack_hand(mob/living/carbon/human/user, list/modifiers)
	user.show_aso_blurb("Выпустив аномалию ты не сможешь передвинуть её. Ты уверен в своем решении?", 3 SECONDS)
	sleep(3 SECONDS)
	var/choice = tgui_input_list(user, "Выпустить аномалию?", "Выбор", list("Выпустить", "Не сейчас."), timeout = 10 SECONDS)
	if(choice == "Выпустить")
		Release()
	else
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
	new contained_abno(get_turf(src))

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

/obj/machinery/abno_core_extractor/attack_hand(mob/living/user, list/modifiers)
	if(cooldown > world.time)
		to_chat(user, span_warning("Машина еще не готова."))
		return
	GrabAnimation()
	sleep(4 SECONDS)
	new /obj/structure/abno_core(get_turf(src))
	cooldown = world.time + cooldown_time

/obj/machinery/abno_core_extractor/proc/GrabAnimation()
	flick("extraction_closed", src)
	animate(src, pixel_y = 56, time = 3 SECONDS, loop = 1, ANIMATION_RELATIVE)
	animate(pixel_y = initial(pixel_y), time = 1 SECONDS, ANIMATION_RELATIVE)
