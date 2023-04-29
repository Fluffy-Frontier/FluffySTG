/datum/emote/living/human/error
	key = "error"
	message = "emits an error sound!"
	emote_type = EMOTE_AUDIBLE
	sound = '~ff/modules/emotes/sound/Microsoft Windows XP Error - Sound Effect.mp3'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/synthetic)
	sound_volume = 40

/datum/emote/living/human/error/New()
	audio_cooldown = cooldown
	. = ..()
