
/obj/item/organ/tongue/Initialize(mapload)
	if(modifies_speech)
		LAZYADD(actions_types, /datum/action/item_action/organ_action/toggle/toggle_autoaccent)
	. = ..()

/obj/item/organ/tongue/should_modify_speech(datum/source, list/speech_args)
	. = ..()
	if(HAS_TRAIT(source, TRAIT_NO_ACCENT))
		return FALSE
