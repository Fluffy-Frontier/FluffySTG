/mob/living/simple_animal/hostile/abnormality/black_sun
	name = "Waxing of the Black Sun"
	desc = "A sundial. Inscribed on the side is the phrase ''Memento Mori''."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "sundial"
	maxHealth = 1000
	health = 1000
	fear_level = ALEPH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/arcadia,
		/datum/ego_datum/weapon/judge,
		/datum/ego_datum/armor/arcadia
		)
//	gift_type = /datum/ego_gifts/arcadia
	//takes 12 minutes from the moment of getting it to breach, and cause a headache.
	var/stage
	var/nextstage = 1 MINUTES
	var/time_addition = 2 MINUTES //Goes down 5 seconds every time someone dies.
	var/list/pillars = list()
	var/list/affected_players = list()
	update_qliphoth = 0

/mob/living/simple_animal/hostile/abnormality/black_sun/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH, PROC_REF(on_mob_death))
	addtimer(CALLBACK(src, PROC_REF(StageChange)), nextstage)

/mob/living/simple_animal/hostile/abnormality/black_sun/Life()
	. = ..()
	if(nextstage < world.time && !LAZYLEN(pillars))
		StageChange()

/mob/living/simple_animal/hostile/abnormality/black_sun/proc/StageChange()
	stage++
	//Add 10 stats to everyone.
	if(stage == 1)
		affected_players = list()	//Clear the list, then fill it up
		for(var/mob/living/carbon/human/L in GLOB.player_list)
			affected_players += L

	for(var/mob/living/carbon/human/L in affected_players)
		L.physiology.burn_mod -= 1
		L.physiology.brain_mod -= 1
		L.physiology.tox_mod -= 1

	switch(stage)
		if(1)
			to_chat(GLOB.clients,span_notice("You see The Black Sun rise in the east."))
			nextstage = world.time + 2 MINUTES
		if(2)
			to_chat(GLOB.clients,span_danger("The Black Sun clears the horizon, filling you with it's warmth."))
			nextstage = world.time + 4 MINUTES
		if(3)
			to_chat(GLOB.clients,span_userdanger("The Black sun is halfway to it's zenith. Dread fills you. You must hurry."))
			nextstage = world.time + 4 MINUTES
		if(4)
			to_chat(GLOB.clients,span_danger("YOUR TIME IS LIMITED. THE SUN IS NEAR IT'S ZENITH."))
			SSweather.run_weather(/datum/weather/bloody_water)
			for(var/mob/living/carbon/human/L in GLOB.player_list)
				flash_color(L, flash_color = COLOR_RED, flash_time = 150)
			nextstage = world.time + 2 MINUTES
		if(5)
			qliphoth_change(-3)
	addtimer(CALLBACK(src, PROC_REF(StageChange)), nextstage)
	addtimer(CALLBACK(src, PROC_REF(StageChange)), nextstage)


/mob/living/simple_animal/hostile/abnormality/black_sun/ZeroQliphoth()
	. = ..()

	qliphoth_change(3)

	to_chat(GLOB.clients,"<span class='colossus'>THE BLACK SUN HAS RISEN.</span>")
	//Also remove your stats
	var/removestats = stage*10
	for(var/mob/living/carbon/human/L in affected_players)
		L.physiology.burn_mod += removestats
		L.physiology.brain_mod += removestats
		L.physiology.tox_mod += removestats
	stage = 0
	for(var/i = 0 to 2)
		var/X = get_turf(pick(GLOB.generic_event_spawns))
		var/turf/T = get_turf(X)
		new /mob/living/simple_animal/hostile/sun_pillar(T)


/mob/living/simple_animal/hostile/abnormality/black_sun/proc/on_mob_death(datum/source, mob/living/died, gibbed)
	SIGNAL_HANDLER
	if(!ishuman(died))
		return FALSE
	if(died.z != z)
		return FALSE
	nextstage += time_addition
	if(time_addition >=0 && stage!=4)
		time_addition =- 5 SECONDS
	to_chat(GLOB.clients, span_notice("The sun has stalled but a moment."))
	return TRUE

/mob/living/simple_animal/hostile/abnormality/black_sun/try_working(mob/living/carbon/human/user)
	neutral_chance = stage*10
	return ..()

/mob/living/simple_animal/hostile/abnormality/black_sun/PostWorkEffect(mob/living/carbon/human/user)
	to_chat(GLOB.clients, span_warning("The Black Sun fades from the sky. You are safe for now."))
	for(var/mob/living/carbon/human/L in affected_players)
		L.physiology.burn_mod += -stage
		L.physiology.brain_mod += stage
		L.physiology.tox_mod += stage
	stage = 0
	return ..()

//Weather effect
/datum/weather/bloody_water
	name = "bloodwater"
	desc = "A visual water weather."

	telegraph_message = "<span class='warning'>Something feels off.</span>"
	telegraph_duration = 150

	weather_message = "<span class='danger'>The blood.... it sings to you</span>"
	weather_duration_lower = 1200
	weather_duration_upper = 1200
	weather_overlay = "bloodwater"

	end_message = "<span class='danger'>The blood subsides.</span>"
	end_duration = 0

	area_type = /area
	protected_areas = list(/area/space)
	target_trait = ZTRAIT_STATION

	overlay_layer = ABOVE_OPEN_TURF_LAYER //Covers floors only
	overlay_plane = FLOOR_PLANE


//Pillars. Do minor white damage, and fire projectiles
/mob/living/simple_animal/hostile/sun_pillar
	name = "pillar of the black sun"
	desc = "A glowing pillar."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64.dmi'
	icon_state = "sun_pillar"
	icon_living = "sun_pillar"
	health = 2500
	maxHealth = 2500
	melee_damage_lower = 0
	melee_damage_upper = 0
	melee_damage_type = BRUTE
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	attack_verb_continuous = "menaces"
	attack_verb_simple = "menace"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/nail1.ogg'
	mob_size = MOB_SIZE_TINY
	del_on_death = TRUE
	var/aoe_range = 10

/mob/living/simple_animal/hostile/sun_pillar/Initialize()
	..()
	for(var/mob/living/simple_animal/hostile/sun_pillar/M in src.loc)	//Don't put two down at the same place
		if(M!=src)
			qdel(src)

/mob/living/simple_animal/hostile/sun_pillar/AttackingTarget()
	return FALSE

/mob/living/simple_animal/hostile/sun_pillar/Move()
	return FALSE

/mob/living/simple_animal/hostile/sun_pillar/Life()
	..()
	for(var/mob/living/L in GLOB.player_list)
		if(L.z != z)
			continue
		if(faction_check_atom(L))
			continue
		L.apply_damage(3, BRUTE)
		new /obj/effect/temp_visual/bluespace_fissure(get_turf(L))

	if(prob(10))
		Aoe()

	//Fire a buncha shit around the room too because it's cool
	var/list/all_turfs = RANGE_TURFS(7, src)
	for(var/turf/open/F in all_turfs)
		if(prob(30))
			addtimer(CALLBACK(src, PROC_REF(Firelaser), F), rand(1,30)) //offset so it looks like you're tossing a buncha shit around the room

/mob/living/simple_animal/hostile/sun_pillar/proc/Firelaser(turf/open/F)
	new /obj/effect/temp_visual/blacksun_laser(F)

//Laser attack
/obj/effect/temp_visual/blacksun_laser
	name = "black sun laser"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64.dmi'
	icon_state = "pillar_strike"
	duration = 15

/obj/effect/temp_visual/blacksun_laser/Initialize()
	..()
	addtimer(CALLBACK(src, PROC_REF(blowup)), 10) //this is how long the animation takes

/obj/effect/temp_visual/blacksun_laser/proc/blowup()
	playsound(src, 'sound/items/weapons/laser.ogg', 10, FALSE, 4)
	for(var/mob/living/carbon/human/H in src.loc)
		H.apply_damage(60, BRUTE)
		H.apply_damage(30, BRUTE)
		if(H.sanity_lost)
			H.gib(DROP_ALL_REMAINS)

//Kills the insane it does a fuckload of white damage, deal black too.
/mob/living/simple_animal/hostile/sun_pillar/proc/Aoe()
	playsound(src, 'sound/items/weapons/wave.ogg', 100, FALSE, 4)
	var/turf/orgin = get_turf(src)
	var/list/all_turfs = RANGE_TURFS(aoe_range, orgin)
	for(var/i = 0 to aoe_range)
		for(var/turf/T in all_turfs)
			if(get_dist(orgin, T) > i)
				continue
			new /obj/effect/temp_visual/sunwave(T)
			for(var/mob/living/carbon/human/L in T)
				if(L.sanity_lost)		//Kill the insane
					L.death()
				L.apply_damage(60, BRUTE)

			all_turfs -= T

//Visual effects
/obj/effect/temp_visual/sunwave
	icon = 'icons/effects/atmospherics.dmi'
	icon_state = "zauker"
	duration = 6

