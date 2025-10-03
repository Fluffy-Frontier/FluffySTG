/mob/living/simple_animal/hostile/abnormality/scorched_girl
	name = "Scorched Girl"
	desc = "An abnormality resembling a girl burnt to ashes. \
	Even though there's nothing left to burn, the fire still doesn't extinguish."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	icon_state = "scorched"
	icon_living = "scorched"
	maxHealth = 400
	health = 400
	fear_level = TETH_LEVEL
	stat_attack = HARD_CRIT
	ranged = TRUE
	vision_range = 12
	aggro_vision_range = 24
	damage_coeff = list(BURN = 0.5, BRAIN = 2, BRUTE = 1, TOX = 2)
	faction = list("hostile")
	can_breach = TRUE
	ego_list = list(
		/datum/ego_datum/weapon/match,
		/datum/ego_datum/armor/match,
	)
	gift_type =  /datum/ego_gifts/match
	observation_prompt = "I thought it was cold. \
		It got warm before I even realize it. The match nailed to my heart doesn't stop burning. \
		The match that never caught a fire before now burns to ash. Maybe is a price for taking my body, to burn so bright and fiery. \
		Let's run when I can burn. I have been suffering and will suffer. But why you are still happy? \
		I know the menace I have become. If nothing will change, I at least want to see you suffering."


	/// Restrict movement when this is set to TRUE
	var/exploding = FALSE
	/// Current cooldown for the players
	var/boom_cooldown
	/// Amount of RED damage done on explosion
	var/boom_damage = 150

	attack_action_types = list(
		/datum/action/innate/change_icon_scorch,
	)


/datum/action/innate/change_icon_scorch
	name = "Toggle Icon"
	desc = "Toggle your icon between breached and contained. (Works only for Limbus Company Labratories)"

/datum/action/innate/change_icon_scorch/Activate()
	. = ..()
	owner.icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	owner.icon_state = "scorched"
	active = 1

/datum/action/innate/change_icon_scorch/Deactivate()
	. = ..()
	owner.icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegumobs.dmi'
	owner.icon_state = "scorched_breach"
	active = 0

/mob/living/simple_animal/hostile/abnormality/scorched_girl/handle_automated_movement()
	var/turf/target_center
	var/highestcount = 0
	for(var/turf/T in GLOB.generic_event_spawns)
		var/targets_at_tile = 0
		for(var/mob/living/L in ohearers(10, T))
			if(!faction_check_atom(L) && L.stat != DEAD)
				targets_at_tile++
		if(targets_at_tile > highestcount)
			target_center = T
			highestcount = targets_at_tile
	if(!target_center)
		..()
	else
		Goto(target_center, 20 DECISECONDS, 1)

/mob/living/simple_animal/hostile/abnormality/scorched_girl/OpenFire()
	if(client)
		explode()
		return

	var/amount_inview = 0
	for(var/mob/living/carbon/human/H in ohearers(7, src))
		if(!faction_check_atom(H) && H.stat != DEAD)
			amount_inview += 1
	if(prob(amount_inview*20))
		explode()

/mob/living/simple_animal/hostile/abnormality/scorched_girl/Move()
	if(exploding)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/scorched_girl/CanAttack(atom/the_target)
	if(..())
		if(ishuman(the_target))
			return TRUE
	return FALSE

/mob/living/simple_animal/hostile/abnormality/scorched_girl/AttackingTarget(atom/attacked_target)
	if(client)
		explode()
		return
	var/amount_inview = 0
	for(var/mob/living/carbon/human/H in ohearers(7, src))
		if(!faction_check_atom(H) && H.stat != DEAD)
			amount_inview += 1
	if(prob(amount_inview * 20))
		explode()
	return

/mob/living/simple_animal/hostile/abnormality/scorched_girl/proc/explode()
	if(boom_cooldown > world.time) // That's only for players
		return
	boom_cooldown = world.time + 3 SECONDS
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/scorchedgirl/pre_ability.ogg', 50, 0, 2)
	if(client)
		if(!do_after(src, 1.5 SECONDS, target = src))
			return
	else
		SLEEP_CHECK_DEATH(1.5 SECONDS, src)
	exploding = TRUE
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/scorchedgirl/ability.ogg', 60, 0, 4)
	SLEEP_CHECK_DEATH(3 SECONDS, src)
	// Ka-boom
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/scorchedgirl/explosion.ogg', 125, 0, 8)
	for(var/mob/living/carbon/human/H in view(7, src))
		H.apply_damage(boom_damage, BRUTE)
		H.apply_damage(boom_damage * 0.5, FIRE)
		if(H.health < 0)
			H.gib(DROP_ALL_REMAINS)
	for(var/obj/structure/obstacle in view(2, src))
		obstacle.take_damage(boom_damage, BRUTE)
	new /obj/effect/temp_visual/explosion(get_turf(src))
	//var/datum/effect_system/smoke_spread/S = new
	//S.set_up(7, get_turf(src))
	//S.start()
	exploding = FALSE
	return

/mob/living/simple_animal/hostile/abnormality/scorched_girl/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(prob(40))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/scorched_girl/FailureEffect(mob/living/carbon/human/user)
	if(prob(80))
		qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/scorched_girl/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	boom_cooldown = world.time + 5 SECONDS // So it doesn't instantly explode
	update_icon()
	GiveTarget(user)

/mob/living/simple_animal/hostile/abnormality/scorched_girl/update_icon_state()
	if(HAS_TRAIT(src, TRAIT_GODMODE)) // Not breaching
		icon_state = initial(icon)
	else // Breaching
		icon_state = "scorched_breach"
	icon_living = icon_state
	return ..()

