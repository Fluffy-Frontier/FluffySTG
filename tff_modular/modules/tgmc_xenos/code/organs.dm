/// TGMC_XENOS (old nova sector xenos)

// Яйцеклад королевы
/obj/item/organ/alien/eggsac/tgmc
	actions_types = list(/datum/action/cooldown/alien/make_structure/lay_egg/tgmc)

/datum/action/cooldown/alien/make_structure/lay_egg/tgmc
	made_structure_type = /obj/structure/alien/egg/tgmc

// Плевалка нейротоксина сентинела
/obj/item/organ/alien/neurotoxin/sentinel
	name = "neurotoxin gland"
	icon_state = "neurotox"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_XENO_NEUROTOXINGLAND
	actions_types = list(
		/datum/action/cooldown/alien/acid/tgmc,
		/datum/action/cooldown/alien/acid/tgmc/lethal,
	)

// Плевалка нейротоксина у спиттера и претора
/obj/item/organ/alien/neurotoxin/spitter
	name = "large neurotoxin gland"
	icon_state = "neurotox"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_XENO_NEUROTOXINGLAND
	actions_types = list(
		/datum/action/cooldown/alien/acid/tgmc/spread,
		/datum/action/cooldown/alien/acid/tgmc/spread/lethal,
		/datum/action/cooldown/alien/acid/corrosion,
	)

// Личная плевалка нейротоксина королевы
/obj/item/organ/alien/neurotoxin/queen
	name = "neurotoxin gland"
	icon_state = "neurotox"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_XENO_NEUROTOXINGLAND
	actions_types = list(
		/datum/action/cooldown/alien/acid/tgmc,
		/datum/action/cooldown/alien/acid/tgmc/lethal,
		/datum/action/cooldown/alien/acid/corrosion,
	)
