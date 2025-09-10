/mob/living/simple_animal/hostile/abnormality/meat_lantern
	name = "Meat Lantern"
	desc = "All you can see is a small white mound with two eyes and a glowing flower."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x32.dmi'
	icon_state = "lantern"
	icon_living = "lantern"
	maxHealth = 900
	health = 900
	base_pixel_x = -16
	pixel_x = -16
	fear_level = TETH_LEVEL
	faction = list("hostile")

	damage_coeff = list(BURN = 1, BRAIN = 1.5, BRUTE = 0.8, TOX = 1, BRUTE = 2)
	wander = FALSE
	can_breach = TRUE
	del_on_death = FALSE
	death_message = "explodes in a shower of gore."
	ego_list = list(
		/datum/ego_datum/weapon/lantern,
		/datum/ego_datum/armor/lantern,
	)

	gift_type = /datum/ego_gifts/lantern
	gift_message = "Not a single employee has seen Meat Lantern's full form."
	observation_prompt = "It's always the same, dull colours in the facility. Grey walls, grey floors, grey ceilings, even the people were grey. <br>\
		Every day was grey until, one day, you saw the a small, beautifully green flower growing and glowing from the ground."


	var/can_act = TRUE
	var/detect_range = 1
	var/chop_cooldown
	var/chop_cooldown_time = 4 SECONDS
	var/chop_damage = 400

/mob/living/simple_animal/hostile/abnormality/meat_lantern/PostSpawn()
	. = ..()
	med_hud_set_health() //show medhud while in containment
	med_hud_set_status()

//Cameras cant auto track it now.
/mob/living/simple_animal/hostile/abnormality/meat_lantern/can_track(mob/living/user)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/meat_lantern/PickTarget(list/Targets)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/meat_lantern/AttackingTarget()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/meat_lantern/Goto(target, delay, minimum_distance)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/meat_lantern/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/meat_lantern/FearEffect() //makes it too easy to find with a giant exclamation mark over your head
	return

/mob/living/simple_animal/hostile/abnormality/meat_lantern/death()
	. = ..()
	gib()

/mob/living/simple_animal/hostile/abnormality/meat_lantern/HasProximity(atom/movable/AM)
	if(!isliving(AM))
		return
	var/mob/living/L = AM
	if(L.stat == DEAD || faction_check_atom(L))
		return
	if(!can_act || (chop_cooldown > world.time))
		return
	INVOKE_ASYNC(src, PROC_REF(BigChop))

/mob/living/simple_animal/hostile/abnormality/meat_lantern/proc/BigChop()
	can_act = FALSE
	new /obj/effect/temp_visual/yellowsmoke(get_turf(src))
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/224x128.dmi'
	flick("lantern_bite_open",src)
	pixel_x = base_pixel_x - 88
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/amber/midnight_out.ogg', 40)
	SLEEP_CHECK_DEATH(7, src)
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/128x128.dmi'
	flick("lantern_bite_closed", src)
	pixel_x = base_pixel_x - 40
	for(var/mob/living/L in oview(1, src))
		if(faction_check_atom(L))
			continue
		L.apply_damage(chop_damage, BRUTE)
		if(L.health < 0)
			L.gib(FALSE,FALSE,TRUE)
	SLEEP_CHECK_DEATH(2.5, src)
	icon = initial(icon)
	pixel_x = base_pixel_x
	can_act = TRUE
	chop_cooldown = world.time + chop_cooldown_time
	addtimer(CALLBACK(src, PROC_REF(ProximityCheck)), chop_cooldown_time)

/mob/living/simple_animal/hostile/abnormality/meat_lantern/proc/ProximityCheck()
	for(var/mob/living/L in range(1,src)) //hidden istype() call
		if(L == src)
			continue
		if(faction_check_atom(L))
			continue
		BigChop()
		return

/mob/living/simple_animal/hostile/abnormality/meat_lantern/med_hud_set_health()
	if(!IsContained())
		var/image/holder = hud_list[HEALTH_HUD]
		holder.icon_state = null
		return
	..()

/mob/living/simple_animal/hostile/abnormality/meat_lantern/med_hud_set_status()
	if(!IsContained())
		var/image/holder = hud_list[STATUS_HUD]
		holder.icon_state = null
		return
	..()

/mob/living/simple_animal/hostile/abnormality/meat_lantern/PostWorkEffect(mob/living/carbon/human/user, work_type, pe, work_time, canceled)
	if (user.get_clothing_class_level(CLOTHING_SERVICE) >= 3)
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/meat_lantern/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/meat_lantern/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	update_icon()
	density = FALSE
	med_hud_set_health() //hides medhud
	med_hud_set_status()
	if(breach_type != BREACH_MINING)
		forceMove(pick(GLOB.generic_event_spawns))
	chop_cooldown = world.time + chop_cooldown_time
	return

/mob/living/simple_animal/hostile/abnormality/meat_lantern/update_icon_state()
	icon = initial(icon)
	icon_living = IsContained() ? initial(icon_state) : "lantern_breach"
	icon_state = icon_living
	return ..()

/obj/effect/temp_visual/yellowsmoke
	icon = 'icons/effects/96x96.dmi'
	icon_state = "smoke2"
	duration = 15
	pixel_x = -32
	base_pixel_x = -32
	pixel_y = -32
	base_pixel_y = -32
	color = COLOR_VIVID_YELLOW
