/// БЛЭКЛИСТЫ ДЛЯ РАС

/datum/quirk/item_quirk/food_allergic/is_species_appropriate(datum/species/mob_species)
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits
	if(TRAIT_SYNTHETIC in species_traits) // Антисинт
		return FALSE
	if(TRAIT_NOHUNGER in species_traits) // Антигемофаг/плазмачел
		return FALSE
	if(TRAIT_TOXINLOVER in species_traits) // Антислайм. Как ни странно, аллергия от лекарств работает, а от еды нет
		return FALSE
	return ..()

/datum/quirk/item_quirk/allergic/is_species_appropriate(datum/species/mob_species)
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits
	if(TRAIT_SYNTHETIC in species_traits) // Антисинт
		return FALSE
	return ..()

/datum/quirk/item_quirk/addict/smoker/is_species_appropriate(datum/species/mob_species)
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits
	if(TRAIT_NOBREATH in species_traits) // Антигемофаг
		return FALSE
	return ..()

/datum/quirk/item_quirk/fluoride_stare/is_species_appropriate(datum/species/mob_species)
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits
	if(TRAIT_SYNTHETIC in species_traits) // Антисинт
		return FALSE
	return ..()

/datum/quirk/item_quirk/anosmia/is_species_appropriate(datum/species/mob_species)
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits
	if(TRAIT_NOBREATH in species_traits) // Нет дыхания - нет обоняния
		return FALSE
	return ..()

/datum/quirk/hungry/is_species_appropriate(datum/species/mob_species)
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits
	if(TRAIT_NOHUNGER in species_traits) // Нет нужды в еде - нет нужды в квирке голода
		return FALSE
	return ..()

/datum/quirk/genetic_mutation/is_species_appropriate(datum/species/mob_species)
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits
	if(TRAIT_GENELESS in species_traits)
		return FALSE
	return ..()

/datum/quirk/system_shock/is_species_appropriate(datum/species/mob_species)
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits
	return (TRAIT_SYNTHETIC in species_traits) // только синт

