/datum/action/cooldown/vampire/targeted/blooddrain
	name = "Thaumaturgy: Blood Drain"
	desc = "Cast a beam of draining magic that saps the vitality of your target to steal their blood and heal yourself."
	button_icon_state = "power_blooddrain"
	active_background_icon_state = "tremere_power_on"
	base_background_icon_state = "tremere_power_off"
	power_explanation = "Cast a beam of draining magic that saps the vitality of your target to steal their blood and heal yourself.\n\
		You must maintain line of sight to the victim for the effect to continue."
	vampire_power_flags = BP_AM_TOGGLE
	vampire_check_flags = BP_CANT_USE_IN_TORPOR | BP_CANT_USE_WHILE_STAKED | BP_CANT_USE_IN_FRENZY | BP_CANT_USE_WHILE_INCAPACITATED | BP_CANT_USE_WHILE_UNCONSCIOUS
	vitaecost = 50
	cooldown_time = 10 SECONDS	// Very unlikely to ever last past 10 seconds even if the actual duration is longer. Combat is a fuck.
	target_range = 7
	power_activates_immediately = FALSE
	prefire_message = "Select your target."
	ranged_mousepointer = 'tff_modular/modules/vampire/icons/vampire_blooddrain.dmi'

	var/datum/status_effect/blood_drain/active_effect
	var/datum/beam/drain_beam

/datum/action/cooldown/vampire/targeted/blooddrain/check_valid_target(atom/target_atom)
	if(!isliving(target_atom))
		return FALSE
	..()

/datum/action/cooldown/vampire/targeted/blooddrain/fire_targeted_power(atom/target_atom, list/modifiers)
	. = ..()
	var/mob/living/living_owner = owner
	var/mob/living/living_victim = target_atom
	living_owner.face_atom(target_atom)
	living_owner.changeNext_move(CLICK_CD_RANGE)
	living_owner.newtonian_move(get_dir(target_atom, living_owner))
	playsound(living_owner, 'tff_modular/modules/vampire/sound/bloodbolt.ogg', 60, TRUE)
	living_victim.apply_status_effect(/datum/status_effect/blood_drain, living_owner, src)

/datum/action/cooldown/vampire/targeted/blooddrain/deactivate_power()
	. = ..()
	if(!isnull(active_effect))
		active_effect.end_drain()

///
/// Status Effect. Literally copied from life drain spell of wizards, but modified to work with vampires.
///
/datum/status_effect/blood_drain
	id = "blood_drain"
	duration = 20 SECONDS
	tick_interval = 0.25 SECONDS
	status_type = STATUS_EFFECT_REPLACE
	processing_speed = STATUS_EFFECT_PRIORITY
	alert_type = null
	var/datum/beam/drain_beam
	var/mob/living/carbon/vampire
	var/datum/action/cooldown/vampire/targeted/blooddrain/spell
	var/blood_drain = 5	 // Amount of blood drained per second

/datum/status_effect/blood_drain/Destroy()
	. = ..()
	vampire = null

/datum/status_effect/blood_drain/on_creation(mob/living/new_owner, mob/living/firer, fired_from, duration_override)
	if(isnull(firer) || isnull(fired_from) || !iscarbon(firer) || !iscarbon(new_owner))
		qdel(src)
		return
	vampire = firer
	spell = fired_from
	spell.active_effect = src
	drain_beam = vampire.Beam(new_owner, icon = 'icons/effects/beam.dmi', icon_state = "blood_drain", time = 22 SECONDS, maxdistance = 7, beam_color = COLOR_RED)
	RegisterSignal(drain_beam, COMSIG_QDELETING, PROC_REF(end_drain))
	new_owner.visible_message(span_boldwarning("[vampire] begins draining the life force from [new_owner]!"), span_boldwarning("[vampire] is draining your life force! You need to get away from [vampire.p_them()] to stop it!"))
	. = ..()

/datum/status_effect/blood_drain/on_apply()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/life_drain)
	return TRUE

/datum/status_effect/blood_drain/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/life_drain)
	if(spell)
		spell.active_effect = null
		spell.deactivate_power()
		spell.StartCooldown()
		spell = null
	if(!QDELETED(drain_beam))
		qdel(drain_beam)
	drain_beam = null

/datum/status_effect/blood_drain/tick(seconds_between_ticks)
	if(!iscarbon(owner) || owner.stat > HARD_CRIT) //If they're dead or non-humanoid, this spell fails
		end_drain()
		return
	if(!iscarbon(vampire)) //You never know what might happen with wizards around
		end_drain()
		return
	if(!CAN_THEY_SEE(vampire, owner)) // if they leave line of sight, no more drain.
		end_drain()
		return

	if(HAS_TRAIT(owner, TRAIT_INCAPACITATED) || owner.stat)
		//If the victim is incapacitated, drain their blood
		owner.blood_volume -= blood_drain * seconds_between_ticks
	else
		//If they aren't incapacitated yet, drain only their stamina
		owner.adjust_stamina_loss(7 * seconds_between_ticks)

	if(SPT_PROB(20, seconds_between_ticks))
		INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "scream")
		owner.visible_message(span_boldwarning("[vampire] absorbs blood from [owner]!"), span_boldwarning("It BURNS!"))

	//Vampire heals at a steady rate over the duration of the spell regardless of the victim's state
	vampire.heal_overall_damage(brute = 0.5, burn = 0.5, stamina = 5)

	spell.vampiredatum_power.adjust_blood_volume(blood_drain * seconds_between_ticks * 2) // Vampires get double the blood drained because of balance
	//Weird beam visuals if it isn't redrawn due to the beam sending players into crit
	drain_beam.redrawing()

/datum/status_effect/blood_drain/proc/end_drain()
	SIGNAL_HANDLER
	if(!QDELETED(src))
		qdel(src)
