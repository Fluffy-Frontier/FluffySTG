/mob/living/simple_animal/hostile/abnormality/tangle
	name = "Tangle"
	desc = "What seems to be a severed head laying in a tangle of hair."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "tangle"
	icon_living = "tangle"
	maxHealth = 1600
	health = 1600
	damage_coeff = list(BURN = 1, BRAIN = 1, BRUTE = 0.5, TOX = 1, BRUTE = 2)
	melee_damage_lower = 0		//Doesn't attack
	melee_damage_upper = 0
	rapid_melee = 2
	melee_damage_type = BRUTE
	stat_attack = HARD_CRIT
	faction = list("hostile")
	can_breach = TRUE
	fear_level = TETH_LEVEL
	ego_list = list(
		/datum/ego_datum/weapon/rapunzel,
		/datum/ego_datum/armor/rapunzel,
	)
//	gift_type =  /datum/ego_gifts/rapunzel
	var/chosen
	var/instinct_count
	var/list/hair_list = list()

/mob/living/simple_animal/hostile/abnormality/tangle/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/tangle/CanAttack(atom/the_target)
	return FALSE

//Grab a list of all agents and picks one
/mob/living/simple_animal/hostile/abnormality/tangle/Initialize()
	. = ..()
	var/list/potentialmarked = list()
	for(var/mob/living/carbon/human/L in GLOB.player_list)
		if(L.stat >= HARD_CRIT || L.sanity_lost || z != L.z) // Dead or in hard crit, insane, or on a different Z level.
			continue
		potentialmarked += L

	if(length(potentialmarked) <= 1) //If there's only one or none of you, then don't do it. I'm not that evil.
		return
	chosen = pick(potentialmarked)



/mob/living/simple_animal/hostile/abnormality/tangle/PostWorkEffect(mob/living/carbon/human/user)
	// If your'e the chosen, lower
	if(user == chosen)
		qliphoth_change(-1)
		icon_state = "tangleawake"
		return

	if(user.get_major_clothing_class() == CLOTHING_ENGINEERING)
		instinct_count+=1
		if((instinct_count==3) || (instinct_count == 6))
			qliphoth_change(-1)
			icon_state = "tangleawake"

/mob/living/simple_animal/hostile/abnormality/tangle/BreachEffect()
	..()
	icon_state = "tangle"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x64.dmi'
	new /obj/structure/spreading/tangle_hair (src)


/mob/living/simple_animal/hostile/abnormality/tangle/death()
	for(var/V in hair_list)
		qdel(V)
		hair_list-=V
	..()


// Hair turf
/obj/structure/spreading/tangle_hair
	gender = PLURAL
	name = "blonde hair"
	desc = "a patch of blonde hair."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi'
	icon_state = "tanglehair"
	anchored = TRUE
	density = FALSE
	layer = MID_TURF_LAYER
	plane = FLOOR_PLANE
	max_integrity = 20
	base_icon_state = "tanglehair"
	var/mob/living/simple_animal/hostile/abnormality/tangle/connected_abno

/obj/structure/spreading/tangle_hair/Initialize()
	. = ..()

	//Stolen from Snow White's. Thanks Para!
	if(!connected_abno)
		connected_abno = locate(/mob/living/simple_animal/hostile/abnormality/tangle) in GLOB.abnormality_mob_list
	if(connected_abno)
		connected_abno.hair_list += src
	expand()


/obj/structure/spreading/tangle_hair/expand()
	addtimer(CALLBACK(src, PROC_REF(expand)), 5 SECONDS)
//	if(connected_abno.hair_list.len>=150)
// 		return
	..()

///obj/structure/spreading/tangle_hair/Crossed(atom/movable/AM)
//	. = ..()
//	if(ishuman(AM))
//		var/mob/living/carbon/human/H = AM
//		H.apply_damage(1, BRUTE, null, H.run_armor_check(null, BRUTE), spread_damage = TRUE)
//		if(prob(10))
//			H.Immobilize(5)
//			to_chat(H, span_warning("You get caught in the hair!"))
