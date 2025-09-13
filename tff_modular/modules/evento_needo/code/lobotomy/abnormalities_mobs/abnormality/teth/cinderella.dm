//Coded by Coxswain
/mob/living/simple_animal/hostile/abnormality/cinderella
	name = "Cinderella's Pumpkin Carriage"
	desc = "A beautiful pumpkin carriage adorned with golden trimmings."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96.dmi'
	icon_state = "cinderella_1"
	icon_living = "cinderella_1"
	maxHealth = 800
	health = 800
	fear_level = TETH_LEVEL

	pixel_x = -16
	base_pixel_x = -16
	ego_list = list(
			/datum/ego_datum/weapon/curfew,
			/datum/ego_datum/armor/curfew
	)
	gift_type = /datum/ego_gifts/curfew
	observation_prompt = "(You sit and wait.) <br>\
		The ground is solid. <br>\
		(You sit and wait.) <br>\
		The beautiful blonde girl is kissing her prince. <br>\
		(You sit and wait.) <br>\
		The prince and princess-to-be are leaving you, even the fairy godmother has left you. <br>\
		(You sit and wait.) <br>\
		The rot has set in on your once vibrant orange flesh and your wheels buckle from the elements. <br>\
		(You sit and wait.) <br>\
		Do you not need me anymore? Did I not take you to the happiest night of your life? <br>\
		(You sit and...)"


	var/freshness = 0
	//Breach stuff
	var/maxSegments = 1
	var/list/segments = list()
	var/list/damaged = list()
	var/already_breached

/mob/living/simple_animal/hostile/abnormality/cinderella/examine(mob/user)
	. = ..()
	var/freshness_state = "Rotten"
	switch(freshness)
		if(4 to 6)
			freshness_state = "Spoiled"
		if(7  to 10)
			freshness_state = "Pristine"
	. += "It looks [freshness_state]"

//Work mechanics
/mob/living/simple_animal/hostile/abnormality/cinderella/try_working(mob/living/carbon/human/user)
	if(already_breached)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/cinderella/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == CLOTHING_SCIENCE)
		freshness = clamp(freshness + 3, 0, 10)
		if(freshness >= 10)
			qliphoth_change(-1)
	if(user.get_major_clothing_class() == CLOTHING_ARMORED)
		freshness = clamp(freshness - 1, 0, 10)
	update_icon_state()
	return ..()

/mob/living/simple_animal/hostile/abnormality/cinderella/update_icon_state()
	if(!freshness)
		icon_state = "cinderella_1"
	else
		icon_state = "cinderella_[clamp(max(1, ceil(freshness / 3)), 1,3)]" //gets a number from 1-3 from the freshness
	icon_living = icon_state
	return ..()

//Breach code. Warning: Compliated
/mob/living/simple_animal/hostile/abnormality/cinderella/ZeroQliphoth(mob/living/carbon/human/user)
	. = ..()
	if(already_breached)
		return
	if(freshness < 10)
		freshness = clamp(freshness + 3, 0, 10)
		qliphoth_change(1)
		update_icon_state()
		return
	already_breached = TRUE
	GoToTheBall()
	animate(src, alpha = 0, time = 3 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(death)), 45 SECONDS)

/mob/living/simple_animal/hostile/abnormality/cinderella/proc/GoToTheBall()
	for(var/mob/living/M in damaged)
		damaged -= M
	var/turf/aimTurf = get_turf(pick(GLOB.start_landmarks_list))
	FireCarriage(aimTurf.y, pick(EAST, WEST), aimTurf.z)

//Yeah, I just copied this from express train; even these slight modifications were a real headache.
/mob/living/simple_animal/hostile/abnormality/cinderella/proc/FireCarriage(aimpoint, direction = pick(EAST, WEST), aimZ = src.z)
	var/spawnX
	if(direction == EAST)
		spawnX = 42
	else
		spawnX = 214
	var/spawnPoint = locate(spawnX, aimpoint, aimZ)
	var/obj/effect/cinderella/seg = new(spawnPoint)
	seg.dir = direction
	seg.icon_state = "cinderella_1"
	notify_ghosts("[seg] is preparing to depart!", source = seg, header="Something Interesting!") // bless this mess
	segments += seg
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(sound_to_playing_players), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/cinderella/bell.ogg', 50), 1)
	addtimer(CALLBACK(src, PROC_REF(MoveCarriage)), 10 SECONDS)

/mob/living/simple_animal/hostile/abnormality/cinderella/proc/MoveCarriage()
	if(LAZYLEN(src.segments))
		addtimer(CALLBACK(src, PROC_REF(MoveCarriage)), 0.5)
		for(var/obj/effect/cinderella/seg in segments)
			if((seg.x < 10 && seg.dir == WEST) || (seg.x > 245 && seg.dir == EAST))
				QDEL_IN(seg, 1)
				src.segments -= seg
			else
				seg.forceMove(get_step(seg, seg.dir))
		DamageTiles()

/mob/living/simple_animal/hostile/abnormality/cinderella/proc/DamageTiles()
	for(var/obj/effect/cinderella/seg in segments)
		var/list/coveredTurfs = list()
		for(var/i = -1, i < 4, i++)
			for(var/j = -1, j < 3, j++)
				var/turf/T = locate(seg.x + i, seg.y + j, seg.z)
				coveredTurfs |= T
		for(var/turf/T in coveredTurfs)
			for(var/mob/living/M in T.contents)
				if(M in src.damaged)
					continue
				src.damaged += M
				if(!seg.noise)
					if(rand())
						playsound(get_turf(seg), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/cinderella/horse1.ogg', 100, 0, 40)
					else
						playsound(get_turf(seg), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/cinderella/horse2.ogg', 100, 0, 40)
					seg.noise = 1
				M.apply_damage(80, BRUTE)
				if(ishuman(M))
					var/mob/living/carbon/human/C = M
					if(C.sanity_lost)
						QDEL_NULL(C.ai_controller)
						C.ai_controller = /datum/ai_controller/insane/wander/penitence //Yeah, we're just copying penitent girl's panic. I'm sure no one will notice.
						C.InitializeAIController()
						C.apply_status_effect(/datum/status_effect/panicked_type/wander/penitence)
