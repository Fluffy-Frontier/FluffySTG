// nothing for now
/datum/action/cooldown/bloodsucker/enter_frenzy
	name = "Enter Frenzy"
	desc = "Go into a rage, gaining the benefits of the Frenzy effect. Show them who is immortal in this castle!"
	button_icon_state = "power_recover"
	level_current = -1
	power_flags = BP_AM_STATIC_COOLDOWN
	bloodsucker_check_flags = BP_CANT_USE_IN_FRENZY
	cooldown_time = 60 SECONDS

/datum/action/cooldown/bloodsucker/enter_frenzy/ActivatePower(atom/target)
	. = ..()
	EnterFrenzy(bloodsuckerdatum_power.owner.current)
	DeactivatePower()

/datum/action/cooldown/bloodsucker/enter_frenzy/proc/EnterFrenzy(mob/living/carbon/human/bloodsucker)
	bloodsucker.apply_status_effect(/datum/status_effect/brujah)
