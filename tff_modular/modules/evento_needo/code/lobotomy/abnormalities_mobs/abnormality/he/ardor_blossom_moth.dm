/mob/living/simple_animal/hostile/abnormality/ardor_moth
	name = "Ardor Blossom Moth"
	desc = "A moth seemingly made of fire."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	pixel_x = -8
	base_pixel_x = -8
	icon_state = "blossom_moth"
	icon_living = "blossom_moth"
	maxHealth = 1200
	health = 1200
	blood_volume = 0
	ranged = TRUE
	attack_verb_continuous = "sears"
	attack_verb_simple = "sear"
	stat_attack = HARD_CRIT
	melee_damage_lower = 11
	melee_damage_upper = 12
	damage_coeff = list(BURN = 1, BRAIN = 0.5, BRUTE = 1, TOX = 0.7, BRUTE = 2, FIRE = 0.2)
	speak_emote = list("flutters")
	vision_range = 14
	aggro_vision_range = 20

	can_breach = TRUE
	fear_level = HE_LEVEL
	faction = list("neutral", "hostile")
	move_to_delay = 3 SECONDS

	ego_list = list(
		/datum/ego_datum/weapon/ardor_star,
		/datum/ego_datum/armor/ardor_star,
	)
//	gift_type =  /datum/ego_gifts/ardor_moth
	observation_prompt = "Orange circles float in the air before your eyes. <br>\
		The lights flutter and dance in the air, creating a haze. <br>\
		Something is burning to death within. <br>\
		Would you be scorched as well if the flames touched you?"


	var/stoked

	secret_chance = TRUE
	secret_name = "Fireball"

/mob/living/simple_animal/hostile/abnormality/ardor_moth/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if(stoked)
		qliphoth_change(1)

/mob/living/simple_animal/hostile/abnormality/ardor_moth/PostWorkEffect(mob/living/carbon/human/user)
	if(!stoked && user.get_major_clothing_class() == CLOTHING_SERVICE)
		if(prob(30))
			qliphoth_change(-2)
	stoked = FALSE

	if(user.get_major_clothing_class() == CLOTHING_SERVICE)
		stoked = TRUE
		to_chat(user, span_notice("You stoke the flames, and it burns hotter."))

/mob/living/simple_animal/hostile/abnormality/ardor_moth/Move()
	..()
	for(var/turf/open/T in range(1, src))
		if(locate(/obj/effect/turf_fire) in T)
			for(var/obj/effect/turf_fire/floor_fire in T)
				qdel(floor_fire)
		new /obj/effect/turf_fire(T)

/mob/living/simple_animal/hostile/abnormality/ardor_moth/spawn_gibs()
	return new /obj/effect/decal/cleanable/ash(drop_location(), src)

// Turf Fire
/obj/effect/turf_fire
	gender = PLURAL
	name = "fire"
	desc = "a burning pyre."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi'
	icon_state = "turf_fire"
	anchored = TRUE
	layer = MID_TURF_LAYER
	plane = FLOOR_PLANE
	base_icon_state = "turf_fire"
	var/damaging = FALSE

/obj/effect/turf_fire/Initialize()
	. = ..()
	QDEL_IN(src, 30 SECONDS)

////Red and not burn, burn is a special damage type.
///obj/effect/turf_fire/Crossed(atom/movable/AM)
//	. = ..()
//	if(!damaging)
//		damaging = TRUE
//		DoDamage()

/obj/effect/turf_fire/proc/DoDamage()
	var/dealt_damage = FALSE
	for(var/mob/living/L in get_turf(src))
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			H.apply_damage(6, FIRE)
			dealt_damage = TRUE
	if(!dealt_damage)
		damaging = FALSE
		return
	addtimer(CALLBACK(src, PROC_REF(DoDamage)), 4)
