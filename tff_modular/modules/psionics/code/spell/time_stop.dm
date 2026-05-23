/datum/action/cooldown/spell/psionic/time_stop
	name = "Time Stop"
	desc = "Create a wave of telekinetic energy to pummel the ground around you."
	button_icon_state = "tech_control"
	category = "Tier 2"
	mana_cost = 80
	cooldown_time = 120 SECONDS
	point_cost = 3
	locked = FALSE
	psionic_level = 2

/datum/action/cooldown/spell/psionic/time_stop/cast(atom/cast_on)
	. = ..()
	var/list/default_immune_atoms = list()
	default_immune_atoms += cast_on
	new /obj/effect/timestop/magic(get_turf(cast_on), 1, 2 SECONDS * cast_power, default_immune_atoms)

/datum/action/cooldown/spell/psionic/time_stop/can_cast_spell(feedback)
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_INCAPACITATED))
		return FALSE
	return TRUE
