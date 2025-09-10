/mob/living/simple_animal/hostile/abnormality/wild_ride
	name = "ride that never ends"
	desc = "A giant skeleton holding a top hat, it seems to be handing out tickets for a roller coaster called \"Mr. Bones Wild Ride\""
	health = 4000
	maxHealth = 4000
	pixel_x = -48
	base_pixel_x = -48
	pixel_y = -20
	base_pixel_y = -20
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/128x128.dmi'
	icon_state = "wild_ride"
	icon_living = "wild_ride"
	del_on_death = FALSE
	can_breach = FALSE
	fear_level = ALEPH_LEVEL
	can_spawn = FALSE//It's a joke abnormality

	ego_list = list(
		/datum/ego_datum/weapon/wild_ride,
		/datum/ego_datum/armor/wild_ride,
	)

//Work mechanics
/mob/living/simple_animal/hostile/abnormality/wild_ride/attackby(obj/item/attacking_item, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!.)
		return
	if(user.sanity_lost || user.stat != CONSCIOUS)
		return FALSE
	user.SetImmobilized(30, ignore_canstun = TRUE)
	if(prob(50))
		return
	user.SetImmobilized(10, ignore_canstun = TRUE)
	user.apply_damage(25, BRUTE)
	if(prob(50))
		qliphoth_change(1)
	if(prob(80))
		return .()

/mob/living/simple_animal/hostile/abnormality/wild_ride/ZeroQliphoth(mob/living/carbon/human/user)
	qliphoth_change(3)
	DoBreachThing()

/mob/living/simple_animal/hostile/abnormality/wild_ride/proc/DoBreachThing()
	var/list/potentialmarked = list()
	var/marked = null
	for(var/mob/living/carbon/human/L in GLOB.player_list)
		if(L.stat >= HARD_CRIT || L.sanity_lost || z != L.z) // Dead or in hard crit, insane, or on a different Z level.
			continue
		potentialmarked += L
		to_chat(L, span_danger("Something horrible is about to happen to someone!"))
	SLEEP_CHECK_DEATH(5 SECONDS, src)
	for(var/mob/living/carbon/human/H in potentialmarked)
		if(faction_check_atom(H, FALSE) || H.z != z || H.stat == DEAD) //hostile, off-z, dead, or working
			continue
		to_chat(H, span_userdanger("WIIIIIILD RIIIDE!"))
		marked = H
		break
	if(!marked)
		return
	to_chat(marked, span_userdanger("THE RIDE NEVER ENDS!"))
	return attackby(user = marked)
