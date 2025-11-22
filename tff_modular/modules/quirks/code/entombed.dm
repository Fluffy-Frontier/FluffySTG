///Удаляет модуль анти-грава у инвалидов при спавне т.к. у них есть коляска
/datum/quirk/equipping/entombed/install_quirk_interaction_features()
	return

/datum/preference/choiced/entombed_skin/init_possible_values()
	return list(
		"Standard",
		"Civilian",
		//"Advanced",
		"Atmospheric",
		"Corpsman",
		//"Cosmohonk",
		"Engineering",
		//"Infiltrator",
		//"Interdyne",
		//"Loader",
		"Medical",
		"Mining",
		"Prototype",
		//"Security",
		"Colonist",
		//"Tarkon",
	)
