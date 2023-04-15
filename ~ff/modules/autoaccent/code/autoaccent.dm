/client/verb/toggle_autoaccent()
	set name = "Toggle Auto-Accent"
	set desc = "Toggle automatic accents for your species"
	set category = "IC"

	if (mob == null)
		to_chat("You cant toggle auto-accent in this state")
	if (HAS_TRAIT(mob, TRAIT_NO_ACCENT))
		REMOVE_TRAIT(mob, TRAIT_NO_ACCENT, "ooc_verb")
		to_chat(src, "Auto-accent is now on")
	else
		ADD_TRAIT(mob, TRAIT_NO_ACCENT, "ooc_verb")
		to_chat(src, "Auto-accent is now off")


/obj/item/organ/internal/tongue/cat
	modifies_speech = TRUE
	languages_native = list(/datum/language/nekomimetic, /datum/language/yangyu, /datum/language/primitive_catgirl) //IDK, Yangyu is native to Felinids? WHY?

/obj/item/organ/internal/tongue/cat/proc/pick_cat_rawr(match)
	if (match[1] == "R")
		return pick("Rr", "Rrr", "Rrrr")
	return pick("rr", "rrr", "rrrr")

/obj/item/organ/internal/tongue/cat/proc/pick_cat_rawr_RU(match)
	if (match[1] == "Р")
		return pick("Рр", "Ррр", "Рррр")
	return pick("рр", "ррр", "рррр")

/obj/item/organ/internal/tongue/cat/modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/static/regex/cat_rawrs = new("r+", "g")
	var/static/regex/cat_Rawrs = new("R+", "g")
	if(message[1] != "*")
		message = cat_rawrs.Replace(message,  PROC_REF(pick_cat_rawr))
		message = cat_Rawrs.Replace(message,  PROC_REF(pick_cat_rawr))
		if(CONFIG_GET(flag/russian_text_formation))
			var/static/regex/cat_rawrs_RU = new("р+", "g")
			var/static/regex/cat_Rawrs_RU = new("Р+", "g")
			message = cat_rawrs_RU.Replace(message,  PROC_REF(pick_cat_rawr_RU))
			message = cat_Rawrs_RU.Replace(message,  PROC_REF(pick_cat_rawr_RU))
	speech_args[SPEECH_MESSAGE] = message

/datum/species/vulpkanin
	mutanttongue = /obj/item/organ/internal/tongue/dog

/obj/item/organ/internal/tongue/dog
	modifies_speech = TRUE
	languages_native = list(/datum/language/canilunzt)

/obj/item/organ/internal/tongue/dog/proc/pick_dog_rawr(match)
	if (match[1] == "R")
		return pick("R", "Rr", "Rrr")
	return pick("r", "rr", "rrr")

/obj/item/organ/internal/tongue/dog/proc/pick_dog_rawr_RU(match)
	if (match[1] == "Р")
		return pick("Р", "Рр", "Ррр")
	return pick("р", "рр", "ррр")

/obj/item/organ/internal/tongue/dog/modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/static/regex/dog_rawrs = new("r+", "g")
	var/static/regex/dog_Rawrs = new("R+", "g")
	if(message[1] != "*")
		message = dog_rawrs.Replace(message, PROC_REF(pick_dog_rawr))
		message = dog_Rawrs.Replace(message, PROC_REF(pick_dog_rawr))
		if(CONFIG_GET(flag/russian_text_formation))
			var/static/regex/dog_rawrs_RU = new("р+", "g")
			var/static/regex/dog_Rawrs_RU = new("Р+", "g")
			message = dog_rawrs_RU.Replace(message, PROC_REF(pick_dog_rawr_RU))
			message = dog_Rawrs_RU.Replace(message, PROC_REF(pick_dog_rawr_RU))
	speech_args[SPEECH_MESSAGE] = message

