/datum/action/cooldown/spell/pointed/psionic/mind_muddle
	name = "Psionic Mind Muddle"
	desc = "Use this at range to confuse a target and give them a little bit of pain."
	button_icon_state = "wiz_tele"
	cooldown_time = 20 SECONDS
	psionic_level = 1
	point_cost = 2
	mana_cost = 10
	locked = FALSE

/datum/action/cooldown/spell/pointed/psionic/mind_muddle/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/mind_muddle/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/victim = cast_on
	if(!do_after(owner, 2 SECONDS, victim, IGNORE_TARGET_LOC_CHANGE | IGNORE_USER_LOC_CHANGE | IGNORE_SLOWDOWNS | IGNORE_HELD_ITEM))
		return FALSE
	victim.adjust_stamina_loss(20 * cast_power)
	victim.adjust_confusion(3 SECONDS * cast_power)
	playsound(victim, 'tff_modular/modules/psionics/sounds/power_used.ogg', 50, TRUE)
	return TRUE
