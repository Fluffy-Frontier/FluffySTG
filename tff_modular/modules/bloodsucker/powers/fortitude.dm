#define FORTITUDE_STUN_IMMUNITY_LEVEL 4
/datum/action/cooldown/bloodsucker/fortitude
	name = "Fortitude"
	desc = "Withstand egregious physical wounds and walk away from attacks that would stun, pierce, and dismember lesser beings, but will render you unable to heal."
	button_icon_state = "power_fortitude"
	power_flags = BP_CONTINUOUS_EFFECT|BP_AM_COSTLESS_UNCONSCIOUS
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	cooldown_time = 10 SECONDS
	bloodcost = 30
	constant_bloodcost = 0.2
	var/fortitude_resist // So we can raise and lower your brute resist based on what your level_current WAS.
	var/list/trigger_listening = list()
	var/traits_to_add = list(TRAIT_PIERCEIMMUNE, TRAIT_NODISMEMBER, TRAIT_PUSHIMMUNE)

/datum/action/cooldown/bloodsucker/fortitude/get_power_explanation_extended()
	. = list()
	. += "Fortitude will provide pierce, stun and dismember immunity."
	. += "You will additionally gain resistance to both brute, burn and stamina damage, scaling with level."
	. += "Fortitude will make you receive [GetFortitudeResist() * 10]% less brute, stamina and [GetFortitudeResist() * 10]% less burn damage."
	. += "At level [FORTITUDE_STUN_IMMUNITY_LEVEL], you gain complete stun immunity while [src] is active."
	. += "Higher levels will increase Brute and Stamina resistance."

/datum/action/cooldown/bloodsucker/fortitude/upgrade_power()
	. = ..()
	if(level_current >= FORTITUDE_STUN_IMMUNITY_LEVEL)
		traits_to_add |= TRAIT_STUNIMMUNE

/datum/action/cooldown/bloodsucker/fortitude/ActivatePower(atom/target)
	owner.balloon_alert(owner, "fortitude turned on.")
	to_chat(owner, span_notice("Your flesh, skin, and muscles become as steel."))
	// Traits & Effects
	owner.add_traits(traits_to_add, BLOODSUCKER_TRAIT)

	var/mob/living/carbon/human/bloodsucker_user = owner
	if(IS_BLOODSUCKER(owner) || IS_GHOUL(owner))
		fortitude_resist = GetFortitudeResist()
		bloodsucker_user.physiology.brute_mod *= fortitude_resist
		bloodsucker_user.physiology.burn_mod *= fortitude_resist
		bloodsucker_user.physiology.stamina_mod *= fortitude_resist

	RegisterSignal(owner, COMSIG_LIVING_ADJUST_BRUTE_DAMAGE, PROC_REF(on_heal))
	RegisterSignal(owner, COMSIG_LIVING_ADJUST_BURN_DAMAGE, PROC_REF(on_heal))
	return TRUE

/datum/action/cooldown/bloodsucker/fortitude/proc/on_heal(mob/current_mob, type, amount, forced)
	if(!forced && active && amount < 0)
		return COMPONENT_IGNORE_CHANGE
	return NONE

/datum/action/cooldown/bloodsucker/fortitude/proc/GetFortitudeResist()
	return max(0.3, 0.7 - level_current * 0.05)

/datum/action/cooldown/bloodsucker/fortitude/DeactivatePower(deactivate_flags)
	if(length(trigger_listening))
		for(var/power in trigger_listening)
			UnregisterSignal(power, COMSIG_FIRE_TARGETED_POWER)
			trigger_listening -= power
	. = ..()
	if(!. || !ishuman(owner))
		return
	var/mob/living/carbon/human/bloodsucker_user = owner
	if(IS_BLOODSUCKER(owner) || IS_GHOUL(owner) && fortitude_resist)
		bloodsucker_user.physiology.brute_mod /= fortitude_resist
		bloodsucker_user.physiology.burn_mod /= fortitude_resist + 0.2
		bloodsucker_user.physiology.stamina_mod /= fortitude_resist
	// Remove Traits & Effects
	owner.remove_traits(traits_to_add, BLOODSUCKER_TRAIT)

	owner.balloon_alert(owner, "fortitude turned off.")
	fortitude_resist = 1
	UnregisterSignal(owner, list(COMSIG_LIVING_ADJUST_BRUTE_DAMAGE, COMSIG_LIVING_ADJUST_BURN_DAMAGE))
	return ..()

#undef FORTITUDE_STUN_IMMUNITY_LEVEL
