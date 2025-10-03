//I think I want to do the idea of temptation.
//The works are always max but you can only do it 3 times per person.	-Kirie
/mob/living/simple_animal/hostile/abnormality/fan
	name = "F.A.N."
	desc = "It appears to be an office fan."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "fan"
	maxHealth = 400
	health = 400
	speak_emote = list("states")
	speech_span = SPAN_ROBOT
	fear_level = HE_LEVEL

	ego_list = list(
		/datum/ego_datum/weapon/metal,
		/datum/ego_datum/armor/metal,
	)
	gift_type = /datum/ego_gifts/metal
	observation_prompt = "It's an ordinary office fan, made of metal. <br>It's turned off for now and you're feeling warm. <br>\
		Turn it on?"


	var/list/safe = list()
	var/list/warning = list()
	var/list/danger = list()
	var/safework = FALSE //Safe if the abnormality was melting
	var/successcount
	var/turned_off = FALSE
	var/list/opposed_weather_list = list(
		/datum/weather/thunderstorm,
		/datum/weather/fog,
		/datum/weather/freezing_wind
		)

/mob/living/simple_animal/hostile/abnormality/fan/examine(mob/user)
	. = ..()
	if(turned_off)
		. += span_notice("It looks like it's turned off.")

/mob/living/simple_animal/hostile/abnormality/fan/PostWorkEffect(mob/living/carbon/human/user)
	if(user in danger)
		if(safework)
			to_chat(user, span_notice("You don't feel quite as tempted this time."))
			safework = FALSE
			return
		to_chat(user, span_danger("Oh."))
		user.throw_at(src, 10, 10, user, spin = TRUE, gentle = FALSE, quickstart = TRUE)
		SLEEP_CHECK_DEATH(3, src)
		playsound(loc, 'sound/machines/juicer.ogg', 100, TRUE)
		user.gib(DROP_ALL_REMAINS)

	else if(user in warning)
		danger+=user
		to_chat(user, span_nicegreen("You feel elated."))

	else if(user in safe)
		warning+=user
		to_chat(user, span_nicegreen("You feel refreshed."))

	else
		safe+=user
		to_chat(user, span_nicegreen("You could use some more."))

//Meltdown
/mob/living/simple_animal/hostile/abnormality/fan/try_working(mob/living/carbon/human/user)
	if(turned_off)
		to_chat(user, span_nicegreen("You hit the on switch. Aaah, that feels nice."))
		TurnOn()
		return FALSE
	if(prob(40))
		safework = TRUE
	return

//Breach
/mob/living/simple_animal/hostile/abnormality/fan/ZeroQliphoth(mob/living/carbon/human/user)
	. = ..()
	if(!turned_off)
		TurnOff()

/mob/living/simple_animal/hostile/abnormality/fan/proc/TurnOn(mob/living/carbon/human/user)
	turned_off = FALSE
	icon_state = "fan"
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/FAN/turnon.ogg', 100, FALSE, 2)
	for(var/mob/living/carbon/human/L in GLOB.player_list)
		var/datum/status_effect/stacking/fanhot/V = L.has_status_effect(/datum/status_effect/stacking/fanhot)
		if(!V)
			continue
		else
			qdel(V)

/mob/living/simple_animal/hostile/abnormality/fan/proc/TurnOff(mob/living/carbon/human/user)
	turned_off = TRUE
	icon_state = "fan_idle"
	playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/FAN/turnoff.ogg', 100, TRUE, 2)
	HeatWave()
	sound_to_playing_players(sound('tff_modular/modules/evento_needo/sounds/Tegusounds/abnormalities/seasons/summer_idle.ogg'))

/mob/living/simple_animal/hostile/abnormality/fan/proc/HeatWave()
	set waitfor = FALSE
	if(!turned_off)
		qliphoth_change(1)
		return

	for(var/W in SSweather.processing) // Supernatural weather should prevent the AC being turned off from making it hot.
		var/datum/weather/V = W
		if(V.type in opposed_weather_list)
			return

	for(var/mob/living/carbon/human/L in GLOB.player_list)
		if(z != L.z || L.stat >= HARD_CRIT) // on a different Z level or dead
			continue
		var/datum/status_effect/stacking/fanhot/V = L.has_status_effect(/datum/status_effect/stacking/fanhot)
		if(!V)
			L.apply_status_effect(/datum/status_effect/stacking/fanhot)
		else
			V.add_stacks(1)
			V.refresh()
	SLEEP_CHECK_DEATH(3 SECONDS, src)
	HeatWave(TRUE)

/datum/status_effect/stacking/fanhot
	id = "stacking_fanhot"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 20 SECONDS
	alert_type = null
	stack_decay = 0
	tick_interval = 10
	stacks = 1
	stack_threshold = 33
	max_stacks = 35
	on_remove_on_mob_delete = TRUE
	alert_type = /atom/movable/screen/alert/status_effect/fanhot
	consumed_on_threshold = FALSE

/atom/movable/screen/alert/status_effect/fanhot
	name = "Hot"
	desc = "Someone turn on the AC!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/status_sprites.dmi'
	icon_state = "hot"

/datum/status_effect/stacking/fanhot/on_apply()
	. = ..()
	to_chat(owner, span_warning("You're starting to sweat."))
	if(owner.client)
		owner.add_client_colour(/datum/client_colour/glass_colour/orange)

/datum/status_effect/stacking/fanhot/add_stacks(stacks_added)
	. = ..()
	if(!stacks_added)
		return
	if(stacks <= 10)
		return
	owner.apply_damage((stacks / 8), FIRE)
	owner.playsound_local(owner, 'sound/items/weapons/lasercannonfire.ogg', 25, TRUE)

/datum/status_effect/stacking/fanhot/on_remove()
	. = ..()
	if(!ishuman(owner))
		return
	to_chat(owner, span_nicegreen("Someone turned on the AC! Rejoice!"))
	if(owner.client)
		owner.remove_client_colour(/datum/client_colour/glass_colour/orange)

/datum/status_effect/stacking/fanhot/threshold_cross_effect()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/status_holder = owner
	to_chat(status_holder, span_warning("IT'S TOO HOT!"))
	owner.apply_damage(10, FIRE)
	stacks -= 10
