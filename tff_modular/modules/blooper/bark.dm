GLOBAL_VAR_INIT(blooper_allowed, TRUE) // For administrators

/datum/smite/normalblooper
	name = "Normal blooper"

/datum/smite/normalblooper/effect(client/user, mob/living/carbon/human/target)
	. = ..()
	target.vocal_bark = null
	target.vocal_bark_id = pick(GLOB.bark_random_list)
	target.vocal_speed = round((BARK_DEFAULT_MINSPEED + BARK_DEFAULT_MAXSPEED) / 2)
	target.vocal_pitch = round((BARK_DEFAULT_MINPITCH + BARK_DEFAULT_MAXPITCH) / 2)
	target.vocal_pitch_range = 0.2


/datum/admins/proc/toggleblooper()
	set category = "Server"
	set desc = "Toggle ANNOYING NOIZES"
	set name = "Toggle Blooper"
	toggle_blooper()
	log_admin("[key_name(usr)] toggled Blooper.")
	message_admins("[key_name_admin(usr)] toggled Blooper.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Blooper", "[GLOB.blooper_allowed ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

/world/AVerbsAdmin()
	. = ..()
	return . + /datum/admins/proc/toggleblooper

/proc/toggle_blooper(toggle = null)
	if(toggle != null)
		if(toggle != GLOB.blooper_allowed)
			GLOB.blooper_allowed = toggle
		else
			return
	else
		GLOB.blooper_allowed = !GLOB.blooper_allowed
	to_chat(world, "<span class='oocplain'><B>The Blooper has been globally [GLOB.blooper_allowed ? "enabled" : "disabled"].</B></span>")

/datum/preference/choiced/bark
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "bark_speech"

/datum/preference/choiced/bark/init_possible_values()
	return assoc_to_keys(GLOB.bark_list)

/datum/preference/choiced/bark/apply_to_human(mob/living/carbon/human/target, value, /datum/preference/numeric/bark_speech_speed)
	target.set_bark(value)

/datum/preference_middleware/bark
	/// Cooldown on requesting a Blooper preview.
	COOLDOWN_DECLARE(bark_cooldown)

	action_delegations = list(
		"play_bark" = PROC_REF(play_bark),
	)

/datum/preference_middleware/bark/proc/play_bark(list/params, mob/user)
	if(!COOLDOWN_FINISHED(src, bark_cooldown))
		return TRUE
	var/atom/movable/barkbox = new(get_turf(user))
	barkbox.set_bark(preferences.read_preference(/datum/preference/choiced/bark))
	barkbox.vocal_pitch = preferences.read_preference(/datum/preference/numeric/bark_speech_pitch)
	barkbox.vocal_speed = preferences.read_preference(/datum/preference/numeric/bark_speech_speed)
	barkbox.vocal_pitch_range = preferences.read_preference(/datum/preference/numeric/bark_pitch_range)
	var/total_delay
	for(var/i in 1 to (round((32 / barkbox.vocal_speed)) + 1))
		addtimer(CALLBACK(barkbox, TYPE_PROC_REF(/atom/movable, bark), list(user), 7, 70, BARK_DO_VARY(barkbox.vocal_pitch, barkbox.vocal_pitch_range)), total_delay)
		total_delay += rand(DS2TICKS(barkbox.vocal_speed/4), DS2TICKS(barkbox.vocal_speed/4) + DS2TICKS(barkbox.vocal_speed/4)) TICKS
	QDEL_IN(barkbox, total_delay)
	COOLDOWN_START(src, bark_cooldown, 2 SECONDS)
	return TRUE

/datum/preference/numeric/bark_speech_speed
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "bark_speech_speed"
	minimum = BARK_DEFAULT_MINSPEED
	maximum = BARK_DEFAULT_MAXSPEED
	step = 0.01

/datum/preference/numeric/bark_speech_speed/apply_to_human(mob/living/carbon/human/target, value)
	target.vocal_speed = value

/datum/preference/numeric/bark_speech_speed/create_default_value()
	return round((BARK_DEFAULT_MINSPEED + BARK_DEFAULT_MAXSPEED) / 2)

/datum/preference/numeric/bark_speech_pitch
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "bark_speech_pitch"
	minimum = BARK_DEFAULT_MINPITCH
	maximum = BARK_DEFAULT_MAXPITCH
	step = 0.01

/datum/preference/numeric/bark_speech_pitch/apply_to_human(mob/living/carbon/human/target, value)
	target.vocal_pitch = value

/datum/preference/numeric/bark_speech_pitch/create_default_value()
	return round((BARK_DEFAULT_MINPITCH + BARK_DEFAULT_MAXPITCH) / 2)

/datum/preference/numeric/bark_pitch_range
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "bark_pitch_range"
	minimum = BARK_DEFAULT_MINVARY
	maximum = BARK_DEFAULT_MAXVARY
	step = 0.01

/datum/preference/numeric/bark_pitch_range/apply_to_human(mob/living/carbon/human/target, value)
	target.vocal_pitch_range = value

/datum/preference/numeric/bark_pitch_range/create_default_value()
	return 0.2


/// Могу ли я использовать свой блупер?
/datum/preference/toggle/send_sound_bark
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "send_sound_bark"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = FALSE

/// Могу ли я слышать блупки остальных?
/datum/preference/toggle/hear_sound_bark
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "hear_sound_bark"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = FALSE

/// It's was stoolen from Splurt build >:3
/datum/bark
	var/name = "Default"
	var/id = "Default"
	var/soundpath

	var/minpitch = BARK_DEFAULT_MINPITCH
	var/maxpitch = BARK_DEFAULT_MAXPITCH
	var/minvariance = BARK_DEFAULT_MINVARY
	var/maxvariance = BARK_DEFAULT_MAXVARY

	// Speed vars. Speed determines the number of characters required for each bark, with lower speeds being faster with higher bark density
	var/minspeed = BARK_DEFAULT_MINSPEED
	var/maxspeed = BARK_DEFAULT_MAXSPEED

	// Visibility vars. Regardless of what's set below, these can still be obtained via adminbus and genetics. Rule of fun.
	var/list/ckeys_allowed
	var/ignore = FALSE // If TRUE - only for admins
	var/allow_random = FALSE
