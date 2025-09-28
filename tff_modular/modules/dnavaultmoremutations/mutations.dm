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
	acquirer.add_traits(list(TRAIT_RESISTHEAT, TRAIT_NOFIRE), DNA_VAULT_TRAIT)
	acquirer.physiology.burn_mod *= 0.5
	var/obj/item/organ/lungs/improved_lungs = acquirer.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(improved_lungs)
		apply_buff(improved_lungs)
	RegisterSignal(acquirer, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(remove_modification))
	RegisterSignal(acquirer, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(reapply_modification))

/datum/mutation/plasmofire/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.remove_traits(list(TRAIT_RESISTHEAT, TRAIT_NOFIRE), DNA_VAULT_TRAIT)
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

/datum/mutation/body_regeneration
	name = "Regeneration"
	desc = "The owner of mutation regenerates a little bit."
	text_gain_indication = span_notice("You feel your skin moving...")
	text_lose_indication = span_warning("Your doesn't feel anything.")
	locked = TRUE

/datum/mutation/body_regeneration/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	RegisterSignal(acquirer, COMSIG_LIVING_LIFE, PROC_REF(regeneration_on_life))

/datum/mutation/body_regeneration/on_losing(mob/living/carbon/human/owner)
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_LIFE)

// Регенерация. Должно работать хуже чем регенарция подперсоны/тени/гемофага, ибо подперсона лечит 0.5 хп на каждую конечность, а тут лечение 0.6 хп распределяется по поврежденным конечностям.
/datum/mutation/body_regeneration/proc/regeneration_on_life(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	var/need_mob_update = FALSE
	need_mob_update += owner.heal_overall_damage(brute = 0.6, burn = 0.6, updating_health = FALSE)
	need_mob_update += owner.adjustToxLoss(-0.3, updating_health = FALSE)
	need_mob_update += owner.adjustOxyLoss(-0.3, updating_health = FALSE)
	if(need_mob_update)
		owner.updatehealth()

/datum/mutation/toxin_immunity
	name = "Hazardous Envirovment Immunity"
	desc = "Envirovment immunity provides immunity to most types of toxins, radiation and viruses."
	text_gain_indication = "You feel as pure as you've ever felt."
	text_lose_indication = "You feel a strange weight in your chest."
	locked = TRUE

/datum/mutation/toxin_immunity/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.add_traits(list(TRAIT_TOXIMMUNE, TRAIT_RADIMMUNE, TRAIT_RADSTORM_IMMUNE, TRAIT_VIRUSIMMUNE), DNA_VAULT_TRAIT)

/datum/mutation/toxin_immunity/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.remove_traits(list(TRAIT_TOXIMMUNE, TRAIT_RADIMMUNE, TRAIT_RADSTORM_IMMUNE, TRAIT_VIRUSIMMUNE), DNA_VAULT_TRAIT)

/datum/mutation/electricity_saturation
	name = "Electricity Saturation"
	desc = "ILLEGAL MUTATION SINCE 2532. PLEASE CONTACT A GENETICIST. Electricity Saturation gives you ENERGY BOOST and causes you to... CREATE THUNDERS."
	locked = TRUE
	var/electricity_detected = FALSE

/datum/mutation/electricity_saturation/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	RegisterSignal(acquirer, COMSIG_LIVING_LIFE, PROC_REF(on_superlife))

/datum/mutation/electricity_saturation/on_losing(mob/living/carbon/human/owner)
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_LIFE)
	electricity_detected = FALSE

/datum/mutation/electricity_saturation/proc/on_superlife(mob/living/carbon/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/target = source
	target.adjust_timed_status_effect(1 SECONDS, /datum/status_effect/dizziness)
	if(SPT_PROB(2, seconds_per_tick))
		var/static/mutable_appearance/overcharge
		overcharge = overcharge || mutable_appearance('icons/effects/effects.dmi', "electricity", EFFECTS_LAYER)
		source.add_overlay(overcharge)

		if(do_after(source, 3 SECONDS, timed_action_flags = (IGNORE_USER_LOC_CHANGE|IGNORE_HELD_ITEM|IGNORE_INCAPACITATED)))
			playsound(source, 'sound/effects/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
			source.cut_overlay(overcharge)
			tesla_zap(source = source, zap_range = 2, power = 7500, cutoff = 1 KILO JOULES, zap_flags = ZAP_OBJ_DAMAGE | ZAP_LOW_POWER_GEN | ZAP_ALLOW_DUPLICATES | ZAP_MOB_DAMAGE)
			source.visible_message(span_danger("[source] violently discharges energy!"), span_warning("You violently discharge energy!"))

	if(SPT_PROB(2, seconds_per_tick))
		source.playsound_local(source, 'sound/effects/singlebeat.ogg', 100, 0)
