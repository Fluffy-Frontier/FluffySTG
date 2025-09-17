/mob/living/simple_animal/hostile/abnormality/caterpillar
	name = "Hookah Caterpillar"
	desc = "A pathetic bug sitting on a leaf."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "caterpillar"
	icon_living = "caterpillar"
	pixel_x = -16
	base_pixel_x = -16
	maxHealth = 2300
	health = 2300
	ranged = TRUE
	attack_verb_continuous = "scolds"
	attack_verb_simple = "scold"
	stat_attack = HARD_CRIT
	melee_damage_lower = 11
	melee_damage_upper = 12
	damage_coeff = list(BURN = 1, BRAIN = 1.5, BRUTE = 1.3, TOX = 0.5, BRUTE = 0)
	speak_emote = list("flutters")

	can_breach = TRUE
	fear_level = WAW_LEVEL
	faction = list("neutral", "hostile")

	ego_list = list(
		/datum/ego_datum/weapon/havana,
		/datum/ego_datum/armor/havana,
	)
//	gift_type =  /datum/ego_gifts/caterpillar
	var/darts_smoked	//how many times you didnt' work repression
	var/can_counter = TRUE
	update_qliphoth = 0

//Set a smoker timer for 15 seconds
/mob/living/simple_animal/hostile/abnormality/caterpillar/BreachEffect()
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x96.dmi'
	addtimer(CALLBACK(src, PROC_REF(Smoke_Timer)), 15 SECONDS)
	..()

/mob/living/simple_animal/hostile/abnormality/caterpillar/proc/Smoke_Timer()
	var/datum/effect_system/smoke_spread/pale/S = new
	S.set_up(8, get_turf(src))	//Make the smoke bigger
	S.start()
	qdel(S)
	addtimer(CALLBACK(src, PROC_REF(Smoke_Timer)), 15 SECONDS)


//Counter shit if you get hit by a bullet, we want to keep them either dodging in and out or firing through the gas
/mob/living/simple_animal/hostile/abnormality/caterpillar/proc/Counter_Timer()
	can_counter = TRUE

/mob/living/simple_animal/hostile/abnormality/caterpillar/bullet_act(obj/projectile/P)
	if(!can_counter)
		return
	can_counter = FALSE
	var/datum/effect_system/smoke_spread/pale/S = new
	S.set_up(12, get_turf(src))	//on counter, do massive amounts of smoke
	S.start()
	qdel(S)
	addtimer(CALLBACK(src, PROC_REF(Counter_Timer)), 15 SECONDS)
	return ..()

/mob/living/simple_animal/hostile/abnormality/caterpillar/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	darts_smoked++	//Smoke a fat stoogie if it's not repression
	if(darts_smoked>=3)
		var/datum/effect_system/smoke_spread/pale/S = new
		S.set_up(4, get_turf(src))	//Make the smoke bigger
		S.start()
		qdel(S)
	if(darts_smoked>=5)
		if(prob(50))
			qliphoth_change(-1)



/////////////////////////////////////////////
// Bad smoke
/////////////////////////////////////////////

/obj/effect/particle_effect/smoke/pale
	icon_state = "palesmoke"
	var/lifetime = 8

//Bypasses smoke detection
///obj/effect/particle_effect/smoke/pale/smoke_mob(mob/living/carbon/C)
//	if(!istype(C))
//		return FALSE
//	if(lifetime<1)
//		return FALSE
//	if(C.smoke_delay)
//		return FALSE
//
//	C.smoke_delay++
//	addtimer(CALLBACK(src, PROC_REF(remove_smoke_delay), C), 10)
//	C.apply_damage(27, BURN)
//	to_chat(C, span_danger("IT BURNS!"))
//	C.emote("scream")
//	lifetime--
//	return TRUE

/datum/effect_system/smoke_spread/pale
	effect_type = /obj/effect/particle_effect/smoke/pale

/obj/effect/particle_effect/smoke/proc/remove_smoke_delay(mob/living/carbon/C)
	if(C)
		C.smoke_delay = 0
