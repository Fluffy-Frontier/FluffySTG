/datum/emote/living/cough/get_sound(mob/living/user)
	if(istesharialt(user))
		return 'tff_modular/modules/emotes/sounds/tesharicough.ogg'
	else if(isnabber(user))
		return 'tff_modular/modules/emotes/sounds/nabbercough.ogg'
	..(user)

/datum/emote/living/sneeze/get_sound(mob/living/user)
	if(istesharialt(user))
		return 'tff_modular/modules/emotes/sounds/tesharisneeze.ogg'
	else if(isnabber(user))
		return 'tff_modular/modules/emotes/sounds/nabbersneeze.ogg'
	..(user)
