/// TGMC_XENOS (old nova sector xenos)

// Глазки ксенусей
/obj/item/organ/eyes/alien/tgmc

/obj/item/organ/eyes/alien/tgmc/apply_scar(side)
	return // Нам не нужны слепые ксеносы из-за шрамов на глазах


// Сосуды плазмы
/obj/item/organ/alien/plasmavessel/tgmc
	name = "plasma vessel"
	icon_state = "plasma"
	w_class = WEIGHT_CLASS_NORMAL
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_XENO_PLASMAVESSEL
	actions_types = list(
		/datum/action/cooldown/alien/transfer,
	)

	stored_plasma = 100
	max_plasma = 250
	heal_rate = 1
	plasma_rate = 5

	var/resting_mult = 8

/obj/item/organ/alien/plasmavessel/tgmc/on_life(seconds_per_tick, times_fired)
	var/delta_time = DELTA_WORLD_TIME(SSmobs)
	//Instantly healing to max health in a single tick would be silly. If it takes 8 seconds to fire, then something's fucked.
	var/delta_time_capped = min(delta_time, 8)
	//If there are alien weeds on the ground then heal if needed or give some plasma
	if(locate(/obj/structure/alien/weeds) in owner.loc)
		if(owner.health >= owner.maxHealth)
			owner.adjustPlasma(plasma_rate * delta_time)
		else
			var/heal_amt = heal_rate
			if(!isalien(owner))
				heal_amt *= 0.2
			if(owner.resting)
				heal_amt *= resting_mult
			heal_amt *= delta_time_capped

			owner.adjustPlasma(0.5 * plasma_rate * delta_time_capped)
			owner.adjust_brute_loss(-heal_amt)
			owner.adjust_fire_loss(-heal_amt)
			owner.adjust_oxy_loss(-heal_amt)
			heal_owner_organs(heal_amt / 20)
	else
		owner.adjustPlasma(0.1 * plasma_rate * delta_time)

/obj/item/organ/alien/plasmavessel/tgmc/proc/heal_owner_organs(heal_amount)
	var/list/slots_to_heal = list(ORGAN_SLOT_BRAIN, ORGAN_SLOT_EYES, ORGAN_SLOT_LIVER, ORGAN_SLOT_EARS, ORGAN_SLOT_STOMACH)
	for(var/slot in slots_to_heal)
		owner.adjust_organ_loss(slot, -heal_amount)

/obj/item/organ/alien/plasmavessel/tgmc/large
	name = "large plasma vessel"
	icon_state = "plasma_large"
	w_class = WEIGHT_CLASS_BULKY
	actions_types = list(
		/datum/action/cooldown/alien/make_structure/plant_weeds,
		/datum/action/cooldown/alien/transfer,
	)
	stored_plasma = 200
	max_plasma = 500
	plasma_rate = 7.5

/obj/item/organ/alien/plasmavessel/tgmc/large/queen
	plasma_rate = 10

/obj/item/organ/alien/plasmavessel/tgmc/small
	name = "small plasma vessel"
	icon_state = "plasma_small"
	w_class = WEIGHT_CLASS_SMALL
	stored_plasma = 100
	max_plasma = 150
	plasma_rate = 2.5

/obj/item/organ/alien/plasmavessel/tgmc/small/tiny
	name = "tiny plasma vessel"
	icon_state = "plasma_tiny"
	w_class = WEIGHT_CLASS_TINY
	max_plasma = 100
	actions_types = list(/datum/action/cooldown/alien/transfer)


// Яйцеклад королевы
/obj/item/organ/alien/eggsac/tgmc
	actions_types = list(/datum/action/cooldown/alien/make_structure/lay_egg/tgmc)

/datum/action/cooldown/alien/make_structure/lay_egg/tgmc
	plasma_cost = 150
	made_structure_type = /obj/structure/alien/egg/tgmc


// Ставилка резины
/obj/item/organ/alien/resinspinner/tgmc
	actions_types = list(/datum/action/cooldown/alien/make_structure/resin/tgmc)

/datum/action/cooldown/alien/make_structure/resin/tgmc
	build_duration = 1.5 SECONDS


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
