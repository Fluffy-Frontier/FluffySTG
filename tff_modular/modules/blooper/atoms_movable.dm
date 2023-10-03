/atom/movable/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_BARK, .proc/handle_special_bark) //There must be a better way to do this

/atom/movable/Destroy()
	UnregisterSignal(src, COMSIG_MOVABLE_BARK)
	. = ..()

/atom/movable/proc/handle_special_bark(atom/movable/source, list/listeners, distance, volume, pitch)
	SIGNAL_HANDLER

	if(!GLOB.blooper_allowed)
		return //No need to run if there are no barks to begin with

	var/list/soundpaths
	switch(GLOB.bark_list[source.vocal_bark_id])
		if(/datum/bark/gaster)
			soundpaths = list(
				'tff_modular/modules/blooper/voice/barks/undertale/voice_gaster_1.ogg',
				'tff_modular/modules/blooper/voice/barks/undertale/voice_gaster_2.ogg',
				'tff_modular/modules/blooper/voice/barks/undertale/voice_gaster_3.ogg',
				'tff_modular/modules/blooper/voice/barks/undertale/voice_gaster_4.ogg',
				'tff_modular/modules/blooper/voice/barks/undertale/voice_gaster_5.ogg',
				'tff_modular/modules/blooper/voice/barks/undertale/voice_gaster_6.ogg',
				'tff_modular/modules/blooper/voice/barks/undertale/voice_gaster_7.ogg'
			)
		else
			return //No change needed

	source.vocal_bark = sound(pick(soundpaths))

/atom/movable
	// Text-to-bark sounds
	// Да. У нас все атом могут иметь звучение для say.
	var/sound/vocal_bark
	var/vocal_bark_id
	var/vocal_pitch = 1
	var/vocal_pitch_range = 0.2 //Actual pitch is (pitch - (vocal_pitch_range*0.5)) to (pitch + (vocal_pitch_range*0.5))
	var/vocal_volume = 70 //Baseline. This gets modified by yelling and other factors
	var/vocal_speed = 4 //Lower values are faster, higher values are slower
	var/vocal_current_bark //When barks are queued, this gets passed to the bark proc. If vocal_current_bark doesn't match the args passed to the bark proc (if passed at all), then the bark simply doesn't play. Basic curtailing of spam~

/atom/movable/proc/set_bark(id)
	if(!id)
		return FALSE
	var/datum/bark/B = GLOB.bark_list[id]
	if(!B)
		return FALSE
	vocal_bark = sound(initial(B.soundpath))
	vocal_bark_id = id
	return vocal_bark

/atom/movable/proc/bark(list/listeners, distance, volume, pitch, queue_time)
	if(!GLOB.blooper_allowed)
		return
	if(queue_time && vocal_current_bark != queue_time)
		return
	if(SEND_SIGNAL(src, COMSIG_MOVABLE_BARK, listeners, distance, volume, pitch))
		return //bark interception. this probably counts as some flavor of BDSM
	if(!vocal_bark)
		if(!vocal_bark_id || !set_bark(vocal_bark_id)) //just-in-time bark generation
			return
	volume = min(volume, 100)
	var/turf/T = get_turf(src)
	for(var/mob/M in listeners)
		M.playsound_local(T, vol = volume, vary = TRUE, frequency = pitch, max_distance = distance, falloff_distance = 0, falloff_exponent = BARK_SOUND_FALLOFF_EXPONENT(distance), sound_to_use = vocal_bark, distance_multiplier = 1)

/atom/movable/send_speech(message, range = 7, obj/source = src, bubble_type, list/spans, datum/language/message_language, list/message_mods = list(), forced = FALSE, tts_message, list/tts_filter)
	. = ..()
	var/list/listeners = get_hearers_in_view(range, source)
	if(SEND_SIGNAL(src, COMSIG_MOVABLE_QUEUE_BARK, listeners, args) || vocal_bark || vocal_bark_id)
		for(var/mob/M in listeners)
			if(!M.client)
				continue
			if(!(M.client?.prefs.read_preference(/datum/preference/toggle/sound_bark)))
				listeners -= M
		var/barks = min(round((LAZYLEN(message) / vocal_speed)) + 1, BARK_MAX_BARKS)
		var/total_delay
		vocal_current_bark = world.time //this is juuuuust random enough to reliably be unique every time send_speech() is called, in most scenarios
		for(var/i in 1 to barks)
			if(total_delay > BARK_MAX_TIME)
				break
			addtimer(CALLBACK(src, .proc/bark, listeners, range, vocal_volume, BARK_DO_VARY(vocal_pitch, vocal_pitch_range), vocal_current_bark), total_delay)
			total_delay += rand(DS2TICKS(vocal_speed / BARK_SPEED_BASELINE), DS2TICKS(vocal_speed / BARK_SPEED_BASELINE) + DS2TICKS(vocal_speed / BARK_SPEED_BASELINE)) TICKS

/randomize_human(mob/living/carbon/human/human)
	. = ..()
	human.set_bark(pick(GLOB.bark_random_list))
	human.vocal_pitch = BARK_PITCH_RAND(human.gender)
	human.vocal_pitch_range = BARK_VARIANCE_RAND

/mob/living/send_speech(message_raw, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language = null, list/message_mods = list(), forced = null, tts_message, list/tts_filter)
	. = ..()
	var/whisper_range = 0
	if(message_mods[WHISPER_MODE])
		whisper_range = MESSAGE_RANGE - WHISPER_RANGE
	var/list/listening = get_hearers_in_range(message_range + whisper_range, source)
	var/is_yell = (say_test(message_raw) == "2")
	//Listening gets trimmed here if a vocal bark's present. If anyone ever makes this proc return listening, make sure to instead initialize a copy of listening in here to avoid wonkiness
	if(SEND_SIGNAL(src, COMSIG_MOVABLE_QUEUE_BARK, listening, args) || vocal_bark || vocal_bark_id)
		for(var/mob/M in listening)
			if(!M.client)
				continue
			if(!(M.client?.prefs.read_preference(/datum/preference/toggle/sound_bark)))
				listening -= M
		var/barks = min(round((LAZYLEN(message_raw) / vocal_speed)) + 1, BARK_MAX_BARKS)
		var/total_delay
		vocal_current_bark = world.time
		for(var/i in 1 to barks)
			if(total_delay > BARK_MAX_TIME)
				break
			addtimer(CALLBACK(src, /atom/movable/proc/bark, listening, (message_range * (is_yell ? 4 : 1)), (vocal_volume * (is_yell ? 1.5 : 1)), BARK_DO_VARY(vocal_pitch, vocal_pitch_range), vocal_current_bark), total_delay)
			total_delay += rand(DS2TICKS(vocal_speed / BARK_SPEED_BASELINE), DS2TICKS(vocal_speed / BARK_SPEED_BASELINE) + DS2TICKS((vocal_speed / BARK_SPEED_BASELINE) * (is_yell ? 0.5 : 1))) TICKS
