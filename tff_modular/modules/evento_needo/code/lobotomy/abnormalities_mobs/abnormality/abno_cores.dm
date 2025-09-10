/obj/structure/abno_core
	name = "blank abnormality core"
	desc = "You shouldn't be seeing this. Please let someone know!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/abno_cores/zayin.dmi'
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

/obj/structure/abno_core/proc/Release()
	if(!contained_abno)//Is this core properly generated?
		return
	new contained_abno(get_turf(src))
	qdel(src)
	return TRUE

/obj/structure/abno_core/proc/Extract()
	var/mob/living/simple_animal/hostile/abnormality/A = SSabnormality_queue.SpawnAbno()
	var/datum/abnormality/abno_ref = A
	for(abno_ref in SSlobotomy_corp.all_abnormality_datums) //Check if they're already in the facility
		if(abno_ref.abno_path == A)
			for(var/mob/living/carbon/human/H in view(1, src))
				to_chat(H, span_boldwarning("This abnormality is already contained!"))
			return FALSE//If the abnormality already exists in a cell, the proc returns early here.
	anchored = TRUE
	icon_state = ""
	animate(src, alpha = 1,pixel_x = -16, pixel_z = 32, time = 3 SECONDS)
	playsound(src,'tff_modular/modules/evento_needo/sounds/Tegusounds/abno_extract.ogg', 50, 5)
	sleep(3 SECONDS)
	SSabnormality_queue.PostSpawn()
	log_admin("[key_name(usr)] has spawned [contained_abno].")
	message_admins("[key_name(usr)] has spawned [contained_abno].")

	SSblackbox.record_feedback("nested tally", "core_spawn_abnormality", 1, list("Initiated Spawn Abnormality", "[SSabnormality_queue.queued_abnormality]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


	qdel(src)

/obj/machinery/abno_core_extractor
	name = "abnormality core containment unit"
	desc = "A device used to transfer abnormalities into containment cells."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_structures_64x64.dmi'
	icon_state = "extraction"
	pixel_x = -16
	base_pixel_x = -16
	pixel_y = 16
	base_pixel_y = 16
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER
	var/cooldown
	var/cooldown_time = 30 MINUTES

/obj/machinery/abno_core_extractor/attack_hand(mob/living/user, list/modifiers)
	if(cooldown > world.time)
		to_chat(user, span_warning("Machine isn't ready yet."))
		return
	GrabAnimation()
	sleep(4 SECONDS)
	var/obj/structure/abno_core/core = new(get_turf(src))
	cooldown = world.time + cooldown_time

/obj/machinery/abno_core_extractor/proc/GrabAnimation()
	flick("extraction_closed", src)
	animate(src, pixel_y = 56, time = 3 SECONDS, loop = 1, ANIMATION_RELATIVE)
	animate(pixel_y = initial(pixel_y), time = 1 SECONDS, ANIMATION_RELATIVE)
