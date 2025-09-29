//Code by Coxswain sprites by Sky
/mob/living/simple_animal/hostile/abnormality/siren
	name = "Siren"
	desc = "The siren that sings the past."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/64x64.dmi'
	pixel_x = -16
	base_pixel_x = -16
	icon_state = "siren"
	maxHealth = 1000
	health = 1000
	speak_emote = list("plays")
	fear_level = HE_LEVEL
	minimum_distance = 3 //runs away during pink midnight
	ego_list = list(
		/datum/ego_datum/weapon/song,
		/datum/ego_datum/weapon/songmini,
		/datum/ego_datum/armor/song,
	)
	gift_type = /datum/ego_gifts/song

	observation_prompt = "My grandfather loved this song once, he used to tell me it was the first song he and his wife, my grandmother, danced and shared their first kiss to. <br>\
		When she passed he would play this song all the time until the vinyl began to warp. <br>One day, I visited him after a long time and the song wasn't playing. <br>\
		\"It's not the same song,\" he'd whisper chin resting over his clenched hands, gripped together until they were as white as his knuckles. <br>\
		\"Why isn't the same song?\""


//meltdown effects
	var/meltdown_cooldown_time = 144 SECONDS
	var/meltdown_cooldown
	var/song_cooldown_time = 60 SECONDS
	var/song_cooldown
	var/meltdown_imminent = FALSE
//Post-work effect
	var/musictimer
//SFX
	var/datum/looping_sound/siren_musictime/musictime
	var/playstatus = FALSE
	var/playrange = 40

//Spawn/music stuff
/mob/living/simple_animal/hostile/abnormality/siren/Initialize()
	. = ..()
	musictime = new(list(src), FALSE)

/mob/living/simple_animal/hostile/abnormality/siren/Life() //todo : rewrite this is a more concise way
	. = ..()
	if(meltdown_cooldown < world.time && !playstatus) // Doesn't decrease while working or playing music but will afterwards
		meltdown_cooldown = world.time + meltdown_cooldown_time
		qliphoth_change(-1)
		meltdown_imminent = FALSE

	if(datum_reference.qliphoth_meter == 1 && !meltdown_imminent) // Is qliphoth 1? Have we not run this yet? If true, play warning sound
		meltdown_imminent = TRUE
		playsound(src, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/siren/burningmemory.ogg', 100, FALSE, 40, falloff_distance = 20)
		playstatus = TRUE
		musictimer = addtimer(CALLBACK(src, PROC_REF(stopPlaying)), 55 SECONDS, TIMER_STOPPABLE)
		icon_state = "siren_breach"
		warning()

	if(song_cooldown < world.time && !datum_reference.qliphoth_meter) // 0 Qliphoth, time to start waking up the abnormalities
		musictime.start()
		song_cooldown = world.time + song_cooldown_time
		playstatus = TRUE

	if(playstatus && !datum_reference.qliphoth_meter) // Abnormality wake-up on cooldown? Play a warning instead.
		warning()

	else if(playstatus && datum_reference.qliphoth_meter >= 2) //O h, we're at a high qliphoth and still playing music for some reason? let's heal people instead
		blessing()

/mob/living/simple_animal/hostile/abnormality/siren/proc/stopPlaying() // This does exactly what it says on the tin.
	if(!datum_reference.qliphoth_meter)
		musictime.stop()
		for(var/mob/living/carbon/human/H in view(playrange, src))
			to_chat(H, span_warning("The music begins to trail off.")) // This is specifically to let players know that abnormalities are no longer breaching
	playstatus = 0
	icon_state = "siren"

/mob/living/simple_animal/hostile/abnormality/siren/proc/turnBackTime(mob/living/carbon/human/user) //Insight work does a bunch of whacky stuff
	var/mob/living/carbon/human/H = user
	var/currentage = H.age
	var/message
	if(datum_reference.qliphoth_meter >= 5) //If we're at max qliphoth, die!
		to_chat(user, span_danger("The last thing you remember is your heart stopping."))
		//playsound(loc, 'sound/effectsmagic/clockwork/ratvar_attack.ogg', 50, TRUE, channel = CHANNEL_SIREN)
		user.gib(DROP_ALL_REMAINS)
		return
	H.age = rand(17 , 85) //minimum age is 17, max is 85. We do a funny and change the user's age to something random.
	if (H.age > currentage)
		message += "You feel older and lucid."
		user.adjustSanityLoss(-user.maxSanity * 0.3) // It's healing
	else if (H.age < currentage)
		message += "You feel younger and vigorous."
		user.adjustBruteLoss(-user.maxHealth * 0.3)
	else
		message += "Doesn't seem like it did anything this time."

	to_chat(H, span_warning("[message]"))

	if(!playstatus && datum_reference.qliphoth_meter <= 1) //Qlihphoth is at or below 1 and insight work was performed? play the healing song!
		playsound(loc, 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/siren/backtherebenjamin.ogg', 50, FALSE,40, falloff_distance = 20)
		playstatus = TRUE //prevents song overlap
		if(musictimer)
			deltimer(musictimer)
		musictimer = addtimer(CALLBACK(src, PROC_REF(stopPlaying)), 60 SECONDS, TIMER_STOPPABLE)
		icon_state = "siren_breach"


/mob/living/simple_animal/hostile/abnormality/siren/try_working(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if(playstatus && !datum_reference.qliphoth_meter)
		stopPlaying()
		qliphoth_change(3)
		return

/mob/living/simple_animal/hostile/abnormality/siren/PostWorkEffect(mob/living/carbon/human/user) //Or by working
	. = ..()
	if(datum_reference.qliphoth_meter <= 1)
		stopPlaying()
	if(user.get_major_clothing_class() == CLOTHING_SCIENCE)
		turnBackTime(user)
	qliphoth_change(5)
	return ..()

/mob/living/simple_animal/hostile/abnormality/siren/proc/warning() //A bunch of messages for various occasions
	if(datum_reference.qliphoth_meter > 0)
		for(var/mob/living/carbon/human/H in view(playrange, src))
			to_chat(H, span_warning("The abnormalities seem restless..."))
		return

	for(var/mob/living/carbon/human/H in view(playrange, src))
		to_chat(H, span_warning("The abnormalities stir as the music plays..."))
	icon_state = "siren_breach"

/mob/living/simple_animal/hostile/abnormality/siren/proc/blessing()
	for(var/mob/living/carbon/human/H in view(playrange, src))
		to_chat(H, span_nicegreen("The music calms your nerves."))
		H.adjustSanityLoss(-3) // It's healing
	return
