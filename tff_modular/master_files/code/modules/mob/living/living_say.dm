/**
 * Слегка дополняем прок living/hear, для того, чтобы добавить возможность существам с трейтом на хороший слух, слышать шепот в приделах экрана.
 */

/mob/living/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods, message_range)
	if(HAS_TRAIT(src, TRAIT_PERFECT_HEARING))
		message_range = 1
	..(message, speaker, message_language, raw_message, radio_freq, spans, message_mods, message_range)
