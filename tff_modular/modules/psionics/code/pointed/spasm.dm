// Станит на непродолжительный срок и заставляет выкинуть вещи из рук
/datum/action/cooldown/spell/pointed/psionic/spasm
	name = "Psionic Spasm"
	desc = "Force a target to drop the items in its hands. Note that this has a hefty power use and cooldown."
	button_icon_state = "genetics_closed"
	cooldown_time = 100 SECONDS
	mana_cost = 20
	psionic_level = 2
	target_msg = "Your muscles spasm!"
	active_msg = "You prepare to stun a target..."
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/pointed/psionic/spasm/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE

	if(issynthetic(cast_on) && cast_power < 2)
		to_chat(owner, span_notice("I dont know how to work with synths."))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/psionic/spasm/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(cast_on, span_warning("Your body is assaulted with psionic energy!"))
	else
		to_chat(cast_on, span_warning(target_msg))
	log_combat(owner, cast_on, "psionically spasmed")
	cast_on.Stun(1 SECONDS * cast_power)
	drain_mana()
	playsound(cast_on, 'tff_modular/modules/psionics/sounds/power_evoke.ogg', 50, TRUE)
	return TRUE
