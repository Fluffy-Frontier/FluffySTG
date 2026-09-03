/datum/action/item_action/organ_action/toggle/toggle_autoaccent
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "neckchop"
	desc = "Toggle automatic accents for your species"

/datum/action/item_action/organ_action/toggle/toggle_autoaccent/New(Target)
	..()
	name = "Toggle Auto-Accent"
/datum/action/item_action/organ_action/toggle/toggle_autoaccent/do_effect(trigger_flags)
	. = ..()
	var/obj/item/organ/tongue/tongue = target
	if(!tongue)
		return FALSE
	var/mob/living/carbon/human/holder = tongue.owner
	if(!holder)
		return FALSE
	if (HAS_TRAIT(holder, TRAIT_NO_ACCENT))
		REMOVE_TRAIT(holder, TRAIT_NO_ACCENT, "toggle_autoaccent")
		to_chat(holder.client, "Auto-accent is now on")
	else
		ADD_TRAIT(holder, TRAIT_NO_ACCENT, "toggle_autoaccent")
		to_chat(holder.client, "Auto-accent is now off")
	return TRUE

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
	return match[1] + text_mult(LOWER_TEXT(match[1]), rand(1, 3))

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
	return match[1] + text_mult(LOWER_TEXT(match[1]), rand(0, 2))

// Almost same as /obj/item/organ/internal/tongue/cat/modify_speech. Maybe there is way to uniform replaces for any tongue with maps.
/obj/item/organ/tongue/dog/modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/static/regex/dog_rawrs = new(@"[рРrR]+", "g")
	if(message[1] != "*")
		message = dog_rawrs.Replace(message, GLOBAL_PROC_REF(pick_dog_rawr))
	speech_args[SPEECH_MESSAGE] = message

