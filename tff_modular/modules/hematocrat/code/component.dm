/datum/component/heart_eater_hematocrat
	/// Check if we fully ate whole heart and reset when we start eat new one.
	var/bites_taken = 0
	/// Remember last heart we ate and reset bites_taken counter if we start eat new one
	var/datum/weakref/last_heart_we_ate
/datum/component/heart_eater_hematocrat/Initialize(...)
	. = ..()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	prepare_species(parent)

/datum/component/heart_eater_hematocrat/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_LIVING_FINISH_EAT, PROC_REF(eat_eat_eat))

/datum/component/heart_eater_hematocrat/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_LIVING_FINISH_EAT)
	UnregisterSignal(parent, COMSIG_SPECIES_GAIN)

/datum/component/heart_eater_hematocrat/proc/prepare_species(mob/living/carbon/human/eater)
	if(eater.get_liked_foodtypes() & GORE)
		return
	var/obj/item/organ/tongue/eater_tongue = eater.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!eater_tongue)
		return
	eater_tongue.disliked_foodtypes &= ~GORE
	eater_tongue.liked_foodtypes |= GORE

/// Proc called when we finish eat somthing.
/datum/component/heart_eater_hematocrat/proc/eat_eat_eat(mob/living/carbon/human/eater, datum/what_we_ate)
	SIGNAL_HANDLER

	if(!istype(what_we_ate, /obj/item/organ/heart))
		return
	var/obj/item/organ/heart/we_ate_heart = what_we_ate
	var/obj/item/organ/heart/previous_heart = last_heart_we_ate?.resolve()
	if(we_ate_heart == previous_heart)
		return
	if (!HAS_TRAIT(we_ate_heart, TRAIT_USED_ORGAN))
		to_chat(eater, span_warning("This heart is utterly lifeless, you won't receive any boons from consuming it!"))
		return
	bites_taken = 0

	last_heart_we_ate = WEAKREF(we_ate_heart)
	bites_taken++
	if(bites_taken < (we_ate_heart.reagents.total_volume/2))
		return
	if(prob(50))
		perfect_heart(eater)
		return
	not_perfect_heart(eater)

/datum/component/heart_eater_hematocrat/proc/perfect_heart(mob/living/carbon/human/eater)
	healing_heart(eater)
	to_chat(eater, span_warning("This heart is perfect. You feel a surge of vital energy."))

///Not Perfect heart give random mutation.
/datum/component/heart_eater_hematocrat/proc/not_perfect_heart(mob/living/carbon/human/eater)
	to_chat(eater, span_warning("This heart is not perfect. You feel nothing."))

///Heart eater give also strong healing from hearts.
/datum/component/heart_eater_hematocrat/proc/healing_heart(mob/living/carbon/human/eater)
	eater.adjustBruteLoss(-30)
	eater.adjustFireLoss(-30)

