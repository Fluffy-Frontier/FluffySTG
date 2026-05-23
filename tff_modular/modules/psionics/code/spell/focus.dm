/datum/action/cooldown/spell/psionic/focus
	name = "Psionic Focus"
	desc = "Creates a useful reagents inside of you, removing stun."
	button_icon_state = "tech_haste"
	category = "Tier 2"
	cooldown_time = 50 SECONDS
	mana_cost = 20
	psionic_level = 2
	locked = FALSE

/datum/action/cooldown/spell/psionic/focus/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/human_living = cast_on
	if(do_after(human_living, 1 SECONDS, timed_action_flags = IGNORE_SLOWDOWNS | IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM))
		to_chat(human_living, span_warning("A calm rush envelops your mind.."))
		human_living.reagents.add_reagent(/datum/reagent/medicine/psimulant, 5)
		drain_mana()
		playsound(human_living, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	else
		return FALSE

/datum/reagent/medicine/psimulant
	name = "Psi-Stimulant"
	description = "This strange substance that cannot be artificially created causes vivacity, stimulation and a surge of strength."
	taste_description = "Brain"
	color = COLOR_TOOL_BLUE
	self_consuming = TRUE

/datum/reagent/medicine/psimulant/on_mob_add(mob/living/affected_mob, amount)
	. = ..()
	var/mob/living/carbon/human/psimulator = affected_mob
	psimulator.add_movespeed_modifier(/datum/movespeed_modifier/psimulant)
	psimulator.add_actionspeed_modifier(/datum/actionspeed_modifier/psimulant)
	psimulator.SetParalyzed(0)
	psimulator.SetStun(0)
	psimulator.SetAllImmobility(0)
	psimulator.remove_status_effect(/datum/status_effect/speech/stutter)
	psimulator.set_resting(FALSE)
	psimulator.SetSleeping(0)

/datum/reagent/medicine/psimulant/metabolize_reagent(mob/living/carbon/affected_mob, seconds_per_tick, metabolized_volume)
	. = ..()
	affected_mob.adjust_stamina_loss(-2)
	affected_mob.adjust_brute_loss(-0.3)
	affected_mob.adjust_fire_loss(-0.3)

/datum/reagent/medicine/psimulant/on_mob_delete(mob/living/affected_mob)
	. = ..()
	var/mob/living/carbon/human/psimulator = affected_mob
	psimulator.remove_movespeed_modifier(/datum/movespeed_modifier/psimulant)
	psimulator.remove_actionspeed_modifier(/datum/actionspeed_modifier/psimulant)

/datum/movespeed_modifier/psimulant
	multiplicative_slowdown = -0.2

/datum/actionspeed_modifier/psimulant
	multiplicative_slowdown = -0.3
