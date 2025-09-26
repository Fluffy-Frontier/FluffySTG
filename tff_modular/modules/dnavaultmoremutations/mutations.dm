/datum/mutation/full_space
	name = "Space Adaptation"
	desc = "A mutation that covers the skin with imperceptible carp scales, and also by creating an organ that produces oxygen inside the body, giving full adaptation to space."
	text_gain_indication = span_notice("Your lungs and skin feel great.")
	text_lose_indication = span_warning("Your lungs and skin feel normal again.")
	locked = TRUE
	mutation_traits = list(TRAIT_NO_BREATHLESS_DAMAGE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD)

/datum/mutation/plasmofire
	name = "Plasma-Fire Immunity"
	desc = "A mutation in the lungs that provides it immunity to plasma's toxic nature and gives protection against fire to skin."
	text_gain_indication = span_notice("Your lungs feel resistant to airborne contaminant.")
	text_lose_indication = span_warning("Your lungs feel vulnerable to airborne contaminant again.")
	locked = TRUE
	mutation_traits = list(TRAIT_VIRUSIMMUNE, TRAIT_RESISTHEAT, TRAIT_NOFIRE)

/datum/mutation/plasmofire/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.physiology.burn_mod *= 0.5
	var/obj/item/organ/lungs/improved_lungs = acquirer.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(improved_lungs)
		apply_buff(improved_lungs)
	RegisterSignal(acquirer, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(remove_modification))
	RegisterSignal(acquirer, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(reapply_modification))

/datum/mutation/plasmofire/on_losing(mob/living/carbon/human/owner)
	. = ..()
	var/obj/item/organ/lungs/improved_lungs = owner.get_organ_slot(ORGAN_SLOT_LUNGS)
	owner.physiology.burn_mod /= 0.5
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
