/datum/mutation/full_space
	name = "Space Adaptation"
	desc = "A mutation that covers the skin with imperceptible carp scales, and also by creating an organ that produces oxygen inside the body, giving full adaptation to space."
	text_gain_indication = span_notice("Your lungs and skin feel great.")
	text_lose_indication = span_warning("Your lungs and skin feel normal again.")
	locked = TRUE
	conflicts = list(/datum/mutation/adaptation)

/datum/mutation/full_space/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.add_traits(list(TRAIT_NO_BREATHLESS_DAMAGE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD), DNA_VAULT_TRAIT)

/datum/mutation/full_space/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.remove_traits(list(TRAIT_NO_BREATHLESS_DAMAGE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD), DNA_VAULT_TRAIT)

/datum/mutation/plasmofire
	name = "Plasma-Fire Resistance"
	desc = "A mutation in the lungs that provides it immunity to plasma's toxic nature and gives protection against fire to skin."
	text_gain_indication = span_notice("Your lungs feel resistant to airborne contaminant.")
	text_lose_indication = span_warning("Your lungs feel vulnerable to airborne contaminant again.")
	locked = TRUE

/datum/mutation/plasmofire/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.add_traits(list(TRAIT_VIRUSIMMUNE, TRAIT_RESISTHEAT, TRAIT_NOFIRE), DNA_VAULT_TRAIT)
	acquirer.physiology.burn_mod *= 0.5
	var/obj/item/organ/lungs/improved_lungs = acquirer.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(improved_lungs)
		apply_buff(improved_lungs)
	RegisterSignal(acquirer, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(remove_modification))
	RegisterSignal(acquirer, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(reapply_modification))

/datum/mutation/plasmofire/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.remove_traits(list(TRAIT_VIRUSIMMUNE, TRAIT_RESISTHEAT, TRAIT_NOFIRE), DNA_VAULT_TRAIT)
	owner.physiology.burn_mod /= 0.5
	var/obj/item/organ/lungs/improved_lungs = owner.get_organ_slot(ORGAN_SLOT_LUNGS)
	UnregisterSignal(owner, COMSIG_CARBON_LOSE_ORGAN)
	UnregisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN)
	if(improved_lungs)
		remove_buff(improved_lungs)

/datum/mutation/plasmofire/proc/remove_modification(mob/source, obj/item/organ/old_organ)
	SIGNAL_HANDLER

	if(istype(old_organ, /obj/item/organ/lungs))
		remove_buff(old_organ)

/datum/mutation/plasmofire/proc/reapply_modification(mob/source, obj/item/organ/new_organ)
	SIGNAL_HANDLER

	if(istype(new_organ, /obj/item/organ/lungs))
		apply_buff(new_organ)

/datum/mutation/plasmofire/proc/apply_buff(obj/item/organ/lungs/our_lungs)
	our_lungs.plas_breath_dam_min *= 0
	our_lungs.plas_breath_dam_max *= 0

/datum/mutation/plasmofire/proc/remove_buff(obj/item/organ/lungs/our_lungs)
	our_lungs.plas_breath_dam_min = initial(our_lungs.plas_breath_dam_min)
	our_lungs.plas_breath_dam_max = initial(our_lungs.plas_breath_dam_max)

/datum/mutation/light_regeneration
	name = "Light Regeneration"
	desc = "The limbs regenerate a little when they are in the light. The mutation is weaker than the regeneration of the podperson."
	text_gain_indication = span_notice("Your feel like a plant...")
	text_lose_indication = span_warning("Your doesn't feel like a plant.")
	locked = TRUE

/datum/mutation/light_regeneration/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	if(ispodperson(acquirer) || isnightmare(acquirer))
		REMOVE_TRAIT(acquirer, TRAIT_USED_DNA_VAULT, DNA_VAULT_TRAIT)
		to_chat(acquirer, "It looks like you already have regeneration of some type. Take another mutation...")
		return
	RegisterSignal(acquirer, COMSIG_LIVING_LIFE, PROC_REF(regeneration_on_life))

/datum/mutation/light_regeneration/on_losing(mob/living/carbon/human/owner)
	. = ..()
	UnregisterSignal(acquirer, COMSIG_LIVING_LIFE)

// Регенерация от света. Должно работать хуже чем регенарция подперсоны, ибо подперсона лечит 0.5 хп на каждую конечность, а тут лечение 0.5 хп распределяется на ВСЕ тело, т.е. около 0.1 на каждую конечность.
/datum/mutation/light_regeneration/proc/regeneration_on_life(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	var/light_amount = 0
	var/turf/turf_loc = owner.loc
	light_amount = min(1, turf_loc.get_lumcount()) - 0.5
	if(light_amount > 0.2)
		var/need_mob_update = FALSE
		need_mob_update += owner.heal_overall_damage(brute = 0.6, burn = 0.6, updating_health = FALSE)
		need_mob_update += owner.adjustToxLoss(-0.6, updating_health = FALSE)
		need_mob_update += owner.adjustOxyLoss(-0.6, updating_health = FALSE)
		if(need_mob_update)
			owner.updatehealth()
