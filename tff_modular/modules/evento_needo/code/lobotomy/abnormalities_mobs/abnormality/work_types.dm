//selfh
/mob/living/simple_animal/hostile/abnormality/proc/pulse_waves(mob/living/carbon/human/user)
	user.show_aso_blurb("ВЫТЕРПИ ЭТО")
	job_tick_check(user)
	RegisterSignal(user, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_damage_user))
	RegisterSignal(src, COMSIG_JOB_TIMER_TICKED, PROC_REF(pulse_wave))

/mob/living/simple_animal/hostile/abnormality/proc/pulse_wave()
	SIGNAL_HANDLER
	var/obj/effect/temp_visual/kinetic_blast/K = new /obj/effect/temp_visual/kinetic_blast(get_turf(src))
	K.color = color
	playsound(get_turf(src), 'sound/effects/chemistry/shockwave_explosion.ogg', 60, TRUE)
	for(var/mob/living/carbon/human/user in view(5, src))
		var/got_one = FALSE
		if(user)
			user.apply_damage(fear_level * 5 + 15)
			got_one = TRUE
		if(!got_one)
			bad_job_effect()
			UnregisterSignal(src, COMSIG_JOB_TIMER_TICKED)
			UnregisterSignal(user, COMSIG_MOB_APPLY_DAMAGE)
			break

/mob/living/simple_animal/hostile/abnormality/proc/on_damage_user(mob/living/carbon/human/source)
	SIGNAL_HANDLER
	if(isnull(source))
		return
	if(source.stat > CONSCIOUS)
		bad_job_effect()
		QDEL_LIST(current_jobs)
		job_tick_effect(source)
		UnregisterSignal(src, COMSIG_JOB_TIMER_TICKED)
		UnregisterSignal(source, COMSIG_MOB_APPLY_DAMAGE)
	else if(out_of_time())
		good_job_effect()
		job_tick_effect(source)
		UnregisterSignal(src, COMSIG_JOB_TIMER_TICKED)
		UnregisterSignal(source, COMSIG_MOB_APPLY_DAMAGE)


//Обычные do_afters со случайными приколами. Суть работы - заставить игрока поверить в то, что он провалил её.
/mob/living/simple_animal/hostile/abnormality/proc/random_do_afters(mob/living/carbon/human/user)
	user.show_aso_blurb("Просто продолжай свою работу", 2.5 SECONDS)
	for(var/i in 1 to fear_level)
		if(!do_after(user, fear_level * 3 SECONDS))
			bad_job_effect()
			break
		//место для смешнявок
		else if(prob(10 * fear_level))
			var/level = text2path("/datum/status_effect/panicked_lvl_[rand(0, 5)]")
			user.apply_status_effect(level)
		else if(prob(20))
			hallucination_pulse(src, 4, 5 SECONDS, 15 SECONDS)
		//else if(prob(20))
		//	var/current_health = maxHealth - user.getOxyLoss() - user.getToxLoss() - user.getFireLoss() - user.getBruteLoss()
		//	user.adjustBruteLoss(current_health * 0.90)
		//	sleep(2 SECONDS)
		//	user.show_aso_blurb("Nailed it")
		//	user.adjustBruteLoss(-(current_health * 0.90))
		else if(prob(30))
			//Код Void'a с Арка
			var/sound/sound = sound('tff_modular/modules/evento_needo/ark_station_stuff/void/trip_blast.wav')
			sound.environment = 23
			sound.volume = 100
			SEND_SOUND(user.client, sound)
			user.emote("agony")
			user.overlay_fullscreen("screamers", /atom/movable/screen/fullscreen/screamers, rand(1, 23))
			user.clear_fullscreen("screamers", rand(15, 60))
	good_job_effect()
	job_tick_effect(user)


//Запоминание кода на время
/mob/living/simple_animal/hostile/abnormality/proc/remember_the_code(mob/living/carbon/human/user)
	var/len = 10 ** rand(fear_level, fear_level + 1)
	user.show_aso_blurb("ЗАПОМНИ КОД")
	sleep(1.5 SECONDS)
	var/remind_code = rand(floor(len / 10), floor(len * 10))
	balloon_alert(user, num2text(remind_code))
	job_things["remind_code"] = remind_code
	current_jobs += PROC_REF(remind_the_code)
	job_tick_effect(user)

/mob/living/simple_animal/hostile/abnormality/proc/remind_the_code(mob/living/carbon/human/user)
	var/answer = job_things["remind_code"]
	if(isnull(answer))
		job_tick_effect(user)
		return
	user.show_aso_blurb("ВСПОМНИ КОД", 2 SECONDS)
	sleep(2 SECONDS)
	//?job_tick_check(user)
	var/list/possible_answers = shuffle(list(answer, rand(answer - floor(answer / 10), answer + floor(answer * 10)), rand(answer - floor(answer / 10), answer + floor(answer * 10))))
	var/code = tgui_input_list(user, "Выбери правильный ответ", "Выбор кода", possible_answers, null, 10 SECONDS)
	if(!code || code != job_things["remind_code"])
		bad_job_effect()
		QDEL_NULL(job_things["remind_code"])
		job_tick_effect(user)
	else
		good_job_effect()
		QDEL_NULL(job_things["remind_code"])
		job_tick_effect(user)


//kother



//Обнимашки
/mob/living/simple_animal/hostile/abnormality/proc/ask_hugs(mob/living/carbon/human/user)
	var/hugs_needed = fear_level * rand(2, 3)
	var/time
	if(fear_level < HE_LEVEL)
		time = 20 SECONDS
	else
		time = 15 SECONDS
	user.show_aso_blurb("Обними это [hugs_needed] раз за [time / 10] секунд", 3 SECONDS)
	sleep(3 SECONDS)
	playsound(get_turf(src), 'sound/machines/beep/beep.ogg')
	job_things["hugs_amount"] = 0
	RegisterSignal(src, COMSIG_CARBON_HELPED, PROC_REF(on_hug))
	addtimer(CALLBACK(src, PROC_REF(check_hugs), user, hugs_needed), time)

/mob/living/simple_animal/hostile/abnormality/proc/on_hug(datum/source, mob/living/hugged)
	SIGNAL_HANDLER
	job_things["hugs_amount"]++

/mob/living/simple_animal/hostile/abnormality/proc/check_hugs(mob/living/carbon/human/user, hugs_needed)
	UnregisterSignal(src, COMSIG_CARBON_HELPED)
	if(job_things["hugs_amount"] < hugs_needed / 2)
		bad_job_effect()
	else if (job_things["hugs_amount"] > hugs_needed && job_things["hugs_amount"] < hugs_needed) //чето между
		neutral_job_effect()
	else
		good_job_effect()
	LAZYREMOVE(job_things, job_things["hugs_amount"])
	job_tick_effect(user)

//coop
/mob/living/simple_animal/hostile/abnormality/proc/bring_friends(mob/living/carbon/human/user)
	var/friends_needed = rand(1, fear_level)
	var/time = fear_level > WAW_LEVEL ? 30 SECONDS : 60 SECONDS
	user.show_aso_blurb("Приведи сюда [friends_needed] друзей за [time / 10] секунд", 3 SECONDS)
	RegisterSignal(src, COMSIG_CARBON_HELPED, PROC_REF(on_hug))
	addtimer(CALLBACK(src, PROC_REF(check_friends), user, friends_needed), time)

/mob/living/simple_animal/hostile/abnormality/proc/check_friends(mob/living/carbon/human/user, friends_needed)
	var/total_friends = 0
	for(var/mob/living/friend in oview(5, src))
		total_friends++
	if(total_friends == friends_needed)
		good_job_effect()
	else if(total_friends > friends_needed / 2 && total_friends != friends_needed) // та самая половина землекопа
		neutral_job_effect()
	else
		bad_job_effect()
	job_tick_effect(user)

//fav toy







/mob/living/simple_animal/hostile/abnormality/proc/ask_money(mob/living/carbon/human/user)
	var/amount
	switch(fear_level)
		if(ALEPH_LEVEL)
			amount = rand(600, 1200)
		if(HE_LEVEL)
			amount = rand(500, 800)
		if(WAW_LEVEL)
			amount = rand(350, 500)
		if(TETH_LEVEL)
			amount = rand(100, 250)
		if(ZAYIN_LEVEL)
			amount = rand(10, 50)
	user.show_aso_blurb("Оно снимет [amount] кредитов с твоего кошелька через 1 минуту.", 3 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(check_money), user, amount), 1 MINUTES)

/mob/living/simple_animal/hostile/abnormality/proc/check_money(mob/living/carbon/human/user, amount)
	var/datum/bank_account/account = user.get_bank_account()
	if(account && account.has_money(amount))
		account.adjust_money(-amount)
		good_job_effect()
	else
		bad_job_effect()
	job_tick_effect(user)














//Логические задачи

//Математические уравнения - плюсы, минусы, деления
/mob/living/simple_animal/hostile/abnormality/proc/mathematical_job(mob/living/carbon/human/user)
	var/a = rand(1, 300)
	var/b = rand(100, 400)
	var/answer = a + b
	user.show_aso_blurb("Реши задачу", 2 SECONDS)
	sleep(2 SECONDS)
	var/player_answer = tgui_input_list(user, "[a] + [b] = ...", "Choice", list(answer, rand(200, 400), rand(200, 400), rand(200, 400)), null, 10 SECONDS)
	if(!player_answer || player_answer != answer)
		bad_job_effect()
	else
		//TIME LEFT?
		SuccessEffect()
	job_tick_effect(user)

























//ОСОБЫЕ ПРОКИ

/mob/living/simple_animal/hostile/abnormality/proc/try_packing(mob/living/carbon/human/user)
	var/succeeded = TRUE
	//Пункт приема товара ниже по коду
	if(fear_level < HE_LEVEL)
		if(user.get_major_clothing_class() == prefered_job && prob(15))
			user.show_aso_blurb("Ты ему понравился!")
		else if(prob(10))
			user.show_aso_blurb("Сегодня твой везучий день!", 3 SECONDS)
			playsound(loc, 'sound/machines/ding.ogg', 50, TRUE)
		//else //if(prob(20))
		//	user.show_aso_blurb("Реши задачку", 3 SECONDS)
		//	sleep(3 SECONDS)
		//	var/x = rand(1, 10 ** fear_level)
		//	var/y = rand(1, 10 ** fear_level)
		//	var/answer = x + y
		//	var/choice = tgui_input_list(user, "[x] + [y] = ...", "Задача", shuffle_inplace(list(answer, rand(1, 10 ** fear_level), rand(1, 10 ** fear_level), rand(1, 10 ** fear_level))), timeout = 18 SECONDS)
		//	if(choice != answer)
		//		user.show_aso_blurb("Может это просто не твое...")
		//		succeeded = FALSE
		else //if(prob(20))
			user.show_aso_blurb("Ну разве это не скучно?")
			for(var/i in 1 to fear_level * 2)
				if(!do_after(user, 5 SECONDS, src))
					succeeded = FALSE
					break

	else //КРУТЫЕ ПАРНИ
		if(prob(20) && issynthetic(user))
			user.show_aso_blurb("Подзарядочка!", 3 SECONDS)
			empulse(user, 2, 5)
			if(user.stat > CONSCIOUS)
				succeeded = FALSE
		if(user.get_major_clothing_class() == hated_job && prob(35))
			user.show_aso_blurb("Ты [prob(10) ? "просто мерзость" : "отвратителен ему"]")
			user.apply_damage(15 * fear_level, wound_bonus = 20)
			succeeded = FALSE
		else if(prob(20))
			user.show_aso_blurb("Ты [prob(10) ? "лох" : "неудачник"]!", 3 SECONDS)
			user.apply_damage(20, BRUTE, wound_bonus = 40)
			playsound(loc, 'sound/machines/ding.ogg', 50, TRUE)
			succeeded = FALSE
		else //if(prob(20))
			user.show_aso_blurb("Вот это уже реально скучно.")
			for(var/i in 1 to fear_level * 3)
				if(!do_after(user, 10 SECONDS, src))
					succeeded = FALSE
					break
		//else //if(prob(20))
		//	user.show_aso_blurb("Реши задачу", 3 SECONDS)
		//	sleep(3 SECONDS)
		//	var/x = rand(1, 10 ** fear_level)
		//	var/y = rand(1, 10 ** fear_level)
		//	var/choice = tgui_input_list(user, "[x] + [y] = ...", "Задача", shuffle(list(x + y, rand(1, 10 ** fear_level), rand(1, 10 ** fear_level), rand(1, 10 ** fear_level), rand(1, 10 ** fear_level), rand(1, 10 ** fear_level))), timeout = 12 SECONDS)
		//	if(choice != (x + y))
		//		user.show_aso_blurb("Увы")
		//		user.apply_damage(40, BRUTE, wound_bonus = 20)
		//		succeeded = FALSE



	//job_tick_effect(user)
	if(!succeeded) //Возможно оно упакует тебя
		FailureEffect(user)
		return
	new /obj/structure/abno_core(get_turf(src), type)
	qdel(src)

