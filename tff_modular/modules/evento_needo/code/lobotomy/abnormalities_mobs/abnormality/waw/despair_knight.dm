#define BLESS_COOLDOWN (5 SECONDS)
/mob/living/simple_animal/hostile/abnormality/despair_knight
	name = "Knight of Despair"
	desc = "A tall humanoid abnormality in a blue dress. \
	Half of her head is black with sharp horn segments protruding out of it."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "despair"
	icon_living = "despair"
	icon_dead = "despair_dead"
	pixel_x = -8
	base_pixel_x = -8
	ranged = TRUE
	ranged_cooldown_time = 3 SECONDS
	minimum_distance = 2
	maxHealth = 2000
	health = 2000
	damage_coeff = list(BURN = 1.2, BRAIN = 1.0, BRUTE = 0.8, TOX = 0.5)
	stat_attack = HARD_CRIT
	del_on_death = FALSE
	death_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/despairknight/dead.ogg'
	fear_level = WAW_LEVEL
	wander = FALSE
	can_breach = TRUE
	move_to_delay = 4
	ego_list = list(
		/datum/ego_datum/weapon/despair,
		/datum/ego_datum/armor/despair,
	)
	gift_type =  /datum/ego_gifts/tears
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/wrath_servant = 2,
		/mob/living/simple_animal/hostile/abnormality/hatred_queen = 2,
		/mob/living/simple_animal/hostile/abnormality/greed_king = 2,
		/mob/living/simple_animal/hostile/abnormality/nihil = 1.5,
	)

	observation_prompt = "I once dedicated myself to the justice of this world, to protect my king, the kingdom and the weak. <br>\
		However in the end nothing was truly upheld on my watch. <br>Even so... I still want to protect someone, anyone..."


	var/mob/living/carbon/human/blessed_human = null
	var/teleport_cooldown
	var/teleport_cooldown_time = 20 SECONDS
	var/swords = 0
	var/nihil_present = FALSE
	var/can_act = TRUE

	attack_action_types = list(
		/datum/action/innate/change_icon_kod,
		/datum/action/cooldown/knightblessing,
	)


/datum/action/innate/change_icon_kod
	name = "Toggle Icon"
	desc = "Toggle your icon between breached and friendly. (Works only for Limbus Company Labratories)"

/datum/action/cooldown/knightblessing
	name = "Give Blessing"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = BLESS_COOLDOWN //5 seconds

/datum/action/cooldown/knightblessing/Trigger(trigger_flags, atom/target)
	if(!..())
		return FALSE
	if(!istype(owner, /mob/living/simple_animal/hostile/abnormality/despair_knight))
		return FALSE
	var/mob/living/simple_animal/hostile/abnormality/despair_knight/despair_knight = owner
	StartCooldown()
	despair_knight.give_blessing()
	return TRUE

/mob/living/simple_animal/hostile/abnormality/despair_knight/proc/give_blessing()
	var/list/nearby = viewers(7, src) // first call viewers to get all mobs that see us
	if (!blessed_human)
		for(var/mob in nearby) // then sanitize the list
			if(mob == src) // cut ourselves from the list
				nearby -= mob
			if(!ishuman(mob)) // cut all the non-humans from the list
				nearby -= mob
			//if(mob.stat == DEAD)
				//nearby -= mob
		var/mob/living/carbon/human/blessed = input(src, "Choose who you want to bless", "Select who you want to protect") as null|anything in nearby // pick someone from the list
		blessed_human = blessed
		RegisterSignal(blessed, COMSIG_LIVING_DEATH, PROC_REF(BlessedDeath))
		RegisterSignal(blessed, COMSIG_HUMAN_INSANE, PROC_REF(BlessedDeath))
		to_chat(blessed, span_nicegreen("You feel protected."))
		blessed.physiology.burn_mod *= 0.5
		blessed.physiology.brain_mod *= 0.5
		blessed.physiology.brute_mod *= 0.5
		blessed.physiology.tox_mod *= 2
		blessed.add_overlay(mutable_appearance('tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi', "despair", -MUTATIONS_LAYER))
		playsound(get_turf(blessed), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/despairknight/gift.ogg', 50, 0, 2)

/mob/living/simple_animal/hostile/abnormality/despair_knight/ZeroQliphoth(mob/living/carbon/human/user)
	. = ..()
	switch(swords)
		if(0)
			add_overlay(mutable_appearance('tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi', "despair_sword1", -ABOVE_MOB_LAYER))
			playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/despairknight/attack.ogg', 50, 0, 4)
			qliphoth_change(1)
		if(1)
			add_overlay(mutable_appearance('tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi', "despair_sword2", -ABOVE_MOB_LAYER))
			playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/despairknight/attack.ogg', 50, 0, 4)
			qliphoth_change(1)
		else
			cut_overlays()
			if(blessed_human)
				BlessedDeath()
			else
				BreachEffect()
			return
	swords += 1

/mob/living/simple_animal/hostile/abnormality/despair_knight/AttackingTarget(atom/attacked_target)
	if(!target)
		GiveTarget(attacked_target)
	return OpenFire()

/mob/living/simple_animal/hostile/abnormality/despair_knight/OpenFire()
	if(!can_act)
		return FALSE
	if(ranged_cooldown > world.time)
		return FALSE
	ranged_cooldown = world.time + ranged_cooldown_time
	for(var/i = 1 to 4)
		var/turf/T = get_step(get_turf(src), pick(1,2,4,5,6,8,9,10))
		if(T.density)
			i -= 1
			continue
		var/obj/projectile/despair_rapier/P
		if(nihil_present)
			P = new /obj/projectile/despair_rapier/justice(T)
		else
			P = new(T)
		P.starting = T
		P.firer = src
		P.fired_from = T
		P.yo = target.y - T.y
		P.xo = target.x - T.x
		P.original = target
		P.set_angle(get_angle(T, target))
		addtimer(CALLBACK (P, TYPE_PROC_REF(/obj/projectile, fire)), 3)
	SLEEP_CHECK_DEATH(3, src)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/despairknight/attack.ogg', 50, 0, 4)
	return

/mob/living/simple_animal/hostile/abnormality/despair_knight/Life()
	. = ..()
	if(.)
		if(!client)
			if(teleport_cooldown <= world.time)
				TryTeleport()

/mob/living/simple_animal/hostile/abnormality/despair_knight/death(gibbed)
	density = FALSE
	animate(src, alpha = 0, time = 5 SECONDS)
	QDEL_IN(src, 5 SECONDS)
	..()

/mob/living/simple_animal/hostile/abnormality/despair_knight/proc/BlessedDeath(datum/source, gibbed)
	SIGNAL_HANDLER
	blessed_human.cut_overlay(mutable_appearance('tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi', "despair", -MUTATIONS_LAYER))
	UnregisterSignal(blessed_human, COMSIG_LIVING_DEATH)
	UnregisterSignal(blessed_human, COMSIG_HUMAN_INSANE)
	blessed_human.physiology.burn_mod /= 0.5
	blessed_human.physiology.brain_mod /= 0.5
	blessed_human.physiology.brute_mod /= 0.5
	blessed_human.physiology.tox_mod /= 2
	blessed_human = null
	if(nihil_present) //We die during a nihil suppression if our champion dies
		death()
		return TRUE
	BreachEffect()
	return TRUE

/mob/living/simple_animal/hostile/abnormality/despair_knight/proc/TryTeleport()
	if(teleport_cooldown > world.time)
		return FALSE
	if(target) // Actively fighting
		return FALSE
	teleport_cooldown = world.time + teleport_cooldown_time
	var/targets_in_range = 0
	for(var/mob/living/L in view(10, src))
		if(!faction_check_atom(L) && L.stat != DEAD && !(HAS_TRAIT(L, TRAIT_GODMODE)))
			targets_in_range += 1
	if(targets_in_range >= 3)
		return FALSE
	var/list/teleport_potential = list()
	for(var/turf/T in GLOB.generic_event_spawns)
		var/targets_at_tile = 0
		for(var/mob/living/L in view(10, T))
			if(!faction_check_atom(L) && L.stat != DEAD)
				targets_at_tile += 1
		if(targets_at_tile >= 2)
			teleport_potential += T
	if(!LAZYLEN(teleport_potential))
		return FALSE
	var/turf/teleport_target = pick(teleport_potential)
	animate(src, alpha = 0, time = 5)
	new /obj/effect/temp_visual/guardian/phase(get_turf(src))
	addtimer(CALLBACK(src, PROC_REF(FinishTeleport), teleport_target), 5)

/mob/living/simple_animal/hostile/abnormality/despair_knight/proc/FinishTeleport(turf/teleport_target)
	animate(src, alpha = 255, time = 5)
	var/area/A = get_area(teleport_target)
	show_global_blurb(6 SECONDS, "Аномальная активность обнаружена в [A.name]", 2 SECONDS, "white", "black", "left", around_player)
	new /obj/effect/temp_visual/guardian/phase/out(teleport_target)
	forceMove(teleport_target)

/mob/living/simple_animal/hostile/abnormality/despair_knight/SuccessEffect(mob/living/carbon/human/user)
	if(user.stat != DEAD && !blessed_human && istype(user) && (user.get_major_clothing_class() == CLOTHING_SCIENCE))
		blessed_human = user
		RegisterSignal(user, COMSIG_LIVING_DEATH, PROC_REF(BlessedDeath))
		RegisterSignal(user, COMSIG_HUMAN_INSANE, PROC_REF(BlessedDeath))
		to_chat(user, span_nicegreen("You feel protected."))
		user.physiology.burn_mod *= 0.5
		user.physiology.brain_mod *= 0.5
		user.physiology.brute_mod *= 0.5
		user.physiology.tox_mod *= 2
		user.add_overlay(mutable_appearance('tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi', "despair", -MUTATIONS_LAYER))
		playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/despairknight/gift.ogg', 50, 0, 2)
	else
		balloon_alert(user, "not smart enough")
	return

/mob/living/simple_animal/hostile/abnormality/despair_knight/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	icon_living = "despair_breach"
	icon_state = icon_living
	addtimer(CALLBACK(src, PROC_REF(TryTeleport)), 5)
	return

/mob/living/simple_animal/hostile/abnormality/despair_knight/Move()
	if(!can_act)
		return FALSE
	return ..()

//Nihil Event code - TODO: Add friendly summons TODO: Add a way to teleport to nihil
/mob/living/simple_animal/hostile/abnormality/despair_knight/proc/EventStart()
	set waitfor = FALSE
	NihilModeEnable()
	ChangeResistances(list(BURN = 0, BRAIN = 0, BRUTE = 0, TOX = 0))
	SLEEP_CHECK_DEATH(6 SECONDS, src)
	say("At last, a worthy foe.")
	SLEEP_CHECK_DEATH(6 SECONDS, src)
	say("All of my work won't be in vain.")
	SLEEP_CHECK_DEATH(6 SECONDS, src)
	say("You'll answer for your crimes!")
	SLEEP_CHECK_DEATH(6 SECONDS, src)
	say("To protect our people!")
	ChangeResistances(list(BURN = 1.2, BRAIN = 1.0, BRUTE = 0.8, TOX = 0.5))

/mob/living/simple_animal/hostile/abnormality/despair_knight/proc/NihilModeEnable()
	NihilIconUpdate()
	nihil_present = TRUE
	fear_level = ZAYIN_LEVEL
	faction = list("neutral")

/mob/living/simple_animal/hostile/abnormality/despair_knight/proc/NihilIconUpdate()
	name = "Magical Girl of Justice"
	desc = "A real magical girl!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "despair_friendly"
	pixel_x = -8
	base_pixel_x = -8

/mob/living/simple_animal/hostile/abnormality/despair_knight/Found(atom/A)
	if(istype(A, /mob/living/simple_animal/hostile/abnormality/nihil)) // 1st Priority
		return TRUE
	return ..()

/mob/living/simple_animal/hostile/abnormality/despair_knight/petrify(statue_timer)
	if(!isturf(loc))
		MoveStatue()
	AIStatus = AI_OFF
	icon_state = "despair_breach"
	var/obj/structure/statue/petrified/magicalgirl/S = new(loc, src, statue_timer)
	S.name = "Ossified Despair"
	ADD_TRAIT(src, TRAIT_NOBLOOD, MAGIC_TRAIT)
	SLEEP_CHECK_DEATH(1, src)
	S.icon = src.icon
	S.icon_state = src.icon_state
	S.pixel_x = -4
	S.base_pixel_x = -4
	var/newcolor = list(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(0,0,0))
	S.add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)
	stat = DEAD
	return TRUE

/mob/living/simple_animal/hostile/abnormality/despair_knight/proc/MoveStatue()
	var/list/teleport_potential = list()
	if(!LAZYLEN(GLOB.start_landmarks_list))
		for(var/mob/living/L in GLOB.mob_living_list)
			if(L.stat == DEAD || L.z != z || HAS_TRAIT(L, TRAIT_GODMODE))
				continue
			teleport_potential += get_turf(L)
	if(!LAZYLEN(teleport_potential))
		var/turf/P = get_turf(pick(GLOB.start_landmarks_list))
		teleport_potential += P
	var/turf/teleport_target = pick(teleport_potential)
	new /obj/effect/temp_visual/guardian/phase(get_turf(src))
	new /obj/effect/temp_visual/guardian/phase/out(teleport_target)
	forceMove(teleport_target)

/mob/living/simple_animal/hostile/abnormality/despair_knight/death(gibbed)
	if(!nihil_present)
		return ..()
	adjustBruteLoss(-999999)
	visible_message(span_boldwarning("Oh no, [src] has been defeated!"))
	INVOKE_ASYNC(src, PROC_REF(petrify), 500000)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/despair_knight/gib()
	if(nihil_present)
		death()
		return FALSE
	return ..()

