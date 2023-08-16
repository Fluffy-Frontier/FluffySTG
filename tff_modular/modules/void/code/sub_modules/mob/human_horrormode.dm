/mob/living/carbon/human
	//Включено ли действие хоорор эффектов.
	var/horror_effect_on = TRUE
	//Текщие состояние нашего испуга - по умолчание мы в норме.
	var/horror_state = HUMAN_HORROR_STATE_NORMAL
	VAR_PRIVATE/screen_effect_locked = FALSE

/mob/living/carbon/human/Life(seconds_per_tick, times_fired)
	. = ..()
	handle_horror()

/mob/living/carbon/human/proc/set_horror_state(new_state, time)
	horror_state = new_state
	handle_horror()
	if(time)
		addtimer(CALLBACK(src, PROC_REF(set_horror_state), HUMAN_HORROR_STATE_NORMAL), time)

/mob/living/carbon/human/proc/handle_horror()
	if(!horror_effect_on || horror_state <= HUMAN_HORROR_STATE_NORMAL)
		return
	if(prob(20))
	var/obj/item/organ/internal/heart/our_heart = get_organ_slot(ORGAN_SLOT_HEART)

	switch(horror_state)
		if(1 to 2)
			our_heart.force_beating(time = 10 SECONDS)
		if(3)
			if(prob(50))
				to_chat(src, span_warning("My head is spinning, and my legs feel numb... God, I'm going to black out..."))
			our_heart.force_beating(TRUE, time = 10 SECONDS)
		if(4 to INFINITY)
			our_heart.force_beating(TRUE, time = 10 SECONDS)
			if(prob(50) && !HAS_TRAIT(src, TRAIT_STABLEHEART))
				our_heart.Stop()

/mob/living/carbon/human/proc/add_screeen_temporary_effect(atom/movable/screen/fullscreen/effect, time = 10 SECONDS, override = TRUE)
	if(screen_effect_locked)
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
	VAR_PRIVATE/foced_beating = FALSE

/obj/item/organ/internal/heart/proc/force_beating(fast = FALSE, time = FALSE)
	if(foced_beating || !beating)
		return
	foced_beating = TRUE
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
	foced_beating = FALSE
