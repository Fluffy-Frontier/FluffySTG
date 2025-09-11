#define NOSFERATU_BANQUET_COOLDOWN (12 SECONDS)
// Coded by Coxswain, initlaly sprited by crabby, sprites later improved on by Reddim
/mob/living/simple_animal/hostile/abnormality/nosferatu
	name = "Nosferatu"
	desc = "A vampire, huh. Think I heard of it somewhere."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "nosferatu"
	icon_living = "nosferatu"
	var/icon_aggro = "nosferatu_breach"
	maxHealth = 2000
	health = 2000
	move_to_delay = 6
	rapid_melee = 1
	fear_level = WAW_LEVEL

	damage_coeff = list(BURN = 0.8, BRAIN = 1.2, BRUTE = 0.4, TOX = 1.5)
	melee_damage_lower = 35
	melee_damage_upper = 45 //has a wide range, he can critically hit you
	melee_damage_type = BRUTE
	stat_attack = HARD_CRIT
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/attack.ogg'
	can_breach = TRUE
	ranged = TRUE
	retreat_distance = 2
	minimum_distance = 1
	projectiletype = /obj/projectile/nosferatu_bat
	projectilesound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/weapons/fixer/generic/dodge.ogg'

	ego_list = list(
		/datum/ego_datum/weapon/dipsia,
		/datum/ego_datum/weapon/banquet,
		/datum/ego_datum/armor/dipsia,
	)
	gift_type = /datum/ego_gifts/dipsia
	observation_prompt = "I was human once, am still human. <br>I think. It's hard to tell anymore. <br>\
		He seemed lost, wandering the backstreets in such finery made him a tempting target, I never realised it was everyone else who was in danger. <br>\
		He wears the mask of humanity well, but a single drop of blood is all it took for him to reveal his ferocity. <br>\
		\"It's too early for a nap... <br>Won't you join me and share the pleasure?\" <br>He asks, his lips still red with my blood."


	// Work Stuff
	var/last_drawn = null
	var/last_drawn_check = 0
	var/failed = FALSE

	// Breach stuff
	var/bloodlust = 4
	var/bloodlust_cooldown = 4
	var/banquet_cooldown
	var/banquet_cooldown_time = 12 SECONDS
	var/banquet_damage = 100
	var/banquet_range = 3
	var/can_act = TRUE
	var/berzerk = FALSE
	var/mist_cooldown
	var/mist_cooldown_time = 30 SECONDS
	var/mist_form = FALSE
	// Minion stuff
	var/list/spawned_bats = list()
	var/summon_cooldown_time = 15 SECONDS
	var/bat_spawn_limit = 6
	var/spawns_bats = TRUE

	// PLAYABLES ATTACKS
	attack_action_types = list(
		/datum/action/cooldown/nosferatu_banquet,
		/datum/action/cooldown/nosferatu_mistform,
		/datum/action/innate/change_icon_nosf,
	)

// Playables buttons
/datum/action/cooldown/nosferatu_banquet
	name = "Banquet"
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	button_icon_state = "nosferatu"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = NOSFERATU_BANQUET_COOLDOWN //12 seconds

/datum/action/innate/change_icon_nosf
	name = "Toggle Icon"
	desc = "Toggle your icon between breached and contained. (Works only for Limbus Company Labratories)"

/datum/action/cooldown/nosferatu_banquet/Trigger(trigger_flags, atom/target)
	if(!..())
		return FALSE
	if(!istype(owner, /mob/living/simple_animal/hostile/abnormality/nosferatu))
		return FALSE
	var/mob/living/simple_animal/hostile/abnormality/nosferatu/nosferatu = owner
	if(nosferatu.IsContained()) // No more using cooldowns while contained
		return FALSE
	StartCooldown()
	nosferatu.Banquet()
	return TRUE

/datum/action/cooldown/nosferatu_mistform
	name = "Mist Form"
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	button_icon_state = "nos_teleport"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = NOSFERATU_BANQUET_COOLDOWN //12 seconds

/datum/action/cooldown/nosferatu_mistform/Trigger(trigger_flags, atom/target)
	if(!..())
		return FALSE
	if(!istype(owner, /mob/living/simple_animal/hostile/abnormality/nosferatu))
		return FALSE
	var/mob/living/simple_animal/hostile/abnormality/nosferatu/nosferatu = owner
	if(nosferatu.IsContained()) // No more using cooldowns while contained
		return FALSE
	StartCooldown()
	nosferatu.MistForm()
	return TRUE

// Spawning stuff
/mob/living/simple_animal/hostile/abnormality/nosferatu/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bloodfeast, siphon = TRUE, range = 2, starting = 1000)

/mob/living/simple_animal/hostile/abnormality/nosferatu/PostSpawn()
	..()
	if(!IsContained())
		update_icon()
	addtimer(CALLBACK(src, PROC_REF(GetThirstier)), 30 SECONDS)

// Work code
/mob/living/simple_animal/hostile/abnormality/nosferatu/proc/GetThirstier()
	if(!IsContained()) // Slowly get hungry over time
		return
	AdjustThirst(-25)
	var/datum/component/bloodfeast/bloodfeast = GetComponent(/datum/component/bloodfeast)
	if(!bloodfeast) // This could potentially happen with admins playing around or something
		return
	switch(bloodfeast.blood_amount)
		if(-INFINITY to 0) // Hey who was supposd to feed the vampire again?
			datum_reference.qliphoth_meter = 0
			BreachEffect()
			return
		if(0 to 500) // WAITER! More blood please!
			datum_reference.qliphoth_meter = 1
		if(500 to 1000) // Middle zone
			datum_reference.qliphoth_meter = 2
		if(1500 to 3000) // So much blood...
			datum_reference.qliphoth_meter = 3
		if(3000 to INFINITY) // WAIT THAT'S TOO MUCH BLOOD!
			datum_reference.qliphoth_meter = 0
			BreachEffect()
			return
	addtimer(CALLBACK(src, PROC_REF(GetThirstier)), 30 SECONDS)
	update_icon()


/mob/living/simple_animal/hostile/abnormality/nosferatu/OnQliphothChange()
	. = ..()
	if(datum_reference.qliphoth_meter > 1)
		icon_state = "nosferatu"
	else
		icon_state = "nosferatu_angry"
	update_icon()

/mob/living/simple_animal/hostile/abnormality/nosferatu/FailureEffect(mob/living/carbon/human/user)
	var/failure_penalty = prob(50) ? 7 : 14
	user.adjustBruteLoss(prob(50) ? 5 : 13 * 3)
	user.blood_volume -= user.blood_volume / 10
	new /obj/effect/temp_visual/damage_effect/bleed(get_turf(user))
	AdjustThirst(failure_penalty * 25) // We're angry so lets suck some blood
	failed = TRUE
	to_chat(user, span_warning("[src] suddenly sucks your blood!"))

/mob/living/simple_animal/hostile/abnormality/nosferatu/PostWorkEffect(mob/living/carbon/human/user)
	if(user.get_major_clothing_class() == CLOTHING_ARMORED && !failed) // Owe we got repessed
		AdjustThirst(-250)
		return
	if(datum_reference.qliphoth_meter < 3) // We're thirsty so lets suck some blood
		AdjustThirst(500)
		user.blood_volume -= user.blood_volume / 5
		user.adjustBruteLoss(15)
		new /obj/effect/temp_visual/damage_effect/bleed(get_turf(user))
		if(!failed)
			to_chat(user, span_warning("[src] suddenly sucks your blood!"))
	if(failed || datum_reference.qliphoth_meter < 3) // We sucked blood at least once, lets check the perp
		if(last_drawn != user)
			last_drawn_check = 0
		last_drawn = user
		last_drawn_check += 1
		if(last_drawn_check >= 3)
			user.adjustBruteLoss(999)
			AdjustThirst(user.blood_volume) // gain up to 2000 blood by draining this poor sod dry
			user.Drain()

/mob/living/simple_animal/hostile/abnormality/nosferatu/examine(mob/user)
	. = ..()
	var/shown_value = ""
	var/datum/component/bloodfeast/bloodfeast = GetComponent(/datum/component/bloodfeast)
	if(bloodfeast && IsContained()) // dont want to succ blood while contained
		switch(datum_reference.qliphoth_meter)
			if(1)
				shown_value = span_redtext("You can see a well of blood sloshing around in its longing eyes.")
			if(2)
				shown_value = span_notice("Looks like it could use a bite.")
			if(3)
				shown_value = span_nicegreen("Looks like it's had enough for now.")
		. += shown_value

// Breach
/mob/living/simple_animal/hostile/abnormality/nosferatu/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	var/list/units_to_add = list(
		/mob/living/simple_animal/hostile/nosferatu_mob = 8
		)
	AddComponent(/datum/component/ai_leadership, units_to_add, 4)
	mist_cooldown = world.time + mist_cooldown_time
	banquet_cooldown = world.time + banquet_cooldown_time
	update_icon()

/mob/living/simple_animal/hostile/abnormality/nosferatu/update_icon_state()
	if(IsContained()) // Not breached or berzerking
		icon_state = initial(icon_state)
		if(datum_reference.qliphoth_meter == 1)
			icon_state = "nosferatu_angry"
		return

	icon_state = icon_aggro
	if(berzerk || mist_form) // Big angry bat form
		icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
		pixel_x = -16
		base_pixel_x = -16
		if(mist_form)
			icon_state = "nosferatu_evade"
	else
		pixel_x = 0
		base_pixel_x = 0
		icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_living = icon_state
	return ..()

/mob/living/simple_animal/hostile/abnormality/nosferatu/Life()
	. = ..()
	if(!.)
		return
	var/datum/component/bloodfeast/bloodfeast = GetComponent(/datum/component/bloodfeast)
	if(!bloodfeast) // This could potentially happen with admins playing around or something
		return
	if(bloodfeast.blood_amount < 3000) // If we have over 3000 blood saved up, we can start using some for regeneration
		return
	var/amount_healed = clamp(bloodfeast.blood_amount * 0.0050, 1, 35) // 15-35 hp healed per second, consuming blood, scaling based on total blood
	src.adjustBruteLoss(-amount_healed)
	AdjustThirst(-amount_healed)

/mob/living/simple_animal/hostile/abnormality/nosferatu/proc/AdjustThirst(blood_amount)
	var/datum/component/bloodfeast/bloodfeast = GetComponent(/datum/component/bloodfeast)
	bloodfeast.AdjustBlood(blood_amount)
	if(bloodfeast.blood_amount > 3000 && !berzerk)
		Berzerk()

/mob/living/simple_animal/hostile/abnormality/nosferatu/proc/Berzerk()
	if(mist_form || IsContained()) // No bricking the mob by Berzerking when we aren't supposed to.
		return
	AdjustThirst(-3000)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/transform.ogg', 35, 8)
	bloodlust_cooldown = clamp(bloodlust_cooldown - 2, 0, 4)
	move_to_delay = 3
	berzerk = TRUE
	update_icon()
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(get_turf(src), src)
	animate(D, alpha = 0, transform = matrix()*2, time = 5)
	retreat_distance = null
	minimum_distance = null
	projectiletype = null
	projectilesound = null
	addtimer(CALLBACK(src, PROC_REF(BatSpawn)), 5 SECONDS)

/mob/living/simple_animal/hostile/abnormality/nosferatu/add_splatter_floor(turf/T, small_drip) //no spilling blood, it just works.
	return

// Special attacks
/mob/living/simple_animal/hostile/abnormality/nosferatu/OpenFire()
	if(!can_act || mist_form)
		return
	if(client)
		return ..()
	if((banquet_cooldown < world.time) && (get_dist(src, target) < 4))
		Banquet()
		return
	return ..()

/mob/living/simple_animal/hostile/abnormality/nosferatu/Shoot(atom/targeted_atom)
	. = ..()
	if(istype(., /obj/projectile/nosferatu_bat))
		var/obj/projectile/nosferatu_bat/P = .
		P.owner = src

/mob/living/simple_animal/hostile/abnormality/nosferatu/Move()
	if(!can_act)
		return FALSE
	..()

/mob/living/simple_animal/hostile/abnormality/nosferatu/AttackingTarget(atom/attacked_target)
	if(mist_form)
		return
	if(!ismob(attacked_target))
		return ..()
	if(!berzerk)
		OpenFire(attacked_target)
		return
	if(!ishuman(target))
		return ..()
	var/mob/living/carbon/human/H = attacked_target
	AdjustThirst(200)
	if(H.health < 0 || H.stat == DEAD)
		AdjustThirst(H.blood_volume) // gain up to 2000 blood by draining a corpse
		H.Drain()
	return ..()

/mob/living/simple_animal/hostile/abnormality/nosferatu/proc/BatSpawn(atom/the_target)
	if(!spawns_bats)
		return
	var/target_atom = the_target
	if(!target_atom) // Wondering why we pass the_target to this proc? Its because the mob's projectile calls BatSpawn(target) on hit!
		target_atom = src
		addtimer(CALLBACK(src, PROC_REF(BatSpawn)), summon_cooldown_time)
	if(isclosedturf(get_turf(target_atom)))
		var/newturf = get_step_towards(get_turf(target_atom), src)
		if(isclosedturf(newturf))
			return
		target_atom = newturf
	playsound(get_turf(target_atom), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/batspawn.ogg', 50, 1)
	//How many we have spawned
	list_clear_nulls(spawned_bats)
	for(var/mob/living/L in spawned_bats)
		if(L.stat == DEAD)
			spawned_bats -= L
	if(length(spawned_bats) >= bat_spawn_limit)
		return

	//Actually spawning them
	var/mob/living/simple_animal/hostile/nosferatu_mob/B = new(get_turf(target_atom))
	spawned_bats+=B

/mob/living/simple_animal/hostile/abnormality/nosferatu/proc/Banquet()//AOE attack
	if(mist_form) // No attack abilities while in mist form
		return
	banquet_cooldown = world.time + banquet_cooldown_time
	can_act = FALSE
	var/turf/myturf = get_turf(src)
	var/list/all_turfs = circle_view_turfs(myturf, banquet_range)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/special_start.ogg', 50, 0, 5)
	for(var/turf/E in all_turfs)
		new /obj/effect/temp_visual/cult/sparks(E)
	SLEEP_CHECK_DEATH(7, src)
	for(var/i = 1 to banquet_range)
		var/counter = 0
		for(var/turf/T in all_turfs)
			if(get_dist(myturf, T) != i)
				continue
			addtimer(CALLBACK(src, PROC_REF(DoAttack), T, all_turfs), ((counter * 0.2) + 3 * (i+1)) + 0.5 SECONDS)
			counter += 1
	if(berzerk) // Spend 400 blood in berzerker mode to perform a more powerful version - a second attack with wider reach
		SLEEP_CHECK_DEATH(14, src)
		var/datum/component/bloodfeast/bloodfeast = GetComponent(/datum/component/bloodfeast)
		if(bloodfeast.blood_amount >= 400)
			AdjustThirst(-400)
			var/extended_range = banquet_range + 1
			all_turfs = circle_view_turfs(myturf, extended_range)
			for(var/turf/E in all_turfs)
				new /obj/effect/temp_visual/cult/sparks(E)
			for(var/i = extended_range, i > 0, i--)
				var/counter = 0
				for(var/turf/T in all_turfs)
					if(get_dist(myturf, T) != i)
						continue
					addtimer(CALLBACK(src, PROC_REF(DoAttack), T, all_turfs), ((counter * 0.2) + 3 * (clamp(5 - i,0 ,5))) + 0.5 SECONDS)
					counter += 1
	SLEEP_CHECK_DEATH(20, src)
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/nosferatu/proc/DoAttack(turf/T, list/all_turfs)
	if(stat == DEAD)
		return
	var/obj/effect/temp_visual/smash_effect/bloodeffect =  new(T)
	bloodeffect.color = "#b52e19"
	playsound(T, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/attack_special.ogg', 25, 0, 5)
	for(var/mob/living/L in HurtInTurf(T, list(), banquet_damage, BRUTE, check_faction = TRUE, exact_faction_match = TRUE, hurt_mechs = TRUE, hurt_structure = TRUE, break_not_destroy = TRUE))
		all_turfs -= T
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			H.blood_volume -= H.blood_volume * 0.15
			if(H.health < 0)
				AdjustThirst(H.blood_volume) // gain up to 2000 blood by draining a corpse
				H.Drain()
		else
			L.apply_damage(banquet_damage * 0.5, BRUTE) // deal extra damage instead of bleed to nonhumans

/mob/living/simple_animal/hostile/abnormality/nosferatu/proc/MistForm()
	if(!can_act)
		return
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/batspawn.ogg', 75, 1)
	addtimer(CALLBACK(src, PROC_REF(ReAppear)), 5 SECONDS)
	incorporeal_move = INCORPOREAL_MOVE_BASIC
	mist_form = TRUE
	density = FALSE
	ChangeResistances(list(BURN = 0, BRAIN = 0, BRUTE = 0, TOX = 0))
	update_icon()

/mob/living/simple_animal/hostile/abnormality/nosferatu/proc/ReAppear()
	incorporeal_move = null
	mist_form = FALSE
	density = TRUE
	ChangeResistances(list(BURN = 0.8, BRAIN = 1.2, BRUTE = 0.4, TOX = 1.5))
	update_icon()

/mob/living/simple_animal/hostile/abnormality/nosferatu/handle_automated_action()
	. = ..()
	if(!can_act || IsContained() || stat == DEAD)
		return

	if(!mist_form && (mist_cooldown <= world.time))
		FleeNow()

// Literally big wolf ripped code, should properly handle automated fleeing through mist form.
/mob/living/simple_animal/hostile/abnormality/nosferatu/proc/FleeNow()
	if(!can_act)
		return
	mist_cooldown = world.time + mist_cooldown_time
	MistForm()
	AIStatus = AI_OFF
	target = null
	walk_to(src, 0)
	add_movespeed_modifier(/datum/movespeed_modifier/nosferatu)
	addtimer(CALLBACK(src, PROC_REF(remove_movespeed_modifier), /datum/movespeed_modifier/nosferatu), 3 SECONDS)
	//stolen from patrol select
	var/turf/target_center
	var/list/potential_centers = list()
	for(var/pos_targ in GLOB.generic_event_spawns)
		var/possible_center_distance = get_dist(src, pos_targ)
		if(possible_center_distance > 4 && possible_center_distance < 46)
			potential_centers += pos_targ
	if(LAZYLEN(potential_centers))
		target_center = pick(potential_centers)
	if(target_center)
		Goto(target_center)
		//Used to be in patrol_reset until i learned that patrol reset is inside Goto.
		update_icon()
		addtimer(CALLBACK(src, PROC_REF(StopFleeing)), 3 SECONDS)
		return
	StopFleeing()

/datum/movespeed_modifier/nosferatu
	multiplicative_slowdown = -2

/mob/living/simple_animal/hostile/abnormality/nosferatu/proc/StopFleeing()
	AIStatus = AI_ON
	update_icon()

// This snippet of code makes it so that attacks from its minions give it blood.
/mob/living/simple_animal/hostile/abnormality/nosferatu/attack_animal(mob/living/simple_animal/M)
	if(!istype(M, /mob/living/simple_animal/hostile/nosferatu_mob))
		return ..()
	var/mob/living/simple_animal/hostile/nosferatu_mob/blood_transfer_target = M
	var/datum/component/bloodfeast/target_bloodfeast = blood_transfer_target.GetComponent(/datum/component/bloodfeast)
	if(target_bloodfeast.blood_amount >= 100)
		var/amount_to_transfer = clamp(target_bloodfeast.blood_amount, 100, 1000)
		target_bloodfeast.AdjustBlood(-amount_to_transfer)
		AdjustThirst(amount_to_transfer)
		visible_message(span_danger("<b>[blood_transfer_target]</b> transfers some collected blood to [src]!"))
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/bloodcollect.ogg', 10, 1)
	else
		blood_transfer_target.LoseTarget()

// Bat minion - A non-dense trash mob that automatically harvests blood on attacks and returns blood to nosferatu. Dangeorus.
/mob/living/simple_animal/hostile/nosferatu_mob
	name = "\improper Sanguine bat"
	desc = "It looks like a bat."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "nosferatu_mob"
	icon_living = "nosferatu_mob"
	icon_dead = "nosferatu_mob"
	density = FALSE
	speak_emote = list("screeches")
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/nosferatu/bat_attack.ogg'
	del_on_death = TRUE
	health = 300
	maxHealth = 300
	damage_coeff = list(BURN = 1.2, BRAIN = 1.8, BRUTE = 0.6, TOX = 2)
	melee_damage_type = BRUTE
	melee_damage_lower = 5
	melee_damage_upper = 20
	move_to_delay = 1.3 //very fast, very weak.
	stat_attack = HARD_CRIT
	ranged = TRUE
	retreat_distance = 3
	minimum_distance = 1

/mob/living/simple_animal/hostile/nosferatu_mob/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bloodfeast, range = 1)

/mob/living/simple_animal/hostile/nosferatu_mob/proc/AdjustThirst(blood_amount)
	var/datum/component/bloodfeast/bloodfeast = GetComponent(/datum/component/bloodfeast)
	bloodfeast.AdjustBlood(blood_amount)

/mob/living/simple_animal/hostile/nosferatu_mob/AttackingTarget(atom/attacked_target) // They gain blood on hit
	. = ..()
	if(!ishuman(attacked_target))
		return
	var/mob/living/carbon/human/H = attacked_target
	if(H.health < 0 || H.stat == DEAD)
		AdjustThirst(H.blood_volume) // gain up to 2000 blood by draining a corpse
		H.Drain()
		return
	AdjustThirst(100)

/mob/living/simple_animal/hostile/nosferatu_mob/OpenFire(atom/A)
	if(istype(A, /mob/living/simple_animal/hostile/abnormality/nosferatu))
		return
	visible_message(span_danger("<b>[src]</b> flies around, seemingly aiming for [A]!"))
	ranged_cooldown = world.time + ranged_cooldown_time

/mob/living/simple_animal/hostile/nosferatu_mob/PickTarget(list/Targets)
	var/list/priority = list()
	for(var/mob/living/L in Targets)
		if(istype(L, /mob/living/simple_animal/hostile/abnormality/nosferatu))
			var/datum/component/bloodfeast/bloodfeast = GetComponent(/datum/component/bloodfeast)
			if(bloodfeast.blood_amount >= 500)
				return L // We have a bunch of blood, time to give it to bossman.4
			continue
		if(!CanAttack(L))
			continue
		priority += L
	if(LAZYLEN(priority))
		return pick(priority)

/mob/living/simple_animal/hostile/nosferatu_mob/CanAttack(atom/the_target)
	if(istype(the_target, /mob/living/simple_animal/hostile/abnormality/nosferatu))
		return TRUE
	return ..()

/mob/living/simple_animal/hostile/nosferatu_mob/death(gibbed)
	var/datum/component/bloodfeast/bloodfeast = GetComponent(/datum/component/bloodfeast)
	var/obj/effect/decal/cleanable/blood/B = new(get_turf(src))
	B.bloodiness = (bloodfeast.blood_amount * 0.5) // drops half of its blood on death. This is potentially far more than what fits in a splatter.
	..()

#undef NOSFERATU_BANQUET_COOLDOWN
