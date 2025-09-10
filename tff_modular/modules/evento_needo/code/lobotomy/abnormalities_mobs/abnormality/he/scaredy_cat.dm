/mob/living/simple_animal/hostile/abnormality/scaredy_cat
	name = "Scaredy Cat"
	desc = "An abnormality ressembling a small defenseless kitten."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "scaredy_cat"
	icon_living = "scaredy_cat"
	icon_dead = "scaredy_dead"
	del_on_death = FALSE
	maxHealth = 800 //Lower health because he can revive indefinitely
	health = 800
	rapid_melee = 1
	move_to_delay = 1.7
	damage_coeff = list(BURN = 4, BRAIN = 4, BRUTE = 4, TOX = 4)
	melee_damage_lower = 1
	melee_damage_upper = 1
	melee_damage_type = BRUTE
	vision_range = 7 //nerfed vision range so he doesn't go 2 continents away from his friend
	stat_attack = CONSCIOUS
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/scaredycat/catattack.ogg'
	attack_verb_continuous = "mauls"
	attack_verb_simple = "claws"
	faction = list("neutral") //Is non hostile without a friend
	can_breach = TRUE
	fear_level = HE_LEVEL
	wander = FALSE
	death_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/scaredycat/catgrunt.ogg'
	ego_list = list(
		/datum/ego_datum/weapon/courage,
		/datum/ego_datum/weapon/bravery,
		/datum/ego_datum/armor/courage,
	)
	gift_type =  /datum/ego_gifts/courage_cat //the sprites for the EGO are shitty codersprites placeholders and are only here so that there's EGO to use
	grouped_abnos = list(
		/mob/living/simple_animal/hostile/abnormality/scarecrow = 2,
		///mob/living/simple_animal/hostile/abnormality/woodsman = 2,
		/mob/living/simple_animal/hostile/abnormality/road_home = 2,
		// Ozma = 2,
		///mob/living/simple_animal/hostile/abnormality/pinocchio = 1.5,
	)

	observation_prompt = "Cowardly kitten. <br>I’ll give you the courage to stand up to anything and everything. <br>The wizard grants you..."


	/// The list of abnormality scaredy cat will automatically join when they breach, add any "Oz" abno to this list if possible
	var/list/prefered_abno_list = list(
		///mob/living/simple_animal/hostile/abnormality/woodsman,
		/mob/living/simple_animal/hostile/abnormality/scarecrow,
		/mob/living/simple_animal/hostile/abnormality/road_home,
	)
	/// Types of abnormalities that we will ignore when they are breaching
	var/list/ignore_abno_list = list(
		/mob/living/simple_animal/hostile/abnormality/training_rabbit,
	)
	/// If scaredy cat is breaching but has no "friend" to follow, he'll wait for the next abno breach to follow them
	var/wait_for_friend = FALSE
	/// The abnormality scaredy cat follows on breach
	var/mob/living/simple_animal/hostile/abnormality/friend
	/// The abnormality cat will prioritize as a friend on breach
	var/mob/living/simple_animal/hostile/abnormality/priority_friend
	/// How much time needs to pass before scaredy cat check if his friend is in view
	var/protect_cooldown_time = 5 SECONDS
	var/protect_cooldown
	var/obj/effect/scaredy_stun/stunned_effect
	update_qliphoth = 0

/mob/living/simple_animal/hostile/abnormality/scaredy_cat/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH, PROC_REF(OnMobDeath))
	RegisterSignal(SSdcs, COMSIG_GLOB_ABNORMALITY_BREACH, PROC_REF(OnAbnoBreach))

///mob/living/simple_animal/hostile/abnormality/scaredy_cat/WorkChance(mob/living/carbon/human/user, chance, work_type)
//	var/newchance = chance
//	if(user.get_clothing_class_level(CLOTHING_ENGINEERING) >= 3)
//		newchance = chance-20
//	return newchance

/mob/living/simple_animal/hostile/abnormality/scaredy_cat/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(user.get_clothing_class_level(CLOTHING_ENGINEERING) >= 3)
		if(prob(40))
			qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/scaredy_cat/FailureEffect(mob/living/carbon/human/user)
	if(user.get_clothing_class_level(CLOTHING_ENGINEERING) >= 3)
		qliphoth_change(-1)
	return


/mob/living/simple_animal/hostile/abnormality/scaredy_cat/BreachEffect(mob/living/carbon/human/user, breach_type)
	protect_cooldown = world.time + protect_cooldown_time //to avoid him teleporting twice for no reason on breach
	if(priority_friend) //if an oz abno escape they take absolute priority
		ProtectFriend(priority_friend)
		priority_friend = null
		return ..()
	var/list/breached_abno = list()
	for(var/datum/abnormality/A in SSlobotomy_corp.all_abnormality_datums)
		if(!A.current)
			continue
		if(!(HAS_TRAIT(A.current, TRAIT_GODMODE)) && A != datum_reference)
			breached_abno += A.current
	if(LAZYLEN(breached_abno))
		ProtectFriend(pick(breached_abno))
	else
		wait_for_friend = TRUE //Should only happen on meltdowns, can safely be killed in that state too
	return ..()

///checks if the friend is in view every 10 second, and if not teleports to it
/mob/living/simple_animal/hostile/abnormality/scaredy_cat/Life()
	. = ..()
	if(!friend || HAS_TRAIT(src, TRAIT_GODMODE) || stat == DEAD) //for some reason life() works on death ain't that something
		return
	if(QDELETED(friend) || HAS_TRAIT(friend, TRAIT_GODMODE)) //if the friend is deleted instead of dying first somehow (looking at you pbird)
		Courage(FALSE)
		return
	if(protect_cooldown < world.time)
		protect_cooldown = world.time + protect_cooldown_time
		if(!can_see(src, friend, vision_range))
			GoToFriend()

/mob/living/simple_animal/hostile/abnormality/scaredy_cat/proc/ProtectFriend(mob/living/simple_animal/hostile/abnormality/abno)
	wait_for_friend = FALSE
	Courage(TRUE)
	friend = abno //You are friend =D
	faction = friend.faction
	GoToFriend()

/mob/living/simple_animal/hostile/abnormality/scaredy_cat/death()
	density = FALSE
	anchored = TRUE
	if(friend)
		addtimer(CALLBACK(src, PROC_REF(Regenerate)), 20 SECONDS)
		stunned_effect = new(get_turf(src))
	else
		animate(src, alpha = 0, time = 10 SECONDS)
		QDEL_IN(src, 10 SECONDS)
	..()

/mob/living/simple_animal/hostile/abnormality/scaredy_cat/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH)
	UnregisterSignal(SSdcs, COMSIG_GLOB_ABNORMALITY_BREACH)
	return ..()

//if he still has a friend, revives
/mob/living/simple_animal/hostile/abnormality/scaredy_cat/proc/Regenerate()
	anchored = FALSE //so it can't be knocked away from his stunned effect
	if(friend)
		stunned_effect = null
		density = TRUE
		revive(HEAL_ALL)
		GoToFriend()
		return
	animate(src, alpha = 0, time = 3 SECONDS)
	QDEL_IN(src, 3 SECONDS)

///teleports to his friend if he can't see them
/mob/living/simple_animal/hostile/abnormality/scaredy_cat/proc/GoToFriend()
	if(!friend)
		return
	var/turf/origin = get_turf(friend)
	var/list/all_turfs = RANGE_TURFS(2, origin)
	for(var/turf/T in all_turfs)
		if(T == origin)
			continue
		var/available_turf
		var/list/friend_line = get_line(T, friend)
		for(var/turf/line_turf in friend_line) //checks if there's a valid path between the turf and the friend
			if(line_turf.is_blocked_turf(exclude_mobs = TRUE))
				available_turf = FALSE
				break
			available_turf = TRUE
		if(!available_turf)
			continue
		playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/scaredycat/cateleport.ogg', 50, FALSE, 4)
		forceMove(T)
		LoseTarget()
		for(var/mob/living/carbon/human/enemy in oview(src, vision_range))
			if(enemy.stat != DEAD)
				GiveTarget(enemy) //the moment he teleports he's already on the offensive
				break
		return

///If scaredy cat becomes a big boy or a baby boy
/mob/living/simple_animal/hostile/abnormality/scaredy_cat/proc/Courage(courage)
	if(courage)
		melee_damage_lower = 15
		melee_damage_upper = 20
		ChangeResistances(list(BURN = 0.5, BRAIN = 2, BRUTE = 1.5, TOX = 0.5))
		icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
		icon_living = "cat_courage"
		icon_dead = "dead_courage"
	else
		friend = null //just to make sure it's actually empty
		if(stat != DEAD)
			wait_for_friend = TRUE //kill him fast before he finds another friend
		faction = list("neutral")
		melee_damage_lower = initial(melee_damage_lower)
		melee_damage_upper = initial(melee_damage_upper) //it shouldn't attack in that form in the first place but...
		ChangeResistances(list(BURN = 4, BRAIN = 4, BRUTE = 4, TOX = 4))
		playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/scaredycat/catchange.ogg', 75, FALSE, 4)
		icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
		icon_living = "scaredy_cat"
		icon_dead = "scaredy_dead"
		if(stunned_effect)
			animate(stunned_effect, alpha = 0, time = 1 SECONDS)
			QDEL_IN(stunned_effect, 1 SECONDS)
			stunned_effect = null
	if(stat != DEAD) //because update_icon() won't do its job properly
		icon_state = icon_living
	else
		icon_state = icon_dead

/mob/living/simple_animal/hostile/abnormality/scaredy_cat/proc/OnMobDeath(datum/source, mob/living/died, gibbed)
	SIGNAL_HANDLER
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		if(istype(died, /mob/living/simple_animal/hostile/abnormality))
			qliphoth_change(1) //counter increase if another abno dies
		return FALSE
	if(died == friend)
		friend = null
		Courage(FALSE)
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/abnormality/scaredy_cat/proc/OnAbnoBreach(datum/source, mob/living/simple_animal/hostile/abnormality/abno)
	SIGNAL_HANDLER
	if((abno.type in ignore_abno_list) || z != abno.z)
		return
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		if(LAZYFIND(prefered_abno_list, abno.type))
			priority_friend = abno
			qliphoth_change(-3) //for all intents and purposes he instantly breach
		else
			qliphoth_change(-1)
		return
	if(LAZYFIND(prefered_abno_list, abno.type) && !LAZYFIND(prefered_abno_list, friend.type))
		friend = abno //literally ditches his old friend if an oz abno gets out and he's not already friend with one
	if(stat == DEAD || !wait_for_friend)
		return
	if(abno != src)
		ProtectFriend(abno)
		return
