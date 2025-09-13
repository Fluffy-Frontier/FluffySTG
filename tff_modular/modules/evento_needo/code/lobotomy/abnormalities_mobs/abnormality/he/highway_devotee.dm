/mob/living/simple_animal/hostile/abnormality/highway_devotee
	name = "Highway Devotee"
	desc = "A giant form holding a 'road closed' sign."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "highway_devotee"
	icon_living = "highway_devotee"
	maxHealth = 1200
	health = 1200
	ranged = TRUE
	attack_verb_continuous = "scorns"
	attack_verb_simple = "scorn"
	damage_coeff = list(BURN = 0, BRAIN = 0, BRUTE = 0, TOX = 0, BRUTE = 0)
	speak_emote = list("rasps")
	pixel_x = -16

	can_breach = TRUE
	fear_level = HE_LEVEL
	faction = list("neutral", "hostile")
	ego_list = list(
		/datum/ego_datum/weapon/uturn,
		/datum/ego_datum/armor/uturn,
	)
	gift_type =  /datum/ego_gifts/uturn
	observation_prompt = "There's a long, wide road ahead. <br>\
		You see someone with a sign at the entrance. <br>\
		\"This is a one-way road. No U-turns.\" <br>\
		\"If you take this road, it'll take ages to come back here.\" <br>\
		As the person claims, the road seems to be stretched almost endlessly into the distance."


	var/talk = FALSE
	var/list/structures = list()

/mob/living/simple_animal/hostile/abnormality/highway_devotee/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/highway_devotee/Life()
	..()
	//Only say this once
	if(talk)
		return
	for(var/mob/living/carbon/human/H in view(5, src))
		//say("If you take this road, it'll take ages to come back here.")
		talk = TRUE
		break

/mob/living/simple_animal/hostile/abnormality/highway_devotee/death(gibbed)
	for(var/obj/Y in structures)
		qdel(Y)
	..()

/mob/living/simple_animal/hostile/abnormality/highway_devotee/proc/KillYourself()
	for(var/obj/Y in structures)
		qdel(Y)
	QDEL_NULL(src)

/* Work effects */
/mob/living/simple_animal/hostile/abnormality/highway_devotee/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/highway_devotee/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-2)
	return

/mob/living/simple_animal/hostile/abnormality/highway_devotee/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	var/turf/T = get_turf(pick(GLOB.generic_event_spawns))
	forceMove(T)
	var/area/A = get_area(T)
	show_global_blurb(6 SECONDS, "Аномальная активность обнаружена в [A.name]", 2 SECONDS, "white", "black", "left", around_player)
	addtimer(CALLBACK(src, PROC_REF(KillYourself)), 3 MINUTES)
	dir = pick(list(NORTH, SOUTH, WEST, EAST))
	for(var/turf/open/U in range(2, src))
		var/obj/structure/blockedpath/P = new(U)
		structures += P

/obj/structure/blockedpath
	name = "highway devotee"
	icon_state = "blank"
	max_integrity = 3000000
	density = 1

