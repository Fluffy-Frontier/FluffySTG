/mob/living/proc/toggle_autoaccent()
	set name = "Toggle Auto-Accent"
	set desc = "Toggle automatic accents for your species"
	set category = "IC"

	if (!src)
		to_chat("You cant toggle auto-accent in this state")
	if (HAS_TRAIT(src, TRAIT_NO_ACCENT))
		REMOVE_TRAIT(src, TRAIT_NO_ACCENT, "ooc_verb")
		to_chat(src.client, "Auto-accent is now on")
	else
		ADD_TRAIT(src, TRAIT_NO_ACCENT, "ooc_verb")
		to_chat(src.client, "Auto-accent is now off")

//If there is build-in func?
/proc/text_mult(text, count)
	. = list()
	while(count--)
		. += text
	return jointext(., "")

/obj/item/organ/tongue/cat
	modifies_speech = TRUE
	languages_native = list(/datum/language/nekomimetic, /datum/language/yangyu, /datum/language/primitive_catgirl) //IDK, Yangyu is native to Felinids? WHY?

/proc/pick_cat_rawr(match)
	return match[1] + text_mult(lowertext(match[1]), rand(1, 3))

/obj/item/organ/tongue/cat/modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/static/regex/cat_rawrs = new(@"[рРrR]+", "g")
	if(message[1] != "*")
		message = cat_rawrs.Replace(message, GLOBAL_PROC_REF(pick_cat_rawr))
	speech_args[SPEECH_MESSAGE] = message

/datum/species/vulpkanin
	mutanttongue = /obj/item/organ/tongue/dog

/obj/item/organ/tongue/dog
	modifies_speech = TRUE
	languages_native = list(/datum/language/canilunzt)

/proc/pick_dog_rawr(match)
	return match[1] + text_mult(lowertext(match[1]), rand(0, 2))

// Almost same as /obj/item/organ/internal/tongue/cat/modify_speech. Maybe there is way to uniform replaces for any tongue with maps.
/obj/item/organ/tongue/dog/modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/static/regex/dog_rawrs = new(@"[рРrR]+", "g")
	if(message[1] != "*")
		message = dog_rawrs.Replace(message, GLOBAL_PROC_REF(pick_dog_rawr))
	speech_args[SPEECH_MESSAGE] = message

