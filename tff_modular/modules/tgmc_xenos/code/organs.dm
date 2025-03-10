/// TGMC_XENOS (old nova sector xenos)

// Яйцеклад королевы
/obj/item/organ/alien/eggsac/tgmc
	actions_types = list(/datum/action/cooldown/alien/make_structure/lay_egg/tgmc)

/datum/action/cooldown/alien/make_structure/lay_egg/tgmc
	made_structure_type = /obj/structure/alien/egg/tgmc


// Плевалка нейротоксина сентинела
/obj/item/organ/alien/neurotoxin/tgmc
	name = "neurotoxin gland"
	icon_state = "neurotox"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_XENO_NEUROTOXINGLAND
	actions_types = list(
		/datum/action/cooldown/alien/acid/tgmc,
		/datum/action/cooldown/alien/acid/tgmc/lethal,
	)

// Плевалка нейротоксина у спиттера и претора
/obj/item/organ/alien/neurotoxin/tgmc/large
	name = "large neurotoxin gland"
	actions_types = list(
		/datum/action/cooldown/alien/acid/tgmc/spread,
		/datum/action/cooldown/alien/acid/tgmc/spread/lethal,
	)

// Личная плевалка нейротоксина королевы
/obj/item/organ/alien/neurotoxin/tgmc/queen
	name = "abnormal neurotoxin gland"
	actions_types = list(
		/datum/action/cooldown/alien/acid/tgmc/queen,
		/datum/action/cooldown/alien/acid/tgmc/lethal/queen,
	)


// Плевалка кислоты сентинела
/obj/item/organ/alien/acid/tgmc
	name = "acid gland"
	icon_state = "acid"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_XENO_ACIDGLAND
	actions_types = list(/datum/action/cooldown/alien/acid/corrosion/tgmc)

// Плевалка кислоты у спиттера, королевы и претора
/obj/item/organ/alien/acid/tgmc/large
	name = "large acid gland"
	actions_types = list(/datum/action/cooldown/alien/acid/corrosion/tgmc/strong)
