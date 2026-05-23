/datum/action/cooldown/spell/pointed/psionic/stasis
	name = "Psionic Stasis"
	desc = "Condenses the Nlom field around one person at a time. This immobilises them and also applies stasis to them."
	button_icon_state = "gen_ice"
	cooldown_time = 60 SECONDS
	point_cost = 1
	psionic_level = 2
	mana_cost = 30
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/stasis/is_valid_target(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/stasis/cast(atom/cast_on)
	. = ..()
	var/mob/living/freezing = cast_on
	if(!do_after(owner, 2 SECONDS, freezing, IGNORE_TARGET_LOC_CHANGE | IGNORE_USER_LOC_CHANGE | IGNORE_SLOWDOWNS | IGNORE_HELD_ITEM))
		return FALSE
	var/duration = cast_power * 4 SECONDS
	freezing.apply_status_effect(/datum/status_effect/freon/watcher/psionic, duration)
	playsound(freezing, 'tff_modular/modules/psionics/sounds/power_evoke.ogg', 50, TRUE)

/datum/status_effect/freon/watcher/psionic/on_creation(mob/living/new_owner, new_duration)
	. = ..()
	duration = new_duration
