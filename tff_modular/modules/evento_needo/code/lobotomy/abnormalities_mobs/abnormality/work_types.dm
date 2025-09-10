//selfh
/mob/living/simple_animal/hostile/abnormality/proc/pulse_waves(mob/living/carbon/human/user)
	user.show_aso_blurb("ВЫТЕРПИ ЭТО")
	sleep(3 SECONDS)
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
			user.apply_damage(fear_level * 4)
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
		to_chat(source, "OVERDAMAGE")
		bad_job_effect()
		deltimer(job_timer)
		UnregisterSignal(src, COMSIG_JOB_TIMER_TICKED)
		UnregisterSignal(source, COMSIG_MOB_APPLY_DAMAGE)
	else if(out_of_time())
		to_chat(source, "Survived")
		good_job_effect()
		job_tick_effect(source)
		UnregisterSignal(src, COMSIG_JOB_TIMER_TICKED)
		UnregisterSignal(source, COMSIG_MOB_APPLY_DAMAGE)
		//SEND_SIGNAL(src, COMSIG_JOB_STOP)

//Обычные do_afters со случайными приколами. Суть работы - заставить игрока поверить в то, что он провалил её.
/mob/living/simple_animal/hostile/abnormality/proc/random_do_afters(mob/living/carbon/human/user)
	for(var/i in 1 to fear_level)
		if(!do_after(user, fear_level * 3 SECONDS))
			bad_job_effect()
			job_tick_effect(user)
			return
		//место для смешнявок
		else if(prob(10 * fear_level))
			var/level = text2path("/datum/status_effect/panicked_lvl_[rand(0, 5)]")
			user.apply_status_effect(level)
		else if(prob(20))
			hallucination_pulse(src, 4, 5 SECONDS, 15 SECONDS)
		else if(prob(20))
			var/current_health = maxHealth - user.getOxyLoss() - user.getToxLoss() - user.getFireLoss() - user.getBruteLoss()
			user.adjustBruteLoss(current_health * 0.90)
			sleep(2 SECONDS)
			user.show_aso_blurb("Nailed it")
			user.adjustBruteLoss(-(current_health * 0.90))
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
	sleep(3 SECONDS)
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
	user.show_aso_blurb("ВСПОМНИ КОД")
	sleep(3 SECONDS)
	job_tick_check(user)
	var/list/possible_answers = shuffle(list(answer, rand(answer - floor(answer / 10), answer + floor(answer * 10)), rand(answer - floor(answer / 10), answer + floor(answer * 10))))
	var/code = tgui_input_list(user, "Выбери правильный ответ", "Выбор кода", possible_answers, null, 10 SECONDS)
	if(!code || code != job_things["remind_code"])
		bad_job_effect()
	else
		good_job_effect()
	QDEL_NULL(job_things["remind_code"])
	job_tick_effect(user)


//kother
//pets

//coop
//fav toy


//Логические задачи

//Математические уравнения - плюсы, минусы, деления
/mob/living/simple_animal/hostile/abnormality/proc/mathematical_job(mob/living/carbon/human/user)
	var/a = rand(1, 300)
	var/b = rand(100, 400)
	var/answer = a + b
	user.show_aso_blurb("РЕШИ ЗАДАЧУ")
	var/player_answer = tgui_input_list(user, "[a] + [b] = ...", "Choice", list(answer, rand(200, 400), rand(200, 400), rand(200, 400)), null, 10 SECONDS)
	if(!player_answer || player_answer != answer)
		bad_job_effect()
	else
		//TIME LEFT?
		SuccessEffect()
	job_tick_effect(user)

