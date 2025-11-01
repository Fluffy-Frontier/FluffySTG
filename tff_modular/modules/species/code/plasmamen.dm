/datum/species/plasmaman
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	mutant_bodyparts = list("legs" = "Normal Legs")
	inherent_traits = list(
		TRAIT_GENELESS,
		TRAIT_HARDLY_WOUNDED,
		TRAIT_NOBLOOD,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_UNHUSKABLE,
		TRAIT_MUTANT_COLORS,
	)

/datum/species/plasmaman/get_default_mutant_bodyparts()
	return list(
		"legs" = list("Normal Legs", FALSE),
	)
