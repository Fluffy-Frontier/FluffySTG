/mob/living/simple_animal/hostile/abnormality/sirocco
	name = "Sirocco"
	desc = "A sentient dust storm. You can see the silhouette of a child-like figure inside."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "sirocco_chill"
	icon_living = "sirocco_chill"
	icon_dead = "sirocco_dead"
	var/breach_icon = "sirocco"
	del_on_death = TRUE
	pixel_x = -16
	base_pixel_x = -16
	maxHealth = 1200
	health = 1200
	blood_volume = 0
	density = FALSE
	damage_coeff = list(BURN = 0, BRAIN = 0, BRUTE = 0, TOX = 0)
	stat_attack = HARD_CRIT
	can_breach = TRUE
	fear_level = TETH_LEVEL
	del_on_death = FALSE
	move_to_delay = 6
	ego_list = list(
		/datum/ego_datum/weapon/desert,
		/datum/ego_datum/armor/desert,
	)
	gift_type = /datum/ego_gifts/desert
	observation_prompt = "Why is everyone here such a bore? <br>Why doesn't anyone want to play with me? <br>\
		A young girl's voice cries out from somewhere within the storm. <br>\
		\"Everyone keeps staring at the floor like life's a chore...is being an adult really that bad?\" <br.\
		\"If that's what an adult is like, I don't wanna grow up!\" <br>\
		What do you say to it?"



	// Work Variables
	var/work_timer
	var/time_to_lower = 2 MINUTES // Time to lower qliphoth

	// Breach variables
	var/cooldown_time = 3 // Cooldown between grab attempts
	var/list/grabbed_list = list()
	var/list_refresh_time = 30
	var/breached_time = 5 MINUTES
	var/lowered_breached_time = 3 MINUTES
	var/grab_range = 3

/mob/living/simple_animal/hostile/abnormality/sirocco/proc/Grabber()
	if(stat == DEAD)
		return
	for(var/atom/movable/A in oview(grab_range, src)) // Grab anything in our range
		if(isliving(A) && faction_check_atom(A))
			continue
		if(A && !A.anchored && !isobserver(A) && A != src)
			A.throw_at(src, 1, 1, src, FALSE)
	addtimer(CALLBACK(src, PROC_REF(Grabber)), cooldown_time)
	addtimer(CALLBACK(src, PROC_REF(ThrowAround)), 2)

/mob/living/simple_animal/hostile/abnormality/sirocco/proc/ThrowAround()
	if(stat == DEAD)
		return
	var/turf/turf_underneath = get_turf(src)
	for(var/atom/movable/A in turf_underneath)
		if(A && !A.anchored && !isobserver(A) && A != src && !(A in grabbed_list))
			if(isliving(A))
				grabbed_list += A
			var/randomdir = rand(0, 10)
			A.throw_at(get_edge_target_turf(src,randomdir), rand(4,7), 3, src, TRUE)

/mob/living/simple_animal/hostile/abnormality/sirocco/proc/RefreshList()
	grabbed_list = list()
	if(stat == DEAD)
		return
	addtimer(CALLBACK(src, PROC_REF(RefreshList)), list_refresh_time)

/mob/living/simple_animal/hostile/abnormality/sirocco/AttackingTarget()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/sirocco/PickTarget(list/Targets)
	return

/* Qliphoth/Breach effects */
/mob/living/simple_animal/hostile/abnormality/sirocco/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(Grabber)), cooldown_time)
	addtimer(CALLBACK(src, PROC_REF(EndStorm)), breached_time)
	addtimer(CALLBACK(src, PROC_REF(RefreshList)), list_refresh_time)
	icon_state = breach_icon
	if(breach_type == BREACH_PINK)
		move_to_delay = 2
		ChangeResistances(list(BURN = 0, BRAIN = 0.4, BRUTE = 0.4, TOX = 0.4))

/mob/living/simple_animal/hostile/abnormality/sirocco/proc/EndStorm()
	grabbed_list = list()
	death()

/mob/living/simple_animal/hostile/abnormality/sirocco/death(gibbed)
	icon_state = icon_dead
	density = FALSE
	grabbed_list = list()
	QDEL_IN(src, 3 SECONDS)
	..()

/mob/living/simple_animal/hostile/abnormality/sirocco/SuccessEffect(mob/living/carbon/human/user, work_type, pe, canceled)
	. = ..()
	breached_time = lowered_breached_time // We don't breach as long

/mob/living/simple_animal/hostile/abnormality/sirocco/NeutralEffect(mob/living/carbon/human/user, work_type, pe, work_time, canceled)
	. = ..()
	qliphoth_change(1)

/mob/living/simple_animal/hostile/abnormality/sirocco/FailureEffect(mob/living/carbon/human/user)
	breached_time = initial(breached_time) // Longer breach due to failure

/mob/living/simple_animal/hostile/abnormality/sirocco/PostSpawn()
	. = ..()
	work_timer = addtimer(CALLBACK(src, PROC_REF(WorkCheck)), time_to_lower, TIMER_OVERRIDE & TIMER_UNIQUE & TIMER_STOPPABLE)

/mob/living/simple_animal/hostile/abnormality/sirocco/proc/WorkCheck()
	if(!IsContained())
		return
	work_timer = addtimer(CALLBACK(src, PROC_REF(WorkCheck)), time_to_lower, TIMER_OVERRIDE & TIMER_UNIQUE & TIMER_STOPPABLE)
	qliphoth_change(-1)

/* Death cleanup */
/mob/living/simple_animal/hostile/abnormality/sirocco/Destroy()
	grabbed_list = list()
	. = ..()
