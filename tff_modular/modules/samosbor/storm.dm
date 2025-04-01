/datum/round_event_control/radiation_storm
	name = "Самосбор"
	typepath = /datum/round_event/samosbor
	max_occurrences = 1
	category = EVENT_CATEGORY_SPACE
	description = "Красная дымка, что заставляет живых существ менять свой облик. Суровый русский аналог рад шторма."
	min_wizard_trigger_potency = 3
	max_wizard_trigger_potency = 7

/datum/round_event/samosbor

/datum/round_event/samosbor/setup()
	start_when = 3
	end_when = start_when + 1
	announce_when = 1

/datum/round_event/samosbor/announce(fake)
	priority_announce("Внимание, объявляется самосбор. Всем срочно занять укрытие в технических туннелях. Все формы жизни под угрозой.", "Межпространственная аномалия", 'tff_modular/modules/samosbor/samosbor.ogg')

/datum/round_event/samosbor/start()
	SSweather.run_weather(/datum/weather/samosbor)

/datum/weather/samosbor
	name = "samosbor"
	desc = "Межпространственная дыра облучает станцию чем-то красным. Кажется, Нар-Си плачет."

	telegraph_duration = 20 SECONDS
	telegraph_message = span_boldbig(span_danger("Вы чувствуете зажигательный ритм."))

	weather_message = span_userdanger("Станцию накрывает красная дымка!")
	weather_overlay = "ash_storm"
	weather_duration = 20 SECONDS
	weather_duration_lower = 20 SECONDS
	weather_duration_upper = 20 SECONDS
	weather_color = "red"
	weather_sound = null

	end_duration = 100
	end_message = span_notice("Дымка рассеивается, оставляя за собой нечто иное.")

	area_type = /area
	protected_areas = list(/area/station/maintenance, /area/station/ai_monitored/turret_protected/ai_upload, /area/station/ai_monitored/turret_protected/ai_upload_foyer,
							/area/station/ai_monitored/turret_protected/aisat/maint, /area/station/ai_monitored/command/storage/satellite,
							/area/station/ai_monitored/turret_protected/ai, /area/station/commons/storage/emergency/starboard, /area/station/commons/storage/emergency/port,
							/area/shuttle, /area/station/security/prison/safe, /area/station/security/prison/toilet, /area/mine/maintenance, /area/icemoon/underground, /area/ruin/comms_agent/maint)
	target_trait = ZTRAIT_STATION

	immunity_type = TRAIT_RADSTORM_IMMUNE

/datum/weather/samosbor/telegraph()
	..()
	status_alarm(TRUE)


/datum/weather/samosbor/weather_act(mob/living/living)
	if(!ishuman(living) || HAS_TRAIT(living, TRAIT_GODMODE))
		if(living.maxHealth > 100)
			return
		else if(!istype(/mob/living/basic/mold/centaur))
			if(prob(10))
				var/turf/where_spawn = get_turf(living)
				if(where_spawn)
					living.gib()
					new /mob/living/basic/mold/centaur(where_spawn)
					return
		return

	var/mob/living/carbon/human/human = living
	if(!human.can_mutate())
		return

	if(HAS_TRAIT(human, TRAIT_RADIMMUNE))
		return

	if(living.can_block_magic(MAGIC_RESISTANCE))
		return

	human.random_mutate_unique_identity()
	human.random_mutate_unique_features()

	if(prob(25))
		do_mutate(human)

/datum/weather/samosbor/end()
	if(..())
		return
	priority_announce("Действие аномалии прекращено, однако принимайте меры предосторожности по возвращению в отделы и сообщайте обо всех подозрительных биологических формах жизни.", "Межпространственная аномалия", ANNOUNCER_RADIATIONPASSED)
	status_alarm(FALSE)

/datum/weather/samosbor/proc/do_mutate(mob/living/carbon/human/carbon_mob)
	if(carbon_mob.stat == DEAD || HAS_TRAIT(carbon_mob, TRAIT_NODISMEMBER))
		return FALSE

	var/list/zone_candidates = carbon_mob.get_missing_limbs()
	for(var/obj/item/bodypart/bodypart in carbon_mob.bodyparts)
		if(bodypart.body_zone == BODY_ZONE_HEAD || bodypart.body_zone == BODY_ZONE_CHEST)
			continue
		if(HAS_TRAIT(bodypart, TRAIT_IGNORED_BY_LIVING_FLESH))
			continue
		if(bodypart.bodypart_flags & BODYPART_UNREMOVABLE)
			continue
		zone_candidates += bodypart.body_zone

	if(!length(zone_candidates))
		return FALSE

	var/target_zone = pick(zone_candidates)
	var/obj/item/bodypart/target_part = carbon_mob.get_bodypart(target_zone)
	if(isnull(target_part))
		carbon_mob.emote("scream")
	else
		target_part.dismember()

	var/part_type
	switch(target_zone)
		if(BODY_ZONE_L_ARM)
			part_type = /obj/item/bodypart/arm/left/flesh
		if(BODY_ZONE_R_ARM)
			part_type = /obj/item/bodypart/arm/right/flesh
		if(BODY_ZONE_L_LEG)
			part_type = /obj/item/bodypart/leg/left/flesh
		if(BODY_ZONE_R_LEG)
			part_type = /obj/item/bodypart/leg/right/flesh

	carbon_mob.visible_message(
		span_danger("[carbon_mob][carbon_mob.p_s()] limb suddenly swells and rips apart, revealing brand new red bloody flesh!"),
		span_bolddanger("Your limb suddenly swells and rips apart, revealing brand new red bloody flesh!"),
		blind_message = span_hear("You hear gore sounds, like someone is tearing up flesh and breaking bones."),
	)
	var/obj/item/bodypart/new_bodypart = new part_type()
	var/mob/living/basic/living_limb_flesh/parasite = new /mob/living/basic/living_limb_flesh(get_turf(carbon_mob))
	parasite.forceMove(new_bodypart)
	new_bodypart.replace_limb(carbon_mob, TRUE)
	parasite.register_to_limb(new_bodypart)
	return TRUE

/datum/weather/samosbor/proc/status_alarm(active) //Makes the status displays show the radiation warning for those who missed the announcement.
	var/datum/radio_frequency/frequency = SSradio.return_frequency(FREQ_STATUS_DISPLAYS)
	if(!frequency)
		return

	var/datum/signal/signal = new
	if (active)
		signal.data["command"] = "alert"
		signal.data["picture_state"] = "radiation"
	else
		signal.data["command"] = "shuttle"

	var/atom/movable/virtualspeaker/virtual_speaker = new(null)
	frequency.post_signal(virtual_speaker, signal)
