#define STATUS_EFFECT_MELTYLOVE /datum/status_effect/display/melting_love_blessing
#define STATUS_EFFECT_SLIMED  /datum/status_effect/melty_slimed
/mob/living/simple_animal/hostile/abnormality/melting_love
	name = "Melting Love"
	desc = "A pink slime creature, resembling a female humanoid."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	icon_state = "melting_love"
	icon_living = "melting_love"
	pixel_x = -16
	base_pixel_x = -16
	speak_emote = list("gurgle")
	attack_verb_continuous = "glomps"
	attack_verb_simple = "glomp"
	/* Stats */
	fear_level = ALEPH_LEVEL
	health = 4000
	maxHealth = 4000
	obj_damage = 60
	damage_coeff = list(BURN = -1, BRAIN = 1, BRUTE = 1.5, TOX = 0.8)
	melee_damage_type = BRUTE
	melee_damage_lower = 55
	melee_damage_upper = 60 // AOE damage increases it drastically
	projectiletype = /obj/projectile/melting_blob
	ranged = TRUE
	stat_attack = DEAD
	minimum_distance = 0
	ranged_cooldown_time = 5 SECONDS
	move_to_delay = 4
	/* Works */
	can_breach = TRUE
	/* Sounds */
	projectilesound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/meltinglove/ranged.ogg'
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/meltinglove/attack.ogg'
	death_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/meltinglove/death.ogg'
	del_on_death = FALSE
	ego_list = list(/datum/ego_datum/weapon/adoration, /datum/ego_datum/armor/adoration)
	gift_type =  /datum/ego_gifts/adoration
	observation_prompt = "The slime craves affection, it covers the cell's floor, walls and celing. <br>\
		It clings to your clothes, your mask and your skin as you enter. <br>At the centre of the cell, where the deluge conglomerates most, is the facismile of a girl. <br>\
		She waves at you shyly. <br>You..."


	var/mob/living/carbon/human/gifted_human = null
	/// Amount of BLACK damage done to all enemies around main target on melee attack. Also includes original target
	var/radius_damage = 30
	update_qliphoth = 0
	success_chance = 33
	neutral_chance = 50
	negative_chance = 27

/mob/living/simple_animal/hostile/abnormality/melting_love/Login()
	. = ..()
	to_chat(src, "<h1>You are Melting Love, A Tank Role Abnormality.</h1><br>\
		<b>|Absorbing Slime|: RED damage heals you instead of damaging you, The same thing applies to your slime pawns.<br>\
		<br>\
		|Sticky Slime|: Some of your abilities will inflict 'SLIMED' on the target.\
		Targets with 'SLIMED' will take BLACK damage over time and will become slowed down for it's duration.<br>\
		<br>\
		|Melting Slime|: As you move around, you will leave behind 'Melting Slime' on the turfs you cross. If any non-slime crosses this 'Melting Slime', They will be inflicted with 'SLIMED'.<br>\
		<br>\
		|Spreading Love...|: When you attack a dead body, you will convert it into a 'Slime Pawn.' Slime pawns exist for a short amount of time and detonate upon their death.\
		When they detonate, they will deal BLACK damage to nearby humans and spread 'Melting Slime' around them.\
		Also, If you attack your own 'Slime Pawn', You will devour them and heal 20% of your HP.<br>\
		<br>\
		|Stay Together...|: When you click on a tile outside your melee range, You will fire a slime projectile towards that tile. The projectile will inflict the target with 'SLIMED' and deal BLACK damage.\
		If the projectile hits a dead body, it will convert it into a slime pawn.</b>")

/mob/living/simple_animal/hostile/abnormality/melting_love/death(gibbed)
	density = FALSE
	animate(src, alpha = 0, time = (5 SECONDS))
	QDEL_IN(src, (5 SECONDS))
	return ..()

/* Attacks */
/mob/living/simple_animal/hostile/abnormality/melting_love/CanAttack(atom/the_target)
	if(isliving(the_target) && !ishuman(the_target))
		var/mob/living/L = the_target
		if(L.stat == DEAD)
			return FALSE
		if(L.type == /mob/living/simple_animal/hostile/slime && health <= maxHealth * 0.8) // We need healing
			return TRUE
	return ..()

/mob/living/simple_animal/hostile/abnormality/melting_love/OpenFire(atom/A)
	if(get_dist(src, A) < 2) // We can't fire normal ranged attack that close
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/abnormality/melting_love/AttackingTarget(atom/attacked_target)
	// Convert
	if(ishuman(attacked_target))
		var/mob/living/carbon/human/H = attacked_target
		if(H.stat == DEAD || H.health <= HEALTH_THRESHOLD_DEAD)
			return SlimeConvert(H)

	// Consume a slime. Cannot work on the big one, so the check is not istype()
	if(attacked_target.type == /mob/living/simple_animal/hostile/slime)
		var/mob/living/simple_animal/hostile/slime/S = attacked_target
		visible_message(span_warning("[src] consumes \the [S], restoring its own health."))
		. = ..() // We do a normal attack without AOE and then consume the slime to restore HP
		adjustBruteLoss(-maxHealth * 0.2)
		S.adjustBruteLoss(S.maxHealth) // To make sure it dies
		return .

	// AOE attack
	if(isliving(attacked_target) || ismecha(attacked_target))
		new /obj/effect/gibspawner/generic/silent/melty_slime(get_turf(attacked_target))
		for(var/turf/open/T in view(1, attacked_target))
			var/obj/effect/temp_visual/small_smoke/halfsecond/S = new(T)
			S.color = "#FF0081"
			var/list/got_hit = list()
			got_hit = HurtInTurf(T, got_hit, radius_damage, BRUTE, null, TRUE, FALSE, TRUE)
			for(var/mob/living/L in got_hit)
				L.apply_status_effect(STATUS_EFFECT_SLIMED)
	return ..()

/mob/living/simple_animal/hostile/abnormality/melting_love/bullet_act(obj/projectile/P)
	if (P.damage_type == BRUTE && !ishuman(P.firer))
		return BULLET_ACT_BLOCK
	. = ..()

/mob/living/simple_animal/hostile/abnormality/melting_love/Move()
	. = ..()
	var/turf/T = get_turf(src)
	if(!isturf(T) || isspaceturf(T))
		return
	if(locate(/obj/effect/decal/cleanable/melty_slime) in T)
		for(var/obj/effect/decal/cleanable/melty_slime/slime in T)
			slime.Refresh()
		return
	new /obj/effect/decal/cleanable/melty_slime(T)

/* Slime Conversion */
/mob/living/simple_animal/hostile/abnormality/melting_love/proc/SlimeConvert(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	if(H.has_status_effect(STATUS_EFFECT_MELTYLOVE))
		//The status effect should explode them eventually. If not we have a bigger problem.
		return FALSE
	visible_message(span_danger("[src] glomps on \the [H] as another slime pawn appears!"))
	new /mob/living/simple_animal/hostile/slime(get_turf(H))
	H.gib(FALSE, TRUE, TRUE)
	return TRUE

/* Qliphoth things */
/mob/living/simple_animal/hostile/abnormality/melting_love/SuccessEffect(mob/living/carbon/human/user)
	if(user.has_status_effect(STATUS_EFFECT_MELTYLOVE))
		qliphoth_change(1)
	return

/mob/living/simple_animal/hostile/abnormality/melting_love/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/melting_love/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/melting_love/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96.dmi'
	icon_living = "melting_breach"
	icon_state = icon_living
	icon_dead = "melting_breach_dead"
	pixel_x = -32
	base_pixel_x = -32
	desc = "A pink hunched creature with long arms, there are also visible bones coming from insides of the slime."
	if(istype(gifted_human))
		DissolveGifted(gifted_human)
	else
		Empower()

/* Gift */
/mob/living/simple_animal/hostile/abnormality/melting_love/PostWorkEffect(mob/living/carbon/human/user)
	if(HAS_TRAIT(user, TRAIT_GODMODE))
		return
	if(!gifted_human && istype(user) && user.get_major_clothing_class() != CLOTHING_ARMORED && user.stat != DEAD && (HAS_TRAIT(src, TRAIT_GODMODE)))
		gifted_human = user
		RegisterSignal(gifted_human, COMSIG_WORK_COMPLETED, PROC_REF(GiftedAnger))
		user.apply_status_effect(STATUS_EFFECT_MELTYLOVE)
		to_chat(user, span_nicegreen("You feel like you received a gift..."))
		playsound(get_turf(user), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/meltinglove/gift.ogg', 50, 0, 2)
		return
	if(istype(user) && user.has_status_effect(STATUS_EFFECT_MELTYLOVE))
		to_chat(gifted_human, span_nicegreen("Melting Love was happy to see you!"))
		gifted_human.adjustSanityLoss(rand(-25,-35))
		return

/mob/living/simple_animal/hostile/abnormality/melting_love/try_working(mob/living/carbon/human/user)
	if(user.has_status_effect(STATUS_EFFECT_MELTYLOVE))
		neutral_chance = 60
		negative_chance = 17
	else
		neutral_chance = 50
		negative_chance = 27
	return ..()

//Status effect will turn them into a slime if they died.
/mob/living/simple_animal/hostile/abnormality/melting_love/proc/DissolveGifted(mob/living/carbon/C)
	to_chat(C, span_userdanger("You feel like you are about to burst!"))
	C.emote("scream")
	C.apply_damage(800, BRUTE)
	C.remove_status_effect(STATUS_EFFECT_MELTYLOVE)

/mob/living/simple_animal/hostile/abnormality/melting_love/proc/UnregisterGiftedSignals(mob/living/carbon/human/user)
	if(user)
		UnregisterSignal(user, COMSIG_WORK_COMPLETED)
		return TRUE

/mob/living/simple_animal/hostile/abnormality/melting_love/proc/GiftedAnger(datum/source, mob/living/carbon/human/user)
	SIGNAL_HANDLER
	if(gifted_human.get_major_clothing_class() == CLOTHING_ARMORED)
		to_chat(gifted_human, span_userdanger("[src] didn't like that!"))
		qliphoth_change(-1)

/* Checking if bigslime is dead or not and apply a damage buff if yes */
/mob/living/simple_animal/hostile/abnormality/melting_love/proc/SlimeDeath(datum/source, gibbed)
	SIGNAL_HANDLER
	Empower()
	for(var/mob/M in GLOB.player_list)
		if(M.z == z && M.client)
			to_chat(M, span_userdanger("You can hear a gooey cry!"))
			SEND_SOUND(M, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/meltinglove/empower.ogg')
			flash_color(M, flash_color = "#FF0081", flash_time = 50)
	return TRUE

/mob/living/simple_animal/hostile/abnormality/melting_love/proc/Empower()
	move_to_delay = 0.5
	melee_damage_lower = 80
	melee_damage_upper = 85
	projectiletype = /obj/projectile/melting_blob/enraged
	adjustBruteLoss(-maxHealth, forced = TRUE)
	desc += " It looks angry."

/mob/living/simple_animal/hostile/abnormality/melting_love/proc/SpawnBigSlime(mob/living/simple_animal/hostile/slime/big/S)
	gifted_human = null
	qliphoth_change(-9)
	if(S)
		RegisterSignal(S, COMSIG_LIVING_DEATH, PROC_REF(SlimeDeath))

/* Slimes (HE) */
/mob/living/simple_animal/hostile/slime
	name = "slime pawn"
	desc = "The skeletal remains of a former employee is floating in it..."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "little_slime"
	icon_living = "little_slime"
	speak_emote = list("gurgle")
	attack_verb_continuous = "glomps"
	attack_verb_simple = "glomp"
	/* Stats */
	health = 400
	maxHealth = 400
	obj_damage = 60
	damage_coeff = list(BURN = -1, BRAIN = 1, BRUTE = 2, TOX = 1)
	melee_damage_type = BRUTE
	melee_damage_lower = 20
	melee_damage_upper = 25
	rapid_melee = 2
	speed = 2
	move_to_delay = 3
	/* Sounds */
	death_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/meltinglove/pawn_death.ogg'
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/meltinglove/pawn_attack.ogg'
	/* Vars and others */
	robust_searching = TRUE
	stat_attack = DEAD
	del_on_death = TRUE
	var/spawn_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/meltinglove/pawn_convert.ogg'
	var/statuschance = 25
	var/death_damage = 20
	var/death_slime_range = 1
	var/decay_damage = 20
	var/decay_timer = 4

/mob/living/simple_animal/hostile/slime/Login()
	. = ..()
	to_chat(src, "<h1>You are a Slime Pawn, A Melting Love minion.</h1><br>\
		<b>|Combust...|: You take 20 BLACK damage every 4 Seconds, Which means you have 40 seconds to live, unless someone attacks you with RED damage. \
		Once you die, you will explode and place down 'Slime' in a 3x3 area around you, and deal 20 BLACK damage to all foes near you.<br>\
		<br>\
		|Mother?|: Melting Love is able to attack you to devour you and heal 20% of her HP.</b>")

/mob/living/simple_animal/hostile/slime/Initialize()
	. = ..()
	playsound(get_turf(src), spawn_sound, 50, 1)
	var/matrix/init_transform = transform
	transform *= 0.1
	alpha = 25
	animate(src, alpha = 255, transform = init_transform, time = 5)

/mob/living/simple_animal/hostile/slime/death()
	for(var/atom/movable/AM in src)
		AM.forceMove(get_turf(src))
	for(var/turf/open/R in range(death_slime_range, src))
		new /obj/effect/decal/cleanable/melty_slime(R)
	for(var/mob/living/L in view(death_slime_range, src))
		if(L.stat != DEAD && !istype(L, /mob/living/simple_animal/hostile/slime))
			L.apply_damage(death_damage, BRUTE, null, L.run_armor_check(null, BRUTE))
	return ..()

/mob/living/simple_animal/hostile/slime/CanAttack(atom/the_target)
	if(isliving(the_target) && !ishuman(the_target))
		var/mob/living/L = the_target
		if(L.stat == DEAD)
			return FALSE
	return ..()

/mob/living/simple_animal/hostile/slime/AttackingTarget(atom/attacked_target)
	// Convert
	if(ishuman(attacked_target))
		var/mob/living/carbon/human/H = attacked_target
		if(H.stat == DEAD || H.health <= HEALTH_THRESHOLD_DEAD)
			return SlimeConvert(H)
		if(prob(statuschance))
			H.apply_status_effect(STATUS_EFFECT_SLIMED)
	return ..()

/mob/living/simple_animal/hostile/slime/proc/SlimeConvert(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	visible_message(span_danger("[src] glomps on \the [H] as another slime pawn appears!"))
	new /mob/living/simple_animal/hostile/slime(get_turf(H))
	H.gib(FALSE, TRUE, TRUE)
	return TRUE

//3 monsters including parasite tree sapling and naked nest use this proc i might make it part of the root in the future -IP
/mob/living/simple_animal/hostile/slime/proc/NestedItems(mob/living/simple_animal/hostile/nest, obj/item/nested_item)
	if(nested_item)
		nested_item.forceMove(nest)

/* Big Slimes (WAW) */
/mob/living/simple_animal/hostile/slime/big
	name = "big slime"
	desc = "The skeletal remains of the former gifted employee is floating in it..."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x48.dmi'
	icon_state = "big_slime"
	icon_living = "big_slime"
	pixel_x = -8
	base_pixel_x = -8
	/* Stats */
	health = 2000
	maxHealth = 2000
	melee_damage_lower = 35
	melee_damage_upper = 40
	spawn_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/meltinglove/pawn_big_convert.ogg'
	statuschance = 75

/*
* MELTY BLESSING
* I want to say that this blessing is a
* bit haphazardly stapled on by me. Half of the mechanics
* are inside melty and the other half is in the status effect
* unsure if this is good. -IP
*/
/datum/status_effect/display/melting_love_blessing
	id = "melting_love_blessing"
	status_type = STATUS_EFFECT_UNIQUE
	duration = -1
	tick_interval = 50
	alert_type = null
	on_remove_on_mob_delete = TRUE
	var/mob/living/simple_animal/hostile/abnormality/melting_love/connected_abno

/datum/status_effect/display/melting_love_blessing/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.physiology.brain_mod -= 30
	connected_abno = locate(/mob/living/simple_animal/hostile/abnormality/melting_love) in GLOB.abnormality_mob_list

/datum/status_effect/display/melting_love_blessing/tick()
	. = ..()
	if(!ishuman(owner))
		QDEL_IN(src, 5)
		return
	var/mob/living/carbon/human/status_holder = owner
	status_holder.adjustSanityLoss(-10)
	if(status_holder.stat == DEAD)
		qdel(src)

/datum/status_effect/display/melting_love_blessing/on_remove()
	if(!ishuman(owner))
		return ..()
	if(!Dissolve(owner) && istype(owner) && connected_abno)
		connected_abno.UnregisterGiftedSignals(owner)
	return ..()

/datum/status_effect/display/melting_love_blessing/proc/Dissolve(mob/living/carbon/human/H)
	if(H)
		H.physiology.brain_mod += 30
		if(H.stat == DEAD)
			var/mob/living/simple_animal/hostile/slime/big/new_mob = new(owner.loc)
			NestedItems(new_mob, H.get_item_by_slot(ITEM_SLOT_SUITSTORE))
			NestedItems(new_mob, H.get_item_by_slot(ITEM_SLOT_BELT))
			NestedItems(new_mob, H.get_item_by_slot(ITEM_SLOT_BACK))
			NestedItems(new_mob, H.get_item_by_slot(ITEM_SLOT_OCLOTHING))
			if(connected_abno)
				connected_abno.SpawnBigSlime(new_mob)
			H.gib(TRUE, TRUE, TRUE)
			return new_mob

/datum/status_effect/display/melting_love_blessing/proc/NestedItems(mob/living/simple_animal/hostile/nest, obj/item/nested_item)
	if(nested_item)
		nested_item.forceMove(nest)

//Slime trails
/obj/effect/decal/cleanable/melty_slime
	name = "Slime"
	desc = "It looks corrosive."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/tegu_effects.dmi'
	icon_state = "melty_slime3"
	random_icon_states = list("melty_slime3")
	mergeable_decal = TRUE
	var/duration = 30 SECONDS
	var/state = 3
	var/timer1
	var/timer2
	var/list/slime_types = list(
		/mob/living/simple_animal/hostile/abnormality/melting_love,
		/mob/living/simple_animal/hostile/slime/big,
		/mob/living/simple_animal/hostile/slime
	)

/obj/effect/decal/cleanable/melty_slime/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	START_PROCESSING(SSobj, src)
	duration += world.time
	timer1 = addtimer(CALLBACK(src, PROC_REF(Reduce)), 10 SECONDS, TIMER_STOPPABLE)
	timer2 = addtimer(CALLBACK(src, PROC_REF(Reduce)), 20 SECONDS, TIMER_STOPPABLE)

/obj/effect/decal/cleanable/melty_slime/proc/Refresh()
	icon_state = "melty_slime3"
	duration = 30 SECONDS
	if(timer1)
		deltimer(timer1)
		timer1 = null
	if(timer2)
		deltimer(timer2)
		timer2 = null
	timer1 = addtimer(CALLBACK(src, PROC_REF(Reduce)), 10 SECONDS, TIMER_STOPPABLE)
	timer2 = addtimer(CALLBACK(src, PROC_REF(Reduce)), 20 SECONDS, TIMER_STOPPABLE)


/obj/effect/decal/cleanable/melty_slime/proc/Reduce()
	state -= 1
	icon_state = "melty_slime[state]"
	update_icon()

/obj/effect/decal/cleanable/melty_slime/process(delta_time)
	if(world.time > duration)
		Remove()

/obj/effect/decal/cleanable/melty_slime/proc/Remove()
	STOP_PROCESSING(SSobj, src)
	animate(src, time = (5 SECONDS), alpha = 0)
	QDEL_IN(src, 5 SECONDS)

/obj/effect/decal/cleanable/melty_slime/proc/streak(list/directions, mapload=FALSE)
	set waitfor = FALSE
	var/direction = pick(directions)
	for(var/i in 0 to pick(0, 200; 1, 150; 2, 50; 3, 17; 50)) //the 3% chance of 50 steps is intentional and played for laughs.
		if (!mapload)
			sleep(2)
		if(!step_to(src, get_step(src, direction), 0))
			break

///obj/effect/decal/cleanable/melty_slime/Crossed(atom/movable/AM)
//	. = ..()
//	if(!isliving(AM))
//		return FALSE
//	if(is_type_in_list(AM, slime_types, FALSE))
//		return
//	var/mob/living/L = AM
//	if("hostile" in L.faction)
//		return
//	L.apply_status_effect(STATUS_EFFECT_SLIMED)

/obj/effect/gibspawner/generic/silent/melty_slime
	gibtypes = list(/obj/effect/decal/cleanable/melty_slime)

/obj/effect/gibspawner/generic/silent/melty_slime/Initialize()
	if(!gibdirections.len)
		gibdirections = list(list(WEST, NORTHWEST, SOUTHWEST, NORTH))
	. = ..()
	return

//Attack Status Effect
/datum/status_effect/melty_slimed
	id = "melty_slimed"
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/melty_slimed
	duration = 10 SECONDS // Hits 5 times
	tick_interval = 2 SECONDS

/atom/movable/screen/alert/status_effect/melty_slimed
	name = "Acidic Goo"
	desc = "Slime is stuck to your skin, slowing you down and dealing BLACK damage!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "slimed"

/datum/status_effect/melty_slimed/tick()
	. = ..()
	if(!isliving(owner))
		return
	var/mob/living/L = owner
	L.apply_damage(10, BRUTE)
	owner.playsound_local(owner, 'sound/effects/wounds/sizzle2.ogg', 25, TRUE)
	if(!ishuman(L))
		return
	if((L.sanityhealth <= 0) || (L.health <= 0))
		var/turf/T = get_turf(L)
		new /mob/living/simple_animal/hostile/slime(T)
		L.gib(TRUE, TRUE, TRUE)

/datum/status_effect/melty_slimed/on_apply()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/slimed)
	owner.playsound_local(owner, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/meltinglove/ranged_hit.ogg', 50, TRUE)
	return ..()

/datum/status_effect/melty_slimed/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/slimed)
	return ..()

/datum/movespeed_modifier/slimed
	multiplicative_slowdown = 1
	variable = FALSE

#undef STATUS_EFFECT_SLIMED
#undef STATUS_EFFECT_MELTYLOVE
