/mob/living/carbon/human
	//Включено ли действие хоорор эффектов. Использовать enable_horror_features()/disable_horror_features()
	VAR_PRIVATE/horror_effect_on = FALSE
	//Текущиее состояние нашего испуга - по умолчание мы в норме.
	var/horror_state = HUMAN_HORROR_STATE_NORMAL
	VAR_PRIVATE/screen_effect_locked = FALSE

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	if(GLOB.world_horror_mode)
		enable_horror_features()
	RegisterSignal(SSdcs, COMSIG_WORLD_HORROR_MODE_ENABLED, PROC_REF(enable_horror_features), override = TRUE)
	RegisterSignal(SSdcs, COMSIG_WORLD_HORROR_MODE_DISABLED, PROC_REF(disable_horror_features), override = TRUE)

/mob/living/carbon/human/Life(seconds_per_tick, times_fired)
	. = ..()
	handle_horror()

/mob/living/carbon/human/proc/enable_horror_features()
	SIGNAL_HANDLER
	if(horror_effect_on)
		return

	overlay_fullscreen("triller_effect", /atom/movable/screen/fullscreen/triller_cold)
	horror_effect_on = TRUE

/mob/living/carbon/human/proc/disable_horror_features()
	SIGNAL_HANDLER
	if(!horror_effect_on)
		return

	clear_fullscreen("triller_effect")
	horror_effect_on = FALSE

//Убираем любые внутренние источники свела, либо его заменители(ночное зрение)
/mob/living/carbon/human/proc/light_out(clothing = TRUE, cybernetic = TRUE)
	if(!horror_effect_on)
		return
	//Лопаем источники света!
	if(glasses && glasses.color_cutoffs && clothing)
		to_chat(src, span_warning("You [glasses.name], break!"))
		do_sparks(4, TRUE, src)
		glasses.Destroy()

	if(cybernetic)
		var/obj/item/organ/internal/eyes/our_eyes = get_organ_slot(ORGAN_SLOT_EYES)
		for(var/obj/item/organ/internal/eyes/black_listed_eyes in HORROR_MODE_BLECKLISTED_EYES)
			if(our_eyes == black_listed_eyes)
				our_eyes.apply_organ_damage(100)
				to_chat(src, span_warning("You [our_eyes.name] is overloadet!"))

/mob/living/carbon/human/proc/set_horror_state(new_state, time)
	horror_state = new_state
	handle_horror()
	if(time)
		addtimer(CALLBACK(src, PROC_REF(set_horror_state), HUMAN_HORROR_STATE_NORMAL), time)

/mob/living/carbon/human/proc/handle_horror()
	if(!horror_effect_on || horror_state <= HUMAN_HORROR_STATE_NORMAL)
		return

	var/obj/item/organ/internal/heart/our_heart = get_organ_slot(ORGAN_SLOT_HEART)
	if(our_heart)
		switch(horror_state)
			if(1)
				our_heart.force_beating(time = 10 SECONDS)
			if(2 to INFINITY)
				our_heart.force_beating(TRUE, time = 10 SECONDS)

	if(horror_state > HUMAN_HORROR_STATE_FEAR)
		shake_camera(src, 2 SECONDS, 3)

/mob/living/carbon/human/proc/add_screeen_temporary_effect(atom/movable/screen/fullscreen/effect, time = 10 SECONDS, override = FALSE)
	if(screen_effect_locked && !override)
		return
	if(override)
		clear_fullscreen("horror_effect")
	screen_effect_locked = TRUE
	overlay_fullscreen("horror_effect", effect)
	addtimer(CALLBACK(src, PROC_REF(clear_screen_temporary_effects)), time)

/mob/living/carbon/human/proc/clear_screen_temporary_effects()
	screen_effect_locked = FALSE
	clear_fullscreen("horror_effect")

/obj/item/organ/internal/heart
	VAR_PRIVATE/forced_beating = FALSE

/obj/item/organ/internal/heart/proc/force_beating(fast = FALSE, time = FALSE)
	if(forced_beating || !beating)
		return FALSE
	forced_beating = TRUE
	var/sound/slowbeat = sound('sound/health/slowbeat.ogg', repeat = TRUE)
	var/sound/fastbeat = sound('sound/health/fastbeat.ogg', repeat = TRUE)

	if(fast)
		owner.playsound_local(get_turf(owner), fastbeat, 40, 0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
	else
		owner.playsound_local(get_turf(owner), slowbeat, 40, 0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)

	if(time)
		addtimer(CALLBACK(src, PROC_REF(restore_beating)), time)

/obj/item/organ/internal/heart/proc/restore_beating()
	owner.stop_sound_channel(CHANNEL_HEARTBEAT)
	forced_beating = FALSE
