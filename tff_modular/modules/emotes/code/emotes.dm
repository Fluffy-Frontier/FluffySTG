/datum/emote/living/cough/get_sound(mob/living/user)
	if(istesharialt(user))
		return 'tff_modular/modules/emotes/sounds/tesharicough.ogg'
	..(user)

/datum/emote/living/sneeze/get_sound(mob/living/user)
	if(istesharialt(user))
		return 'tff_modular/modules/emotes/sounds/tesharisneeze.ogg'
	..(user)
