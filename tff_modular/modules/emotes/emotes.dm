/mob/living/proc/emote_alli_growl()
	set name = "> Alli Growl"
	set category = "Emotes+"
	usr.emote("alligrowl", intentional = TRUE)

/mob/living/proc/emote_alli_hiss()
	set name = "> Alli Hiss"
	set category = "Emotes+"
	usr.emote("allihiss", intentional = TRUE)

/mob/living/proc/emote_alli_call()
	set name = "> Alli Call"
	set category = "Emotes+"
	usr.emote("allicall", intentional = TRUE)

/datum/emote/living/alligrowl
	key = "Alli Growl"
	key_third_person = "alligrowl"
	message = "Growls Intensively!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'tff_modular/modules/emotes/sounds/alli_growl.ogg'

/datum/emote/living/allihiss
	key = "Alli Hiss"
	key_third_person = "allihiss"
	message = "Hisses deeply!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'tff_modular/modules/emotes/sounds/alli_hiss.ogg'

/datum/emote/living/allicall
	key = "Alli Call"
	key_third_person = "allicall"
	message = "Shortly calls!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'tff_modular/modules/emotes/sounds/alli_call.ogg'
