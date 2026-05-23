// Мед сканер на расстоянии
/datum/action/cooldown/spell/pointed/psionic/skinsight
	name = "Skinsight"
	desc = "Try to read target's vital energy and determine their state."
	button_icon_state = "wiz_blind"
	cooldown_time = 1 SECONDS
	point_cost = 0
	mana_cost = 5
	target_msg = "You feel like someone is looking deep into you."
	active_msg = "You prepare to scan a target..."
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/skinsight/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/psionic/skinsight/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(cast_on, span_notice("Your body is being read by a psionic nearby."))
	else
		to_chat(cast_on, span_warning(target_msg))
	if(cast_power >= 2)
		healthscan(owner, cast_on, SCANNER_VERBOSE, TRUE, tochat = TRUE)
	else
		healthscan(owner, cast_on, SCANNER_VERBOSE, FALSE, tochat = TRUE)
	drain_mana()
	playsound(cast_on, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	return TRUE
