/datum/action/cooldown/spell/pointed/psionic/jump
	name = "Psionic Jump"
	desc = "Teleport to a destination you click on."
	button_icon_state = "tech_dispel"
	cooldown_time = 30 SECONDS
	psionic_level = 2
	mana_cost = 20
	point_cost = 2
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/jump/can_cast_spell(feedback)
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_NO_TRANSFORM))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/jump/is_valid_target(atom/cast_on)
	if(isclosedturf(cast_on))
		return FALSE
	if(isobj(cast_on))
		return FALSE
	if(!(cast_on in view(owner.client.view, owner)))
		owner.balloon_alert(owner, "out of view!")
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/jump/cast(atom/cast_on)
	. = ..()
	do_teleport(owner, get_turf(cast_on), 1, /obj/effect/temp_visual/dir_setting/ninja, /obj/effect/temp_visual/dir_setting/ninja, 'tff_modular/modules/psionics/sounds/power_fabrication.ogg', channel = TELEPORT_CHANNEL_MAGIC)
	drain_mana()
	return TRUE
