/datum/quirk/item_quirk/asthma/is_species_appropriate(datum/species/mob_species)
	return ..() && !(TRAIT_NOBREATH in GLOB.species_prototypes[mob_species].inherent_traits)
