/datum/quirk/coldblooded
	name = "Cold Blooded"
	desc = "You're cold blooded like lizards! Try to control your body temperature or you're dead."
	value = -2
	medical_record_text = "Patient is cold blooded."
	gain_text = "You feel like you're unable to warm yourself."
	lose_text = "You feel like you're able to warm yourself again."
	icon = FA_ICON_SNOWFLAKE
	mob_trait = TRAIT_COLDBLOODED

/datum/quirk/coldblooded/is_species_appropriate(datum/species/mob_species)
    if(ispath(mob_species, /datum/species/lizard))
        return FALSE
    return ..()

