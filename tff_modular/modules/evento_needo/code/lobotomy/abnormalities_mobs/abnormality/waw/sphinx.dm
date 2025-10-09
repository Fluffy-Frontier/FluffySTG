//Coded by Coxswain
/mob/living/simple_animal/hostile/abnormality/sphinx
	name = "Sphinx"
	desc = "A gigantic stone feline."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x48.dmi'
	icon_state = "sphinx"
	icon_living = "sphinx"
	var/icon_aggro = "sphinx_eye"
	speak_emote = list("intones")
	pixel_x = -16
	base_pixel_x = -16
	ranged = TRUE
	maxHealth = 2000
	health = 2000
	damage_coeff = list(BURN = 1.2, BRAIN = 0.5, BRUTE = 0.8, TOX = 1.5)
	stat_attack = HARD_CRIT
	move_to_delay = 4
	melee_damage_lower = 70
	melee_damage_upper = 100
	attack_sound = 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/sphinx/attack.ogg'
	attack_action_types = list(/datum/action/cooldown/sphinx_gaze, /datum/action/cooldown/sphinx_quake)
	can_breach = TRUE
	fear_level = WAW_LEVEL
	melee_damage_type = BRUTE
	ego_list = list(
		/datum/ego_datum/weapon/pharaoh,
		/datum/ego_datum/armor/pharaoh,
	)
	gift_type =  /datum/ego_gifts/pharaoh
	secret_chance = TRUE // Why do we live, just to suffer?
	secret_icon_file = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	secret_icon_state = "sphonx"

	observation_prompt = "I found myself in an antique land <br>\
		A vast and trunkless leg of stone stands before me in the desert that stretches far and wide. <br>\
		Beside me, the great sphinx lies. <br>It beckons me to answer the plaque. <br>\
		Written in characters I have never seen before, well are the sculptor's passions read. <br>\
		\"What goes on four feet in the morning, two feet in midday, and three feet in the evening?\""


	//work-related
	var/loot_progress = 0
	var/prudence_work_chance = 0
	var/list/workloot = list(
		/obj/item/golden_needle,
		/obj/item/canopic_jar,
	)
	//breach
	var/can_act = TRUE
	var/curse_cooldown
	var/curse_cooldown_time = 12 SECONDS
	var/quake_cooldown
	var/quake_cooldown_time = 6 SECONDS
	var/quake_damage = 20

//Playables buttons
	attack_action_types = list(
		/datum/action/cooldown/sphinx_gaze,
		/datum/action/cooldown/sphinx_quake,
	)

	speak = list(
		"Our old masters are waiting for us.",
		"Listen to the stars.",
		"The age of mankind is over...",
		"AHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA!!",
		"I can't... It's too much!",
	)

/datum/action/cooldown/sphinx_gaze
	name = "Sphinx's Gaze"
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	button_icon_state = "sphinx"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = 12 SECONDS

/datum/action/cooldown/sphinx_gaze/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/hostile/abnormality/sphinx/sphinx = owner
	if(!istype(sphinx))
		return FALSE
	if(sphinx.IsContained()) // No more using cooldowns while contained
		return FALSE
	if(sphinx.curse_cooldown_time > world.time || !sphinx.can_act)
		return FALSE
	StartCooldown()
	sphinx.StoneVision(FALSE)
	return TRUE

/datum/action/cooldown/sphinx_quake
	name = "Sphinx's Earthquake"
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	button_icon_state = "ebony_barrier"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = 6 SECONDS

/datum/action/cooldown/sphinx_quake/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/hostile/abnormality/sphinx/sphinx = owner
	if(!istype(sphinx))
		return FALSE
	if(sphinx.IsContained()) // No more using cooldowns while contained
		return FALSE
	if(sphinx.quake_cooldown > world.time || !sphinx.can_act)
		return FALSE
	StartCooldown()
	sphinx.Quake()
	return TRUE

/mob/living/simple_animal/hostile/abnormality/sphinx/InitializeSecretIcon()
	. = ..()
	icon_aggro = "sphonx_eye"

// Abnormality Work Stuff
/mob/living/simple_animal/hostile/abnormality/sphinx/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	prudence_work_chance = clamp(user.get_clothing_class_level(CLOTHING_SCIENCE) * 0.45, 1, 3) // Additional roll on a every work tick based on prudence

	if(prob(prudence_work_chance * 10))
		loot_progress += 1
	if(prob(prudence_work_chance * 20))
		loot_progress += 1

/mob/living/simple_animal/hostile/abnormality/sphinx/PostWorkEffect(mob/living/carbon/human/user)
	if(loot_progress == 2)
		var/turf/dispense_turf = get_step(src, EAST)
		var/reward = pick(workloot)
		new reward(dispense_turf)
	loot_progress = 0
	if(user.sanity_lost)
		QDEL_NULL(user.ai_controller)
		user.ai_controller = /datum/ai_controller/insane/wander/sphinx
		user.InitializeAIController()

/mob/living/simple_animal/hostile/abnormality/sphinx/FailureEffect(mob/living/carbon/human/user)
	qliphoth_change(-1)
	if(!user)
		return
	if(user.get_major_clothing_class() == CLOTHING_SCIENCE)
		return
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/eyes/eyes = H.get_organ_slot(ORGAN_SLOT_EYES)
	var/obj/item/organ/ears/ears = H.get_organ_slot(ORGAN_SLOT_EARS)
	var/obj/item/organ/tongue/tongue = H.get_organ_slot(ORGAN_SLOT_TONGUE)
	var/chosenorgan = pick(eyes,ears,tongue)
	while(!chosenorgan)
		if(!eyes && !ears && !tongue)
			to_chat(H, span_warning("With nothing left to lose, you lose your life."))
			H.dust()
			return
		chosenorgan = pick(eyes,ears,tongue)
	if(chosenorgan == eyes)
		to_chat(user, span_warning("A brilliant flash of light is the last thing you see..."))
	if(chosenorgan == ears)
		to_chat(user, span_warning("Suddenly, everything goes quiet..."))
	if(chosenorgan == tongue)
		to_chat(user, span_warning("Your mouth feels uncomfortably hollow..."))
	//chosenorgan.Remove(user)
	qdel(chosenorgan)

// Breach
/mob/living/simple_animal/hostile/abnormality/sphinx/BreachEffect(mob/living/carbon/human/user)
	. = ..()
	AddElement(/datum/element/knockback, 3, FALSE, TRUE)
	GiveTarget(user)

/mob/living/simple_animal/hostile/abnormality/sphinx/Move()
	if(!can_act)
		return FALSE
	..()

/mob/living/simple_animal/hostile/abnormality/sphinx/PickTarget(list/Targets)
	var/list/priority = list()
	for(var/mob/living/L in Targets)
		if(!CanAttack(L))
			continue
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			if(H.sanity_lost) //ignore the panicked
				continue
			else
				priority += L
		else
			priority += L
	if(LAZYLEN(priority))
		return pick(priority)

/mob/living/simple_animal/hostile/abnormality/sphinx/AttackingTarget(atom/attacked_target)
	if(!ishuman(attacked_target))
		if(!target)
			GiveTarget(attacked_target)
		return OpenFire(attacked_target)

	var/mob/living/carbon/human/H = attacked_target
	if(!H.sanity_lost)
		if(!target)
			GiveTarget(attacked_target)
		return OpenFire(attacked_target)

	QDEL_NULL(H.ai_controller)
	H.ai_controller = /datum/ai_controller/insane/wander/sphinx
	H.InitializeAIController()
	LoseTarget(H)

/mob/living/simple_animal/hostile/abnormality/sphinx/OpenFire()
	if(!can_act)
		return

	if((curse_cooldown <= world.time)  && !client)
		StoneVision(FALSE)
		return
	StoneThrow(target)

/mob/living/simple_animal/hostile/abnormality/sphinx/attackby(obj/item/I, mob/living/user, params)
	..()
	if(!client)
		TryQuake()

/mob/living/simple_animal/hostile/abnormality/sphinx/attack_animal(mob/living/simple_animal/M)
	..()
	if(!client)
		TryQuake()

/mob/living/simple_animal/hostile/abnormality/sphinx/proc/StoneThrow()
	if(!can_act)
		return
	can_act = FALSE
	SLEEP_CHECK_DEATH(3, src)
	playsound(get_turf(target), 'tff_modular/modules/evento_needo/sounds/Tegusounds/arbiter/repulse.ogg', 20, 0, 5)
	new /obj/effect/temp_visual/rockwarning(get_turf(target), src)
	SLEEP_CHECK_DEATH(10, src)
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/sphinx/proc/TryQuake()
	if((quake_cooldown <= world.time)  && !client)
		Quake()

/mob/living/simple_animal/hostile/abnormality/sphinx/proc/Quake()
	if(quake_cooldown > world.time || !can_act)
		return
	quake_cooldown = world.time + quake_cooldown_time
	can_act = FALSE
	var/turf/origin = get_turf(src)
	playsound(origin, 'tff_modular/modules/evento_needo/sounds/Tegusounds/arbiter/knock.ogg', 25, 0, 5)
	SLEEP_CHECK_DEATH(9, src)
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/brown/rock_attack.ogg', 50, 0, 8)
	for(var/turf/T in view(2, src))
		new /obj/effect/temp_visual/smash_effect(T)
		for(var/mob/living/victim in HurtInTurf(T, list(), quake_damage, BRUTE, null, TRUE, FALSE, TRUE, FALSE, TRUE, TRUE))
			var/throw_target = get_edge_target_turf(victim, get_dir(victim, get_step_away(victim, src)))
			if(!victim.anchored)
				var/throw_velocity = (prob(60) ? 1 : 4)
				victim.throw_at(throw_target, rand(1, 2), throw_velocity, src)
	SLEEP_CHECK_DEATH(8, src)
	icon_state = icon_living
	SLEEP_CHECK_DEATH(3, src)
	can_act = TRUE

/mob/living/simple_animal/hostile/abnormality/sphinx/proc/StoneVision(attack_chain)
	if((curse_cooldown > world.time) && !attack_chain)
		return
	if(!attack_chain)
		playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/sphinx/stone_ready.ogg', 50, 0, 5)
		icon_state = icon_aggro
		can_act = FALSE
		src.set_light(5, 7, "D4FAF37", TRUE)
		for(var/turf/T in view(7, src))
			if(T.density)
				continue
			new /obj/effect/temp_visual/stone_gaze(T)
	curse_cooldown = world.time + curse_cooldown_time
	SLEEP_CHECK_DEATH(12, src)
	for(var/mob/living/carbon/human/L in viewers(7, src))
		if(L.client && CanAttack(L) && L.stat != DEAD)
			if(!L.is_blind() && L.dir == get_dir(L, src))
				StoneCurse(L)
	if(!attack_chain)
		StoneVision(TRUE)
		return
	icon_state = icon_living
	can_act = TRUE
	src.set_light(0, 0, null, FALSE) //using all params takes care of the other procs.
	return

/mob/living/simple_animal/hostile/abnormality/sphinx/proc/StoneCurse(target)
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	if(!(H.has_movespeed_modifier(/datum/movespeed_modifier/petrify_partial)))
		H.add_movespeed_modifier(/datum/movespeed_modifier/petrify_partial)
		addtimer(CALLBACK(H, TYPE_PROC_REF(/mob, remove_movespeed_modifier), /datum/movespeed_modifier/petrify_partial), 3 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)
		to_chat(H, span_warning("Your whole body feels heavy..."))
		playsound(get_turf(H), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/sphinx/petrify.ogg', 50, 0, 5)
	else
		H.petrify()

// Insanity lines
/datum/ai_controller/insane/wander/sphinx
	lines_type = /datum/ai_behavior/say_line/insanity_sphinx

/datum/ai_behavior/say_line/insanity_sphinx
	lines = list(
		"Our old masters are waiting for us.",
		"Listen to the stars.",
		"The age of mankind is over...",
		"AHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA!!",
		"I can't... It's too much!",
	)

// Objects - Items
/obj/item/golden_needle
	name = "golden needle"
	desc = "A pair of golden needles, can treat total petrification or grant immunity to stuns for a short time. \
	It could be helpful even if you aren't petrified..."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/teguitems.dmi'
	icon_state = "gold_needles"

/obj/item/golden_needle/pre_attack(atom/A, mob/living/user, params)
	. = ..()
	if(istype(A,/obj/structure/statue/petrified))
		playsound(A, 'sound/effects/break_stone.ogg', rand(10,50), TRUE)
		A.visible_message(span_danger("[A] returns to normal!"), span_userdanger("You break free of the stone!"))
		A.Destroy()
		qdel(src)
		return TRUE

/obj/item/golden_needle/attack_self(mob/user)
	var/mob/living/carbon/human/H = user
	playsound(H, 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/green/stab.ogg', rand(10,50), TRUE)
	to_chat(H, span_warning("You jab the golden needles into your vein!"))
	to_chat(user, span_userdanger("You feel unstoppable!"))
	qdel(src)
	return

/obj/item/canopic_jar
	name = "canopic jar"
	desc = "An ominous and foul-smelling jar, the contents can supposedly be consumed to replace missing organs. \
	An extra heart could be useful, too..."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/teguitems.dmi'
	icon_state = "canopic_jar"

/obj/item/canopic_jar/attack_self(mob/user)
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/ears/ears = user.get_organ_slot(ORGAN_SLOT_EARS)
	var/obj/item/organ/tongue/tongue = user.get_organ_slot(ORGAN_SLOT_TONGUE)
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	for(var/organ in H.organs)
		if(!eyes || !ears || !tongue)
			H.regenerate_organs()
		else
			to_chat(user, span_userdanger("You feel your heart rate increase!"))
		playsound(H, 'sound/items/eatfood.ogg', rand(25,50), TRUE)
		to_chat(H, span_warning("You hold your nose and quaff the contents of the jar!"))
		qdel(src)
		return

// Objects - Effects
/obj/effect/temp_visual/stone_gaze
	name = "stone gaze"
	icon_state = "ironfoam"
	duration = 2 SECONDS

/obj/effect/temp_visual/stone_gaze/Initialize()
	. = ..()
	alpha = rand(75,255)
	animate(src, alpha = 0, time = 20)

/datum/movespeed_modifier/petrify_partial
	variable = TRUE
	multiplicative_slowdown = 2

	//Effects
/obj/effect/temp_visual/rockattack
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi'
	icon_state = "rockattack"
	duration = 6
	randomdir = TRUE // random spike appearance
	layer = ABOVE_MOB_LAYER

/obj/effect/temp_visual/rockwarning
	name = "moving rocks"
	desc = "A target warning you of incoming pain"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/effects.dmi'
	icon_state = "rockwarning"
	duration = 10
	layer = RIPPLE_LAYER // We want this HIGH. SUPER HIGH. We want it so that you can absolutely, guaranteed, see exactly what is about to hit you.
	var/damage = 40 //Red Damage
	var/mob/living/caster // who made this, anyway

/obj/effect/temp_visual/rockwarning/Initialize(mapload, new_caster)
	. = ..()
	if(new_caster)
		caster = new_caster
	addtimer(CALLBACK(src, PROC_REF(explode)), 0.9 SECONDS)

/obj/effect/temp_visual/rockwarning/proc/explode()
	var/turf/target_turf = get_turf(src)
	if(!target_turf)
		return
	if(QDELETED(caster) || caster?.stat == DEAD || !caster)
		return
	playsound(target_turf, 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/brown/rock_attack.ogg', 50, 0, 8)
	new /obj/effect/temp_visual/rockattack(target_turf)
	for(var/turf/T in view(1, src))
		new /obj/effect/temp_visual/smash_effect(T)
		for(var/mob/living/L in caster.HurtInTurf(T, list(), damage, BRUTE, null, TRUE, FALSE, TRUE, hurt_hidden = TRUE, hurt_structure = TRUE))
			if(L.health < 0)
				L.gib(DROP_ALL_REMAINS)
	qdel(src)
