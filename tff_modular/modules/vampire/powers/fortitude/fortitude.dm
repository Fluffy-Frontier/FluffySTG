/datum/discipline/fortitude
	name = "Fortitude"
	discipline_explanation = "Fortitude is a Discipline that grants Kindred unearthly toughness."
	icon_state = "fortitude"

	// Lists of abilities granted per level
	level_1 = list(/datum/action/cooldown/vampire/fortitude)
	level_2 = list(/datum/action/cooldown/vampire/fortitude/two)
	level_3 = list(/datum/action/cooldown/vampire/fortitude/three)
	level_4 = list(/datum/action/cooldown/vampire/fortitude/four)
	level_5 = list(/datum/action/cooldown/vampire/fortitude/five)

/**
 *	FORTITUDE
 *	All levels: Incrementally increasing brute and stamina resistance.
 *	Level 1: Pierce resistance
 * 	Level 2: Push immunity
 * 	Level 3: Dismember resistance
 * 	Level 4: Complete stun immunity
 *	Level 5: Grab Resistance
 */

/datum/action/cooldown/vampire/fortitude
	name = "Fortitude"
	desc = "Withstand egregious physical wounds and walk away from attacks that would stun, pierce, and dismember lesser beings."
	button_icon_state = "power_fortitude"
	power_explanation = "Grants increasing levels of brute and stamina resistance, as well as various immunities to physical harm.\n\
						At level 1: Gain pierce resistance.\n\
						At level 2: Gain push immunity.\n\
						At level 3: Gain dismember resistance.\n\
						At level 4: Gain complete stun immunity."
	vampire_power_flags = BP_AM_TOGGLE | BP_AM_COSTLESS_UNCONSCIOUS
	vampire_check_flags = BP_CANT_USE_IN_TORPOR | BP_CANT_USE_WHILE_STAKED
	vitaecost = 50
	cooldown_time = 5 SECONDS

	var/resistance = 0.8

	// Flags for what immunities to turn on at which level
	var/pierce = TRUE
	var/push = FALSE
	var/dismember = FALSE
	var/stun = FALSE
	var/grab = FALSE
	var/burn_resistance = 0.9

/datum/action/cooldown/vampire/fortitude/two
	resistance = 0.6
	burn_resistance = 0.8
	pierce = TRUE
	push = TRUE

/datum/action/cooldown/vampire/fortitude/three
	resistance = 0.4
	burn_resistance = 0.7
	pierce = TRUE
	push = TRUE
	dismember = TRUE

/datum/action/cooldown/vampire/fortitude/four
	resistance = 0.3
	burn_resistance = 0.6
	pierce = TRUE
	push = TRUE
	dismember = TRUE
	stun = TRUE

/datum/action/cooldown/vampire/fortitude/five
	resistance = 0.3
	burn_resistance = 0.5
	pierce = TRUE
	push = TRUE
	dismember = TRUE
	stun = TRUE
	grab = TRUE

/datum/action/cooldown/vampire/fortitude/activate_power()
	. = ..()
	owner.balloon_alert(owner, "fortitude turned on.")
	to_chat(owner, span_notice("Your flesh has become as hard as steel!"))
	owner.playsound_local(null, 'tff_modular/modules/vampire/sound/fortitude_on.ogg', 100, FALSE, pressure_affected = FALSE)
	// Traits & Effects
	if(pierce)
		ADD_TRAIT(owner, TRAIT_PIERCEIMMUNE, REF(src))
	if(dismember)
		ADD_TRAIT(owner, TRAIT_NODISMEMBER, REF(src))
	if(push)
		ADD_TRAIT(owner, TRAIT_PUSHIMMUNE, REF(src))
	if(stun)
		ADD_TRAIT(owner, TRAIT_STUNIMMUNE, REF(src)) // They'll get stun resistance + this, who cares.
	if(grab)
		ADD_TRAIT(owner, TRAIT_GRABRESISTANCE, REF(src))

	var/mob/living/carbon/human/user = owner
	RegisterSignal(user, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_take_damage))
	user.physiology.brute_mod *= resistance
	user.physiology.stamina_mod *= resistance * 2 // Stamina resistance is half as effective because they have it inherently.
	user.physiology.burn_mod *= burn_resistance // they get burn resistance, but way less

/datum/action/cooldown/vampire/fortitude/proc/on_take_damage(datum/source, damage_amount, damage_type, ...)
	SIGNAL_HANDLER
	var/blood_to_consume = damage_amount / (resistance + 0.1)
	vampiredatum_power.adjust_blood_volume(-blood_to_consume)

/datum/action/cooldown/vampire/fortitude/use_power()
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/user = owner
	if(istype(user.buckled, /obj/vehicle))
		user.buckled.unbuckle_mob(src, force = TRUE)

/datum/action/cooldown/vampire/fortitude/deactivate_power()
	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/vampire_user = owner
	UnregisterSignal(vampire_user, COMSIG_MOB_APPLY_DAMAGE)
	vampire_user.physiology.brute_mod /= resistance
	vampire_user.physiology.burn_mod /= burn_resistance
	vampire_user.physiology.stamina_mod /= resistance * 2

	// Remove Traits & Effects
	REMOVE_TRAITS_IN(owner, REF(src))

	owner.balloon_alert(owner, "fortitude turned off.")
	owner.playsound_local(null, 'tff_modular/modules/vampire/sound/fortitude_off.ogg', 100, FALSE, pressure_affected = FALSE)

	return ..()
