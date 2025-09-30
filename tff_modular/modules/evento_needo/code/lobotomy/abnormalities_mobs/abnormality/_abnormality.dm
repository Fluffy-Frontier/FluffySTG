#define JOB_ABNORMALITY_PACKING "Упаковать"

/mob/living/simple_animal/hostile/abnormality
	name = "Abnormality"
	desc = "An abnormality..? You should report this to the Head!"
	robust_searching = TRUE
	ranged_ignores_vision = TRUE
	stat_attack = HARD_CRIT
	layer = LARGE_MOB_LAYER
	combat_mode = TRUE
	del_on_death = TRUE
	damage_coeff = list(BRUTE = 1, BURN = 1, TOXIN = 1, STAMINA = 1, OXYGEN = 1)
	atmos_requirements = null
	minbodytemp = 0
	see_in_dark = 7
	vision_range = 12
	aggro_vision_range = 20
	move_resist = MOVE_FORCE_STRONG // They kept stealing my abnormalities
	pull_force = MOVE_FORCE_STRONG
	can_buckle_to = FALSE // Please. I beg you. Stop stealing my vending machines.
	mob_size = MOB_SIZE_HUGE // No more lockers, Whitaker
	blood_volume = BLOOD_VOLUME_NORMAL // THERE WILL BE BLOOD. SHED.
	simple_mob_flags = SILENCE_RANGED_MESSAGE
	/// Can this abnormality spawn normally during the round?
	var/can_spawn = TRUE
	/// Reference to the datum we use
	var/datum/abnormality/datum_reference = null
	/// Separate level of fear. If null - will use threat level.
	var/fear_level = ZAYIN_LEVEL
	/// List of humans that witnessed the abnormality breaching
	var/list/breach_affected = list()
	/// Copy-pasted from megafauna.dm: This allows player controlled mobs to use abilities
	var/chosen_attack = 1
	/// Attack actions, sets chosen_attack to the number in the action
	var/list/attack_action_types = list()
	/// If there is a small sprite icon for players controlling the mob to use
	var/small_sprite_type = /datum/action/small_sprite/abnormality
	/// Check to see if the abnormality hates goods or can't get them.
	var/good_hater = FALSE
	/// List of ego equipment datums
	var/list/ego_list = list()
	/// EGO Gifts
	var/datum/ego_gifts/gift_type = null
	var/gift_chance = null
	var/gift_message = "You were gifted."
	// Increased Abno appearance chance
	/// Assoc list, you do [path] = [probability_multiplier] for each entry
	var/list/grouped_abnos = list()

	/// If an abnormality should not be possessed even if possessibles are enabled, mainly for admins.
	var/do_not_possess = FALSE

	// secret skin variables ahead

	/// Toggles if the abnormality has a secret form and can spawn naturally
	var/secret_chance = FALSE
	/// tracks if the current abnormality is in its secret form
	var/secret_abnormality = FALSE

	/// if assigned, this gift will be given instead of a normal one on a successfull gift aquisition whilst a secret skin is in effect
	var/secret_gift

	/// An icon state assigned to the abnormality in its secret form
	var/secret_icon_state
	/// An icon state assigned when an abnormality is alive
	var/secret_icon_living
	// An icon state assigned when an abnormality gets suppressed in its secret form
	var/secret_icon_dead
	/// An icon file assigned to the abnormality in its secret form, usually should not be needed to change
	var/secret_icon_file

	/// Offset for secret skins in the X axis
	var/secret_horizontal_offset = 0
	/// Offset for secret skins in the Y axis
	var/secret_vertical_offset = 0

	var/secret_name

	// rcorp stuff
	var/rcorp_team

	//num to change qlipoth on basic action
	var/update_qliphoth = -1
	var/update_qliphoth_chance

	var/action_cooldown = 20 SECONDS
	var/next_action_time
	var/last_action_time

	var/can_breach = FALSE
	var/breached = FALSE
	var/meltdown = FALSE
	var/observation_prompt

	//Work stuff
	var/temp_chance = 0
	var/success_chance = 10
	var/neutral_chance = 40
	var/negative_chance = 40
	var/ego_on_death = FALSE
	var/currently_working = FALSE
	var/max_points = 100
	var/result_points = 100
	var/job_timer
	var/job_time_step
	var/work_types = list(
		//CLOTHING_ENGINEERING, //NAMES?
		CLOTHING_SCIENCE,
		CLOTHING_SERVICE,
		CLOTHING_ARMORED,
		JOB_ABNORMALITY_PACKING,
	)
	var/list/job_things = list()
	var/datum/callback/job_callback
	var/list/current_jobs = list()
	var/datum/callback/post_work_effect
	var/calm_down_time = 3 MINUTES

	var/prefered_job = null
	var/hated_job = null


/mob/living/simple_animal/hostile/abnormality/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	REMOVE_TRAIT(src, TRAIT_GODMODE, ADMIN_TRAIT)
	manual_emote("awakens...")

/mob/living/simple_animal/hostile/abnormality/Logout()
	. = ..()
	if(!.)
		return FALSE
	if(breached)
		return FALSE
	ADD_TRAIT(src, TRAIT_GODMODE, ADMIN_TRAIT)

/mob/living/simple_animal/hostile/abnormality/Initialize(mapload)
	datum_reference = new(src)
	datum_reference.qliphoth_meter_max = rand(1, 3)
	datum_reference.qliphoth_meter = datum_reference.qliphoth_meter_max
	SSlobotomy_corp.NewAbnormality(datum_reference)

	switch(max(damage_coeff))
		if(BRUTE)
			prefered_job = CLOTHING_ARMORED
		if(BURN)
			prefered_job = CLOTHING_ENGINEERING
		if(BRAIN)
			prefered_job = CLOTHING_SCIENCE
		if(TOX)
			prefered_job = CLOTHING_SERVICE

	switch(min(damage_coeff))
		if(BRUTE)
			hated_job = CLOTHING_ARMORED
		if(BURN)
			hated_job = CLOTHING_ENGINEERING
		if(BRAIN)
			hated_job = CLOTHING_SCIENCE
		if(TOX)
			hated_job = CLOTHING_SERVICE

	for(var/action_type in attack_action_types)
		var/datum/action/innate/abnormality_attack/attack_action = new action_type()
		attack_action.Grant(src)
	if(small_sprite_type)
		var/datum/action/small_sprite/small_action = new small_sprite_type()
		small_action.Grant(src)
	toggle_ai(AI_OFF)
	ADD_TRAIT(src, TRAIT_GODMODE, ADMIN_TRAIT)

	if(fear_level > WAW_LEVEL)
		ego_on_death = TRUE

	if(!gift_chance)
		switch(fear_level)
			if(ZAYIN_LEVEL)
				gift_chance = 23
			if(TETH_LEVEL)
				gift_chance = 17
			if(WAW_LEVEL)
				gift_chance = 13
			if(HE_LEVEL)
				gift_chance = 8
			if(ALEPH_LEVEL)
				gift_chance = 4

	if(secret_chance && (prob(10)))
		InitializeSecretIcon()

	post_work_effect = CALLBACK(PROC_REF(PostWorkEffect))
	return ..()

/mob/living/simple_animal/hostile/abnormality/Destroy()
	job_callback = null
	post_work_effect = null
	return ..()

/mob/living/simple_animal/hostile/abnormality/death(gibbed)
	if(ego_on_death)
		if(prob(60))
			try_giving_ego()
	return ..()

/mob/living/simple_animal/hostile/abnormality/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(IsContained())
		qliphoth_change(-1)

/mob/living/simple_animal/hostile/abnormality/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	. = ..()
	if(IsContained())
		qliphoth_change(-1)

/mob/living/simple_animal/hostile/abnormality/apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, attacking_item, wound_clothing)
	if(is_ego_weapon(attacking_item))
		damage *= 1.5
	return ..()

/mob/living/simple_animal/hostile/abnormality/bullet_act(obj/projectile/proj)
	if(istype(proj, /obj/projectile/ego_bullet))
		proj.damage *= 1.5
	return ..()

/mob/living/simple_animal/hostile/abnormality/handle_automated_movement()
	if(!AIStatus)
		return

/mob/living/simple_animal/hostile/abnormality/examine(mob/user)
	. = ..()
	if(observation_prompt)
		. += observation_prompt

/mob/living/simple_animal/hostile/abnormality/proc/on_damaged(datum/source)
	SIGNAL_HANDLER
	if(!IsContained())
		return
	var/mob/living/carbon/human/user = source
	if(user)
		user.adjustSanityLoss(fear_level * 10)
	qliphoth_change(-1)

/mob/living/simple_animal/hostile/abnormality/proc/InitializeSecretIcon()
	SHOULD_CALL_PARENT(TRUE) // if you ever need to override this proc, consider adding onto it instead or not using all the variables given
	secret_abnormality = TRUE

	if(secret_icon_file)
		icon = secret_icon_file

	if(secret_icon_state)
		icon_state = secret_icon_state

	if(secret_icon_living)
		icon_living = secret_icon_living

	if(secret_horizontal_offset)
		base_pixel_x = secret_horizontal_offset

	if(secret_vertical_offset)
		base_pixel_y = secret_vertical_offset

	if(secret_icon_dead)
		icon_dead = secret_icon_dead

	if(secret_name)
		name = secret_name

/mob/living/simple_animal/hostile/abnormality/add_to_mob_list()
	. = ..()
	GLOB.abnormality_mob_list |= src

/mob/living/simple_animal/hostile/abnormality/remove_from_mob_list()
	. = ..()
	GLOB.abnormality_mob_list -= src


/mob/living/simple_animal/hostile/abnormality/Life(seconds_per_tick, times_fired)
	set waitfor = FALSE
	. = ..()
	if(!.) // Dead
		return FALSE
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return FALSE
	FearEffect()

// Applies fear damage to everyone in range
/mob/living/simple_animal/hostile/abnormality/proc/FearEffect()
	if(fear_level <= 0)
		return
	for(var/mob/living/carbon/human/H in ohearers(7, src))
		if(H in breach_affected)
			continue
		if(H.stat == DEAD)
			continue
		breach_affected += H
		if(HAS_TRAIT(H, TRAIT_COMBATFEAR_IMMUNE))
			to_chat(H, span_notice("This again...?"))
			H.apply_status_effect(/datum/status_effect/panicked_lvl_0)
			continue
		var/sanity_result = clamp(fear_level, -1, 5)
		var/sanity_damage = 0
		var/result_text = FearEffectText(H, sanity_result)
		switch(sanity_result)
			if(-INFINITY to 0)
				H.apply_status_effect(/datum/status_effect/panicked_lvl_0)
				to_chat(H, span_notice("[result_text]"))
				continue
			if(1)
				sanity_damage = H.maxSanity*0.1
				H.apply_status_effect(/datum/status_effect/panicked_lvl_1)
				to_chat(H, span_warning("[result_text]"))
			if(2)
				sanity_damage = H.maxSanity*0.3
				H.apply_status_effect(/datum/status_effect/panicked_lvl_2)
				to_chat(H, span_danger("[result_text]"))
			if(3)
				sanity_damage = H.maxSanity*0.6
				H.apply_status_effect(/datum/status_effect/panicked_lvl_3)
				to_chat(H, span_userdanger("[result_text]"))
			if(4)
				sanity_damage = H.maxSanity*0.8
				H.apply_status_effect(/datum/status_effect/panicked_lvl_4)
				to_chat(H, span_userdanger("<b>[result_text]</b>"))
			if(5)
				sanity_damage = H.maxSanity*0.95
				H.apply_status_effect(/datum/status_effect/panicked_lvl_4)
		H.adjustSanityLoss(sanity_damage)
		SEND_SIGNAL(H, COMSIG_FEAR_EFFECT, fear_level, sanity_damage)
	return

/mob/living/simple_animal/hostile/abnormality/proc/FearEffectText(mob/affected_mob, level = 0)
	level = num2text(clamp(level, -1, 5))
	var/list/result_text_list = list(
		"-1" = list("I've got this.", "How boring.", "Doesn't even phase me."),
		"0" = list("Just calm down, do what we always do.", "Just don't lose your head and stick to the manual.", "Focus..."),
		"1" = list("Hah, I'm getting nervous.", "Breathe in, breathe out...", "It'll be fine if we focus, I think..."),
		"2" = list("There's no room for error here.", "My legs are trembling...", "Damn, it's scary."),
		"3" = list("GODDAMN IT!!!!", "H-Help...", "I don't want to die!"),
		"4" = list("What am I seeing...?", "I-I can't take it...", "I can't understand..."),
		"5" = list("......"),
	)
	return pick(result_text_list[level])

// Called by datum_reference when the abnormality has been fully spawned
/mob/living/simple_animal/hostile/abnormality/proc/PostSpawn()
	SHOULD_CALL_PARENT(TRUE)
	HandleStructures()

// Moves structures already in its datum; Overrides can spawn structures here.
/mob/living/simple_animal/hostile/abnormality/proc/HandleStructures()
	SHOULD_CALL_PARENT(TRUE)
	if(!datum_reference)
		return FALSE
	return TRUE

// A little helper proc to spawn structures; Returns itself, so you can handle additional stuff later
/mob/living/simple_animal/hostile/abnormality/proc/SpawnConnectedStructure(atom/movable/A = null, x_offset = 0, y_offset = 0)
	if(!ispath(A))
		return
	if(!istype(datum_reference))
		return
	A = new A(get_turf(src))
	A.x += x_offset
	A.y += y_offset
	// We put it in datum ref for malicious purposes
	datum_reference.connected_structures[A] = list(x_offset, y_offset)
	return A

///* Transfers a var to the datum to be used later
//The variable's key needs to be non-numerical.*/
///mob/living/simple_animal/hostile/abnormality/proc/TransferVar(key, value)
//	if(isnull(datum_reference))
//		return
//	LAZYSET(datum_reference.transferable_var, key, value)
//
//// Access an item in the "transferable_var" list of the abnormality's datum
///mob/living/simple_animal/hostile/abnormality/proc/RememberVar(key)
//	if(isnull(datum_reference))
//		return
//	return LAZYACCESS(datum_reference.transferable_var, key)

// Giving an EGO gift to the user after work is complete
/mob/living/simple_animal/hostile/abnormality/proc/GiftUser(mob/living/carbon/human/user, chance = gift_chance)
	SHOULD_CALL_PARENT(TRUE)
	if(!istype(user) || isnull(gift_type))
		return FALSE
	if(istype(user.ego_gift_list[initial(gift_type.slot)], gift_type)) // If we already have same gift - don't run the checks
		return FALSE
	if(!prob(chance))
		return FALSE
	var/datum/ego_gifts/EG
	if(secret_abnormality && secret_gift)
		EG = new secret_gift
	else
		EG = new gift_type
	EG.datum_reference = src.datum_reference
	user.Apply_Gift(EG)
	to_chat(user, span_nicegreen("[gift_message]"))
	return TRUE

/mob/living/simple_animal/hostile/abnormality/proc/try_giving_ego(mob/living/carbon/human/user, success)
	SIGNAL_HANDLER
	if(fear_level <= TETH_LEVEL)
		if(prob(45))
			spawn_ego(user)
	else if(fear_level == WAW_LEVEL)
		if(prob(30))
			spawn_ego(user)
	else
		if(prob(30))
			spawn_ego()

/mob/living/simple_animal/hostile/abnormality/proc/spawn_ego(mob/living/creature)
	var/turf/T = isnull(creature) ? get_turf(src) : get_turf(creature)
	if(T)
		var/new_ego = pick(ego_list)
		if(isnull(new_ego) || istype(new_ego, /obj/item/ego_weapon/ranged))
			return
		if(creature)
			to_chat(creature, "Ты был вознагражден ЭГО.")
		else
			visible_message("ЭГО материализуется под аномалией.")
		var/datum/ego_datum/ego = new new_ego(src)
		var/obj/item/ego_item = ego.item_path
		if(ego_item)
			ego_item = new ego_item(T)
		qdel(ego)
	return

/mob/living/simple_animal/hostile/abnormality/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = try_working(user)
	if(!.)
		return ..()

/mob/living/simple_animal/hostile/abnormality/proc/try_working(mob/living/carbon/human/user)
	//PREWORK
	last_action_time = world.time
	if(!IsContained()) //НЕТ ВРЕМЕНИ БОЛТАТЬ, ОНО ЖРЕТ ТВОЮ НОГУ
		return FALSE
	if(currently_working)
		to_chat(user, span_notice("Someone else is already working with this."))
		return FALSE
	if(next_action_time > world.time)
		to_chat(user, span_notice("[name] isn't ready for work yet."))
		return FALSE
	currently_working = TRUE
	result_points = max_points
	SEND_SIGNAL(user, COMSIG_WORK_STARTED)
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_WORK_STARTED, src)
	QDEL_LIST(current_jobs)
	LAZYINITLIST(current_jobs)
	var/selected_work = tgui_input_list(user, "Select work type", "Choice", LAZYLEN(work_types) && prob(65) ? work_types : list("Начать работу", JOB_ABNORMALITY_PACKING), null, 10 SECONDS)
	if(!selected_work)
		currently_working = FALSE
		return FALSE
	switch(selected_work)
		if("Начать работу")
			current_jobs += PROC_REF(random_do_afters)
		//if(CLOTHING_ENGINEERING)
		if(CLOTHING_SCIENCE)
			current_jobs += PROC_REF(mathematical_job)
			current_jobs += PROC_REF(remember_the_code)
		if(CLOTHING_SERVICE)
			current_jobs += PROC_REF(ask_hugs)
			current_jobs += PROC_REF(check_friends)
		if(CLOTHING_ARMORED)
			current_jobs += PROC_REF(pulse_waves)
			current_jobs += PROC_REF(ask_money)
		if(JOB_ABNORMALITY_PACKING)
			current_jobs += PROC_REF(try_packing) //ДОДЕЛАТЬ РАБОТЫ

	if(!LAZYLEN(current_jobs))
		return
	shuffle_inplace(current_jobs) //Временное решение из-за малого количества работ
	job_callback = CALLBACK(src, current_jobs[1], user)
	job_callback?.Invoke()

//Проверка успевает ли игрок выполнить задачу, срабатывает каждые 10 секунд.
/mob/living/simple_animal/hostile/abnormality/proc/job_tick_check(mob/living/carbon/human/user)
	if(!LAZYLEN(current_jobs))
		return
	//Вышло ли время?
	if(!isnull(job_timer) && out_of_time())
		bad_job_effect()
		job_tick_effect(user)
		return
	job_time_step++
	SEND_SIGNAL(src, COMSIG_JOB_TIMER_TICKED)
	job_timer = addtimer(CALLBACK(src, PROC_REF(job_tick_check)), 10 SECONDS)


//Эффект после каждой выполненной работы, сюда относятся любые влияния (например постоянный урон при контакте) и высчитывается выполнения задачи. Если задача готоа - ызыает следующую
/mob/living/simple_animal/hostile/abnormality/proc/job_tick_effect(mob/living/carbon/human/user, complete = FALSE)
	SHOULD_CALL_PARENT(TRUE)

	LAZYREMOVE(current_jobs, current_jobs[1])
	//Работы выполнены
	if(!LAZYLEN(current_jobs))
		currently_working = FALSE
		if(!isnull(job_timer))
			deltimer(job_timer)
		SEND_SIGNAL(user, COMSIG_WORK_COMPLETED, datum_reference)
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_WORK_COMPLETED, datum_reference)
		post_work_effect.Invoke(user)
		try_giving_ego(user)
		if(action_cooldown)
			next_action_time = world.time + action_cooldown

		if(result_points > 75)
			SuccessEffect(user)
		else if(result_points <= 75 && result_points > 35)
			NeutralEffect(user)
		else
			FailureEffect(user)

	else
		job_time_step = 0
		if(!isnull(job_timer))
			deltimer(job_timer)
		job_tick_check() //ПРОDАЛ ЕСЛИ МАКС И ЗАДАНИЕ НЕ DЫПОЛНЕНО?
		job_callback = CALLBACK(src, current_jobs[1], user)
		job_callback?.Invoke()

	return

/mob/living/simple_animal/hostile/abnormality/proc/out_of_time(mob/living/carbon/human/user)
	var/max_step
	switch(fear_level)
		if(ZAYIN_LEVEL)
			max_step = 2
		if(TETH_LEVEL)
			max_step = 2 //CHANGE TO MODULAR TIMERS
		if(WAW_LEVEL)
			max_step = 4
		if(HE_LEVEL)
			max_step = 4
		if(ALEPH_LEVEL)
			max_step = 5
	if(job_time_step > max_step)
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/abnormality/proc/work_interrupted_effect(mob/living/carbon/human/user)
	currently_working = FALSE
	return

/mob/living/simple_animal/hostile/abnormality/proc/good_job_effect()
	playsound(loc, 'sound/machines/ping.ogg', 50, TRUE)
	return

/mob/living/simple_animal/hostile/abnormality/proc/neutral_job_effect()
	SHOULD_CALL_PARENT(TRUE)
	playsound(loc, 'sound/machines/creak.ogg', 60, TRUE)
	if(prob(50))
		result_points -= fear_level * 3
	return

/mob/living/simple_animal/hostile/abnormality/proc/bad_job_effect()
	SHOULD_CALL_PARENT(TRUE)
	playsound(loc, 'sound/machines/synth/synth_no.ogg', 30, TRUE)
	result_points -= fear_level * 4
	return


//ИТОГОВЫЕ РЕЗУЛЬТАТЫ ВСЕХ РАБОТ

/mob/living/simple_animal/hostile/abnormality/proc/SuccessEffect(mob/living/carbon/human/user)
	return

//Возвращает шанс от
/mob/living/simple_animal/hostile/abnormality/proc/NeutralEffect(mob/living/carbon/human/user)
	if(update_qliphoth && prob(update_qliphoth_chance))
		qliphoth_change(update_qliphoth)
	return

//Возвращает шанс от
/mob/living/simple_animal/hostile/abnormality/proc/FailureEffect(mob/living/carbon/human/user)
	if(update_qliphoth)
		qliphoth_change(update_qliphoth)
	return

/mob/living/simple_animal/hostile/abnormality/proc/PostWorkEffect(mob/living/carbon/human/user)
	GiftUser(user, gift_chance)
	return


/mob/living/simple_animal/hostile/abnormality/proc/qliphoth_change(num)
	datum_reference.qliphoth_meter += num
	if(datum_reference.qliphoth_meter <= 0)
		ZeroQliphoth()
	if(datum_reference.qliphoth_meter > datum_reference.qliphoth_meter_max)
		datum_reference.qliphoth_meter = datum_reference.qliphoth_meter_max
	OnQliphothChange(num)
	return

/mob/living/simple_animal/hostile/abnormality/proc/CalmDown()
	breached = FALSE
	if(!IsContained())
		qliphoth_change(datum_reference.qliphoth_meter_max)
		if(istype(datum_reference))
			deadchat_broadcast(" угомонился.", "<b>[src.name]</b>", src, get_turf(src))

// Effects when qliphoth reaches 0
/mob/living/simple_animal/hostile/abnormality/proc/ZeroQliphoth(mob/living/carbon/human/user)
	addtimer(CALLBACK(src, PROC_REF(CalmDown)), calm_down_time * fear_level)
	if(can_breach)
		BreachEffect(user)
	return

// Special breach effect for abnormalities with can_breach set to TRUE
/mob/living/simple_animal/hostile/abnormality/proc/BreachEffect(mob/living/carbon/human/user)
	if(!can_breach)
		// If a custom breach is called and the mob has no way of handling it, just ignore it.
		// Should follow normal behaviour with ..()
		return FALSE
	breached = TRUE
	toggle_ai(AI_ON) // Run.
	REMOVE_TRAIT(src, TRAIT_GODMODE, ADMIN_TRAIT)
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_ABNORMALITY_BREACH, src)
	if(istype(datum_reference))
		deadchat_broadcast(" впал в ярость.", "<b>[src.name]</b>", src, get_turf(src))
	FearEffect()
	return TRUE

// On lobotomy_corp subsystem qliphoth event
/mob/living/simple_animal/hostile/abnormality/proc/OnQliphothEvent()
	return

// When qliphoth meltdown begins
/mob/living/simple_animal/hostile/abnormality/proc/MeltdownStart()
	meltdown = TRUE
	return

/mob/living/simple_animal/hostile/abnormality/proc/OnQliphothChange(amount = 0)
	return

///implants the abno with a slime radio implant, only really relevant during admeme or sentient abno rounds
/mob/living/simple_animal/hostile/abnormality/proc/AbnoRadio()
	var/obj/item/implant/radio/slime/imp = new(src)
	imp.implant(src, src) //acts as if the abno is both the implanter and the one being implanted, which is technically true I guess?
	datum_reference.abno_radio = TRUE

/mob/living/simple_animal/hostile/abnormality/proc/IsContained() //Are you in a cell and currently contained?? If so stop.
//Contained checks for: If the abnorm is godmoded AND one of the following: It does not have a qliphoth meter OR has qliphoth remaining OR no qliphoth but can't breach
	if(HAS_TRAIT(src, TRAIT_GODMODE) && (!datum_reference.qliphoth_meter_max || datum_reference.qliphoth_meter || (!datum_reference.qliphoth_meter && !can_breach)))
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/abnormality/proc/GetName()
	return name

/mob/living/simple_animal/hostile/abnormality/spawn_gibs()
	if(blood_volume <= 0)
		return
	return new /obj/effect/gibspawner/generic(drop_location(), src, get_static_viruses())

// Actions
/datum/action/innate/abnormality_attack
	name = "Abnormality Attack"
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	button_icon_state = ""
	background_icon_state = "bg_abnormality"
	var/mob/living/simple_animal/hostile/abnormality/A
	var/chosen_message
	var/chosen_attack_num = 0

/datum/action/innate/abnormality_attack/Destroy()
	A = null
	return ..()

/datum/action/innate/abnormality_attack/Grant(mob/living/L)
	if(istype(L, /mob/living/simple_animal/hostile/abnormality))
		A = L
		return ..()
	return FALSE

/datum/action/innate/abnormality_attack/Activate()
	A.chosen_attack = chosen_attack_num
	to_chat(A, chosen_message)

/datum/action/innate/abnormality_attack/toggle
	name = "Toggle Attack"
	var/toggle_message
	var/toggle_attack_num = 1
	var/button_icon_toggle_activated = ""
	var/button_icon_toggle_deactivated = ""

/datum/action/innate/abnormality_attack/toggle/Activate()
	. = ..()
	button_icon_state = button_icon_toggle_activated
	build_all_button_icons()
	active = TRUE


/datum/action/innate/abnormality_attack/toggle/Deactivate()
	A.chosen_attack = toggle_attack_num
	to_chat(A, toggle_message)
	button_icon_state = button_icon_toggle_deactivated
	build_all_button_icons()
	active = FALSE




//SMALL ICON

//Small sprites
/datum/action/small_sprite
	name = "Toggle Giant Sprite"
	desc = "Others will always see you as giant"
	button_icon = 'icons/mob/actions/actions_xeno.dmi'
	button_icon_state = "smallqueen"
	background_icon_state = "bg_alien"
	var/small = FALSE
	var/small_icon
	var/small_icon_state

/datum/action/small_sprite/abnormality
	button_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	button_icon_state = "abnormality"
	background_icon_state = "bg_abnormality"
	small_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/actions_abnormality.dmi'
	small_icon_state = "abnormality"

/datum/action/small_sprite/Trigger(trigger_flags, atom/target)
	..()
	if(!small)
		var/image/I = image(icon = small_icon, icon_state = small_icon_state, loc = owner)
		I.override = TRUE
		I.pixel_x -= owner.pixel_x
		I.pixel_y -= owner.pixel_y
		owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic, "smallsprite", I, AA_TARGET_SEE_APPEARANCE | AA_MATCH_TARGET_OVERLAYS)
		small = TRUE
	else
		owner.remove_alt_appearance("smallsprite")
		small = FALSE

ADMIN_VERB_AND_CONTEXT_MENU(make_angry, R_ADMIN, "Make angry", "Включает режим агрессии у аномалии", ADMIN_CATEGORY_GAME, mob/living/simple_animal/hostile/abnormality/abno in world)
	if(!istype(abno, /mob/living/simple_animal/hostile/abnormality))
		to_chat(user, span_warning("Работает только на аномалиях LC"))
		return
	abno.qliphoth_change(-abno.datum_reference.qliphoth_meter_max)
	if(!abno.IsContained())
		to_chat(user, span_warning("[abno.name] не имеет механики побега."))
		return
	log_admin("[key_name(user)] взбесил [abno.name]")
	message_admins("[key_name_admin(user)] взбесил [abno.name]")
	BLACKBOX_LOG_ADMIN_VERB("Make Angry")

#undef JOB_ABNORMALITY_PACKING
