/obj/item/organ/tongue/nabber/get_tongue_emote_sound(datum/source, key, list/sounds)
	. = ..()
	if(key == "scream")
		return 'tff_modular/modules/nabbers/sounds/nabberscream.ogg'

/datum/laugh_type/nabber
	name = "Ascent Laugh"
	laugh_sounds = list('tff_modular/modules/nabbers/sounds/nabberlaugh.ogg')
	female_laugh_type = null


/datum/scream_type/nabber
	name = "Ascent Scream"
	scream_sounds = list('tff_modular/modules/nabbers/sounds/nabberscream.ogg')
	female_scream_type = null
